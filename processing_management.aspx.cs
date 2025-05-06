using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;

public partial class processing_management : System.Web.UI.Page
{
    IntranetDataDataContext db = null;
    //DateHandler dateHandler = null;

    protected void Page_Init(object sender, EventArgs e)
    {
        db = new IntranetDataDataContext();
        //dateHandler = new DateHandler();
    }
    
    
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void processing_DataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {




        var job_list_items = from j in db.job_list_items
                             where j.item_completed == false
                             &&  j.material_processed == false
                             &&  j.order_needs_processing == true
                             && j.processing_completed_by != null
                             && j.manager_has_processed_order == true
                             orderby j.processing_completed_by
                             select j ;


        e.Result = job_list_items;
        //e.Result = job_list_items.AsEnumerable().OrderBy(i => i, new ItemComparer());



    }

  /*  private class ItemComparer : IComparer<job_list_item>
    {
        DateHandler dateHandler = new DateHandler();


        public int Compare(job_list_item x, job_list_item y)
        {



            
            return dateHandler.addWorkDays((DateTime)x.processing_completed_by, ((Int32)x.processing_days_needed) * -1, 2).CompareTo(dateHandler.addWorkDays((DateTime)y.processing_completed_by, ((Int32)y.processing_days_needed) * -1, 2));

        }
    }*/




    protected void processing_ItemUpdating(object sender, ListViewUpdateEventArgs e)
    {

        DateHandler dateHandler = new DateHandler();
        
        if (!e.OldValues["processing_completed_by"].Equals(e.NewValues["processing_completed_by"]))
        {
            // processing date changed
            // update the expected date for the joblist info page
            e.NewValues["date_expected"] = dateHandler.addWorkDays(Convert.ToDateTime(e.NewValues["processing_completed_by"]), 1, 2);
            //update the receive date for orders management
            e.NewValues["receive_by_date"] = dateHandler.addWorkDays(Convert.ToDateTime(e.NewValues["processing_completed_by"]),-( Convert.ToInt32(e.NewValues["processing_days_needed"])), 2);

            sendJobListMailNotification("Processing date changed for " + e.NewValues["section.client.job_name"].ToString() + " - " + e.NewValues["section.section_name"].ToString(), User.Identity.Name + " changed the processing date from : " + e.OldValues["processing_completed_by"] + " to " + e.NewValues["processing_completed_by"] + "------> "+ e.NewValues["description"].ToString());

        }


        if (((Boolean)e.OldValues["material_processed"]) == false && ((Boolean)e.NewValues["material_processed"]) == true)
        {

            e.NewValues["item_completed"] = true;
            e.NewValues["material_delivered"] = true; // just in case they didnt tick it off as received yet, if its processed complete it must have been received
            e.NewValues["date_completed"] = DateTime.Now.ToString();
            e.NewValues["user_completed"] = Context.User.Identity.Name;

            //send mail

            sendJobListMailNotification("Processing complete for " + e.NewValues["section.client.job_name"].ToString() + " - " + e.NewValues["section.section_name"].ToString(), User.Identity.Name + " indicated that processing is complete for : " + e.NewValues["description"].ToString() );

        }
    }
       
   

        





    
    protected void processing_ItemUpdated(object sender, ListViewUpdatedEventArgs e)
    {





        //ToBeProcessedListView.DataBind();

    }

    /*public string GetRowToBeProcessedColour(Object pExpectedDateObject, Object pDaysNeededToProcessObject)
    {
        DateTime pExpectedDate = new DateTime();
        int pDaysNeededToProcess = 0;

        try{
            pExpectedDate = (DateTime)pExpectedDateObject;
            pDaysNeededToProcess = Convert.ToInt32(pDaysNeededToProcessObject);
        }
        catch(Exception e)
        {
            return "#694141";
        }

        DateHandler dateHandler = new DateHandler();
        try
        {
            int netWorkDays = dateHandler.netWorkingDays(DateTime.Now, pExpectedDate, 2, false);
            

            if (netWorkDays < 1)
            {
                return "#694141";//red - overdue
            }
            else
                if (netWorkDays <= pDaysNeededToProcess)
                {
                    return "#416969";//green - current task
                }
                else
                {
                    return "transparent;";// task for future date
                }
        }
        catch (Exception e)
        {
            // this means that the expected date is older than current date
            return "#694141";
        }


    }*/

    public string GetRowColour(Object pExpectedDateObject)
    {
        DateTime pExpectedDate = new DateTime();


        try
        {
            pExpectedDate = (DateTime)pExpectedDateObject;

        }
        catch (Exception e)
        {
            return "#694141";
        }

        DateHandler dateHandler = new DateHandler();

        try
        {

            int netWorkDays = dateHandler.netWorkingDays(DateTime.Now, pExpectedDate, 2, false);

            if (netWorkDays < 1)
            {
                return "#694141";//red - overdue
            }
            else
                if (netWorkDays >= 1 && netWorkDays <= 5)
            {
                return "#416969";//green - todays task
            }
            else if (netWorkDays >= 6 && netWorkDays <= 15)
            {
                return "#FE9A2E";//yellow - due in the next week
            }
            else
            {
                return "transparent;";// task for future date
            }
        }
        catch (Exception e)
        {
            // this means that the expected date is older than current date
            return "#694141";
        }


    }
    public static string GetPrintTarget(object pStatusObject)
    {
        bool status = false;
        if (pStatusObject != null)
        {
            status = (bool)pStatusObject;
        }

        if (status)
        {
            return "print_site_order.aspx";
        }
        else
        {
            return "print_production_order.aspx";
        }
    }

    public static string GetImage(bool status)
    {
        if (status)
        {
            return "images/yes.png";
        }
        else
        {
            return "images/blank.png";
        }
    }
    public bool GetAllowedToUpdate()
    {
        if (Context.User.IsInRole("Director") || Context.User.IsInRole("Processing Manager"))
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    private void sendJobListMailNotification(string pSubject, string pMessageBody)
    {
        ArrayList addressToList = new ArrayList();


        addressToList.Add("graham");
        addressToList.Add("alex");

        //remove the person that is logging the note
        try
        {
            addressToList.Remove(User.Identity.Name.Trim().ToLower());
        }
        catch (Exception e)
        {
            //in case we trying to remove a user that is not in the list
        }

        //build the toAddress
        String toAddress = "";
        int count = 0;
        foreach (string i in addressToList)
        {
            if (count > 0) { toAddress = toAddress + ","; }
            toAddress = toAddress + i + "@blu-line.co.za";
            count++;
        }

        if (count <= 0)
        {
            //means only person to send the mail to was the person logging the note, whos address is removed
            return;
        }

        EmailSender emailSender = new EmailSender();
        emailSender.setToAddresses(toAddress);
        emailSender.setFromAddress(User.Identity.Name.Trim().ToLower() + "@blu-line.co.za");
        emailSender.setSubject(pSubject);
        emailSender.setBody(pMessageBody);
        emailSender.sendEmail();


    }
            
        

}
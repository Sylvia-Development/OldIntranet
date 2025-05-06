using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;

public partial class orders_management : System.Web.UI.Page
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


    protected void to_be_ordered_DataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {




        var job_list_items = from j in db.job_list_items
                             where j.item_completed == false
                             && (j.default_item_na == null || j.default_item_na == false)
                             && j.production_assistant_to_order == true
                             && j.material_ordered == false
                             && j.manager_has_processed_order == true
                             orderby j.order_reminder_date ascending, j.section_id, j.default_list_Item_order
                             select j;





        e.Result = job_list_items;

    }
    protected void to_be_ordered_ItemUpdating(object sender, ListViewUpdateEventArgs e)
    {


        TextBox notesTextBox = (TextBox)((ListView)sender).EditItem.FindControl("notes_TextBox");
        TextBox orderNoTextBox = (TextBox)((ListView)sender).EditItem.FindControl("order_no_TextBox");
        if (e.OldValues["order_reminder_date"] == null)
            e.OldValues["order_reminder_date"] = System.DateTime.Now;
        if (e.NewValues["order_reminder_date"] == null)
            e.NewValues["order_reminder_date"] = System.DateTime.Now;
        string dateChangeAlert = "";

        if (!e.OldValues["order_reminder_date"].Equals(e.NewValues["order_reminder_date"]))
        {
            //this means the date has been moved and I want to know why 
            if (notesTextBox.Text == null || notesTextBox.Text.Trim().Length <= 0)
            {
                notesTextBox.BackColor = System.Drawing.Color.IndianRed;
                notesTextBox.ForeColor = System.Drawing.Color.White;


                e.Cancel = true;
                return;

            }
            dateChangeAlert = " Order Date moved from " + e.OldValues["order_reminder_date"] + " to " + e.NewValues["order_reminder_date"];

        }
        if (((Boolean)e.OldValues["material_ordered"]) == false && ((Boolean)e.NewValues["material_ordered"]) == true)
        {
            // item has been ticked as ordered, that means they must fill in an order number
            if (orderNoTextBox.Text == null || orderNoTextBox.Text.Trim().Length <= 0)
            {
                orderNoTextBox.BackColor = System.Drawing.Color.IndianRed;
                orderNoTextBox.ForeColor = System.Drawing.Color.White;


                e.Cancel = true;
                return;

            }
            e.NewValues["order_confirmed"] = false;
            e.NewValues["material_ordered_date"] = System.DateTime.Now;
            e.NewValues["material_ordered_by"] = User.Identity.Name;

        }
        //placed this code in updating instead of updated because if the code below throws an exception then it must stop the updating of the task
        if (notesTextBox.Text != null && notesTextBox.Text.Trim().Length > 0)
        {
            //save the note
            job_list_item_note itemNote = new job_list_item_note();
            itemNote.job_list_item_id = Int32.Parse(e.NewValues["id"].ToString());
            itemNote.note_description = notesTextBox.Text;
            itemNote.user_logged = User.Identity.Name;
            itemNote.date_logged = System.DateTime.Now;

            db.job_list_item_notes.InsertOnSubmit(itemNote);

            db.SubmitChanges();
            //send mail

            //sendJobListMailNotification("New Ordering note for " + e.NewValues["section.client.job_name"].ToString() + " - " + e.NewValues["section.section_name"].ToString(), User.Identity.Name + " logged a new \"To Be Ordered\" note for item - " + e.NewValues["description"].ToString() + " ------> " + notesTextBox.Text + " ------> " + dateChangeAlert);
            

        }

        
        


    }
    protected void to_be_ordered_ItemUpdated(object sender, ListViewUpdatedEventArgs e)
    {
        if (((Boolean)e.OldValues["material_ordered"]) == false && ((Boolean)e.NewValues["material_ordered"]) == true)
        {
            // tasks to do if matrial is marked as ordered
            ToBeConfirmedListView.DataBind();


        }
        

    }

    protected void to_be_confirmed_DataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {




        var job_list_items = from j in db.job_list_items
                             where j.item_completed == false
                             && (j.default_item_na == null || j.default_item_na == false)
                             && j.material_ordered == true
                             && j.order_confirmed == false
                             orderby j.material_ordered_date ascending
                             select j;





        e.Result = job_list_items;

    }
    protected void to_be_confirmed_ItemUpdating(object sender, ListViewUpdateEventArgs e)
    {

        DropDownList orderConfirmedDropDown = (DropDownList)ToBeConfirmedListView.EditItem.FindControl("OrderConfirmedMethodDropDown");
        
        if (((Boolean)e.OldValues["order_confirmed"]) == false && ((Boolean)e.NewValues["order_confirmed"]) == true)
        {
            // item has been ticked as confirmed, the method must be filled in
            if (orderConfirmedDropDown.SelectedValue == null || orderConfirmedDropDown.SelectedValue.Trim().Length <= 0)
            {
                orderConfirmedDropDown.BackColor = System.Drawing.Color.IndianRed;
                orderConfirmedDropDown.ForeColor = System.Drawing.Color.White;


                e.Cancel = true;
                return;

            }

            e.NewValues["order_confirmed_date"] = System.DateTime.Now;
            e.NewValues["order_confirmed_by"] = User.Identity.Name;

        }


    }
    protected void to_be_confirmed_ItemUpdated(object sender, ListViewUpdatedEventArgs e)
    {

        ToBeReceivedListView.DataBind();

    }

    protected void to_be_received_DataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {




        var job_list_items = from j in db.job_list_items
                             where j.item_completed == false
                             && (j.default_item_na == null || j.default_item_na == false)
                             && j.material_ordered == true
                             && j.order_confirmed == true
                             && j.material_delivered == false
                             orderby j.receive_by_date ascending
                             select j;





        e.Result = job_list_items;

    }
    protected void to_be_received_ItemUpdating(object sender, ListViewUpdateEventArgs e)
    {

        TextBox notesTextBox = (TextBox)((ListView)sender).EditItem.FindControl("notes_TextBox");
        DateHandler dateHandler = new DateHandler();
        string dateChangeAlert = "";
        ActivityLog log = new ActivityLog();

        if (e.OldValues["receive_by_date"] != null &&  !e.OldValues["receive_by_date"].Equals(e.NewValues["receive_by_date"]))
        {
            //this means the date has been moved and I want to know why 
            if (notesTextBox.Text == null || notesTextBox.Text.Trim().Length <= 0)
            {
                notesTextBox.BackColor = System.Drawing.Color.IndianRed;
                notesTextBox.ForeColor = System.Drawing.Color.White;


                e.Cancel = true;
                return;

            }
            dateChangeAlert = " Receive Date moved from " + e.OldValues["receive_by_date"] + " to " + e.NewValues["receive_by_date"];
                // update the expected date for the joblist info page
            // I commented this next functionality out because it wasnt working to move the processing by date
            
            if (e.NewValues["order_needs_processing"] == null || Convert.ToBoolean(e.NewValues["order_needs_processing"]) == false)
            {

                e.NewValues["date_expected"] = dateHandler.addWorkDays(Convert.ToDateTime(e.NewValues["receive_by_date"]), 1, 2);

            }
            else
            {
                //update the date expected and the new processing date
                
                e.NewValues["processing_completed_by"] = dateHandler.addWorkDays(Convert.ToDateTime(e.NewValues["receive_by_date"]), Convert.ToInt32(e.NewValues["processing_days_needed"]), 2);

                e.NewValues["date_expected"] = dateHandler.addWorkDays(Convert.ToDateTime(e.NewValues["processing_completed_by"]), 1, 2);

            }

        }
        if (((Boolean)e.OldValues["material_delivered"]) == false && ((Boolean)e.NewValues["material_delivered"]) == true)
        {
            // item has been ticked as received, 

            e.NewValues["material_received_date"] = System.DateTime.Now;
            e.NewValues["material_received_by"] = User.Identity.Name;
            if (e.NewValues["order_needs_processing"] == null || Convert.ToBoolean( e.NewValues["order_needs_processing"]) == false)
            {
                e.NewValues["material_processed"] = true;
                e.NewValues["item_completed"] = true;
                e.NewValues["date_completed"] = DateTime.Now.ToString();
                e.NewValues["user_completed"] = User.Identity.Name;
                e.NewValues["date_expected"] = null;

            }

            log.sendStockOrderReceivedEmail(e.NewValues["section.client.job_name"].ToString() + " - " + e.NewValues["section.section_name"].ToString(), User.Identity.Name, e.NewValues["description"].ToString());
            

        }
        //placed this code in updating instead of updated because if the code below throws an exception then it must stop the updating of the task
        if (notesTextBox.Text != null && notesTextBox.Text.Trim().Length > 0)
        {
            //save the note
            job_list_item_note itemNote = new job_list_item_note();
            itemNote.job_list_item_id = Int32.Parse(e.NewValues["id"].ToString());
            itemNote.note_description = notesTextBox.Text;
            itemNote.user_logged = User.Identity.Name;
            itemNote.date_logged = System.DateTime.Now;

            db.job_list_item_notes.InsertOnSubmit(itemNote);

            db.SubmitChanges();

            log.sendStockOrderNotesEmail(e.NewValues["section.client.job_name"].ToString() + " - " + e.NewValues["section.section_name"].ToString(), User.Identity.Name, dateChangeAlert + "------> " + notesTextBox.Text + " : \n\n Original Order Detail:\n\n " + e.NewValues["description"].ToString());
          

        }




    }
    protected void to_be_received_ItemUpdated(object sender, ListViewUpdatedEventArgs e)
    {

        //ToBeProcessedListView.DataBind();

    }

   

    public string GetListCount(string pListCountType)
    {
        string result = "";
        if (pListCountType != null && pListCountType.Equals("General Tasks"))
        {

            int count = (from j in db.job_list_items
                         where j.item_completed == false
                         && j.is_general_task == true
                         && j.manager_has_processed_order == true
                         && j.order_reminder_date.Value.Date <= System.DateTime.Now.Date
                         
                         select j).Count();

            if (count > 0)
                result = "(" + count.ToString() + ")";
        }
        else if (pListCountType != null && pListCountType.Equals("New Orders"))
        {

            int count = (from j in db.job_list_items
                         where j.item_completed == false
                         && (j.default_item_na == null || j.default_item_na == false)
                         && j.production_assistant_to_order == true
                         && j.material_ordered == false
                         && j.manager_has_processed_order == true
                         && j.order_reminder_date.Value.Date <= System.DateTime.Now.Date

                         select j).Count();

           


            if (count > 0)
                result = "(" + count.ToString() + ")";
        }
        else if (pListCountType != null && pListCountType.Equals("Orders Confirmed"))
        {

            int count = (from j in db.job_list_items
                         where j.item_completed == false
                         && j.material_ordered == true
                         && j.order_confirmed == false

                         select j).Count();

            if (count > 0)
                result = "(" + count.ToString() + ")";
        }
        else if (pListCountType != null && pListCountType.Equals("Orders Receiving"))
        {

            int count = (from j in db.job_list_items
                         where j.item_completed == false
                         && j.material_ordered == true
                         && j.order_confirmed == true
                         && j.material_delivered == false
                         && (j.receive_by_date.Value.Date == null || j.receive_by_date.Value.Date <= System.DateTime.Now.Date )

                         select j).Count();

            if (count > 0)
                result = "(" + count.ToString() + ")";
        } 

        return result;

    }

   
    public string GetRowToBeProcessedColour(Object pExpectedDateObject)
    {
        DateTime pExpectedDate = new DateTime();
        if (pExpectedDateObject != null)
        {
            pExpectedDate = (DateTime)pExpectedDateObject;
        }
        else
        {
            return "redrow"; //"#694141";
        }

        DateHandler dateHandler = new DateHandler();
        try
        {
            int netWorkDays = dateHandler.netWorkingDays(DateTime.Now, pExpectedDate, 2, false);

            if (netWorkDays < 1)
            {
                return "redrow"; //"#694141";//red - overdue
            }
            else
                if (netWorkDays == 1)//(netWorkDays >= 1 && netWorkDays <= 4)
            {
                return "greenrow"; //"#416969";//green - todays task
            }
            else if (netWorkDays > 1 && netWorkDays <= 8)
            {
                return "amberrow"; //"#FE9A2E";//yellow - due in the next week
            }
            else
            {
                return "transparent";// task for future date
            }


        
        }
        catch (Exception e)
        {
            // this means that the expected date is older than current date
            return "redrow";
        }


    }

    

}
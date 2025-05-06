using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;


public partial class production_management_new : System.Web.UI.Page
{
    IntranetDataDataContext db = null;
    DateHandler dateHandler = null;


    protected void Page_Init(object sender, EventArgs e)
    {
        db = new IntranetDataDataContext();
        dateHandler = new DateHandler();


    }


    protected void Page_Load(object sender, EventArgs e)
    {

    }


    protected void orders_schedule_DataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {




        var job_list_items = from j in db.job_list_items

                             where j.item_completed == false
                             && (j.default_item_na == null || j.default_item_na == false)
                             && j.order_needs_processing == true
                             && (j.manager_has_processed_order != null && j.manager_has_processed_order == true)
                             && (j.is_snag_list_item == null || j.is_snag_list_item == false)
                             orderby j.processing_completed_by 
                             select j;


       
        


        e.Result = job_list_items;


    }
    protected void orders_schedule_ItemUpdating(object sender, ListViewUpdateEventArgs e)
    {
        e.NewValues["is_main_material_order"] = false;

        TextBox siteDeliveryTextBox = (TextBox)((ListView)sender).EditItem.FindControl("datepicker");
        if (siteDeliveryTextBox.Text == null || siteDeliveryTextBox.Text.Trim().Length <= 0)
        {
            siteDeliveryTextBox.BackColor = System.Drawing.Color.IndianRed;
            siteDeliveryTextBox.ForeColor = System.Drawing.Color.White;
            e.Cancel = true;
            return;
        }

        // set expected date
      if(e.NewValues["processing_completed_by"] != null)
        {
            // update the expected date
            e.NewValues["date_expected"] = dateHandler.addWorkDays(DateTime.Parse(e.NewValues["processing_completed_by"].ToString()), 1, 2);
        }


            if ((bool)(e.OldValues["item_completed"]) == false && (bool)(e.NewValues["item_completed"]) == true)
        {
            e.NewValues["date_completed"] = DateTime.Now.Date;
            e.NewValues["user_completed"] = User.Identity.Name;
        }

    }
    protected void orders_schedule_ItemUpdated(object sender, ListViewUpdatedEventArgs e)
    {
        DateHandler dateHandler = new DateHandler();
        HiddenField hiddenClientName = (HiddenField)((ListView)sender).EditItem.FindControl("hiddenClientName");
        HiddenField hiddenSectionName = (HiddenField)((ListView)sender).EditItem.FindControl("hiddenSectionName");
        HiddenField hiddenSectionId = (HiddenField)((ListView)sender).EditItem.FindControl("sectionId");
        HiddenField hiddenJobListId = (HiddenField)((ListView)sender).EditItem.FindControl("jobListId");
        HiddenField hiddenDeptId = (HiddenField)((ListView)sender).EditItem.FindControl("hiddenDeptId");
        string jobName = hiddenClientName.Value + " - " + hiddenSectionName.Value;


        /*project_date projectDate = new project_date();
        projectDate.section_id = Convert.ToInt32(hiddenSectionId.Value);
        projectDate.into_production_date = DateTime.Now;
        projectDate.in_production = true;
        projectDate.production_complete = false;
        projectDate.factory_scheduled = false;
        projectDate.stock_orders_sent = false;
        projectDate.scheduled_plan_creation = false;
        projectDate.plumbing_electrical_complete = false;
        projectDate.final_measurements_complete = false;
        projectDate.is_job_list_item = true;
        projectDate.client_lead_time = 0;
        projectDate.production_buffer = 0;
        db.project_dates.InsertOnSubmit(projectDate);
        db.SubmitChanges();



        production_control productionControl = new production_control();
        productionControl.section_id = Convert.ToInt32(hiddenSectionId.Value);
        productionControl.cabinets_applicable = false;
        productionControl.cabinets_before_finishes_days = 0;
        productionControl.cabinets_complete = false;
        productionControl.cabinets_days = 0;
        productionControl.communicated_site_delivery_date = false;
        productionControl.custom_structures_applicable = false;
        productionControl.custom_structures_complete = false;
        productionControl.custom_structures_days = 0;
        productionControl.finishes_applicable = false;
        productionControl.finishes_complete = false;
        productionControl.finishes_days = 0;
        productionControl.joblist_item_id = Convert.ToInt32(hiddenJobListId.Value);
        productionControl.order_has_been_setup = false;
        productionControl.plan_generation_applicable = false;
        productionControl.plan_generation_complete = false;
        productionControl.plan_generation_days = 0;
        productionControl.production_buffer = 0;
        productionControl.projects_dates_id = projectDate.id;
        productionControl.supplier_orders_applicable = false;
        productionControl.supplier_orders_complete = false;
        productionControl.supplier_orders_days = 0;

        db.production_controls.InsertOnSubmit(productionControl);


        db.SubmitChanges();*/








       

            if (hiddenDeptId.Value.Equals("7")|| hiddenDeptId.Value.Equals("8")|| hiddenDeptId.Value.Equals("6")|| hiddenDeptId.Value.Equals("3")|| hiddenDeptId.Value.Equals("2")|| hiddenDeptId.Value.Equals("0")) {
            // means it was an order logged by site guys

            // check if site delivery date was changed 
            if (e.OldValues["processing_completed_by"] == null && e.NewValues["processing_completed_by"] != null)
            {
                sendMailNotofication("Site Order delivery DATE SET for " + jobName, User.Identity.Name + " set a Site Order delivery date of : " + dateHandler.addWorkDays(DateTime.Parse(e.NewValues["processing_completed_by"].ToString()), 1, 2).ToString("ddd, d MMM, yyyy") + " for the following Site Order >> \n\n" + e.NewValues["description"]);

            }else if (!e.OldValues["processing_completed_by"].Equals(e.NewValues["processing_completed_by"]))
                {

                    sendMailNotofication("Site Order delivery DATE CHANGED for " + jobName, User.Identity.Name + " changed the Site Order delivery date from : " + (dateHandler.addWorkDays(DateTime.Parse(e.OldValues["processing_completed_by"].ToString()), 1, 2)).ToString("ddd, d MMM, yyyy") + " to " + dateHandler.addWorkDays(DateTime.Parse(e.NewValues["processing_completed_by"].ToString()), 1, 2).ToString("ddd, d MMM, yyyy") + "\n\n" + e.NewValues["description"]);

                }

                    // check if production is now complete 
                if ((bool)(e.OldValues["item_completed"]) == false && (bool)(e.NewValues["item_completed"]) == true)
                {
                    
                    sendMailNotofication("Site Order COMPLETE for " + jobName, User.Identity.Name + " has indicated that Site Order is READY." + "\n\n" + e.NewValues["description"]);
                }
            }
            

        }
    




    protected void production_schedule_DataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {




        var production_schedule = from p in db.project_dates
                                 where p.in_production == true && p.production_complete == false
                                 orderby p.site_delivery_date
                                 select p;




        e.Result = production_schedule;


    }
    protected void production_schedule_ItemUpdating(object sender, ListViewUpdateEventArgs e)
    {
        TextBox siteDeliveryTextBox = (TextBox)((ListView)sender).EditItem.FindControl("datepicker");
        if (siteDeliveryTextBox.Text == null || siteDeliveryTextBox.Text.Trim().Length <= 0)
        {
            siteDeliveryTextBox.BackColor = System.Drawing.Color.IndianRed;
            siteDeliveryTextBox.ForeColor = System.Drawing.Color.White;
            e.Cancel = true;
            return;
        }


        if ((bool)(e.OldValues["production_complete"]) == false && (bool)(e.NewValues["production_complete"]) == true)
        {
            e.NewValues["production_complete_date"] = DateTime.Now.Date;
        }

        if ((bool)(e.OldValues["stock_orders_sent"]) == false && (bool)(e.NewValues["stock_orders_sent"]) == true)
        {
            TextBox taskDateTextBox = (TextBox)((ListView)sender).EditItem.FindControl("datepicker4");
            if (taskDateTextBox.Text == null || taskDateTextBox.Text.Trim().Length <= 0)
            {
                taskDateTextBox.BackColor = System.Drawing.Color.IndianRed;
                taskDateTextBox.ForeColor = System.Drawing.Color.White;
                e.Cancel = true;
                return;
            }
        }
    }
    protected void production_schedule_ItemUpdated(object sender, ListViewUpdatedEventArgs e)
    {

        DateHandler dateHandler = new DateHandler();


        ProductionCompleteListView.DataBind();

        TextBox taskDateTextBox = (TextBox)((ListView)sender).EditItem.FindControl("datepicker4");
        DateTime tasksDate = System.DateTime.Now;
        if (taskDateTextBox.Text != null && taskDateTextBox.Text.Trim().Length > 0)
        {

            tasksDate = Convert.ToDateTime(taskDateTextBox.Text);
        }



        //send the default ordering tasks to prince
        if ((bool)(e.OldValues["stock_orders_sent"]) == false && (bool)(e.NewValues["stock_orders_sent"]) == true)
        {

            var joListDefaults = from j in db.job_list_item_defaults
                                 where j.type == 0
                                 select j;




            foreach (var jld in joListDefaults)
            {
                job_list_item listItem = new job_list_item();
                listItem.is_main_material_order = jld.is_main_material_order;
                listItem.receive_by_date = dateHandler.addWorkDays(tasksDate, Convert.ToInt32(listItem.supplier_lead_time), 2);
                listItem.date_expected = dateHandler.addWorkDays((DateTime)listItem.receive_by_date, 1, 2);
                listItem.item_completed = false;
                listItem.section_id = Convert.ToInt32(e.NewValues["section.section_id"]);
                listItem.production_assistant_to_order = true;
                listItem.material_ordered = false;
                listItem.manager_has_processed_order = true;
                listItem.order_reminder_date = tasksDate;
                listItem.description = jld.description;
                listItem.date_logged = System.DateTime.Now;
                listItem.user_logged = "system";
                listItem.default_list_Item_order = jld.list_item_order;
                listItem.default_item_na = false;
                listItem.is_waste = false;

                db.job_list_items.InsertOnSubmit(listItem);



            }
            db.SubmitChanges();

            



        }

        // check if site delivery date was changed 

        if (!e.OldValues["site_delivery_date"].Equals(e.NewValues["site_delivery_date"]))
        {

            HiddenField hiddenClientName = (HiddenField)((ListView)sender).EditItem.FindControl("hiddenClientName");
            HiddenField hiddenSectionName = (HiddenField)((ListView)sender).EditItem.FindControl("hiddenSectionName");
            string jobName = hiddenClientName.Value + " - " + hiddenSectionName.Value;
            sendMailNotofication("Site Delivery DATE CHANGED for " + jobName, User.Identity.Name + " changed the Site Delivery date from : " + e.OldValues["site_delivery_date"] + " to " + e.NewValues["site_delivery_date"]);

        }

        // check if production is now complete 

        if ((bool)(e.OldValues["production_complete"]) == false && (bool)(e.NewValues["production_complete"]) == true)
        {

            HiddenField hiddenClientName = (HiddenField)((ListView)sender).EditItem.FindControl("hiddenClientName");
            HiddenField hiddenSectionName = (HiddenField)((ListView)sender).EditItem.FindControl("hiddenSectionName");
            string jobName = hiddenClientName.Value + " - " + hiddenSectionName.Value;
            sendMailNotofication("Production COMPLETE for " + jobName, User.Identity.Name + " has indicated that production is COMPLETE." );

        }










    }

    protected void production_complete_DataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {

        DateTime checkDate = dateHandler.addWorkDays(DateTime.Now, 120, 2); // a date in the future to set when not to show past jobs


        var production_schedule = from p in db.project_dates
                                  where p.in_production == true && p.production_complete == true && p.production_complete_date < checkDate
                                  orderby p.site_delivery_date
                                  select p;




        e.Result = production_schedule;

    }

    public string GetOrdersRowColour(Object pExpectedDateObject)
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

    public string GetProductionDateId(Object pProductionDatesObject)
    {
        string result = "---";

        try
        {
            System.Data.Linq.EntitySet<project_date> controls = (System.Data.Linq.EntitySet<project_date>)pProductionDatesObject;
            result = controls.Single().id.ToString();
        }
        catch (Exception e)
        {


        }
        return result;






    }

    public string GetProductionControlId(Object pProductionDatesObject)
    {
        string result = "--";

        try {
            System.Data.Linq.EntitySet<production_control> controls = (System.Data.Linq.EntitySet<production_control>)pProductionDatesObject;
            result = controls.Single().id.ToString();

            /*project_date pd = (from p in db.project_dates
                               where p.id == controls.Single().projects_dates_id
                               select p).Single();

            pd.job_list_item_id = controls.Single().joblist_item_id;
                
            db.SubmitChanges();*/

        }
        catch(Exception e)
        {


        }
        return result;


       
    


    }


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
                if (netWorkDays >= 1 && netWorkDays <= 10)
            {
                return "#416969";//green - todays task
            }
            else if (netWorkDays >= 11 && netWorkDays <= 20)
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

    
    public static string GetYesNoImage(object pStatusObject)
    {
        bool status = false;
        if (pStatusObject != null)
        {
            status = (bool)pStatusObject;
        }

        if (status)
        {
            return "images/yes.png";
        }
        else
        {
            return "images/no.png";
        }
    }

    public static bool GetCanTickComplete(object pFactoryScheduledObject, object pPlansScheduledObject, object pStockOrdersSentObject)
    {
        bool factoryScheduledStatus = false;
        bool plansScheduledStatus = false;
        bool stockOrdersStatus = false;

        try {
            factoryScheduledStatus = (bool)pFactoryScheduledObject;
            plansScheduledStatus = (bool)pPlansScheduledObject;
            stockOrdersStatus = (bool)pStockOrdersSentObject;
        }catch(Exception ex)
        {

        }


        if (factoryScheduledStatus == true && plansScheduledStatus == true && stockOrdersStatus == true)
        {
            return true;
        }
        else
        {
            return false;
        }

        

    }

    private void sendMailNotofication(string pSubject, string pMessageBody)
    {
        ArrayList addressToList = new ArrayList();
        addressToList.Add("graham");
        //addressToList.Add("eugene");
        //addressToList.Add("carron");
        //addressToList.Add("brett");
        //addressToList.Add("corne");

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

        if (count > 0)
        {
            EmailSender emailSender = new EmailSender();
            emailSender.setToAddresses(toAddress);
            emailSender.setSubject(pSubject);
            emailSender.setBody(pMessageBody);
            emailSender.sendEmail();
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





}
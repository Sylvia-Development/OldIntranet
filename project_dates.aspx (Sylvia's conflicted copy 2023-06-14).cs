using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;


public partial class project_dates : System.Web.UI.Page
{

    IntranetDataDataContext db = null;
    DateHandler dateHandler = new DateHandler();

    protected void Page_Init(object sender, EventArgs e)
    {
        db = new IntranetDataDataContext();
        


    }
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void project_dates_DataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {




        var project_dates = from p in db.project_dates
                                 where p.section.quote_status == "Won" &&
                                 p.in_production == false && (p.is_job_list_item == false || p.is_job_list_item == null)
                                 orderby p.site_delivery_date
                                 select p;


     



        e.Result = project_dates.AsEnumerable().OrderBy(i => i, new ItemComparer());


    }




    private class ItemComparer : IComparer<project_date>
    {
        DateHandler dateHandler = new DateHandler();


        public int Compare(project_date x, project_date y)
        {



            DateTime intoProductionX = new DateTime();
            DateTime intoProductionY = new DateTime();

            if (x.site_delivery_date != null && x.client_lead_time != null )
            {

                intoProductionX = GetIntoProductionByDate(x.site_delivery_date.Value, x.client_lead_time.Value);
            }
            if (y.site_delivery_date != null && y.client_lead_time != null)
            {
                intoProductionY = GetIntoProductionByDate(y.site_delivery_date.Value, y.client_lead_time.Value);
            }
            return intoProductionX.CompareTo(intoProductionY);


        }
    }

	public bool getAllowedToEdit()
	{

		bool result = true;

		if (Context.User.IsInRole("Director") || Context.User.IsInRole("System Integration"))
		{
			result = false;

		}
		return result;

	}
	protected void project_dates_ItemUpdating(object sender, ListViewUpdateEventArgs e)
    {

        TextBox siteDeliveryTextBox = (TextBox)((ListView)sender).EditItem.FindControl("datepicker2");
        TextBox leadTimeTextBox = (TextBox)((ListView)sender).EditItem.FindControl("LeadTimeTextBox");
        TextBox bufferTextBox = (TextBox)((ListView)sender).EditItem.FindControl("BufferTextBox");
        try
        {
            DateTime siteDeliveryDate = DateTime.Parse(e.NewValues["site_delivery_date"].ToString());
        }catch  (Exception ex)
        { }

        if (siteDeliveryTextBox.Text == null || siteDeliveryTextBox.Text.Trim().Length <= 0)
        {
            siteDeliveryTextBox.BackColor = System.Drawing.Color.Yellow;
            siteDeliveryTextBox.ForeColor = System.Drawing.Color.Black;
            e.Cancel = true;
            return;
        }
        if (leadTimeTextBox.Text == null || leadTimeTextBox.Text.Trim().Length <= 0)
        {
            leadTimeTextBox.BackColor = System.Drawing.Color.Yellow;
            leadTimeTextBox.ForeColor = System.Drawing.Color.Black;
            e.Cancel = true;
            return;
        }
        if (bufferTextBox.Text == null || bufferTextBox.Text.Trim().Length <= 0)
        {
            bufferTextBox.BackColor = System.Drawing.Color.Yellow;
            bufferTextBox.ForeColor = System.Drawing.Color.Black;
            e.Cancel = true;
            return;
        }

        if  ((bool)(e.NewValues["final_measurements_complete"]) == true) //((bool)(e.OldValues["final_measurements_complete"]) == false)
        {
            e.NewValues["final_measurements_complete_date"] = DateTime.Now.Date;
            e.NewValues["final_measurements_complete_by"] = Context.User.Identity.Name;
        }
        if ((bool)(e.OldValues["in_production"]) == false && (bool)(e.NewValues["in_production"]) == true) // means has been put into production
        {

            Utils util = new Utils();
            
            int productionBuffer = Int32.Parse(e.NewValues["production_buffer"].ToString());
            int projectDateId = Int32.Parse(e.NewValues["id"].ToString());

            DateTime dateWithBuffer = dateHandler.addWorkDays(siteDeliveryDate, (productionBuffer + 1) * -1, 2);
            e.NewValues["site_delivery_date"] = dateWithBuffer;

            job_list_item listItem = new job_list_item();
            listItem.is_main_material_order = true;
            listItem.date_expected = siteDeliveryDate;
            listItem.item_completed = false;
            listItem.section_id = Convert.ToInt32(e.NewValues["section.section_id"]);
            listItem.production_assistant_to_order = false;
            listItem.material_ordered = false;
            listItem.manager_has_processed_order = true;
            //listItem.order_reminder_date = tasksDate;
            listItem.description = "Main Material Manufacturing";
            listItem.date_logged = System.DateTime.Now;
            listItem.user_logged = "system";
            //listItem.default_list_Item_order = jld.list_item_order;
            listItem.default_item_na = false;
            listItem.is_waste = false;
            listItem.order_dispatched = false;

            db.job_list_items.InsertOnSubmit(listItem);
            db.SubmitChanges();

            production_control productionControl = new production_control();
            productionControl.section_id = Convert.ToInt32(e.NewValues["section.section_id"]);
            productionControl.cabinets_applicable = false;
            productionControl.cabinets_before_finishes_days = util.getProductionDefaults().cabinets_before_finishes.Value;
            productionControl.cabinets_complete = false;
            productionControl.cabinets_days = util.getProductionDefaults().cabinets.Value;
            productionControl.communicated_site_delivery_date = true;
            productionControl.custom_structures_applicable = false;
            productionControl.custom_structures_complete = false;
            productionControl.custom_structures_days = util.getProductionDefaults().custom_structures.Value;
            productionControl.finishes_applicable = false;
            productionControl.finishes_complete = false;
            productionControl.finishes_days = util.getProductionDefaults().finishes.Value;
            productionControl.joblist_item_id = listItem.id;
            productionControl.order_has_been_setup = false;
            productionControl.plan_generation_applicable = false;
            productionControl.plan_generation_complete = false;
            productionControl.plan_generation_days = util.getProductionDefaults().plan_generation.Value;
            productionControl.production_buffer = productionBuffer;
            productionControl.projects_dates_id = projectDateId;
            productionControl.supplier_orders_applicable = false;
            productionControl.supplier_orders_complete = false;
            productionControl.supplier_orders_days = util.getProductionDefaults().plan_generation.Value;

            db.production_controls.InsertOnSubmit(productionControl);


            db.SubmitChanges();

            if (!Utils.isContractsJob(getClientId(Convert.ToInt32(e.NewValues["section.section_id"]))))
            {

                // inject tasks for Dept 2 (Twilla)

                /*reminder rem = new reminder();
                rem.type = 0;
                rem.department_id = 2;
                rem.reminder1 = "Email Client and Builder with Provisional Installation Date - site delivery is estimated for " + e.NewValues["site_delivery_date"];
                rem.high_priority = false;
                rem.reminder_order = 0;
                rem.section_id = Convert.ToInt32(e.NewValues["section.section_id"]);
                rem.reminder_status = 0;
                rem.reminder_due_date = System.DateTime.Now.Date;
                rem.date_completed = new DateTime(1901, 1, 1);
                db.reminders.InsertOnSubmit(rem);*/

                reminder rem2 = new reminder();
                rem2.type = 0;
                rem2.department_id = 2;
                rem2.reminder1 = "Book Delivery Vehicle";
                rem2.high_priority = false;
                rem2.reminder_order = 0;
                rem2.section_id = Convert.ToInt32(e.NewValues["section.section_id"]);
                rem2.reminder_status = 0;
                DateTime rem2Date = dateHandler.addWorkDays(siteDeliveryDate, -3, 2); // 3 days before site delivery
                rem2.reminder_due_date = rem2Date;
                rem2.date_completed = new DateTime(1901, 1, 1);
                db.reminders.InsertOnSubmit(rem2);

                reminder rem3 = new reminder();
                rem3.type = 0;
                rem3.department_id = 2;
                rem3.reminder1 = "Find out Access procedures";
                rem3.high_priority = false;
                rem3.reminder_order = 0;
                rem3.section_id = Convert.ToInt32(e.NewValues["section.section_id"]);
                rem3.reminder_status = 0;
                DateTime rem3Date = dateHandler.addWorkDays(siteDeliveryDate, -3, 2); // 3 days before site delivery
                rem3.reminder_due_date = rem3Date;
                rem3.date_completed = new DateTime(1901, 1, 1);
                db.reminders.InsertOnSubmit(rem3);

                reminder rem4 = new reminder();
                rem4.type = 0;
                rem4.department_id = 2;
                rem4.reminder1 = "Send Client & Builder confirmation of delivery";
                rem4.high_priority = false;
                rem4.reminder_order = 0;
                rem4.section_id = Convert.ToInt32(e.NewValues["section.section_id"]);
                rem4.reminder_status = 0;
                DateTime rem4Date = dateHandler.addWorkDays(siteDeliveryDate, -1, 2); // 1 days before site delivery
                rem4.reminder_due_date = rem4Date;
                rem4.date_completed = new DateTime(1901, 1, 1);
                db.reminders.InsertOnSubmit(rem4);

                reminder rem5 = new reminder();
                rem5.type = 0;
                rem5.department_id = 2;
                rem5.reminder1 = "Start the clock on Installtion Time";
                rem5.high_priority = false;
                rem5.reminder_order = 0;
                rem5.section_id = Convert.ToInt32(e.NewValues["section.section_id"]);
                rem5.reminder_status = 0;
                DateTime rem5Date = dateHandler.addWorkDays(siteDeliveryDate, 0, 2); // 0 days before site delivery
                rem5.reminder_due_date = rem5Date;
                rem5.date_completed = new DateTime(1901, 1, 1);
                db.reminders.InsertOnSubmit(rem5);

                // inject tasks for Dept 8 (Quinton)

                reminder rem6 = new reminder();
                rem6.type = 0;
                rem6.department_id = 8;
                rem6.reminder1 = "Schedule Provisional Installation  - site delivery is estimated for " + e.NewValues["site_delivery_date"];
                rem6.high_priority = false;
                rem6.reminder_order = 0;
                rem6.section_id = Convert.ToInt32(e.NewValues["section.section_id"]);
                rem6.reminder_status = 0;
                rem6.reminder_due_date = System.DateTime.Now.Date;
                rem6.date_completed = new DateTime(1901, 1, 1);
                db.reminders.InsertOnSubmit(rem6);

                reminder rem7 = new reminder();
                rem7.type = 0;
                rem7.department_id = 8;
                rem7.reminder1 = "Arrange site meeting for TS to confirm site is ready for installation  (Set followup Reminders to confirm with Client & Builder)";
                rem7.high_priority = false;
                rem7.reminder_order = 0;
                rem7.section_id = Convert.ToInt32(e.NewValues["section.section_id"]);
                rem7.reminder_status = 0;
                DateTime rem7Date = dateHandler.addWorkDays(DateTime.Parse(e.NewValues["site_delivery_date"].ToString()), -20, 2); // 20 days before site delivery
                rem7.reminder_due_date = rem7Date;
                rem7.date_completed = new DateTime(1901, 1, 1);
                db.reminders.InsertOnSubmit(rem7);

                reminder rem8 = new reminder();
                rem8.type = 0;
                rem8.department_id = 8;
                rem8.reminder1 = "Confirm stone (& concrete) installation date with TT & Lenny";
                rem8.high_priority = false;
                rem8.reminder_order = 0;
                rem8.section_id = Convert.ToInt32(e.NewValues["section.section_id"]);
                rem8.reminder_status = 0;
                DateTime rem8Date = dateHandler.addWorkDays(DateTime.Parse(e.NewValues["site_delivery_date"].ToString()), -10, 2); // 10 days before site delivery
                rem8.reminder_due_date = rem8Date;
                rem8.date_completed = new DateTime(1901, 1, 1);
                db.reminders.InsertOnSubmit(rem8);

                reminder rem9 = new reminder();
                rem9.type = 0;
                rem9.department_id = 8;
                rem9.reminder1 = "If Applicable get Michelle to arrange Travel details";
                rem9.high_priority = false;
                rem9.reminder_order = 0;
                rem9.section_id = Convert.ToInt32(e.NewValues["section.section_id"]);
                rem9.reminder_status = 0;
                DateTime rem9Date = dateHandler.addWorkDays(DateTime.Parse(e.NewValues["site_delivery_date"].ToString()), -10, 2); // 10 days before site delivery
                rem9.reminder_due_date = rem9Date;
                rem9.date_completed = new DateTime(1901, 1, 1);
                db.reminders.InsertOnSubmit(rem9);



                // inject tasks for Dept 20 (Jose)

                reminder rem10 = new reminder();
                rem10.type = 0;
                rem10.department_id = 20;
                rem10.reminder1 = "Schedule Plan Generation";
                rem10.high_priority = false;
                rem10.reminder_order = 0;
                rem10.section_id = Convert.ToInt32(e.NewValues["section.section_id"]);
                rem10.reminder_status = 0;
                rem10.reminder_due_date = System.DateTime.Now.Date;
                rem10.date_completed = new DateTime(1901, 1, 1);
                db.reminders.InsertOnSubmit(rem10);

                reminder rem11 = new reminder();
                rem11.type = 0;
                rem11.department_id = 20;
                rem11.reminder1 = "Enter and setup Walls for installation checklists";
                rem11.high_priority = false;
                rem11.reminder_order = 0;
                rem11.section_id = Convert.ToInt32(e.NewValues["section.section_id"]);
                rem11.reminder_status = 0;
                rem11.reminder_due_date = dateHandler.addWorkDays(DateTime.Now.Date, 5, 2);
                rem11.date_completed = new DateTime(1901, 1, 1);
                db.reminders.InsertOnSubmit(rem11);

                // inject tasks for Dept 10 (Tersia)

                reminder rem12 = new reminder();
                rem12.type = 0;
                rem12.department_id = 10;
                rem12.reminder1 = "Send Progress Draw to Client (first confirm Job is still on track) : requested by System";
                rem12.high_priority = false;
                rem12.reminder_order = 0;
                rem12.section_id = Convert.ToInt32(e.NewValues["section.section_id"]);
                rem12.reminder_status = 0;
                DateTime rem12Date = dateHandler.addWorkDays(siteDeliveryDate, -10, 2); // 10 days before site delivery
                rem12.reminder_due_date = rem12Date;
                rem12.date_completed = new DateTime(1901, 1, 1);
                db.reminders.InsertOnSubmit(rem12);



                db.SubmitChanges();
            }





            e.NewValues["into_production_date"] = DateTime.Now.Date;
            e.NewValues["job_list_item_id"] = listItem.id;
        }
        
    }

        
    protected void project_dates_ItemUpdated(object sender, ListViewUpdatedEventArgs e)
    {

        HiddenField hiddenClientName = (HiddenField)((ListView)sender).EditItem.FindControl("hiddenClientName");
        HiddenField hiddenSectionName = (HiddenField)((ListView)sender).EditItem.FindControl("hiddenSectionName");
        string jobName = hiddenClientName.Value + " - " + hiddenSectionName.Value;
        ActivityLog log = new ActivityLog();

        if ((bool)(e.OldValues["final_measurements_complete"]) == false && (bool)(e.NewValues["final_measurements_complete"]) == true)
        {
            log.sendFinalMeasurmentsEmail(jobName, User.Identity.Name);
        }



            if ((bool)(e.OldValues["in_production"]) == false && (bool)(e.NewValues["in_production"]) == true)
        {
            
            log.sendJobPutIntoProductionEmail(jobName, User.Identity.Name);
        }


        InProductionListView.DataBind();

    }

    protected void in_production_DataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {




        var project_dates = from p in db.project_dates
                            where p.in_production == true && p.production_complete == false && (p.is_job_list_item == false || p.is_job_list_item == null)
                            orderby p.site_delivery_date descending
                            select p;


        

        e.Result = project_dates;


    }

    protected void in_production_ItemUpdating(object sender, ListViewUpdateEventArgs e)
    {

        /*TextBox siteDeliveryTextBox = (TextBox)((ListView)sender).EditItem.FindControl("datepicker4");
        TextBox bufferTextBox = (TextBox)((ListView)sender).EditItem.FindControl("BufferTextBox2");
        if (siteDeliveryTextBox.Text == null || siteDeliveryTextBox.Text.Trim().Length <= 0)
        {
            siteDeliveryTextBox.BackColor = System.Drawing.Color.IndianRed;
            siteDeliveryTextBox.ForeColor = System.Drawing.Color.White;
            e.Cancel = true;
            return;
        }

        if (bufferTextBox.Text == null || bufferTextBox.Text.Trim().Length <= 0)
        {
            bufferTextBox.BackColor = System.Drawing.Color.IndianRed;
            bufferTextBox.ForeColor = System.Drawing.Color.White;
            e.Cancel = true;
            return;
        }*/


        if ((bool)(e.OldValues["in_production"]) == true && (bool)(e.NewValues["in_production"]) == false)// means the job has been taken out of production
        {
            e.NewValues["into_production_date"] = null;


        }
        /*if ((!e.OldValues["production_buffer"].Equals(e.NewValues["production_buffer"]))
         || (!e.OldValues["site_delivery_date"].Equals(e.NewValues["site_delivery_date"])))// means the buffer or site delivery has changed
        {
            //updated the joblist expected date
            HiddenField hiddenJobListItemId = (HiddenField)((ListView)sender).EditItem.FindControl("jobListItemId");

            var jobList = (from j in db.job_list_items where j.id == Int32.Parse(hiddenJobListItemId.Value) select j).Single();

            jobList.date_expected = DateTime.Parse(e.NewValues["site_delivery_date"].ToString());

            //jobList.date_expected = dateHandler.addWorkDays(DateTime.Parse(e.NewValues["site_delivery_date"].ToString()), (Int32.Parse(e.NewValues["production_buffer"].ToString()) + 1) * -1, 2);

            jobList.production_controls.SingleOrDefault().production_buffer = Int32.Parse(e.NewValues["production_buffer"].ToString());
            db.SubmitChanges();

            if (!e.OldValues["site_delivery_date"].Equals(e.NewValues["site_delivery_date"])){

                ActivityLog log = new ActivityLog();
                log.sendJobSiteDeliveryDateChangedEmail(jobList.section.client.job_name + " - " + jobList.section.section_name, User.Identity.Name,DateTime.Parse(e.OldValues["site_delivery_date"].ToString()).ToString("ddd, d MMM, yyyy"), DateTime.Parse(e.NewValues["site_delivery_date"].ToString()).ToString("ddd, d MMM, yyyy"));

            }


        }*/
    }


    protected void in_production_ItemUpdated(object sender, ListViewUpdatedEventArgs e)
    {



        HiddenField hiddenSectionId = (HiddenField)((ListView)sender).EditItem.FindControl("sectionId");
        HiddenField hiddenClientName = (HiddenField)((ListView)sender).EditItem.FindControl("hiddenClientName");
        HiddenField hiddenSectionName = (HiddenField)((ListView)sender).EditItem.FindControl("hiddenSectionName");
        string jobName = hiddenClientName.Value + " - " + hiddenSectionName.Value;
        if ((bool)(e.OldValues["in_production"]) == true && (bool)(e.NewValues["in_production"]) == false)// means the job has been taken out of production
        {

            var projectDateObject = (from p in db.project_dates where p.section_id == Int32.Parse(hiddenSectionId.Value) select p).Single();
            projectDateObject.job_list_item_id = null;
            db.SubmitChanges();


            var controlObject = from c in db.production_controls where c.section_id == Int32.Parse(hiddenSectionId.Value) select c;

            db.production_controls.DeleteAllOnSubmit(controlObject);

            db.SubmitChanges();

            var jobListObject = from j in db.job_list_items where j.section_id == Int32.Parse(hiddenSectionId.Value) && j.description == "Main Material Manufacturing" select j;

            db.job_list_items.DeleteAllOnSubmit(jobListObject);

            db.SubmitChanges();

            ActivityLog log = new ActivityLog();
            log.sendJobTakenOutOfProductionEmail(jobName, User.Identity.Name);

        }

        InProductionListView.DataBind();
        ProjectDatesListView.DataBind();

    }


    private int getClientId(int pSectionId)
    {
        

        var clientId = from p in db.sections
                      where p.section_id == pSectionId
                      select p.client_id;


        return clientId.FirstOrDefault();

    }

    public static string GetApplianceYesNoImage(object pSectionObject)
    {
        section sectionObject = null;
        bool status = false;


        if (pSectionObject != null)
            sectionObject = (section)pSectionObject;

        if(sectionObject.section_appliances != null && sectionObject.section_appliances.Count() > 0)
        {
            status = (bool)sectionObject.section_appliances.Single().confirmed;

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
    public static bool GetCanGoIntoProduction(object pSectionObject, object pFinalMeasureStatusObject)
    {
        section sectionObject = null;
        bool finalMeasureStatus = false;
        if (pFinalMeasureStatusObject != null)
        {
            finalMeasureStatus = (bool)pFinalMeasureStatusObject;
        }
        bool status = false;


        if (pSectionObject != null)
            sectionObject = (section)pSectionObject;
        else
            return false;

        // first check is section status is set to won 
        if (sectionObject.quote_status != null && sectionObject.quote_status.Equals("Won"))
        {

            if (sectionObject.section_appliances != null && sectionObject.section_appliances.Count() > 0)
            {
                status = (bool)sectionObject.section_appliances.Single().confirmed;

            }
            if (status) // if appliances where confirmed then check if final measurments were done
            {
                status = finalMeasureStatus;

            }
            if(status) // iff all good then final check is to make sure that the into production date is today so that all lead times and dates will be up to date when going into production
            {
                DateHandler dateHandler = new DateHandler();
                DateTime siteDeliveryDate;
                int clientLeadTime = 0;
                DateTime dateIntoProductionBy;
                int netWorkDays = 0;
                try {
                    siteDeliveryDate = sectionObject.project_dates.Single(o => o.is_job_list_item != true).site_delivery_date.Value;
                    clientLeadTime = sectionObject.project_dates.Single(o => o.is_job_list_item != true).client_lead_time.Value;

                    //siteDeliveryDate = sectionObject.project_dates.Single().site_delivery_date.Value;
                    //clientLeadTime = sectionObject.project_dates.Single().client_lead_time.Value;
                }catch (Exception e)
                {
                    return false;
                }
                if (siteDeliveryDate != null && clientLeadTime != 0)
                {
                    dateIntoProductionBy = dateHandler.addWorkDays(siteDeliveryDate, (clientLeadTime + 1) * -1, 2);

                    netWorkDays = dateHandler.netWorkingDays(DateTime.Now, dateIntoProductionBy, 2, false);
                }
                if (netWorkDays != 1)// means dateIntoProductionBy is not today so you are not allowed to send it to production until the lead times are set correctly
                    status = false;
            }

        }
        return status;
    }

    public string GetRowColour(Object pSiteDeliveryDateObject, Object pClientLeadTimeObject)
    {
		//TableRow row = new TableRow();


		try
		{
            DateTime dateIntoProductionBy = DateTime.Parse( GetIntoProductionByDate(pSiteDeliveryDateObject, pClientLeadTimeObject));  
            int netWorkDays = dateHandler.netWorkingDays(DateTime.Now, dateIntoProductionBy, 2, false);

            if (netWorkDays < 1)
            {
                return "redrow";
                //return row.Attributes.Add("class", "greenrow");

                    /*.Attributes.Add("class", "redrow");*/

				/*"#ff3743";*///"#694141";red - overdue#ff3743

			}
			else
                if (netWorkDays == 1)//(netWorkDays >= 1 && netWorkDays <= 4)
            {
                return "greenrow"; //"#2e8b57";//green - todays task
            }
            else if (netWorkDays > 1 && netWorkDays <= 8)
            {
                return "amberrow"; //"#ed9121 "; //"#FE9A2E";yellow - due in the next week

			}
            else
            {
                return ""; //"transparent;";// task for future date
            }
        }
        catch (Exception e)
        {
            // this means that the expected date is older than current date
            return "redrow";
        }


    }



    public string GetExactDate(Object pWonDateObject)
    {
        DateTime wonDate = new DateTime();
       


        try
        {
            wonDate = (DateTime)pWonDateObject;
            
        }
        catch (Exception e)
        {
            return "-";
        }



        return dateHandler.addWorkDays(wonDate, 50 , 2).ToString("ddd, d MMM, yyyy");



    }




    public static DateTime GetIntoProductionByDate(DateTime pSiteDeliveryDate, int pClientLeadTime)
    {
        // this method contain the logic of working out into production date 

        DateTime dateIntoProductionBy = new DateTime();
        DateHandler dateHandler = new DateHandler();
        
        
        dateIntoProductionBy = dateHandler.addWorkDays(pSiteDeliveryDate, (pClientLeadTime +1) * -1, 2);


        return dateIntoProductionBy;



    }

    public string GetIntoProductionByDate(Object pSiteDeliveryDateObject, Object pClientLeadTimeObject)
    {
        DateTime siteDeliveryDate = new DateTime();
        int clientLeadTime = 0;
        
        
        try
        {
            siteDeliveryDate = (DateTime)pSiteDeliveryDateObject;
            clientLeadTime = (int)pClientLeadTimeObject;
        }
        catch (Exception e)
        {
            return "-";
        }
       


       return GetIntoProductionByDate(siteDeliveryDate, clientLeadTime).ToString("ddd, d MMM, yyyy");



    }
    public string GetProductionCompleteByDate(Object pSiteDeliveryDateObject, Object pProductionBufferObject)
    {
        DateTime siteDeliveryDate = new DateTime();       
        int productionBuffer = 0;
        DateTime productionCompleteBy = new DateTime();



        try
        {
            siteDeliveryDate = (DateTime)pSiteDeliveryDateObject;
            
            productionBuffer = (int)pProductionBufferObject;
        }
        catch (Exception e)
        {
            return "-";
        }

        productionCompleteBy = dateHandler.addWorkDays(siteDeliveryDate, (productionBuffer+1) * -1, 2);


        return productionCompleteBy.ToString("ddd, d MMM, yyyy");



    }


    public string GetProductionCompleteByInWeeks(Object pSiteDeliveryDateObject, Object pClientLeadTimeObject, Object pProductionBufferObject)
    {
        DateTime productionCompleteDate = new DateTime();
        DateTime intoProductionDate = new DateTime();
        try {
             productionCompleteDate = DateTime.Parse(GetProductionCompleteByDate(pSiteDeliveryDateObject, pProductionBufferObject));
             intoProductionDate = DateTime.Parse(GetIntoProductionByDate(pSiteDeliveryDateObject, pClientLeadTimeObject));
        }
        catch(Exception e)
        {
            return "-";

        }

        int netWorkDays = dateHandler.netWorkingDays(intoProductionDate, productionCompleteDate, 2, true);

        return "("+Math.Round((decimal)netWorkDays/5,1)+" weeks / "+netWorkDays+" days)";



    }


    public string GetLeadTimeInWeeks(Object pClientLeadTimeObject)
    {
        
        int clientLeadTime = 0;
        

       



        try
        {
            
            clientLeadTime = (int)pClientLeadTimeObject;
            
        }
        catch (Exception e)
        {
            return "-";
        }

       

        return "(" + Math.Round((decimal)clientLeadTime / 5, 1) + " weeks)";



    }



    

}
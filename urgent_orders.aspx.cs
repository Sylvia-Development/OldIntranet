using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using System.Text;

public partial class urgent_orders : System.Web.UI.Page
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

    

    protected void new_orders_DataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {


        //project_date projectdate = new project_date();



        var production_control = from p in db.production_controls
                                 where p.order_has_been_setup == false && p.project_date.in_production == true
                                 && p.job_list_item.is_main_material_order == false
                                 orderby p.job_list_item.date_logged
                                 select p;
        
        e.Result = production_control;






    }
    protected void new_orders_ItemUpdating(object sender, ListViewUpdateEventArgs e)
    {

        CheckBox naCheckbox = (CheckBox)((ListView)sender).EditItem.FindControl("naCheckBox");
        CheckBox ordersCheckBox = (CheckBox)((ListView)sender).EditItem.FindControl("ordersCheckBox");

        TextBox siteDeliveryDate = (TextBox)((ListView)sender).EditItem.FindControl("datepicker");
        TextBox ordersReceivedByDate = (TextBox)((ListView)sender).EditItem.FindControl("datepicker2");


        if (naCheckbox.Checked == false)
        {
                     
            if (siteDeliveryDate.Text.Trim().Length <= 0)
            {
                siteDeliveryDate.BackColor = System.Drawing.Color.IndianRed;
                siteDeliveryDate.ForeColor = System.Drawing.Color.White;
                e.Cancel = true;
                return;
            }
            if(ordersCheckBox.Checked == true)
            {
                if (ordersReceivedByDate.Text.Trim().Length <= 0)
                {
                    ordersReceivedByDate.BackColor = System.Drawing.Color.IndianRed;
                    ordersReceivedByDate.ForeColor = System.Drawing.Color.White;
                    e.Cancel = true;
                    return;
                }


            }
      
        }
        else // means the item has been marked NA so I dont want any other values to have been set
        {
            if (ordersCheckBox.Checked == true )
            {

                ordersCheckBox.BackColor = System.Drawing.Color.IndianRed;              
                e.Cancel = true;
                return;
            }
            if (ordersReceivedByDate.Text.Trim().Length > 0)
            {
                ordersReceivedByDate.BackColor = System.Drawing.Color.IndianRed;
                ordersReceivedByDate.ForeColor = System.Drawing.Color.White;
                e.Cancel = true;
                return;
            }

            if (siteDeliveryDate.Text.Trim().Length > 0)
            {
                siteDeliveryDate.BackColor = System.Drawing.Color.IndianRed;
                siteDeliveryDate.ForeColor = System.Drawing.Color.White;
                e.Cancel = true;
                return;
            }


        }
        
        
        e.NewValues["order_has_been_setup"] = true;

        
        
         

    }
    protected void new_orders_ItemUpdated(object sender, ListViewUpdatedEventArgs e)
    {



        CheckBox ordersCheckBox = (CheckBox)((ListView)sender).EditItem.FindControl("ordersCheckBox");
        HiddenField hiddenJobName = (HiddenField)((ListView)sender).EditItem.FindControl("hiddenJobName");
        HiddenField hiddenSectionName = (HiddenField)((ListView)sender).EditItem.FindControl("hiddenSectionName");
        HiddenField description = (HiddenField)((ListView)sender).EditItem.FindControl("hiddenDescription");
        string jobName = hiddenJobName.Value + " - " + hiddenSectionName.Value;
        CheckBox naCheckbox = (CheckBox)((ListView)sender).EditItem.FindControl("naCheckBox");
        TextBox siteDeliveryDateTB = (TextBox)((ListView)sender).EditItem.FindControl("datepicker");

        HiddenField projectsDatesId = (HiddenField)((ListView)sender).EditItem.FindControl("projectsDatesId");
        HiddenField joblistId = (HiddenField)((ListView)sender).EditItem.FindControl("jobListId");
        
        
        
        job_list_item jobListItem = (from j in db.job_list_items
                                     where j.id == Int32.Parse(joblistId.Value)
                                     select j).Single();
        if (naCheckbox.Checked == false)
        {

            project_date projectDate = (from p in db.project_dates
                                        where p.id == Int32.Parse(projectsDatesId.Value)
                                        select p).Single();

            DateTime siteDeliveryDate = DateTime.Parse(siteDeliveryDateTB.Text);

            projectDate.site_delivery_date = siteDeliveryDate;
            projectDate.production_buffer = 0;

            jobListItem.date_expected = siteDeliveryDate;

            logConfirmation(jobListItem.id);

            ActivityLog log = new ActivityLog();
            log.sendSiteOrderDateSetEmail(jobName, User.Identity.Name, siteDeliveryDate.ToString("ddd, d MMM, yyyy"), description.Value);



            ProductionScheduleListView.DataBind();

            // insert logistics control record 

            logistics_control logisticsControl = new logistics_control();
            logisticsControl.vehicle_confirmed = false;
            logisticsControl.team_confirmed = false;
            logisticsControl.accommodation_confirmed = false;
            logisticsControl.delivery_complete = false;
            logisticsControl.delivery_note_uploaded = false;
            logisticsControl.job_list_item_id = Int32.Parse(joblistId.Value);
            logisticsControl.site_delivery_date = dateHandler.addWorkDays(siteDeliveryDate, 3, 2);

            db.logistics_controls.InsertOnSubmit(logisticsControl);
            db.SubmitChanges();

            // log the initial logistics control confirmation 
            logistics_control_confirmation confirmation = new logistics_control_confirmation();
            confirmation.logistics_control_id = logisticsControl.id;
            confirmation.confirmed_date = DateTime.Now;
            confirmation.user_confirmed = "System";
            db.logistics_control_confirmations.InsertOnSubmit(confirmation);
            db.SubmitChanges();



            // insert a stock order for procurement if the order neeeds supplier orders 
            if (ordersCheckBox.Checked == true)
            {
                TextBox ordersReceivedByDateTB = (TextBox)((ListView)sender).EditItem.FindControl("datepicker2");
                DateTime ordersReceivedByDate = DateTime.Parse(ordersReceivedByDateTB.Text);

                job_list_item item = new job_list_item();

                item.department_id = 1;
                item.section_id = jobListItem.section_id;
                item.date_logged = DateTime.Now;
                item.order_reminder_date = DateTime.Now;
                item.date_expected = ordersReceivedByDate;
                item.receive_by_date = ordersReceivedByDate;
                item.user_logged = User.Identity.Name;
                item.is_main_material_order = false;
                item.manager_has_processed_order = true;
                item.order_needs_processing = false;
                item.production_assistant_to_order = true;
                item.manager_processed_date = DateTime.Now;
                item.manager_processed_name = User.Identity.Name;
                item.default_item_na = false;
                item.is_waste = false;

                item.description = "-------- FOR SUPPLIER ORDER PURPOSES -------- \n\nPLEASE PLACE SUPPLIER ORDERS NEEDED FOR THE ORDER BELOW\n\n" + description.Value;




                db.job_list_items.InsertOnSubmit(item);

                db.SubmitChanges();
                ActivityLog log2 = new ActivityLog();
                log2.sendStockOrderAddedEmail(jobName, User.Identity.Name, description.Value);

            }




        }
        else
        {
            

           jobListItem.default_item_na = true;
       

        }
        db.SubmitChanges();


        




    }

    

    protected void production_schedule_DataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {

        string pOderBy = Page.Request.QueryString["pOrderBy"];

        
        if (pOderBy == null)
        {
            pOderBy = "productionDate";
        }

        if (pOderBy.Equals("productionDate")){

            var production_control = from p in db.production_controls
                                     where p.job_list_item.item_completed == false
                                     && p.job_list_item.is_main_material_order == false
                                     && p.order_has_been_setup == true
                                     && p.project_date.in_production == true
                                     && (p.job_list_item.default_item_na == null || p.job_list_item.default_item_na == false)

                                     orderby p.job_list_item.date_expected
                                     select p;


            e.Result = production_control;

        }
        else if (pOderBy.Equals("loggedDate")){

                var production_control = from p in db.production_controls
                                         where p.job_list_item.item_completed == false
                                         && p.job_list_item.is_main_material_order == false
                                         && p.order_has_been_setup == true
                                         && p.project_date.in_production == true
                                         && (p.job_list_item.default_item_na == null || p.job_list_item.default_item_na == false)

                                         orderby p.job_list_item.date_logged
                                         select p;


                e.Result = production_control;
            }

       // e.Result = production_control.AsEnumerable().OrderBy(i => i, new ItemComparer());


    }
   /* private class ItemComparer : IComparer<production_control>
    {
        DateHandler dateHandler = new DateHandler();


        public int Compare(production_control x, production_control y)
        {


            DateTime dateToCompleteByX = dateHandler.addWorkDays(x.project_date.site_delivery_date.Value, (x.production_buffer.Value + 1) * -1, 2);
            DateTime dateToCompleteByY = dateHandler.addWorkDays(y.project_date.site_delivery_date.Value, (y.production_buffer.Value + 1) * -1, 2);



            return dateToCompleteByX.CompareTo(dateToCompleteByY);


        }
    }*/


    protected void production_schedule_ItemUpdating(object sender, ListViewUpdateEventArgs e)
    {

        TextBox newSiteDeliveryDateTB = (TextBox)((ListView)sender).EditItem.FindControl("datepicker");
        CheckBox itemCompleteCheckBox = (CheckBox)((ListView)sender).EditItem.FindControl("itemCompleteCheckBox");
        CheckBox itemNACheckBox = (CheckBox)((ListView)sender).EditItem.FindControl("itemNACheckbox");
        HiddenField oldSiteDeliveryDateHF = (HiddenField)((ListView)sender).EditItem.FindControl("siteDeliveryDate");



        if (itemNACheckBox.Checked == false)
        {


            if (newSiteDeliveryDateTB.Text.Trim().Length <= 0)
            {
                newSiteDeliveryDateTB.BackColor = System.Drawing.Color.IndianRed;
                newSiteDeliveryDateTB.ForeColor = System.Drawing.Color.White;
                e.Cancel = true;
                return;
            }

            DateTime newSiteDeliveryDate = DateTime.Parse(newSiteDeliveryDateTB.Text);
            DateTime oldSiteDeliveryDate = DateTime.Parse(oldSiteDeliveryDateHF.Value);



            HiddenField hiddenJobListId = (HiddenField)((ListView)sender).EditItem.FindControl("jobListId");

            if (!newSiteDeliveryDate.Equals(oldSiteDeliveryDate))

            {
                // means that the site delivery date has changed 

                HiddenField projectsDatesId = (HiddenField)((ListView)sender).EditItem.FindControl("projectsDatesId");
                HiddenField joblistId = (HiddenField)((ListView)sender).EditItem.FindControl("jobListId");


                project_date projectDate = (from p in db.project_dates
                                            where p.id == Int32.Parse(projectsDatesId.Value)
                                            select p).Single();


                projectDate.site_delivery_date = newSiteDeliveryDate;



                job_list_item jobListItem = (from j in db.job_list_items
                                             where j.id == Int32.Parse(joblistId.Value)
                                             select j).Single();

                jobListItem.date_expected = newSiteDeliveryDate;

                db.SubmitChanges();

                HiddenField hiddenJobName = (HiddenField)((ListView)sender).EditItem.FindControl("hiddenJobName");
                HiddenField hiddenSectionName = (HiddenField)((ListView)sender).EditItem.FindControl("hiddenSectionName");
                HiddenField description = (HiddenField)((ListView)sender).EditItem.FindControl("hiddenDescription");

                string jobName = hiddenJobName.Value + " - " + hiddenSectionName.Value;

                logConfirmation(jobListItem.id);

                ActivityLog log = new ActivityLog();
                log.sendSiteOrderDateChangeEmail(jobName, User.Identity.Name, oldSiteDeliveryDate.ToString("ddd, d MMM, yyyy"), newSiteDeliveryDate.ToString("ddd, d MMM, yyyy"), description.Value);



            }




            if (itemCompleteCheckBox.Checked == true)
            { // means that item has been set to complete 

                var jobListObject = (from j in db.job_list_items where j.id == Int32.Parse(hiddenJobListId.Value) select j).Single();



                jobListObject.item_completed = true;
                jobListObject.date_completed = DateTime.Now.Date;
                jobListObject.user_completed = User.Identity.Name;

                db.SubmitChanges();

                HiddenField hiddenJobName = (HiddenField)((ListView)sender).EditItem.FindControl("hiddenJobName");
                HiddenField hiddenSectionName = (HiddenField)((ListView)sender).EditItem.FindControl("hiddenSectionName");
                HiddenField description = (HiddenField)((ListView)sender).EditItem.FindControl("hiddenDescription");

                string jobName = hiddenJobName.Value + " - " + hiddenSectionName.Value;

                ActivityLog log = new ActivityLog();
                log.sendSiteOrderCompletedEmail(jobName, User.Identity.Name, description.Value);



            }

        }
        else // means the item has been marked NA so I dont want any other values to have been set
        {
            if (itemCompleteCheckBox.Checked == true)
            {

                itemCompleteCheckBox.BackColor = System.Drawing.Color.IndianRed;
                e.Cancel = true;
                return;
            }

            DateTime newSiteDeliveryDate = DateTime.Parse(newSiteDeliveryDateTB.Text);
            DateTime oldSiteDeliveryDate = DateTime.Parse(oldSiteDeliveryDateHF.Value);



            

            if (!newSiteDeliveryDate.Equals(oldSiteDeliveryDate))
            {// means the date has been changed but the NA checkbox was ticked 

                newSiteDeliveryDateTB.BackColor = System.Drawing.Color.IndianRed;
                newSiteDeliveryDateTB.ForeColor = System.Drawing.Color.White;
                e.Cancel = true;
                return;
            }
        }






        }
    protected void production_schedule_ItemUpdated(object sender, ListViewUpdatedEventArgs e)
    {

        CheckBox itemNACheckBox = (CheckBox)((ListView)sender).EditItem.FindControl("itemNACheckbox");
        if (itemNACheckBox.Checked == true)// mark the item as NA
        {
            HiddenField joblistId = (HiddenField)((ListView)sender).EditItem.FindControl("jobListId");
            job_list_item jobListItem = (from j in db.job_list_items
                                         where j.id == Int32.Parse(joblistId.Value)
                                         select j).Single();

            jobListItem.default_item_na = true;
            jobListItem.item_completed = true;
            jobListItem.date_completed = DateTime.Now.Date;
            jobListItem.user_completed = User.Identity.Name;
            db.SubmitChanges();

            
           

            var x = from d in db.section_dispatch_items
                     where d.job_list_order_id == Int32.Parse(joblistId.Value)
                     select d;
            
            
            // delete all the log items 
            foreach (var di in x)
            {
                var y = from d in db.section_dispatch_log_items
                         where d.dispatch_item_id == di.id
                         select d;
                db.section_dispatch_log_items.DeleteAllOnSubmit(y);
                db.SubmitChanges();
            }
                


            db.section_dispatch_items.DeleteAllOnSubmit(x);
            db.SubmitChanges();


        }


    }


    private DateTime getSiteDeliveryDate(DateTime intoProductionDate, int pBuffer, int pFinishes, int pStructures, int pCabinets)
    {
        int totalDaysAllocated = 0;

        //find the longest days needed
        int maxDays = Math.Max(pFinishes, pStructures);
        maxDays = Math.Max(maxDays, pCabinets);

        totalDaysAllocated = maxDays + pBuffer;

       

        return dateHandler.addWorkDays(intoProductionDate, totalDaysAllocated + 1, 2);

    }



    public void confirmClick(object sender, CommandEventArgs e)
    {


        int jobListId = Int32.Parse(e.CommandArgument.ToString());

        logConfirmation(jobListId);

        ProductionScheduleListView.DataBind();





    }

    private void logConfirmation(int pJobListItemId)
    {
        production_date_confirmation confirmation = new production_date_confirmation();
        confirmation.job_list_item_id = pJobListItemId;
        confirmation.confirmed_date = DateTime.Now;
        confirmation.user_confirmed = User.Identity.Name;

        db.production_date_confirmations.InsertOnSubmit(confirmation);


        db.SubmitChanges();


    }


    public static string GetLastConfirmationDetails(object jobListItemObject)
    {

        string info = "--";

        try
        {

            job_list_item jobListItem = (job_list_item)jobListItemObject;
            DateTime lastConfirmationDate = jobListItem.production_date_confirmations.Last().confirmed_date;
            String userConfirmed = jobListItem.production_date_confirmations.Last().user_confirmed;


            info = lastConfirmationDate.ToString("ddd, d MMM, yyyy") + " by " + userConfirmed;






        }
        catch (Exception e)
        {


        }






        return info;
    }



    public static string GetConfirmButtonImage(object jobListItemObject)
    {

        string imageUrl = "images/alert.png";

        try
        {

            job_list_item jobListItem = (job_list_item)jobListItemObject;
            DateTime lastConfirmationDate = jobListItem.production_date_confirmations.Last().confirmed_date;
            DateTime siteDeliveryDate = (DateTime)jobListItem.project_dates.First().site_delivery_date;
            DateHandler dateHandler = new DateHandler();
            int daysUntilDelivery = dateHandler.netWorkingDays(DateTime.Now, siteDeliveryDate, 2, false);
            int daysElapsed = dateHandler.netWorkingDays(lastConfirmationDate, DateTime.Now, 2, false);

            int daysControl = 0;
            if (daysUntilDelivery > 15)// three weeks plus away from delivery
                daysControl = 5;
            else if (daysUntilDelivery > 5) // between 6 - 15 days away from delivery
                daysControl = 2;
            else  // less than a week to delivery 
                daysControl = 1;


            if (daysElapsed > daysControl)
                imageUrl = "images/alert.png";
            else
                imageUrl = "images/confirmed.png";





        }
        catch (Exception e)
        {


        }






        return imageUrl;
    }



    public string GetRowColour(Object pSiteDeliveryDateObject)
    {

        try
        {
            DateTime siteDeliveryDate = (DateTime)pSiteDeliveryDateObject;



            int netWorkDays = dateHandler.netWorkingDays(DateTime.Now, siteDeliveryDate, 2, false);

            if (netWorkDays < 1)
            {
                return "redrow";        // "#694141";//red - overdue
            }
            else
                if (netWorkDays >= 1 && netWorkDays <= 5)
            {
                return "greenrow";           //"#416969";//green - 
            }
            else if (netWorkDays > 5 && netWorkDays <= 15)
            {
                return "amberrow";  //"#FE9A2E";//yellow - due in the next week
            }
            else
            {
                return "transparent;";// task for future date
            }
        }
        catch (Exception e)
        {
            // this means that the expected date is older than current date
            return "redrow";   // "#694141";
        }


    }



    public static string GetPackageImage(object orderIdObject)
    {
        int orderId = -1;
        if (orderIdObject != null)
            orderId = (int)orderIdObject;


        bool status = areAnyPackagesLoaded(orderId);

        if (status)
        {
            return "images/yes.png";
        }
        else
        {
            return "images/no.png";
        }
    }
    public static bool areAnyPackagesLoaded(int pOrderId)
    {
        

        IntranetDataDataContext db = new IntranetDataDataContext();

        var anyPackages = (from sp in db.section_dispatch_items
                           where sp.job_list_order_id == pOrderId
                           select sp).Any();

       
        
        
        return anyPackages;
    }




    public static bool GetEnabled(string pType, System.Security.Principal.IPrincipal pUser)
    {
        bool status = false;

        if (pType.Equals("days"))
        {
            if (pUser.IsInRole("Director") || pUser.IsInRole("Production Controller"))
                status = true;
        }
        else if (pType.Equals("applicable"))
        {
            if (pUser.IsInRole("Director") || pUser.IsInRole("Production Controller"))
                status = true;
        }
        else if (pType.Equals("plansComplete"))
        {
            if (pUser.IsInRole("Director") || pUser.IsInRole("Production Controller") || pUser.IsInRole("Technical Administrator"))
                status = true;

        }
        else if (pType.Equals("ordersComplete"))
        {
            if (pUser.IsInRole("Director") || pUser.IsInRole("Production Controller"))
                status = true;

        }
        else if (pType.Equals("finishesComplete"))
        {
            if (pUser.IsInRole("Director") || pUser.IsInRole("Production Controller") || pUser.IsInRole("Finishes Coordinator"))
                status = true;

        }
        else if (pType.Equals("structuresComplete"))
        {
            if (pUser.IsInRole("Director") || pUser.IsInRole("Production Controller") || pUser.IsInRole("Production Team Coordinator"))
                status = true;

        }
        else if (pType.Equals("cabinetsComplete"))
        {
            if (pUser.IsInRole("Director") || pUser.IsInRole("Production Controller") || pUser.IsInRole("Production Team Coordinator"))
                status = true;

        }


        return status;



    }


    public string GetDoneByDate(Object pSectionObject, String pType, Object pProductionControlIdObject)
    {
        section pSection = new section();
        production_control pProductionControl = new production_control();
        DateTime productionCompleteByDate = new DateTime();
        int pProductionControlId = (int)pProductionControlIdObject;



        try
        {
            pSection = (section)pSectionObject;
            pProductionControl = pSection.production_controls.Where(p => p.id == pProductionControlId).Single();
        }
        catch (Exception e)
        {
            return productionCompleteByDate.ToString();
        }



        try
        {

             productionCompleteByDate = DateTime.Parse(GetProductionByDate(pProductionControl.project_date.site_delivery_date.Value, pProductionControl.production_buffer.Value));


           
          


            /*if (pType.ToLower().Equals("finishes"))
            {

                dateToCompleteBy = dateHandler.addWorkDays(productionCompleteByDate,pProductionControl.finishes_days.Value*-1, 2);



            }
            else if (pType.ToLower().Equals("structures"))
            {

                dateToCompleteBy = dateHandler.addWorkDays(productionCompleteByDate, pProductionControl.custom_structures_days.Value*-1, 2);


            }
            else if (pType.ToLower().Equals("cabinets"))
            {

                
                    dateToCompleteBy = dateHandler.addWorkDays(productionCompleteByDate,pProductionControl.cabinets_days.Value*-1, 2);
                

            }*/


        }
        catch (Exception e)
        {

            return productionCompleteByDate.ToString();
        }

        return productionCompleteByDate.ToString("ddd, d MMM, yyyy");
    }

    public string GetStartByDate(Object pSectionObject, String pType, Object pProductionControlIdObject)
    {
        section pSection = new section();
        production_control pProductionControl = new production_control();
        DateTime dateToCompleteBy = new DateTime();
        DateTime dateToStartBy = new DateTime();
        int pProductionControlId = (int)pProductionControlIdObject;



        try
        {
            pSection = (section)pSectionObject;
            pProductionControl = pSection.production_controls.Where(p => p.id == pProductionControlId).Single();
        }
        catch (Exception e)
        {
            return dateToCompleteBy.ToString();
        }

        try
        {
            dateToCompleteBy = DateTime.Parse(GetDoneByDate(pSectionObject, pType, pProductionControlIdObject));

            if (pType.ToLower().Equals("finishes"))
            {

                dateToStartBy = dateHandler.addWorkDays(dateToCompleteBy, (pProductionControl.finishes_days.Value - 1) * -1, 2);

            }
            else if (pType.ToLower().Equals("structures"))
            {

                dateToStartBy = dateHandler.addWorkDays(dateToCompleteBy, (pProductionControl.custom_structures_days.Value - 1) * -1, 2);

            }
            else if (pType.ToLower().Equals("cabinets"))
            {

                dateToStartBy = dateHandler.addWorkDays(dateToCompleteBy, (pProductionControl.cabinets_days.Value - 1) * -1, 2);

            }


        }
        catch (Exception e)
        {

            return dateToStartBy.ToString();
        }

        return dateToStartBy.ToString("ddd, d MMM, yyyy");
    }


    public static bool GetIsNotMainMaterial(object pStatusObject)
    {

        bool status = false;
        if (pStatusObject != null)
        {
            status = (bool)pStatusObject;
        }


        return !status;
    }


    public string GetProductionByDate(DateTime pSiteDeliveryDate, int pProductionBuffer)
    {

        DateTime dateToCompleteBy = dateHandler.addWorkDays(pSiteDeliveryDate, (pProductionBuffer + 1) * -1, 2);

        return dateToCompleteBy.ToString("ddd, d MMM, yyyy");

    }


    public string GetProductionByDate(Object pSiteDeliveryDateObject, Object pProductionBufferObject)
    {

        return GetProductionByDate((DateTime)pSiteDeliveryDateObject, (int)pProductionBufferObject);
    }

    protected void validate_order_proceessing(object source, ServerValidateEventArgs args)
    {

        /* CustomValidator sender = (CustomValidator)source;
         DropDownList orderActionDropDown = (DropDownList)ToBeOrderedListView.EditItem.FindControl("OrderActionDropDown");

         if (orderActionDropDown.SelectedValue.Equals("0"))
         {
             args.IsValid = true;

         }
         else if (orderActionDropDown.SelectedValue.Equals("1"))
         {
             CheckBox needsProcessingCheckbox = (CheckBox)ToBeOrderedListView.EditItem.FindControl("needs_processing_checkbox");
             if (needsProcessingCheckbox.Checked)
             {
                 if (sender.ControlToValidate.Equals("datepicker") || sender.ControlToValidate.Equals("processing_days_needed"))
                 {
                     if (args.Value == null || args.Value.Trim().Length <= 0)
                     {
                         args.IsValid = false;
                     }
                     else if (sender.ControlToValidate.Equals("processing_days_needed"))
                     {
                         int result;
                         if (!int.TryParse(args.Value, out result))
                         {
                             args.IsValid = false;
                         }

                     }
                 }

             }
         }
         else if (orderActionDropDown.SelectedValue.Equals("2"))
         {

             if (sender.ControlToValidate.Equals("datepicker")
                 || sender.ControlToValidate.Equals("processing_days_needed")
                 || sender.ControlToValidate.Equals("order_no_textbox"))
             {
                 if (args.Value == null || args.Value.Trim().Length <= 0)
                 {
                     args.IsValid = false;
                 }
                 else if (sender.ControlToValidate.Equals("processing_days_needed"))
                 {
                     int result;
                     if (!int.TryParse(args.Value, out result))
                     {
                         args.IsValid = false;
                     }

                 }
             }

         }
         else if (orderActionDropDown.SelectedValue.Equals("3"))
         {

             if (sender.ControlToValidate.Equals("datepicker2")
                 || sender.ControlToValidate.Equals("order_no_textbox"))
             {
                 if (args.Value == null || args.Value.Trim().Length <= 0)
                 {
                     args.IsValid = false;
                 }
             }

         }
         else if (orderActionDropDown.SelectedValue.Equals("4"))
         {

             if (sender.ControlToValidate.Equals("datepicker3"))
             {
                 if (args.Value == null || args.Value.Trim().Length <= 0)
                 {
                     args.IsValid = false;
                 }
             }

         }

     */
    }

    public static string GetDailyReportImage(object pIdObject, String pType)
    {
        int id = 0;
        if (pIdObject != null)
            id = (int)pIdObject;



        return "Images/tasks.png";

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

   










}
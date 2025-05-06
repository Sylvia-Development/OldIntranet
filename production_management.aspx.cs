using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using System.Text;
using System.Drawing;

public partial class production_management : System.Web.UI.Page
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


        project_date projectdate = new project_date();



        var production_control = from p in db.production_controls
                                 where p.order_has_been_setup == false && p.project_date.in_production == true
                                 && p.job_list_item.is_main_material_order == true
                                 orderby p.job_list_item.date_logged
                                 select p;


        e.Result = production_control;






    }
    protected void new_orders_ItemUpdating(object sender, ListViewUpdateEventArgs e)
    {

        TextBox siteDeliveryDate = (TextBox)((ListView)sender).EditItem.FindControl("datepicker");

        if (siteDeliveryDate.Text.Trim().Length <= 0)
        {
            siteDeliveryDate.BackColor = System.Drawing.Color.IndianRed;
            siteDeliveryDate.ForeColor = System.Drawing.Color.White;
            e.Cancel = true;
            return;
        }


        e.NewValues["order_has_been_setup"] = true;

       
    }
    protected void new_orders_ItemUpdated(object sender, ListViewUpdatedEventArgs e)
    {

        TextBox siteDeliveryDateTB = (TextBox)((ListView)sender).EditItem.FindControl("datepicker");
        DateTime siteDeliveryDate = DateTime.Parse(siteDeliveryDateTB.Text);


        HiddenField projectsDatesId = (HiddenField)((ListView)sender).EditItem.FindControl("projectsDatesId");
        project_date projectDate = (from p in db.project_dates
                                    where p.id == Int32.Parse(projectsDatesId.Value)
                                    select p).Single();



        projectDate.site_delivery_date = siteDeliveryDate;
        

        db.SubmitChanges();

        logConfirmation((int)projectDate.job_list_item_id);

        ActivityLog log = new ActivityLog();
        log.sendProductionConfirmDateEmail(projectDate.section.client.job_name + "-" + projectDate.section.section_name, User.Identity.Name, ((DateTime)(projectDate.job_list_item.date_expected)).ToString("ddd, d MMM, yyyy"), ((DateTime)(projectDate.site_delivery_date)).ToString("ddd, d MMM, yyyy"));


        ProductionScheduleListView.DataBind();

        // insert logistics control record 

        logistics_control logisticsControl = new logistics_control();
        logisticsControl.vehicle_confirmed = false;
        logisticsControl.team_confirmed = false;
        logisticsControl.accommodation_confirmed = false;
        logisticsControl.delivery_complete = false;
        logisticsControl.delivery_note_uploaded = false;
        logisticsControl.job_list_item_id = projectDate.job_list_item_id;
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


    }


    protected void production_schedule_DataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {
        



            var production_control = from p in db.production_controls
                                     where p.job_list_item.item_completed == false
                                     && p.job_list_item.is_main_material_order == true
                                     && p.order_has_been_setup == true
                                     && p.project_date.in_production == true

                                     orderby p.project_date.site_delivery_date
                                     select p;


        e.Result = production_control;

                 //e.Result = production_control.AsEnumerable().OrderBy(i => i, new ItemComparer());
            
        
    }
    /*  private class ItemComparer : IComparer<production_control>
      {
          DateHandler dateHandler = new DateHandler(); 


      public int Compare(production_control x, production_control y)
      {


             DateTime dateToCompleteByX = dateHandler.addWorkDays(x.project_date.site_delivery_date.Value , (x.production_buffer.Value + 1) * -1, 2);
              DateTime dateToCompleteByY = dateHandler.addWorkDays(y.project_date.site_delivery_date.Value, (y.production_buffer.Value + 1) * -1, 2);



              return dateToCompleteByX.CompareTo(dateToCompleteByY);


      }
      }*/


    protected void production_schedule_ItemUpdating(object sender, ListViewUpdateEventArgs e)
    {

        TextBox newSiteDeliveryDateTB = (TextBox)((ListView)sender).EditItem.FindControl("datepicker");
        CheckBox itemCompleteCheckBox = (CheckBox)((ListView)sender).EditItem.FindControl("itemCompleteCheckBox");
        HiddenField oldSiteDeliveryDateHF = (HiddenField)((ListView)sender).EditItem.FindControl("siteDeliveryDate");



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
        HiddenField projectsDatesId = (HiddenField)((ListView)sender).EditItem.FindControl("projectsDatesId");
        HiddenField joblistId = (HiddenField)((ListView)sender).EditItem.FindControl("jobListId");
        if (!newSiteDeliveryDate.Equals(oldSiteDeliveryDate))

        {
            // means that the site delivery date has changed 

            


            project_date projectDate = (from p in db.project_dates
                                        where p.id == Int32.Parse(projectsDatesId.Value)
                                        select p).Single();


            projectDate.site_delivery_date = newSiteDeliveryDate;

            db.SubmitChanges();

           

            HiddenField hiddenJobName = (HiddenField)((ListView)sender).EditItem.FindControl("hiddenJobName");
            HiddenField hiddenSectionName = (HiddenField)((ListView)sender).EditItem.FindControl("hiddenSectionName");
            HiddenField description = (HiddenField)((ListView)sender).EditItem.FindControl("hiddenDescription");

            string jobName = hiddenJobName.Value + " - " + hiddenSectionName.Value;

            logConfirmation((int)projectDate.job_list_item_id);

            ActivityLog log = new ActivityLog();
            log.sendProductionDateChangedEmail(jobName, User.Identity.Name, oldSiteDeliveryDate.ToString("ddd, d MMM, yyyy"), newSiteDeliveryDate.ToString("ddd, d MMM, yyyy"),((DateTime)(projectDate.job_list_item.date_expected)).ToString("ddd, d MMM, yyyy"));



        }




        if (itemCompleteCheckBox.Checked == true)
        { // means that item has been set to complete 

            var jobListObject = (from j in db.job_list_items where j.id == Int32.Parse(hiddenJobListId.Value) select j).Single();



            jobListObject.item_completed = true;
            jobListObject.date_completed = DateTime.Now;
            jobListObject.user_completed = User.Identity.Name;

            db.SubmitChanges();

            project_date projectDate = (from p in db.project_dates
                                        where p.id == Int32.Parse(projectsDatesId.Value)
                                        select p).Single();


            projectDate.production_complete = true;
            projectDate.production_complete_date = DateTime.Now;

            db.SubmitChanges();

            HiddenField hiddenJobName = (HiddenField)((ListView)sender).EditItem.FindControl("hiddenJobName");
            HiddenField hiddenSectionName = (HiddenField)((ListView)sender).EditItem.FindControl("hiddenSectionName");
            HiddenField description = (HiddenField)((ListView)sender).EditItem.FindControl("hiddenDescription");

            string jobName = hiddenJobName.Value + " - " + hiddenSectionName.Value;

            ActivityLog log = new ActivityLog();
            
            log.sendProductionCompleteEmail(jobName, User.Identity.Name);



        }








    }
    protected void production_schedule_ItemUpdated(object sender, ListViewUpdatedEventArgs e)
    {









    }

    public void confirmClick(object sender, CommandEventArgs e)
    {


        int jobListId = Int32.Parse(e.CommandArgument.ToString());

        production_date_confirmation confirmation = new production_date_confirmation();

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

        try {

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
                return "redrow"; //"#694141";//red - overdue
            }
            else
                if (netWorkDays >= 1 && netWorkDays <= 5)
            {
                return "greenrow";// "#416969";//green - 
            }
            else if (netWorkDays > 5 && netWorkDays <= 15)
            {
                return "amberrow";    //"#FE9A2E";//yellow - due in the next week
            }
            else
            {
                return "transparent;";// task for future date
            }
        }
        catch (Exception e)
        {
            // this means that the expected date is older than current date
            return "redrow"; //"#694141";
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


    public int getDefaultLeadTimes(String pType)
    {

        production_lead_time defaults =  (from p in db.production_lead_times select p).Single();

        int result = 0;

        if (pType.ToLower().Equals("plans"))
            result = defaults.plan_generation.Value;
        else if (pType.ToLower().Equals("orders"))
            result = defaults.supplier_orders.Value;
        else if (pType.ToLower().Equals("finishes"))
            result = defaults.finishes.Value;
        else if (pType.ToLower().Equals("structures"))
            result = defaults.custom_structures.Value;
        else if (pType.ToLower().Equals("cabinets"))
            result = defaults.cabinets.Value;
        else if (pType.ToLower().Equals("cabinets_before_finishes"))
            result = defaults.cabinets_before_finishes.Value;
        else if (pType.ToLower().Equals("client_lead_time"))
            result = defaults.client_lead_time.Value; 
        else if (pType.ToLower().Equals("production_buffer"))
            result = defaults.production_buffer.Value; 

        return result;



    }

    
    public string GetTDColour(Object pSectionObject,String pType, Object pProductionControlIdObject)
    {
        section pSection = new section();
        production_control pProductionControl = new production_control();
        int pProductionControlId = (int)pProductionControlIdObject;


        try
        {
            pSection = (section)pSectionObject;
            pProductionControl = pSection.production_controls.Where(p => p.id == pProductionControlId).Single();
            
        }
        catch (Exception e)
        {
            return "#694141";
        }

       

       try
        {
            int allocatedDays = 0;

            if (pType.ToLower().Equals("plans"))
            {

                

                if (pProductionControl.plan_generation_applicable == false)
                    return "black";
                if (pProductionControl.plan_generation_complete == true)
                    return "azure";

                allocatedDays = pProductionControl.plan_generation_days.Value;
       
            }
            else if (pType.ToLower().Equals("orders"))
            {
                if(pProductionControl.supplier_orders_applicable == false)
                    return "black";
                if (pProductionControl.supplier_orders_complete == true)
                    return "azure";

                allocatedDays = pProductionControl.supplier_orders_days.Value;

            }    
            else if (pType.ToLower().Equals("finishes"))
            {
                if(pProductionControl.finishes_applicable == false)
                    return "black";
                if (pProductionControl.finishes_complete == true)
                    return "azure";

                allocatedDays = pProductionControl.finishes_days.Value;
            }    
            else if (pType.ToLower().Equals("structures"))
            {
                if(pProductionControl.custom_structures_applicable == false)
                    return "black";
                if (pProductionControl.custom_structures_complete == true)
                    return "azure";

                allocatedDays = pProductionControl.custom_structures_days.Value;

            }   
            else if (pType.ToLower().Equals("cabinets"))
            {
                if(pProductionControl.cabinets_applicable == false)
                    return "black";
                if (pProductionControl.cabinets_complete == true)
                    return "azure";

                allocatedDays = pProductionControl.cabinets_days.Value;

            }

            
            DateTime dateToCompleteBy = DateTime.Parse(GetDoneByDate(pSectionObject, pType, pProductionControlIdObject));
            DateTime overallProductionCompleteDate = DateTime.Parse( GetProductionByDate(pProductionControl.project_date.site_delivery_date.Value, pProductionControl.project_date.production_buffer.Value));
                
                


            if (dateToCompleteBy > overallProductionCompleteDate)
                return "#694141";//red - overdue


            int netWorkDays = dateHandler.netWorkingDays(DateTime.Now, dateToCompleteBy, 2, false);




            if (netWorkDays < 1)
            {
                return "#694141";//red - overdue
            }
            else
                if (netWorkDays >= 1 && netWorkDays <= allocatedDays)
                {
                    return "#416969";//green - todays task
                }
                else if (netWorkDays > allocatedDays && netWorkDays <= allocatedDays+5)
                {
                    return "#FE9A2E";//yellow - due in the next week
                }else
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

    public static bool GetEnabled(string pType,System.Security.Principal.IPrincipal pUser)
    {
        bool status = false;

        if (pType.Equals("days"))
        {
            if(pUser.IsInRole("Director") || pUser.IsInRole("Production Controller"))
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

        } else if (pType.Equals("ordersComplete"))
        {
            if (pUser.IsInRole("Director") || pUser.IsInRole("Production Controller"))
                status = true;

        } else if (pType.Equals("finishesComplete"))
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
        DateTime dateToCompleteBy = new DateTime();
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

            DateTime productionCompleteByDate = DateTime.Parse(GetProductionByDate(pProductionControl.project_date.site_delivery_date.Value, pProductionControl.production_buffer.Value));
        

            int greaterOfFinishesOrStructuresDays = 0;
            if (pProductionControl.finishes_days.Value >= pProductionControl.custom_structures_days.Value)
                greaterOfFinishesOrStructuresDays = pProductionControl.finishes_days.Value;
            else
                greaterOfFinishesOrStructuresDays = pProductionControl.custom_structures_days.Value;

            int totalCabinetDays = 0;
            if (pProductionControl.cabinets_days.Value > 0)
            {
                totalCabinetDays = pProductionControl.cabinets_days.Value;
                if (pProductionControl.cabinets_before_finishes_days.Value > 0)
                {
                    totalCabinetDays = totalCabinetDays - (pProductionControl.cabinets_before_finishes_days.Value + 1);

                }

            }



            int totalProductionDays = pProductionControl.plan_generation_days.Value + pProductionControl.supplier_orders_days.Value + greaterOfFinishesOrStructuresDays + totalCabinetDays;



            if (pType.ToLower().Equals("plans"))
            {

                dateToCompleteBy = dateHandler.addWorkDays(productionCompleteByDate, (totalProductionDays - pProductionControl.plan_generation_days.Value)*-1 , 2);




            }
            else if (pType.ToLower().Equals("orders"))
            {
              
                    dateToCompleteBy = dateHandler.addWorkDays(productionCompleteByDate, (totalProductionDays - (pProductionControl.plan_generation_days.Value + pProductionControl.supplier_orders_days.Value))*-1, 2);


            }
            else if (pType.ToLower().Equals("finishes"))
            {
                
                    dateToCompleteBy = dateHandler.addWorkDays(productionCompleteByDate, (totalProductionDays - (pProductionControl.plan_generation_days.Value + pProductionControl.supplier_orders_days.Value+ greaterOfFinishesOrStructuresDays)) * -1, 2);//pProductionControl.finishes_days.Value))*-1, 2);



            }
            else if (pType.ToLower().Equals("structures"))
            {
               
                    dateToCompleteBy = dateHandler.addWorkDays(productionCompleteByDate, (totalProductionDays - (pProductionControl.plan_generation_days.Value + pProductionControl.supplier_orders_days.Value + greaterOfFinishesOrStructuresDays)) * -1, 2);//pProductionControl.custom_structures_days.Value))*-1, 2);


            }
            else if (pType.ToLower().Equals("cabinets"))
            {

                //if (pProductionControl.finishes_complete_date != null)
                   // dateToCompleteBy = dateHandler.addWorkDays(pProductionControl.finishes_complete_date.Value, (pProductionControl.cabinets_days.Value - pProductionControl.cabinets_before_finishes_days.Value) , 2);
                //else
                    dateToCompleteBy = dateHandler.addWorkDays(productionCompleteByDate, (totalProductionDays - (pProductionControl.plan_generation_days.Value + pProductionControl.supplier_orders_days.Value + greaterOfFinishesOrStructuresDays  + (pProductionControl.cabinets_days.Value - (pProductionControl.cabinets_before_finishes_days.Value+1) )))*-1, 2);


            }


        }
        catch (Exception e)
        {
            
            return dateToCompleteBy.ToString();
        }

        return dateToCompleteBy.ToString("ddd, d MMM, yyyy");
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

           if (pType.ToLower().Equals("plans"))
           {
          
               dateToStartBy = dateHandler.addWorkDays(dateToCompleteBy, (pProductionControl.plan_generation_days.Value -1) * -1, 2);

           }
           else if (pType.ToLower().Equals("orders"))
           {

               dateToStartBy = dateHandler.addWorkDays(dateToCompleteBy, (pProductionControl.supplier_orders_days.Value -1) * -1, 2);

           }
           else if (pType.ToLower().Equals("finishes"))
           {
      
               dateToStartBy = dateHandler.addWorkDays(dateToCompleteBy, (pProductionControl.finishes_days.Value -1) * -1, 2);

           }
           else if (pType.ToLower().Equals("structures"))
           {
  
               dateToStartBy = dateHandler.addWorkDays(dateToCompleteBy, (pProductionControl.custom_structures_days.Value -1) * -1, 2);

           }
           else if (pType.ToLower().Equals("cabinets"))
           {

               dateToStartBy = dateHandler.addWorkDays(dateToCompleteBy, (pProductionControl.cabinets_days.Value -1) * -1, 2);

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


    public string GetProductionByDate(Object pSiteDeliveryDateObject,Object pProductionBufferObject)
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

    public string GetLeadTimeInWeeks(Object pIntoProductionDateObject)
    {



        

        DateTime intoProductionDate = (DateTime)pIntoProductionDateObject;

        

        int currentLeadTime = dateHandler.netWorkingDays(intoProductionDate, DateTime.Now, 2, true);


        decimal weeksWithDay = Math.Round((decimal)currentLeadTime / 5, 1);
        decimal weeksOnly = Math.Round((decimal)currentLeadTime / 5, 0);
        int daysOnly = (int)((weeksWithDay - weeksOnly)*5);


        

        return "(" + weeksOnly + " weeks "+daysOnly+" days)";



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
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class logistics_control : System.Web.UI.Page
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


    protected void logistics_schedule_DataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {




        var logistics_control = from l in db.logistics_controls
                                 where l.delivery_complete == false && l.job_list_item.default_item_na == false
                                 orderby l.site_delivery_date
                                 select l;


        e.Result = logistics_control;
        

    }
    


    protected void logistics_schedule_ItemUpdating(object sender, ListViewUpdateEventArgs e)
    {

        TextBox vehicleTB = (TextBox)((ListView)sender).EditItem.FindControl("vehicleTextBox");
        TextBox teamTB = (TextBox)((ListView)sender).EditItem.FindControl("teamTextBox");
        TextBox accomTB = (TextBox)((ListView)sender).EditItem.FindControl("accomTextBox");
        TextBox siteDeliveryDateTB = (TextBox)((ListView)sender).EditItem.FindControl("datepicker");
        TextBox deliveryCompleteDateTB = (TextBox)((ListView)sender).EditItem.FindControl("datepicker2");
        HiddenField oldSiteDeliveryDateHF = (HiddenField)((ListView)sender).EditItem.FindControl("originalSiteDeliveryDate");
        HiddenField productionCompleteHF = (HiddenField)((ListView)sender).EditItem.FindControl("productionCompleteHF");
        Label productionCompleteLabel = (Label)((ListView)sender).EditItem.FindControl("productionCompleteLabel");
        Label manufacturedLabel = (Label)((ListView)sender).EditItem.FindControl("manufacturedLabel");
        Label verifiedLabel = (Label)((ListView)sender).EditItem.FindControl("verifiedLabel");
        Label dispatchLabel = (Label)((ListView)sender).EditItem.FindControl("dispatchLabel");


        CheckBox vehicleCheckBox = (CheckBox)((ListView)sender).EditItem.FindControl("vehicleCheckBox");
        CheckBox teamCheckBox = (CheckBox)((ListView)sender).EditItem.FindControl("teamCheckBox");
        CheckBox accomCheckBox = (CheckBox)((ListView)sender).EditItem.FindControl("accomCheckBox");
        CheckBox deliveryCompleteCheckBox = (CheckBox)((ListView)sender).EditItem.FindControl("deliveryCompleteCheckBox");
        CheckBox deliveryNoteUploadedCheckBox = (CheckBox)((ListView)sender).EditItem.FindControl("deliveryNoteUploaded");



        if (vehicleCheckBox.Checked == true)
        {
            if (vehicleTB.Text.Trim().Length <= 0)
            {
                vehicleTB.BackColor = System.Drawing.Color.IndianRed;
                vehicleTB.ForeColor = System.Drawing.Color.White;
                e.Cancel = true;
                return;
            }

        }
        if (teamCheckBox.Checked == true)
        {
            if (teamTB.Text.Trim().Length <= 0)
            {
                teamTB.BackColor = System.Drawing.Color.IndianRed;
                teamTB.ForeColor = System.Drawing.Color.White;
                e.Cancel = true;
                return;
            }

        }
        if (accomCheckBox.Checked == true)
        {
            if (accomTB.Text.Trim().Length <= 0)
            {
                accomTB.BackColor = System.Drawing.Color.IndianRed;
                accomTB.ForeColor = System.Drawing.Color.White;
                e.Cancel = true;
                return;
            }

        }
        if (siteDeliveryDateTB.Text.Trim().Length <= 0)
        {
            siteDeliveryDateTB.BackColor = System.Drawing.Color.IndianRed;
            siteDeliveryDateTB.ForeColor = System.Drawing.Color.White;
            e.Cancel = true;
            return;
        }
        if(deliveryCompleteCheckBox.Checked == true)
        {
            if (productionCompleteHF.Value.Equals("False"))// means production is not complete 
            {
                
                productionCompleteLabel.BackColor = System.Drawing.Color.IndianRed;
                productionCompleteLabel.ForeColor = System.Drawing.Color.White;
                e.Cancel = true;
                return;

            }
            if (!manufacturedLabel.Text.Equals("0"))// means there are items still in production
            {

                manufacturedLabel.BackColor = System.Drawing.Color.IndianRed;
                manufacturedLabel.ForeColor = System.Drawing.Color.White;
                e.Cancel = true;
                return;

            }
            if (!verifiedLabel.Text.Equals("0"))// means there are items still in production
            {

                verifiedLabel.BackColor = System.Drawing.Color.IndianRed;
                verifiedLabel.ForeColor = System.Drawing.Color.White;
                e.Cancel = true;
                return;

            }
            if (!dispatchLabel.Text.Equals("0"))// means there is an open disptch event 
            {

                dispatchLabel.BackColor = System.Drawing.Color.IndianRed;
                dispatchLabel.ForeColor = System.Drawing.Color.White;
                e.Cancel = true;
                return;

            }


            if (deliveryNoteUploadedCheckBox.Checked == false)
            {
                deliveryNoteUploadedCheckBox.BackColor = System.Drawing.Color.IndianRed;
                deliveryNoteUploadedCheckBox.ForeColor = System.Drawing.Color.White;
                e.Cancel = true;
                return;

            }
            if (deliveryCompleteDateTB.Text.Trim().Length <= 0)
            {
                deliveryCompleteDateTB.BackColor = System.Drawing.Color.IndianRed;
                deliveryCompleteDateTB.ForeColor = System.Drawing.Color.White;
                e.Cancel = true;
                return;
            }


        }




        DateTime newSiteDeliveryDate = DateTime.Parse(siteDeliveryDateTB.Text);
        DateTime oldSiteDeliveryDate = DateTime.Parse(oldSiteDeliveryDateHF.Value);

        HiddenField hiddenJobName = (HiddenField)((ListView)sender).EditItem.FindControl("hiddenJobName");
        HiddenField hiddenSectionName = (HiddenField)((ListView)sender).EditItem.FindControl("hiddenSectionName");
        HiddenField logisticsControlId = (HiddenField)((ListView)sender).EditItem.FindControl("logisticsControlId");
        Label description = (Label)((ListView)sender).EditItem.FindControl("descriptionLabel");

        string jobName = hiddenJobName.Value + " - " + hiddenSectionName.Value;



        if (!newSiteDeliveryDate.Equals(oldSiteDeliveryDate))

        {
            // means that the site delivery date has changed 

            logConfirmation(Int32.Parse(logisticsControlId.Value));

            ActivityLog log = new ActivityLog();
            log.sendSiteDeliveryDateChangedEmail(jobName,description.Text, User.Identity.Name, oldSiteDeliveryDate.ToString("ddd, d MMM, yyyy, HH:mm"), newSiteDeliveryDate.ToString("ddd, d MMM, yyyy, HH:mm"));

            logLogisticsNoteBySystem(Int32.Parse(logisticsControlId.Value), User.Identity.Name + " changed the Site Delivery Date Time from " + oldSiteDeliveryDate.ToString("ddd, d MMM, yyyy, HH:mm") + " to " + newSiteDeliveryDate.ToString("ddd, d MMM, yyyy, HH:mm"));

        }
        if (deliveryCompleteCheckBox.Checked == true)
        {
            // means delivery has been checked complete 

            DateTime deliveryCompleteDate = DateTime.Parse(deliveryCompleteDateTB.Text);

            ActivityLog log = new ActivityLog();
            log.sendDeliveryCompleteEmail(jobName, description.Text, User.Identity.Name, deliveryCompleteDate.ToString("ddd, d MMM, yyyy, HH:mm"));

            logLogisticsNoteBySystem(Int32.Parse(logisticsControlId.Value), User.Identity.Name + " ticked off Delivery as Complete with a Actual Site Delivery Date as " + deliveryCompleteDate.ToString("ddd, d MMM, yyyy, HH:mm"));


        }

    }
    protected void logistics_schedule_ItemUpdated(object sender, ListViewUpdatedEventArgs e)
    {









    }

    public void confirmClick(object sender, CommandEventArgs e)
    {


        int logisticsControlId = Int32.Parse(e.CommandArgument.ToString());

        logConfirmation(logisticsControlId);

        LogisticsScheduleListView.DataBind();





    }

    private void logConfirmation(int pLogisticsControlId)
    {
        logistics_control_confirmation confirmation = new logistics_control_confirmation();
        confirmation.logistics_control_id = pLogisticsControlId;
        confirmation.confirmed_date = DateTime.Now;
        confirmation.user_confirmed = User.Identity.Name;

        db.logistics_control_confirmations.InsertOnSubmit(confirmation);


        db.SubmitChanges();


    }

    private void logLogisticsNoteBySystem(int pLogisticsControlId, string pNoteDescription)
    {
        logistics_control_note note = new logistics_control_note();
        note.user_logged = "System";
        note.date_logged = DateTime.Now;
        note.note_description = pNoteDescription;
        note.logistics_control_id = pLogisticsControlId;

        db.logistics_control_notes.InsertOnSubmit(note);

        db.SubmitChanges();


    }



    public static string GetLastConfirmationDetails(object jobListItemObject)
    {

        string info = "--";

        try
        {

            job_list_item jobListItem = (job_list_item)jobListItemObject;
            DateTime lastConfirmationDate = (DateTime)jobListItem.logistics_controls.Single().logistics_control_confirmations.Last().confirmed_date;
            String userConfirmed = jobListItem.logistics_controls.Single().logistics_control_confirmations.Last().user_confirmed;


            info = lastConfirmationDate.ToString("ddd, d MMM, yyyy") + " by " + userConfirmed;






        }
        catch (Exception e)
        {


        }






        return info;
    }


    public static string GetOrderDescriptionDetails(object jobListItemObject)
    {

        string info = "--";

        try
        {

            job_list_item jobListItem = (job_list_item)jobListItemObject;

            if (jobListItem.is_main_material_order == true)
            {
                info = jobListItem.description;

            }
            else
            {
                info = "Site Order - " + jobListItem.id;
            }


           





        }
        catch (Exception e)
        {


        }






        return info;
    }

    public static string GetProductionCompleteDate(object jobListItemObject)
    {
        string info = "--";
        try
        {
            job_list_item jobListItem = (job_list_item)jobListItemObject;
            info = ((DateTime)(jobListItem.project_dates.Single().site_delivery_date)).ToString("ddd, d MMM, yyyy");
            
        }
        catch (Exception e){}
        return info;
    }
    public static string GetPackagesBeingManufactured(object jobListItemObject)
    {
        string info = "--";
        try
        {
            job_list_item jobListItem = (job_list_item)jobListItemObject;
            var packagesBeingManufactured = jobListItem.section_dispatch_items.Where(p => p.current_status == "Being Manufactured");
            int count = packagesBeingManufactured.Count();
            info = count.ToString();

        }
        catch (Exception e) { }
        return info;
    }
    public static string GetPackagesVerified(object jobListItemObject)
    {
        string info = "--";
        try
        {
            job_list_item jobListItem = (job_list_item)jobListItemObject;
            var packagesVerified = jobListItem.section_dispatch_items.Where(p => p.current_status == "Verified");
            int count = packagesVerified.Count();
            info = count.ToString();

        }
        catch (Exception e) { }
        return info;
    }

    public static string GetDispatch(object jobListItemObject)
    {
        string info = "--";
        try
        {
            job_list_item jobListItem = (job_list_item)jobListItemObject;

            var dispatchEvents = (((jobListItem.section_dispatch_items.Where(p => p.dispatch_event == new DateTime(8888, 8, 8))).OrderBy(o => o.dispatch_event)).GroupBy(i => i.dispatch_event)).Select(g => g.First()); 
            int count = dispatchEvents.Count();
            info = count.ToString();


           

        }
        catch (Exception e) { }
        return info;
    }



    public static string GetConfirmButtonImage(object jobListItemObject)
    {

        string imageUrl = "images/alert.png";

        try
        {

            job_list_item jobListItem = (job_list_item)jobListItemObject;
            DateTime lastConfirmationDate = (DateTime)jobListItem.logistics_controls.First().logistics_control_confirmations.Last().confirmed_date;
            DateTime siteDeliveryDate = (DateTime)jobListItem.logistics_controls.First().site_delivery_date;
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
                return "greenrow"; //"#416969";//green - 
            }
            else if (netWorkDays > 5 && netWorkDays <= 15)
            {
                return "amberrow"; //"#FE9A2E";//yellow - due in the next week
            }
            else
            {
                return "transparent;";// task for future date
            }
        }
        catch (Exception e)
        {
            // this means that the expected date is older than current date
            return "redrow"; // "#694141";
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





}
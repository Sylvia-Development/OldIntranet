using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class logistics_control_completed : System.Web.UI.Page
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


        DateTime controlDate = dateHandler.addWorkDays(DateTime.Now, -120, 2); // a control date to limit results to six month ago 

        var logistics_control = from l in db.logistics_controls
                                where l.delivery_complete == true && (l.delivery_complete_date > controlDate)
                                orderby l.delivery_complete_date
                                select l;


        e.Result = logistics_control;


    }



    protected void logistics_schedule_ItemUpdating(object sender, ListViewUpdateEventArgs e)
    {
        CheckBox deliveryCompleteCheckBox = (CheckBox)((ListView)sender).EditItem.FindControl("deliveryCompleteCheckBox");

       
        

        HiddenField hiddenJobName = (HiddenField)((ListView)sender).EditItem.FindControl("hiddenJobName");
        HiddenField hiddenSectionName = (HiddenField)((ListView)sender).EditItem.FindControl("hiddenSectionName");
        HiddenField logisticsControlId = (HiddenField)((ListView)sender).EditItem.FindControl("logisticsControlId");
        Label description = (Label)((ListView)sender).EditItem.FindControl("descriptionLabel");

        string jobName = hiddenJobName.Value + " - " + hiddenSectionName.Value;



       
        if (deliveryCompleteCheckBox.Checked == false)
        {
            // means delivery has been marked as not complete anymore 


            e.NewValues["delivery_complete_date"] = null;
            e.NewValues["delivery_note_uploaded"] = 0;
            ActivityLog log = new ActivityLog();
            log.sendDeliveryCompleteReversalEmail(jobName, description.Text, User.Identity.Name);

            logLogisticsNoteBySystem(Int32.Parse(logisticsControlId.Value), User.Identity.Name + " UN-TICKED Delivery Complete ");


        }

    }
    protected void logistics_schedule_ItemUpdated(object sender, ListViewUpdatedEventArgs e)
    {









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
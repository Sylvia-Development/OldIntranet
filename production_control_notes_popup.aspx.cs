using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;

public partial class production_control_notes_popup : System.Web.UI.Page
{
    IntranetDataDataContext db = null;


    protected void Page_Init(object sender, EventArgs e)
    {
        db = new IntranetDataDataContext();

    }

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void production_notes_DataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {


        int pProductionControlId = -1;
        string pProcessType = "";

        try
        {
            pProductionControlId = Int32.Parse(Page.Request.QueryString["pProductionControlId"]);
            pProcessType = Page.Request.QueryString["pProcessType"].ToString();

        }
        catch (Exception ex) { }

        var production_notes = from c in db.production_control_notes
                             where c.production_control_id == pProductionControlId
                             && c.production_process == pProcessType

                               orderby c.date_logged descending
                             select c;



        e.Result = production_notes;

    }

    protected void production_notes_ItemInserting(object sender, ListViewInsertEventArgs e)
    {

        int pProductionControlId = -1;
        string pProcessType = "";

        try
        {
            pProductionControlId = Int32.Parse(Page.Request.QueryString["pProductionControlId"]);
            pProcessType = Page.Request.QueryString["pProcessType"].ToString();

        }
        catch (Exception ex) { }

        e.Values["production_control_id"] = pProductionControlId;
        e.Values["production_process"] = pProcessType;
        e.Values["date_logged"] = DateTime.Now.ToString();
        e.Values["user_logged"] = User.Identity.Name;




    }

    protected void production_notes_ItemInserted(object sender, ListViewInsertedEventArgs e)
    {

        /*
        ActivityLog log = new ActivityLog();
        log.sendStockOrderNotesEmail(jobListItem.section.client.job_name + " - " + jobListItem.section.section_name, User.Identity.Name, e.Values["note_description"].ToString());
        */




    }

    
    public string GetJobInfo()
    {
        int pProductionControlId = -1;
        string pProcessType = "";

        try
        {
            pProductionControlId = Int32.Parse(Page.Request.QueryString["pProductionControlId"]);
            pProcessType = Page.Request.QueryString["pProcessType"].ToString();

        }
        catch (Exception ex) { }

        production_control productionControlItem =  (from c in db.production_controls
                                                     where c.id == pProductionControlId
                                                     select c).Single();

        return productionControlItem.section.client.job_name + " - " + productionControlItem.section.section_name + " : " + pProcessType;



    }



}
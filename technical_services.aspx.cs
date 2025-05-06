using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;


public partial class technical_services : System.Web.UI.Page
{
    IntranetDataDataContext db = null;
    DateHandler dateHandler = null;

    protected void Page_Load(object sender, EventArgs e)
    {
        db = new IntranetDataDataContext();
        dateHandler = new DateHandler();
    }

    protected void to_be_ordered_DataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {

        var job_list_items = from j in db.job_list_items

                             where j.item_completed == false
                             && (j.default_item_na == null || j.default_item_na == false)
                             && (j.manager_has_processed_order == null || j.manager_has_processed_order == false)
                             && (j.is_snag_list_item == null || j.is_snag_list_item == false)
                             orderby j.date_logged ascending
                             select j;

        e.Result = job_list_items;

    }
    protected void to_be_ordered_ItemUpdating(object sender, ListViewUpdateEventArgs e)
    {

        DropDownList reasonDropDown = (DropDownList)ToBeOrderedListView.EditItem.FindControl("ReasonDropDownList");
        if (reasonDropDown.SelectedValue.Equals("0"))
        {
            reasonDropDown.BackColor = System.Drawing.Color.IndianRed;
            reasonDropDown.ForeColor = System.Drawing.Color.White;
            e.Cancel = true;
            return;
        }



        DropDownList orderActionDropDown = (DropDownList)ToBeOrderedListView.EditItem.FindControl("OrderActionDropDown");
        
        if (orderActionDropDown.SelectedValue.Equals("1"))
        {
            

            e.NewValues["production_assistant_to_order"] = false;
            e.NewValues["manager_has_processed_order"] = true;

            e.NewValues["order_needs_processing"] = true;
            e.NewValues["manager_processed_date"] = DateTime.Now;
            e.NewValues["manager_processed_name"] = User.Identity.Name;

            project_date projectDate = new project_date();
            projectDate.section_id = Convert.ToInt32(e.NewValues["section.section_id"]);
            projectDate.job_list_item_id = Convert.ToInt32(e.NewValues["id"]);
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
            productionControl.section_id = Convert.ToInt32(e.NewValues["section.section_id"]);
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
            productionControl.joblist_item_id = Convert.ToInt32(e.NewValues["id"]);
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


            db.SubmitChanges();

        }
       
       
        else if (orderActionDropDown.SelectedValue.Equals("2"))
        {


            e.NewValues["manager_has_processed_order"] = true;
            e.NewValues["default_item_na"] = true;
            e.NewValues["item_completed"] = true;
            e.NewValues["date_completed"] = DateTime.Now.Date;
            e.NewValues["user_completed"] = User.Identity.Name;
            e.NewValues["manager_processed_date"] = DateTime.Now;
            e.NewValues["manager_processed_name"] = User.Identity.Name;


        }

    }
    protected void to_be_ordered_ItemUpdated(object sender, ListViewUpdatedEventArgs e)
    {
        DropDownList orderActionDropDown = (DropDownList)ToBeOrderedListView.EditItem.FindControl("OrderActionDropDown");

        if (orderActionDropDown.SelectedValue.Equals("1"))
        {

            ActivityLog log = new ActivityLog();
            log.sendSiteOrderAddedEmail(e.NewValues["section.client.job_name"].ToString() + " - " + e.NewValues["section.section_name"].ToString(), User.Identity.Name, e.NewValues["description"].ToString());

            


    }
        
        ToBeOrderedListView.DataBind();

    }

}
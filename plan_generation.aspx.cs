using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;

public partial class plan_generation : System.Web.UI.Page
{
    IntranetDataDataContext db = null;
    DateHandler dateHandler = null;

    protected void Page_Load(object sender, EventArgs e)
    {
        db = new IntranetDataDataContext();
        dateHandler = new DateHandler();
    }
    protected void production_schedule_DataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {









        var production_schedule = from p in db.project_dates
                                  where (p.in_production==true &&  p.job_list_item.item_completed == false )
                                  && (p.is_job_list_item == false || p.is_job_list_item == null)
                                  orderby p.site_delivery_date descending
                                  select p;



        

        e.Result = production_schedule;


    }
    protected void production_schedule_ItemUpdating(object sender, ListViewUpdateEventArgs e)
    {

        if ((bool)(e.OldValues["plumbing_electrical_complete"]) == false && (bool)(e.NewValues["plumbing_electrical_complete"]) == true)
        {
            e.NewValues["plumbing_electrical_complete_date"] = DateTime.Now.Date;
            e.NewValues["plumbing_electrical_complete_by"] = User.Identity.Name;
        }
        

        if ((bool)(e.OldValues["plans_done"]) != (bool)(e.NewValues["plans_done"]))
        {
            HiddenField hiddenId = (HiddenField)((ListView)sender).EditItem.FindControl("hiddenId");
            var production_control = (from p in db.production_controls where p.projects_dates_id == Int32.Parse(hiddenId.Value) select p).Single();

            production_control.plan_generation_complete = (bool)(e.NewValues["plans_done"]);
            if((bool)(e.NewValues["plans_done"]) == true)
            {
                production_control.plan_generation_completed_user = User.Identity.Name;
                production_control.plan_generation_complete_date = DateTime.Now.Date;

            }
            else
            {
                production_control.plan_generation_completed_user = null;
                production_control.plan_generation_complete_date = null;

            }

           
            db.SubmitChanges();


        }
        if ((bool)(e.OldValues["technical_orders_done"]) != (bool)(e.NewValues["technical_orders_done"]))
        {
            HiddenField hiddenId = (HiddenField)((ListView)sender).EditItem.FindControl("hiddenId");
            var production_control = (from p in db.production_controls where p.projects_dates_id == Int32.Parse(hiddenId.Value) select p).Single();

            production_control.supplier_orders_complete = (bool)(e.NewValues["technical_orders_done"]);
            if ((bool)(e.NewValues["technical_orders_done"]) == true)
            {
                production_control.supplier_orders_completed_user = User.Identity.Name;
                production_control.supplier_orders_complete_date = DateTime.Now.Date;

            }
            else
            {
                production_control.supplier_orders_completed_user = null;
                production_control.supplier_orders_complete_date = null;

            }


            db.SubmitChanges();


        }

    }
    protected void production_schedule_ItemUpdated(object sender, ListViewUpdatedEventArgs e)
    {

       




        

    }

    protected void production_not_DataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {









        var production_schedule = from p in db.project_dates
                                  where p.in_production == false && (p.is_job_list_item == false || p.is_job_list_item == null)
                                  orderby p.site_delivery_date 
                                  select p;





        e.Result = production_schedule;


    }
    protected void production_not_ItemUpdating(object sender, ListViewUpdateEventArgs e)
    {

       

    }
    protected void production_not_ItemUpdated(object sender, ListViewUpdatedEventArgs e)
    {








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
    public static string GetWallsImage(object sectionIdObject)
    {
        int sectionId = -1;
        if (sectionIdObject != null)
            sectionId = (int)sectionIdObject;


        bool status = areAllWallItemsVerified(sectionId);

        if (status)
        {
            return "images/yes.png";
        }
        else
        {
            return "images/no.png";
        }
    }
    public static bool areAllWallItemsVerified(int pSectionId)
    {
        bool result = false;

        IntranetDataDataContext db = new IntranetDataDataContext();

        var wallsToCheck = from sw in db.walls
                           where sw.section_id == pSectionId && (sw.wall_label != "General" && sw.wall_label != "Appliances / HV Items" && sw.wall_label != "Supplier Value Adds / Returns")
                           select sw.id;

        foreach (int wallId in wallsToCheck)
        {


            int nullCount = (from w in db.wall_checklist_items
                             where w.wall_id == wallId
                             && w.item_relevant_to_wall == null
                             select w).Count();

            if (nullCount > 0) // this means that there are wall checklist items that have not been verified for this wall
            {
                result = false;

            }
            else // this means there are no more wall checklist items to verify for this wall
            {
                result = true;
            }
            if (result == false)
                break;
        }
        return result;
    }






}
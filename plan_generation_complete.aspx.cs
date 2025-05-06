using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class plan_generation_complete : System.Web.UI.Page
{
    IntranetDataDataContext db = null;
    DateHandler dateHandler = null;

    protected void Page_Load(object sender, EventArgs e)
    {
        db = new IntranetDataDataContext();
        dateHandler = new DateHandler();
    }

    protected void production_complete_DataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {









        var production_schedule = from p in db.project_dates
                                  where (p.job_list_item.item_completed == true && ((DateTime)p.job_list_item.date_completed).AddDays(730) > DateTime.Now) // two years back
                                  && (p.is_job_list_item == false || p.is_job_list_item == null)
                                  orderby p.site_delivery_date descending
                                  select p;





        e.Result = production_schedule;


    }
    protected void production_complete_ItemUpdating(object sender, ListViewUpdateEventArgs e)
    {





    }
    protected void production_complete_ItemUpdated(object sender, ListViewUpdatedEventArgs e)
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
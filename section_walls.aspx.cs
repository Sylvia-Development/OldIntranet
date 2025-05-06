 using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class section_walls : System.Web.UI.Page
{
    IntranetDataDataContext db = null;

    protected void Page_Init(object sender, EventArgs e)
    {
        db = new IntranetDataDataContext();



    }

    protected void Page_Load(object sender, EventArgs e)
    {

        

    }

    public static string GetClientNameSection(object pSectionIdObject)
    {

        IntranetDataDataContext db = new IntranetDataDataContext();
        int pSectionId = -1;
        string result = "";
        if (pSectionIdObject != null)
        {

            pSectionId = Int32.Parse( pSectionIdObject.ToString());


            section theSection = (from s in db.sections
                              where s.section_id == pSectionId
                              select s).Single();
            result = theSection.client.job_name + " - " + theSection.section_name;
        }

        return result;

       
    }
    public static string GetVerifiedInfo(object pWallIdObject,object pSectionIdObject)
    {

        IntranetDataDataContext db = new IntranetDataDataContext();
        int pWallId = -1;
        int pSectionId = Int32.Parse(pSectionIdObject.ToString());
        string result = "Error";
        if (pWallIdObject != null)
        {

            pWallId = Int32.Parse(pWallIdObject.ToString());


            int nullCount = (from w in db.wall_checklist_items
                             where w.wall_id == pWallId
                             && w.item_relevant_to_wall == null
                                  select w).Count();

            if (nullCount > 0) // this means that there are wall checklist items that have not been verified
            {
                result = "<a href=\"verify_sitelist_items.aspx?pSectionId="+pSectionId+"&pWallId="+pWallId+"\">Verify Items >>"+"</a>";

            }
            else // this means there are no more wall checklist items to verify
            {

                result = "<a href=\"verify_sitelist_items.aspx?pSectionId=" + pSectionId + "&pWallId=" + pWallId + "\"><img src=\"images/yes.png\" /></a>";

            }

            
        }

        return result;


    }

    protected void walls_ItemInserting(object sender, ListViewInsertEventArgs e)
    {
        e.Values["section_id"] = Page.Request.QueryString["pSectionId"];

        if (e.Values["wall_order"] == null)
        {
            e.Values["wall_order"] = 0;

        }



    }
    protected void walls_ItemInserted(object sender, LinqDataSourceStatusEventArgs e)
    {
        // copy over default site checklist items for that wall

        var defaultListItems = from a in db.wall_checklist_defaults
                             where a.dept_id == 3
                             select a;


        foreach (wall_checklist_default checklistDefault in defaultListItems)
        {
            wall_checklist_item checklistItem = new wall_checklist_item();

            checklistItem.dept_id = 3;
            checklistItem.wall_id = ((wall)e.Result).id;
            checklistItem.description = checklistDefault.description;
            checklistItem.checklist_item_order = checklistDefault.checklist_item_order;
            checklistItem.added_date = DateTime.Now;
            checklistItem.added_user = "System";
            checklistItem.item_relevant_to_wall = null;
            checklistItem.category_id = checklistDefault.category_id;
            checklistItem.item_type = checklistDefault.item_type;


            db.wall_checklist_items.InsertOnSubmit(checklistItem);

        }

        try
        {
            db.SubmitChanges();
        }
        catch (Exception ex)
        {
            throw ex;
        }
       



    }



    protected void WallsDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {
        int pSectionId = -1;
        try
        {
            pSectionId = Int32.Parse(Page.Request.QueryString["pSectionId"]);
        }
        catch (Exception ex) { }

        var theWalls = from w in db.walls
                              where w.section_id == pSectionId
                              orderby w.wall_order
                              select w;



        e.Result = theWalls;
    }






    protected void ListView1_ItemDeleting(object sender, ListViewDeleteEventArgs e)
    {
        int pWallId = (int)e.Keys["id"];
        //delete all wall items 
        var deletedItems = from w in db.wall_checklist_items
                           where w.wall_id == pWallId
                           select w;
        if (deletedItems != null)
        {
            db.wall_checklist_items.DeleteAllOnSubmit(deletedItems);
            db.SubmitChanges();
        }




    }
}
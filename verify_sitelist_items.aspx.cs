using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class verify_sitelist_items : System.Web.UI.Page
{
    IntranetDataDataContext db = null;

    protected void Page_Init(object sender, EventArgs e)
    {
        db = new IntranetDataDataContext();



    }
    
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    public static string GetWallClientNameSection(object pWallIdObject)
    {

        IntranetDataDataContext db = new IntranetDataDataContext();
        int pWallId = -1;
        string result = "";
        if (pWallIdObject != null)
        {

            pWallId = Int32.Parse(pWallIdObject.ToString());


            wall theWall = (from w in db.walls
                                  where w.id == pWallId
                                  select w).Single();
            result = theWall.wall_label + " - " + theWall.section.client.job_name + " - " + theWall.section.section_name;
        }

        return result;


    }

    protected void set_is_catagory_relevant(object sender, CommandEventArgs e)
    {

        int pCategoryId = -1;
        int pWallId = -1;
        try
        {
            pWallId = Int32.Parse(Page.Request.QueryString["pWallId"]);
            pCategoryId = Int32.Parse(e.CommandArgument.ToString());
        }
        catch (Exception ex) { }

        IEnumerable<wall_checklist_item>  items = from w in db.wall_checklist_items
                                                  where w.wall_id == pWallId && w.category_id == pCategoryId 
                                                  select w;
        foreach (var item in items ){
            item.item_relevant_to_wall = true;

        }
        db.SubmitChanges();
        ListView2.DataBind();

    }
    protected void set_is_catagory_NOT_relevant(object sender, CommandEventArgs e)
    {

        int pCategoryId = -1;
        int pWallId = -1;
        try
        {
            pWallId = Int32.Parse(Page.Request.QueryString["pWallId"]);
            pCategoryId = Int32.Parse(e.CommandArgument.ToString());
        }
        catch (Exception ex) { }

        IEnumerable<wall_checklist_item> items = from w in db.wall_checklist_items
                                                 where w.wall_id == pWallId && w.category_id == pCategoryId
                                                 select w;
        foreach (var item in items)
        {
            item.item_relevant_to_wall = false;

        }
        db.SubmitChanges();
        ListView2.DataBind();

    }

    protected void set_is_relevant(object sender, CommandEventArgs e)
    {

        wall_checklist_item item = db.wall_checklist_items.First(c => c.id == Int32.Parse(e.CommandArgument.ToString()));
        item.item_relevant_to_wall = true;
        db.SubmitChanges();
        ListView2.DataBind();
       
    }
    protected void set_is_NOT_relevant(object sender, CommandEventArgs e)
    {

        wall_checklist_item item = db.wall_checklist_items.First(c => c.id == Int32.Parse(e.CommandArgument.ToString()));
        item.item_relevant_to_wall = false;
        db.SubmitChanges();
        ListView2.DataBind();

    }


    protected void wall_checklist_ItemInserting(object sender, ListViewInsertEventArgs e)
    {
        e.Values["dept_id"] = 3;
        e.Values["checklist_item_order"] = 0;
        //e.Values["category_id"] = 1;
        e.Values["wall_id"] = Page.Request.QueryString["pWallId"];
        e.Values["added_date"] = DateTime.Now ;
        e.Values["added_user"] = Context.User.Identity.Name;
        e.Values["item_relevant_to_wall"] = true;


    }

    protected void WallsChecklistDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {
        int pWallId = -1;
        try
        {
            pWallId = Int32.Parse(Page.Request.QueryString["pWallId"]);
        }
        catch (Exception ex) { }

        var checklists = from c in db.wall_checklist_items
                       where c.wall_id== pWallId
                       orderby c.wall_checklist_category.category_order,c.description
                       select c;



        e.Result = checklists;
    }

    protected void WallsChecklistCatagoryDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {
        int pWallId = -1;
        try
        {
            pWallId = Int32.Parse(Page.Request.QueryString["pWallId"]);
        }
        catch (Exception ex) { }

        var checklistsCatagories = (from w in db.wall_checklist_items
                         where (w.wall_id == pWallId) && (w.category_id != null)
                         orderby w.wall_checklist_category.category_order
                         select w.wall_checklist_category).Distinct();


        
        e.Result = checklistsCatagories;
    }


    public static string GetYesNoImage(object statusObject)
    {
        bool status = false;
        if (statusObject != null)
            status = (bool)statusObject;


        if (status)
        {
            return "images/yes.png";
        }
        else
        {
            return "images/no-cross.png";
        }
    }



}
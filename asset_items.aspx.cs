using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class asset_items : System.Web.UI.Page
{
    IntranetDataDataContext db = null;
    
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Page_Init(object sender, EventArgs e)
    {
        db = new IntranetDataDataContext();
    }

    protected void page_load_finish(Object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            if (titleLabel.Text.Length <= 0)
            {

                int pId = -1;
                string pType = "";

                try
                {
                    pType = Page.Request.QueryString["pType"];
                    pId = Int32.Parse(Page.Request.QueryString["pId"]);
                    



                }
                catch (Exception ex) { }
                 IQueryable<String> result = null;

                if (pType.Equals("class"))
                {

                    result = from c in db.asset_classes
                             where c.id == pId
                             select c.description;
                    titleLabel.Text = result.First();
                }
                else if (pType.Equals("group"))
                {
                    result = from c in db.asset_groups
                              where c.id == pId
                              select c.description;

                    titleLabel.Text = result.First();

                }
                else if (pType.Equals("archived"))
                {
                    

                    titleLabel.Text = "Archived Assets";

                }

                
                
               

            }
        }
    }

    protected void AssetItemsDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {
        int pId = -1;
        string pType = "";

        try
        {
            pId = Int32.Parse(Page.Request.QueryString["pId"]);
            pType = Page.Request.QueryString["pType"];

            

        }
        catch (Exception ex) { }
        IOrderedQueryable assets = null;

        if (pType.Equals("class"))
        {

            assets = from a in db.asset_items
                        where  a.class_id == pId &&
                        a.current_status != "Archived"
                        orderby a.description
                        select a;

        }
        else if (pType.Equals("group"))
        {
            assets = from a in db.asset_items
                     where a.group_id == pId &&
                        a.current_status != "Archived"
                     orderby a.current_status descending
                     select a;


        }
        else if (pType.Equals("archived"))
        {
            assets = from a in db.asset_items
                     where a.current_status.ToLower() == "archived"
                     orderby a.group_id
                     select a;


        }

        e.Result = assets;
    }

    protected void asset_items_ItemUpdating(object sender, ListViewUpdateEventArgs e)
    {

       


    }
    protected void asset_items_ItemUpdated(object sender, ListViewUpdatedEventArgs e)
    {

        if (!e.NewValues["current_status"].Equals(e.OldValues["current_status"])) // means status has changed -> must log an asset note
        {

           

            asset_audit_note note = new asset_audit_note();
            note.item_id = Int32.Parse(e.NewValues["id"].ToString());
            note.date = DateTime.Now;
            note.logged_by = Page.User.Identity.Name;
            note.audit_note = "Item Status changed from '" + e.OldValues["current_status"] + "' to '" + e.NewValues["current_status"] + "'";



            db.asset_audit_notes.InsertOnSubmit(note);

            db.SubmitChanges();

        



        }



     
    }


}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class asset_lookup : System.Web.UI.Page
{
    IntranetDataDataContext db = null;

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Page_Init(object sender, EventArgs e)
    {
        db = new IntranetDataDataContext();
    }
    protected void AssetItemsDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {
        int pAssetId = -1;
        

        try
        {
            pAssetId = Int32.Parse(Page.Request.QueryString["pAssetId"]);
           


        }
        catch (Exception ex) { }
        IQueryable assets = from a in db.asset_items
                                 where a.id == pAssetId 
                                   select a;

       

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
            note.audit_note = "Item Status changed to '" + e.NewValues["current_status"] + "'";



            db.asset_audit_notes.InsertOnSubmit(note);

            db.SubmitChanges();





        }




    }

}
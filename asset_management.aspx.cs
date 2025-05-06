using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;

public partial class asset_management : System.Web.UI.Page
{
    IntranetDataDataContext db = null;
    


    protected void Page_Init(object sender, EventArgs e)
    {
        db = new IntranetDataDataContext();
        


    }
    protected void Page_Load(object sender, EventArgs e)
    {

    }


    protected void AssetAuditsDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {

        DateTime checkDate = System.DateTime.Now.AddMonths(-12); // a date 12 months back


        IOrderedQueryable audits = from a in db.asset_audits
                                   where a.date_of_audit > checkDate
                                   orderby a.date_of_audit descending
                                   select a;



        e.Result = audits;
    }

    protected void AssetItemsDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {




        IOrderedQueryable assets = from a in db.asset_items
                                   where a.current_status != "Archived" && a.current_status != "Confirmed"
                                   orderby a.group_id, a.current_status
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
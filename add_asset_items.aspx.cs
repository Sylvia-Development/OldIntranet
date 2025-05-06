using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class add_asset_items : System.Web.UI.Page
{

    IntranetDataDataContext db = null;

    protected void Page_Init(object sender, EventArgs e)
    {
        db = new IntranetDataDataContext();

    }
    protected void Page_Load(object sender, EventArgs e)
    {

       /*if (!IsPostBack)
        {

            FormView1.ChangeMode(FormViewMode.Insert);
        }*/

    }

    protected void asset_item_itemInserting(object sender, FormViewInsertEventArgs e)
    {
        e.Values["current_status"] = "Confirmed";
        if (e.Values["purchase_date"] == null || e.Values["purchase_date"].ToString().Length <= 0)
            e.Values["purchase_date"] = DateTime.Now;
        if (e.Values["purchase_price"] == null || e.Values["purchase_price"].ToString().Length <= 0)
            e.Values["purchase_price"] = "0";
        

    }

    protected void asset_item_itemInserted(object sender, FormViewInsertedEventArgs e)
    {
        
        
        
    }

    protected void datasource_Inserted(object sender, LinqDataSourceStatusEventArgs e)
    {
        asset_item item = (asset_item)e.Result;

        asset_audit_note note = new asset_audit_note();
        note.item_id = item.id;
        note.date = DateTime.Now;
        note.logged_by = Page.User.Identity.Name;
        note.audit_note = "Item Added - Status is 'Confirmed' " ;



        db.asset_audit_notes.InsertOnSubmit(note);

        db.SubmitChanges();
        
    }
    

}
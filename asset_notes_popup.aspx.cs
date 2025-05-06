using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class asset_notes_popup : System.Web.UI.Page
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

                int pItemId = -1;
                

                try
                {
                    pItemId = Int32.Parse(Page.Request.QueryString["pItemId"]);
                    



                }
                catch (Exception ex) { }
                


                 IQueryable<String> result = from a in db.asset_items
                                             where a.id == pItemId
                              select a.description;

                    titleLabel.Text = result.First() + " Audit Notes";
 

            }
        }
    }

     protected void AssetNotesDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
     {
         int pItemId = -1;
        
         try
         {
             pItemId = Int32.Parse(Page.Request.QueryString["pItemId"]);
        



         }
         catch (Exception ex) { }
         



         IOrderedQueryable notes = from n in db.asset_audit_notes
                                   where n.item_id == pItemId 
                      orderby n.date descending
                      select n;

        

         e.Result = notes;
     }
     protected void asset_note_ItemInserting(object sender, ListViewInsertEventArgs e)
     {
         e.Values["item_id"] = Page.Request.QueryString["pItemId"];
         e.Values["date"] = DateTime.Now;
         e.Values["logged_by"] = Page.User.Identity.Name;




     }

     protected void asset_note_ItemInserted(object sender, ListViewInsertedEventArgs e)
     {
         
         string user = Page.User.Identity.Name;

         if (user != null && user.Trim().Length > 0)
         {
             if (!user.Trim().ToLower().Equals("graham"))// send graham an email of the note if he is not the one logging the note
             {

                 ActivityLog activityLog = new ActivityLog();


                 activityLog.logActivity("Asset Note Logged", user + " logged an asset note for asset ID " + e.Values["item_id"] + " :- " + e.Values["audit_note"], user + "@blu-line.co.za", "graham@blu-line.co.za");
             }

         }



     }
}

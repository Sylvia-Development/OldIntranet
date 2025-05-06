using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class asset_damages_popup : System.Web.UI.Page
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

                titleLabel.Text = result.First()+ " Damages";


            }
        }
    }

    protected void AssetDamagesDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {
        int pItemId = -1;

        try
        {
            pItemId = Int32.Parse(Page.Request.QueryString["pItemId"]);




        }
        catch (Exception ex) { }




        IOrderedQueryable notes = from n in db.asset_damages
                                  where n.asset_id == pItemId
                                  orderby n.still_applicable descending, n.date_logged descending
                                  select n;



        e.Result = notes;
    }
    protected void asset_damages_ItemInserting(object sender, ListViewInsertEventArgs e)
    {
        e.Values["asset_id"] = Page.Request.QueryString["pItemId"];
        e.Values["date_logged"] = DateTime.Now;
        e.Values["user_logged"] = Page.User.Identity.Name;
        e.Values["still_applicable"] = true;




    }

    protected void asset_damages_ItemInserted(object sender, ListViewInsertedEventArgs e)
    {
        string user = Page.User.Identity.Name;

        if (user != null && user.Trim().Length > 0)
        {
            if (!user.Trim().ToLower().Equals("graham"))// send graham an email of the note if he is not the one logging the note
            {

                ActivityLog activityLog = new ActivityLog();


                activityLog.logActivity("Asset Damage Logged", user + " logged an asset Damages note for asset ID " + e.Values["asset_id"] + " :- " + e.Values["description"], user + "@blu-line.co.za", "graham@blu-line.co.za");
            }

        }





    }

    public static string GetOpenTag(object pStatusObject)
    {
        bool status = false;
        if (pStatusObject != null)
        {
            status = (bool)pStatusObject;
        }

        if (status)
        {
            return "";
        }
        else
        {
            return "<del>";
        }
    }
    public static string GetCloseTag(object pStatusObject)
    {
        bool status = false;
        if (pStatusObject != null)
        {
            status = (bool)pStatusObject;
        }

        if (status)
        {
            return "";
        }
        else
        {
            return "</del>";
        }
    }


}
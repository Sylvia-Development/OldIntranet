using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Web.Security;

public partial class my_assets : System.Web.UI.Page
{
    IntranetDataDataContext db = null;

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Page_Init(object sender, EventArgs e)
    {
        db = new IntranetDataDataContext();
    }

    [WebMethod]
    public static string bookIn(int pAssetBookoutId, String pUser, String pAssetOwner, String pAssetBorrower)
   
   
    {

        IntranetDataDataContext db2 = new IntranetDataDataContext();
        var recordToUpdate = (from b in db2.asset_bookouts
                              where b.id == pAssetBookoutId
                              select b).Single();



        recordToUpdate.date_in = DateTime.Now;

        // log the audit note

        asset_audit_note note = new asset_audit_note();
        note.item_id = recordToUpdate.asset_id;
        note.date = DateTime.Now;
       note.logged_by = pUser;
      note.audit_note = pUser + " booked item in that " + pAssetBorrower+" borrowed";



        db2.asset_audit_notes.InsertOnSubmit(note);

      
        try
        {
            db2.SubmitChanges();
        }
        catch (Exception e)
        {
            return e.Message;
        }




        
        ActivityLog activityLog = new ActivityLog();

        string emailAddresses = pAssetOwner + "@blu-line.co.za";

        if (!pAssetOwner.ToLower().Equals(pAssetBorrower.ToLower())){
            emailAddresses += ","+pAssetBorrower+"@blu-line.co.za";
        }
        if(!emailAddresses.ToLower().Contains("graham")){
            
            emailAddresses += ",graham@blu-line.co.za";
        }
        if (!emailAddresses.ToLower().Contains("alex"))
        {

            emailAddresses += ",alex@blu-line.co.za";
        }


        //activityLog.logActivity("Asset item booked in", pUser + " booked in a " + recordToUpdate.asset_item.description + " that " + pAssetBorrower + " borrowed from " + pAssetOwner, "intranet@blu-line.co.za", emailAddresses);


        return "ok";

    }

    [WebMethod]
    public static string bookOut(int pAssetId, String pUser, String pAssetOwner, String pAssetBorrower, String pAssetDescription)
    {

        IntranetDataDataContext db2 = new IntranetDataDataContext();
        //log in bookout table

        asset_bookout ab = new asset_bookout();
        ab.asset_id = pAssetId;
        ab.date_out = DateTime.Now;
        ab.booked_to = pAssetBorrower;

        db2.asset_bookouts.InsertOnSubmit(ab);

        // log the audit note

        asset_audit_note note = new asset_audit_note();
        note.item_id = pAssetId;
        note.date = DateTime.Now;
        note.logged_by = pUser;
        note.audit_note = pUser + " booked item out to " + pAssetBorrower ;



        db2.asset_audit_notes.InsertOnSubmit(note);


        try
        {
            db2.SubmitChanges();
        }
        catch (Exception e)
        {
            return e.Message;
        }





        ActivityLog activityLog = new ActivityLog();

        string emailAddresses = pAssetOwner + "@blu-line.co.za";

        if (!pAssetOwner.ToLower().Equals(pAssetBorrower.ToLower()))
        {
            emailAddresses += "," + pAssetBorrower + "@blu-line.co.za";
        }
        if (!emailAddresses.ToLower().Contains("graham"))
        {

            emailAddresses += ",graham@blu-line.co.za";
        }
        if (!emailAddresses.ToLower().Contains("alex"))
        {

            emailAddresses += ",alex@blu-line.co.za";
        }


       // activityLog.logActivity("Asset item booked out", pUser + " booked out a " + pAssetDescription + " that "+ pAssetOwner+" owns to "+ pAssetBorrower , "intranet@blu-line.co.za", emailAddresses);


        return "ok";

    }

    protected void BorrowedAssetDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {

        string user = "";

        //paramUser is a username through the url, used by graham to check other users "myassets" pages

        string paramUser = Page.Request.QueryString["pUser"];

        if (paramUser != null && paramUser.Trim().Length > 0)
        {  // means there was a username in the url

            user = paramUser;
        }
        else
        {

            user = Page.User.Identity.Name.ToLower();
            //a slight hack to combine michelle and graham as joint owner of assets
            if (user.Equals("michelle"))
            {
                user = "graham";
            }

        }

        

        IOrderedQueryable assets  = from a in db.asset_bookouts
                     where a.booked_to == user &&
                     a.date_in == null
                     orderby a.date_out 
                     select a;

       

        e.Result = assets;
    }

    protected void LeantAssetDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {


        string user = "";

        //paramUser is a username through the url, used by graham to check other users "myassets" pages

        string paramUser = Page.Request.QueryString["pUser"];

        if (paramUser != null && paramUser.Trim().Length > 0)
        {  // means there was a username in the url

            user = paramUser;
        }
        else
        {

            user = Page.User.Identity.Name.ToLower();
            //a slight hack to combine michelle and graham as joint owner of assets
            if (user.Equals("michelle"))
            {
                user = "graham";
            }

        }





        IOrderedQueryable assets = from a in db.asset_bookouts
                                   where a.asset_item.asset_group.description == user &&
                                   a.date_in == null
                                   orderby a.date_out
                                   select a;



        e.Result = assets;
    }

    protected void AssetItemsDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {

        string user = "";

        //paramUser is a username through the url, used by graham to check other users "myassets" pages

        string paramUser = Page.Request.QueryString["pUser"];

        if (paramUser != null && paramUser.Trim().Length > 0)
        {  // means there was a username in the url

            user = paramUser;
        }
        else
        {

            user = Page.User.Identity.Name.ToLower();
            //a slight hack to combine michelle and graham as joint owner of assets
            if (user.Equals("michelle"))
            {
                user = "graham";
            }

        }
       
        
        var assets = from a in db.asset_items
                     where a.asset_group.description.Trim().ToLower() == user.Trim().ToLower()
                     && a.current_status != "Archived" 
                     orderby a.current_status descending
                     select a;

        assets = (IOrderedQueryable<asset_item>)assets.Where(u => !u.asset_bookouts.Any(b => b.asset_id == u.id && b.date_in == null));


        

        e.Result = assets;
    }

   /* private bool isAssetBookedOut(int pAssetId)
    {
        bool result = false;

        if (db.asset_bookouts.Any(u => u.asset_id == pAssetId && u.date_in == null))
        {
            result = true;
        
        }


        return result;


    }*/

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

    protected void team_info_selecting(object sender, LinqDataSourceSelectEventArgs e)
    {


        MembershipUserCollection muc = Membership.GetAllUsers();



        List<aspnet_User> resultList = new List<aspnet_User>();

        aspnet_User firstUser = new aspnet_User();
        firstUser.UserName = null;
        resultList.Add(firstUser);
        aspnet_User sharpeningUser = new aspnet_User();
        sharpeningUser.UserName = "Sharpening";
        resultList.Add(sharpeningUser);



        foreach (MembershipUser ee in muc)
        {

            aspnet_User user = new aspnet_User();
            user.UserName = ee.UserName;
            resultList.Add(user);

        }

        e.Result = resultList;


    }
    
}
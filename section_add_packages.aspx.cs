using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class section_add_packages : System.Web.UI.Page
{
    IntranetDataDataContext db = null;
    
    ActivityLog log = null;


    protected void Page_Init(object sender, EventArgs e)
    {
        db = new IntranetDataDataContext();
        log = new ActivityLog();


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

            pSectionId = Int32.Parse(pSectionIdObject.ToString());


            section theSection = (from s in db.sections
                                  where s.section_id == pSectionId
                                  select s).Single();
            result = theSection.client.job_name + " - " + theSection.section_name;
        }

        return result;


    }

    public static string GetOrderDescription(object pOrderIdObject)
    {
        IntranetDataDataContext db = new IntranetDataDataContext();
        int pOrderId = -1;
        string result = "";
        if (pOrderIdObject != null)
        {

            pOrderId = Int32.Parse(pOrderIdObject.ToString());


            job_list_item theOrder = (from j in db.job_list_items
                                  where j.id == pOrderId
                                      select j).Single();
            result = theOrder.description;
        }

        return result;



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


    protected void package_ItemInserting(object sender, ListViewInsertEventArgs e)
    {

        TextBox descriptionTextBox = (TextBox)((ListView)sender).InsertItem.FindControl("descriptionTextBox");
        int pOrderId = -1;
        try
        {
            pOrderId = Int32.Parse(Page.Request.QueryString["pOrderId"]);
        }
        catch (Exception ex) {
            descriptionTextBox.BackColor = System.Drawing.Color.IndianRed;
            descriptionTextBox.ForeColor = System.Drawing.Color.White;
            e.Cancel = true;
            return;

        }

        // get the wall ID from the parent ListView
        ListView lv = (ListView)sender;
        ListViewItem lvi = (ListViewItem)lv.Parent;
        string wallId = ((Label)lvi.FindControl("hiddenWallIdLabel")).Text;

        
        if (descriptionTextBox.Text == null || descriptionTextBox.Text.Trim().Length <= 0)
        {
            descriptionTextBox.BackColor = System.Drawing.Color.IndianRed;
            descriptionTextBox.ForeColor = System.Drawing.Color.White;
            e.Cancel = true;
            return;
        }


        e.Values["wall_id"] = wallId;
        e.Values["job_list_order_id"] = pOrderId;
        e.Values["date_added"] = DateTime.Now.ToString();
        e.Values["user_added"] = User.Identity.Name;
        e.Values["current_status"] = "Being Manufactured";
        e.Values["dispatch_event"] = new DateTime(9999,9,9);




    }
    protected void package_ItemInserted(object sender, LinqDataSourceStatusEventArgs e)
    {
        int pPackageId = ((section_dispatch_item)e.Result).id;
        log.logSectionPackageActivity(pPackageId, "Package ADDED Successfully", User.Identity.Name);

    }

    protected void package_ItemUpdating(object sender, ListViewUpdateEventArgs e)
    {

        TextBox descriptionTextBox = (TextBox)((ListView)sender).EditItem.FindControl("descriptionTextBox");
        if (descriptionTextBox.Text == null || descriptionTextBox.Text.Trim().Length <= 0)
        {
            descriptionTextBox.BackColor = System.Drawing.Color.IndianRed;
            descriptionTextBox.ForeColor = System.Drawing.Color.White;
            e.Cancel = true;
            return;
        }

    }
    protected void package_ItemUpdated(object sender, ListViewUpdatedEventArgs e)
    {
        int pPackageId = Int32.Parse(e.NewValues["id"].ToString());
        log.logSectionPackageActivity(pPackageId, "Package description CHANGED from \"" + e.OldValues["description"] + "\" to \"" + e.NewValues["description"] + "\"", User.Identity.Name);

    }

    protected void package_ItemDeleting(object sender, ListViewDeleteEventArgs e)
    {
        int pPackageId = Int32.Parse(e.Keys["id"].ToString());


        //delete all logs first
        var deletedItems = from s in db.section_dispatch_log_items
                           where s.dispatch_item_id == pPackageId
                           select s;
        if (deletedItems != null)
        {
            db.section_dispatch_log_items.DeleteAllOnSubmit(deletedItems);
            db.SubmitChanges();
        }

    }

    protected void packageDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {
        //int pSectionId = -1;
        int pWallId = -1;
        int pOrderId = -1;
        try
        {
            // pSectionId = Int32.Parse(Page.Request.QueryString["pSectionId"]);
            pWallId = Int32.Parse(e.SelectParameters["wallId"].ToString());
            pOrderId = Int32.Parse(Page.Request.QueryString["pOrderId"]);
           


        }
        catch (Exception ex) { }

        var packages = from p in db.section_dispatch_items
                       where p.wall_id == pWallId &&
                       p.job_list_order_id == pOrderId &&
                       p.current_status == "Being Manufactured"
                       orderby p.wall.wall_order
                       select p;



        e.Result = packages;
    }

    
    




}
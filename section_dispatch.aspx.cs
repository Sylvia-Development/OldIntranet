using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;


public partial class section_dispatch : System.Web.UI.Page
{
    IntranetDataDataContext db = null;
    System.Drawing.Color errorColour = System.Drawing.Color.Red;
    System.Drawing.Color successColour = System.Drawing.Color.Green;
    ActivityLog log = null;


    protected void Page_Init(object sender, EventArgs e)
    {
        db = new IntranetDataDataContext();
        log = new ActivityLog();
       

    }

    protected void Page_Load(object sender, EventArgs e)
    {



    }

    protected void after_page_load(Object sender, EventArgs e)

    {

        scanResult.Text = "";

    }

    protected void Dispatch_Click(object sender, EventArgs e)
    {

        int pPackageId = -1;
        int pSectionId = -1;

        

        try
        {
            pPackageId = Int32.Parse(barcode.Text);
            pSectionId = Int32.Parse(Page.Request.QueryString["pSectionId"]);

        }
        catch (Exception ex)
        {

            scanResult.Text = "Not a Valid Barcode Number (" + ex.Message + ")";
            scanResult.BackColor = errorColour;
            barcode.Text = "";

            ScriptManager.RegisterClientScriptBlock(this, GetType(), "uKey", "PlaySound_BadScan();", true);


            return;

        }



        try
        {
            section_dispatch_item package = (from s in db.section_dispatch_items
                                             where s.id == pPackageId
                                             select s).Single();


            if (package.wall.section_id != pSectionId)
            {
                scanResult.Text = "Package being Dispatched belongs to a different Client";
                scanResult.BackColor = errorColour;
                barcode.Text = "";
                ScriptManager.RegisterClientScriptBlock(this, GetType(), "uKey", "PlaySound_BadScan();", true);
                return;


            }



            
            if (package.current_status.Equals("Dispatched"))
            {
                scanResult.Text = "Package has already been Dispatched";
                scanResult.BackColor = errorColour;
                barcode.Text = "";
                ScriptManager.RegisterClientScriptBlock(this, GetType(), "uKey", "PlaySound_BadScan();", true);
                return;
            }
            if (package.current_status.Equals("Removed"))
            {
                scanResult.Text = "Package cannot be Dispatched as it was removed from Dispatch List";
                scanResult.BackColor = errorColour;
                barcode.Text = "";
                ScriptManager.RegisterClientScriptBlock(this, GetType(), "uKey", "PlaySound_BadScan();", true);
                return;
            }

            if (!package.current_status.Equals("Verified"))
            {
                scanResult.Text = "Package cannot be Dispatched as it has not yet been Verified";
                scanResult.BackColor = errorColour;
                barcode.Text = "";
                ScriptManager.RegisterClientScriptBlock(this, GetType(), "uKey", "PlaySound_BadScan();", true);
                return;
            }

           

            package.current_status = "Dispatched";
            package.dispatch_event = new DateTime(8888, 8, 8); // this adds the item to the open dispatch event 

            db.SubmitChanges();
            scanResult.Text = package.description + " - Package Dispatched Successfully";
            scanResult.BackColor = successColour;
            barcode.Text = "";
            ScriptManager.RegisterClientScriptBlock(this, GetType(), "uKey", "PlaySound_GoodScan();", true);
            log.logSectionPackageActivity(package.id, "Package scanned for DISPATCH Successfully", User.Identity.Name);

            PackageListView.DataBind();
            DispatchEventListView.DataBind();

        }
        catch (InvalidOperationException ioex)
        {
            scanResult.Text = "Barcode Number does not exist in the database";
            scanResult.BackColor = errorColour;
            barcode.Text = "";
            ScriptManager.RegisterClientScriptBlock(this, GetType(), "uKey", "PlaySound_BadScan();", true);
            return;

        }
        catch (Exception ex)
        {
            scanResult.Text = "Error (" + ex.Message + ")";
            scanResult.BackColor = errorColour;
            barcode.Text = "";
            ScriptManager.RegisterClientScriptBlock(this, GetType(), "uKey", "PlaySound_BadScan();", true);
            return;

        }





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

   

    protected void beingManufacturedDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {
        int pSectionId = -1;

        try
        {
            pSectionId = Int32.Parse(Page.Request.QueryString["pSectionId"]);



        }
        catch (Exception ex) { }

        var packages = from p in db.section_dispatch_items
                       where p.wall.section_id == pSectionId &&
                       p.current_status == "Being Manufactured"
                       orderby p.wall.wall_order
                       select p;



        e.Result = packages;
    }

 
    protected void packageDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {
        // Items ready for dispatch
        int pSectionId = -1;

        try
        {
            pSectionId = Int32.Parse(Page.Request.QueryString["pSectionId"]);



        }
        catch (Exception ex) { }

        var packages = from p in db.section_dispatch_items
                       where p.wall.section_id == pSectionId &&
                       p.current_status == "Verified"
                       orderby p.wall.wall_order
                       select p;



        e.Result = packages;
    }

    protected void dispatchedPackageDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {

        DateTime pEvent = new DateTime();
        int pSectionId = -1;

        try
        {
            // pSectionId = Int32.Parse(Page.Request.QueryString["pSectionId"]);
            pEvent = DateTime.Parse(e.SelectParameters["eventID"].ToString());
            pSectionId = Int32.Parse(Page.Request.QueryString["pSectionId"]);


        }
        catch (Exception ex) { }

       

        var packages = from p in db.section_dispatch_items
                       where p.wall.section_id == pSectionId &&
                       (p.dispatch_event.Value.Date == pEvent.Date &&
                       p.dispatch_event.Value.Hour == pEvent.Hour&&
                       p.dispatch_event.Value.Minute == pEvent.Minute &&
                       p.dispatch_event.Value.Second == pEvent.Second) &&
                       p.current_status == "Dispatched"
                       orderby p.wall.wall_order
                       select p;



        e.Result = packages;
    }

   
    protected void EventsDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {
        int pSectionId = -1;

        try
        {
            pSectionId = Int32.Parse(Page.Request.QueryString["pSectionId"]);



        }
        catch (Exception ex) { }

        var events = (from p in db.section_dispatch_items
                      where p.wall.section_id == pSectionId
                      && p.dispatch_event != new DateTime(9999, 9, 9) // this is a default date used when creating a package
                      orderby p.dispatch_event descending
                      select p).GroupBy(i => i.dispatch_event).Select(g => g.First());

       

        e.Result = events;

    }



    protected void DispatchEventListView_ItemDataBound(object sender, ListViewItemEventArgs e)
    {
        
     

        DateTime pOpenEvent = new DateTime(8888, 8, 8); // this is the date of the current open event 
        
        HtmlAnchor deliveryNoteLink = (HtmlAnchor)e.Item.FindControl("deliveryNoteLink");
        Label eventLabel = (Label)e.Item.FindControl("eventLabel");

        string sectionId = Page.Request.QueryString["pSectionId"];


        if (e.Item.ItemType == ListViewItemType.DataItem)
        {
            
            

             
            DateTime currentEvent = (DateTime)((section_dispatch_item)e.Item.DataItem).dispatch_event;
            if (pOpenEvent.Equals(currentEvent))
            {

                

                deliveryNoteLink.HRef = "print_delivery_note.aspx?pEvent=" + currentEvent.ToString() + "&pSectionId=" + sectionId;
                deliveryNoteLink.InnerText = "Print Delivery Note >>";

                eventLabel.Text = "OPEN DISPATCH EVENT";
                eventLabel.BackColor = System.Drawing.Color.Green;


            }
            else
            {

                

                deliveryNoteLink.HRef = "print_delivery_note.aspx?pEvent=" + currentEvent.ToString() + "&pSectionId=" + sectionId;
                deliveryNoteLink.InnerText = "Re-Print Delivery Note >>";
                deliveryNoteLink.Attributes.Remove("onclick");

                eventLabel.Text = currentEvent.ToString("dd MMM yyyy HH:mm:ss");

            }


        }    



    }
}
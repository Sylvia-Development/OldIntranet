using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class section_verify_dispatch : System.Web.UI.Page
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

    protected void Verify_Click(object sender, EventArgs e)
    {

        int pPackageId = -1;
        int pSectionId = -1;

       
        
       

        try
        {
            pPackageId = Int32.Parse(barcode.Text);
            pSectionId = Int32.Parse(Page.Request.QueryString["pSectionId"]);

        }
        catch (Exception ex) {

            scanResult.Text = "Not a Valid Barcode Number (" + ex.Message + ")";
            scanResult.BackColor = errorColour;
            barcode.Text = "";

            ScriptManager.RegisterClientScriptBlock(this, GetType(), "uKey", "PlaySound_BadScan();", true);


            return;

        }



         try{
            section_dispatch_item package = (from s in db.section_dispatch_items
                                             where s.id == pPackageId
                                             select s).Single();


            if(package.wall.section_id != pSectionId)
            {
                scanResult.Text = "Package being Verified belongs to a different Client";
                scanResult.BackColor = errorColour;
                barcode.Text = "";
                ScriptManager.RegisterClientScriptBlock(this, GetType(), "uKey", "PlaySound_BadScan();", true);
                return;


            }



            if (package.current_status.Equals("Verified"))
            {
                scanResult.Text = "Package has already been Verified";
                scanResult.BackColor = errorColour;
                barcode.Text = "";
                ScriptManager.RegisterClientScriptBlock(this, GetType(), "uKey", "PlaySound_BadScan();", true);
                return;
            }
            if (package.current_status.Equals("Removed"))
            {
                scanResult.Text = "Package cannot be verified as it was removed from Dispatch List";
                scanResult.BackColor = errorColour;
                barcode.Text = "";
                ScriptManager.RegisterClientScriptBlock(this, GetType(), "uKey", "PlaySound_BadScan();", true);
                return;
            }
            if (package.current_status.Equals("Dispatched"))
            {
                scanResult.Text = "Package cannot be verified as it was already Dispatched";
                scanResult.BackColor = errorColour;
                barcode.Text = "";
                ScriptManager.RegisterClientScriptBlock(this, GetType(), "uKey", "PlaySound_BadScan();", true);
                return;
            }


            package.current_status = "Verified";
            
            db.SubmitChanges();
            scanResult.Text = package.description+" - Package Verifed Successfully";
            scanResult.BackColor = successColour;
            barcode.Text = "";
            ScriptManager.RegisterClientScriptBlock(this, GetType(), "uKey", "PlaySound_GoodScan();", true);
            log.logSectionPackageActivity(package.id, "Package VERIFIED Successfully", User.Identity.Name);

            PackageListView.DataBind();
            VerifiedPackageListView.DataBind();

        }
        catch(InvalidOperationException ioex)
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


    protected void Remove_Click(object sender, CommandEventArgs e)
    {

        
        int pPackageId = -1;
        try
        {

            pPackageId = Int32.Parse(e.CommandArgument.ToString());
        }
        catch (Exception ex) {
            scanResult.Text = "Error (" + ex.Message + ")";
            scanResult.BackColor = errorColour;
            return;

        }
        
        



        try
        {
            section_dispatch_item package = (from s in db.section_dispatch_items
                                             where s.id == pPackageId
                                             select s).Single();


         


            package.current_status = "Removed";
            
            db.SubmitChanges();
            log.logSectionPackageActivity(package.id, "Package REMOVED from Verified List", User.Identity.Name);
            VerifiedPackageListView.DataBind();
            RemovedPackageListView.DataBind();

        }
        
        catch (Exception ex)
        {
            scanResult.Text = "Error (" + ex.Message + ")";
            scanResult.BackColor = errorColour;
            return;

        }





    }

    protected void ReVerify_Click(object sender, CommandEventArgs e)
    {


        int pPackageId = -1;
        try
        {

            pPackageId = Int32.Parse(e.CommandArgument.ToString());
        }
        catch (Exception ex)
        {
            scanResult.Text = "Error (" + ex.Message + ")";
            scanResult.BackColor = errorColour;
            return;

        }





        try
        {
            section_dispatch_item package = (from s in db.section_dispatch_items
                                             where s.id == pPackageId
                                             select s).Single();





            package.current_status = "Verified";
            
            db.SubmitChanges();
            log.logSectionPackageActivity(package.id, "Package RE-VERIFIED Successfully", User.Identity.Name);
            VerifiedPackageListView.DataBind();
            RemovedPackageListView.DataBind();

        }

        catch (Exception ex)
        {
            scanResult.Text = "Error (" + ex.Message + ")";
            scanResult.BackColor = errorColour;
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
    
   
   

   

    protected void packageDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
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

    protected void verifiedPackageDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {
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


    protected void removedPackageDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {
        int pSectionId = -1;

        try
        {
            pSectionId = Int32.Parse(Page.Request.QueryString["pSectionId"]);



        }
        catch (Exception ex) { }

        var packages = from p in db.section_dispatch_items
                       where p.wall.section_id == pSectionId &&
                       p.current_status == "Removed"
                       orderby p.wall.wall_order
                       select p;

        

        e.Result = packages;
    }

    



}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class print_single_package_barcode : System.Web.UI.Page
{
    IntranetDataDataContext db = null;

    protected void Page_Init(object sender, EventArgs e)
    {
        db = new IntranetDataDataContext();
    }

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    
    

    protected void print_DataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {
        int pPackageId = -1;

        String sPackageId = Page.Request.QueryString["pPackageId"];
        if (sPackageId != null)
        {
            pPackageId = Int32.Parse(sPackageId);
        }



        var package = from p in db.section_dispatch_items
                             where p.id == pPackageId
                      select p;





        e.Result = package;

    }

    public static string GetBarcodeLogo(object clientIDObject)
    {
        

       int clientId = -1;
        if (clientIDObject != null)
            clientId = (int)clientIDObject;

        


        if (clientId == 9025) //Shancon
        {
            return "images/shancon_barcode_logo.png";
        }
        else if (clientId == 9030) //Shellcase
        {
            return "images/shellcase_barcode_logo.png";
        }
        else
        {

            return "images/Blu-line_barcode_Logo.jpg";
        }
    }


}
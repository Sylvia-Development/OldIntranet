using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class print_all_package_barcodes_by_wall : System.Web.UI.Page
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
        int pWallId = -1;
        int pOrderId = -1;

        String sWallId = Page.Request.QueryString["pWallId"];
        String sOrderId = Page.Request.QueryString["pOrderId"];
        if (sWallId != null)
        {
            pWallId = Int32.Parse(sWallId);
            pOrderId = Int32.Parse(sOrderId);
        }



        var packages = from p in db.section_dispatch_items
                      where p.wall_id == pWallId &&
                      p.job_list_order_id == pOrderId &&
                       p.current_status == "Being Manufactured" 
                       select p;





        e.Result = packages;

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
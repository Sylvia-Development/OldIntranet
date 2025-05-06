using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class section_verify_select_order : System.Web.UI.Page
{

    IntranetDataDataContext db = null;
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Page_Init(object sender, EventArgs e)
    {
        db = new IntranetDataDataContext();
       


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

    protected void siteOrdersDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {

        int pSectionId = -1;
        try
        {
            pSectionId = Int32.Parse(Page.Request.QueryString["pSectionId"]);
        }
        catch (Exception ex) { }

        var theOrders = from j in db.job_list_items
                       where j.section_id == pSectionId &&
                       j.is_main_material_order == false &&
                       j.manager_has_processed_order == true &&
                       j.production_assistant_to_order == false
                       && (j.is_snag_list_item == null || j.is_snag_list_item == false)
                       && (j.default_item_na == null || j.default_item_na == false)

                        orderby j.date_logged descending
                       select j;



        e.Result = theOrders;

    }

    protected void dispatchOrdersDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {
        int pSectionId = -1;
        try
        {
            pSectionId = Int32.Parse(Page.Request.QueryString["pSectionId"]);
        }
        catch (Exception ex) { }

        var theOrders = from j in db.job_list_items
                        where j.section_id == pSectionId &&
                        j.description == "<----FOR DISPATCH PURPOSES ONLY---->"
                        orderby j.date_logged
                        select j;

       



        e.Result = theOrders;
    }

    protected void mainMaterialDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {
        int pSectionId = -1;
        try
        {
            pSectionId = Int32.Parse(Page.Request.QueryString["pSectionId"]);
        }
        catch (Exception ex) { }

        var theOrders = from j in db.job_list_items
                        where j.section_id == pSectionId &&
                        j.is_main_material_order == true 
                        && j.description == "Main Material Manufacturing"
                        orderby j.date_logged
                        select j;



        e.Result = theOrders;

    }
}
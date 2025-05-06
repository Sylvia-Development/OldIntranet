using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class print_site_order : System.Web.UI.Page
{
    IntranetDataDataContext db = null;

    protected void Page_Init(object sender, EventArgs e)
    {
        db = new IntranetDataDataContext();
    }


    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void getClientSectionName(Object sender, EventArgs e)
    {
        Label label = (Label)sender;
        int pSectionId = -1;

        String sectionID = Page.Request.QueryString["pSectionId"];
        if (sectionID != null)
        {
            pSectionId = Int32.Parse(sectionID);
        }
        var section = (from s in db.sections
                       where s.section_id == pSectionId
                       select s).Single();



        label.Text = section.client.job_name + " - " + section.section_name;

    }

    protected void print_DataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {
        int pItemId = -1;

        String itemId = Page.Request.QueryString["itemId"];
        if (itemId != null)
        {
            pItemId = Int32.Parse(itemId);
        }



        var job_list_items = from j in db.job_list_items
                             where j.id == pItemId
                             select j;





        e.Result = job_list_items;

    }
}
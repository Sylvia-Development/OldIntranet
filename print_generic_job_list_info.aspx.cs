using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;


public partial class print_generic_job_list_info : System.Web.UI.Page
{
    IntranetDataDataContext db = null;

    protected void Page_Init(object sender, EventArgs e)
    {
        db = new IntranetDataDataContext();
    }
    
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    public string GetWasteNames(Object pNamesObject)
    {
        string returnString = "None";

        if (pNamesObject != null)
        {
            IList<waste_name> nameList = (IList<waste_name>)pNamesObject;
            StringBuilder builder = new StringBuilder();
            foreach (waste_name name in nameList)
            {
                builder.Append(name.user_responsible);
                builder.Append("<br/>");

            }
            returnString = builder.ToString();
        }

        return returnString;


    }

    protected void getClientSectionName(Object sender, EventArgs e)
    {
        Label label = (Label)sender;
        int pSectionId = -1;

        String sectionID = Page.Request.QueryString["pSectionId"];
        String type = Page.Request.QueryString["pType"];
        if (sectionID != null)
        {
            pSectionId = Int32.Parse(sectionID);
        }
        var section = (from s in db.sections
                       where s.section_id == pSectionId
                       select s).Single();



        label.Text = section.client.job_name + " - " + section.section_name + " : "+type;

    }

    protected void print_DataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {
        int pJobListID = -1;

        String jobListID = Page.Request.QueryString["pJobListId"];
        if (jobListID != null)
        {
            pJobListID = Int32.Parse(jobListID);
        }



        var job_list_items = from j in db.job_list_items
                             where j.id == pJobListID
                             select j;





        e.Result = job_list_items;

    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class setup_default_job_list_items : System.Web.UI.Page
{
    IntranetDataDataContext db = null;

    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Page_Init(object sender, EventArgs e)
    {
        db = new IntranetDataDataContext();
    }


    protected void default_job_list_ItemInserting(object sender, ListViewInsertEventArgs e)
    {
        


    }

    protected void JobListDefaultsDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {
       

        var jobListDefaults = from j in db.job_list_item_defaults
                      
                        orderby j.type, j.list_item_order
                        select j;



        e.Result = jobListDefaults;
    }

    



}
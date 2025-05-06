using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class job_lists : System.Web.UI.Page
{
    IntranetDataDataContext db = null;

    protected void Page_Init(object sender, EventArgs e)
    {
        db = new IntranetDataDataContext();
    }

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    public string GetListCount(object jobListItemsObject, string pType)
    {

        string result = "";
        if (jobListItemsObject == null)
            return result;
        
        IEnumerable<job_list_item> jobListItems = (IEnumerable<job_list_item>)jobListItemsObject;

        int count = 0;
         if(pType.Equals("Orders")){   
          count =  jobListItems.Count(r => (r.item_completed == false && (r.default_item_na == null || r.default_item_na == false) && (r.is_snag_list_item == null || r.is_snag_list_item == false)));
         }
         else if (pType.Equals("Snags"))
         {
             count = jobListItems.Count(r => (  r.is_snag_list_item == true && r.item_completed == false ));
         }
         if (count > 0)
         {
             result = "(" + count.ToString() + " "+pType+") ";
            

         }
        return result;

    }

    protected void clientListDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {


        if (Context.User.IsInRole("Director") 
            || Context.User.IsInRole("Processing Manager") 
            || Context.User.IsInRole("Processing Assistant")
            || Context.User.IsInRole("Production Manager")
            || Context.User.IsInRole("Production Assistant"))
        {

            var sections = from s in db.sections
                           where s.in_ops_dept == 1 && (s.production_status_id == 9 || s.production_status_id == 26)
                           orderby s.client.job_name
                           select s;
            e.Result = sections;
        }
        else {

            var sections = from s in db.sections
                           where s.in_ops_dept == 1 && s.production_status_id == 26
                           orderby s.client.job_name
                           select s;
            e.Result = sections;
        
        
        }


    }
}
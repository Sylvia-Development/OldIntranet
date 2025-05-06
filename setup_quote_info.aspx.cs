using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class quote_info_setup : System.Web.UI.Page
{
    IntranetDataDataContext db = null;
    
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Page_Init(object sender, EventArgs e)
    {
         db = new IntranetDataDataContext();
    }


    protected void ListView5_ItemInserting(object sender, ListViewInsertEventArgs e)
    {
        DropDownList ddlParentIds = (DropDownList)ListView5.InsertItem.FindControl("parentList");
        if (ddlParentIds != null)
        {
            if (ddlParentIds.SelectedValue.Trim().Length == 0)
            {
                e.Values["referrer_parent_id"] = null;
            }
            else
            {
                e.Values["referrer_parent_id"] = ddlParentIds.SelectedValue;
            }
        }
    }

    protected void LinqDataSource6_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {
        var referres = from r in  db.referrers
                        where r.referrer_parent_id == null 
                        orderby r.referrer_name
                        select r;
        
        
        
        e.Result = referres;
    }

    protected void LinqDataSource3_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {
        var referres = from r in db.referrers
                       orderby r.referrer1.referrer_name,r.referrer_name
                       select r;
        e.Result = referres;
    }


    


}

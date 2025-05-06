using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class asset_audits : System.Web.UI.Page
{
    IntranetDataDataContext db = null;

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Page_Init(object sender, EventArgs e)
    {
        db = new IntranetDataDataContext();
    }


    protected void AssetAuditsDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {
        
        DateTime checkDate = System.DateTime.Now.AddMonths(-12); // a date 12 months back


        IOrderedQueryable audits = from a in db.asset_audits
                     where a.date_of_audit > checkDate
                     orderby a.date_of_audit descending
                     select a;



        e.Result = audits;
    }
}
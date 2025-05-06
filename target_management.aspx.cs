using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class target_management : System.Web.UI.Page
{
    IntranetDataDataContext db = null;

    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Page_Init(object sender, EventArgs e)
    {
        db = new IntranetDataDataContext();
    }

    protected void RefreshPage(object sender, ListViewUpdatedEventArgs e)
    {
        Page.Response.Redirect("target_management.aspx");
    }


    protected void TargetsDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {
       


        var targets = from t in db.monthly_targets
                        
                        orderby t.id
                        select t;



        e.Result = targets;
    }

    protected void getTotalTarget(Object sender, EventArgs e)
    {
        Label label = (Label)sender;



        label.Text = String.Format("{0:N2}", (from t in db.monthly_targets select t.target_amount).Sum());
    }


}
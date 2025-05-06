using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class sms_log_popup : System.Web.UI.Page
{
    IntranetDataDataContext db = null;

    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Page_Init(object sender, EventArgs e)
    {
        db = new IntranetDataDataContext();
    }



    protected void getClientName(Object sender, EventArgs e)
    {
        Label label = (Label)sender;
        int pClientId = -1;

        try
        {
            pClientId = Int32.Parse(Page.Request.QueryString["pClientId"]);

        }
        catch (Exception ex) { }

        var clientName = (from c in db.clients
                          where c.client_id == pClientId
                          select c).Single();




        label.Text = clientName.job_name;
    }
    protected void SmsDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {
        int pClientId = -1;
        int pDeptId = -1;

        try
        {
            pClientId = Int32.Parse(Page.Request.QueryString["pClientId"]);
            pDeptId = Int32.Parse(Page.Request.QueryString["pDepartmentId"]);

        }
        catch (Exception ex) { }

        var smsLogs = from c in db.sms_logs
                      where c.client_id == pClientId
                      && c.dept_id == pDeptId
                      orderby c.date descending
                      select c;




        e.Result = smsLogs;
    }


}
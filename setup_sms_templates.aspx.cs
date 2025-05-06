using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

public partial class setup_sms_templates : System.Web.UI.Page
{
    IntranetDataDataContext db = null;

    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Page_Init(object sender, EventArgs e)
    {
        db = new IntranetDataDataContext();
    }

    protected void SmsTemplatesDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {
        int pDepartmentId = -1;
        try
        {
            pDepartmentId = Int32.Parse(Page.Request.QueryString["pDepartmentId"]);
        }
        catch (Exception ex) { }
        
        
        var templates  = from t in db.sms_templates
                         where t.dept_id == pDepartmentId
                        orderby t.display_order
                        select t;



        e.Result = templates;
    }


    protected void sms_template_ItemInserting(object sender, ListViewInsertEventArgs e)
    {
        e.Values["dept_id"] = Page.Request.QueryString["pDepartmentId"];

    }
    

}

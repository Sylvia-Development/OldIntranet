using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class client_category_popup : System.Web.UI.Page
{
    IntranetDataDataContext db = null;
    
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Page_Init(object sender, EventArgs e)
    {
        db = new IntranetDataDataContext();



    }



    protected void client_category_selecting(object sender, LinqDataSourceSelectEventArgs e)
    {

        int pClientId = -1;
        try
        {
            pClientId = Int32.Parse(Page.Request.QueryString["pClientId"]);
        }
        catch (Exception ex) { }
        var responses = from r in db.client_category_responses where r.category_id ==  (from c in db.clients where c.client_id == pClientId select c.client_category_id).Single()
                         orderby r.id
                         select r;
        

        e.Result = responses;
    }
}
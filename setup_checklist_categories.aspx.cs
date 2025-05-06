using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class setup_checklist_categories : System.Web.UI.Page
{
    IntranetDataDataContext db = null;

    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Page_Init(object sender, EventArgs e)
    {
        db = new IntranetDataDataContext();
    }

    protected void checklist_category_ItemInserting(object sender, ListViewInsertEventArgs e)
    {
        e.Values["dept_id"] = Page.Request.QueryString["pDepartmentId"];



    }



    protected void Checklist_Categories_DataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {
        int pDepartmentId = -1;
        try
        {
            pDepartmentId = Int32.Parse(Page.Request.QueryString["pDepartmentId"]);
        }
        catch (Exception ex) { }

        var checklist_categories = from c in db.wall_checklist_categories
                              where c.dept_id == pDepartmentId
                              orderby c.category_order
                              select c;



        e.Result = checklist_categories;
    }



}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class setup_default_checklist_items : System.Web.UI.Page
{
    IntranetDataDataContext db = null;

    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Page_Init(object sender, EventArgs e)
    {
        db = new IntranetDataDataContext();
    }

   


    protected void checklist_ItemInserting(object sender, ListViewInsertEventArgs e)
    {
        e.Values["dept_id"] = Page.Request.QueryString["pDepartmentId"];
        DropDownList categoryDropdown = (DropDownList)((ListView)sender).InsertItem.FindControl("Category_DropDownList");
        if (categoryDropdown.SelectedValue != null)
        {
            e.Values["category_id"] = categoryDropdown.SelectedValue;
        }


    }

    

    protected void ChecklistDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {
        int pDepartmentId = -1;
        try
        {
            pDepartmentId = Int32.Parse(Page.Request.QueryString["pDepartmentId"]);
        }
        catch (Exception ex) { }

        var checklist_items = from c in db.wall_checklist_defaults
                        where  c.dept_id == pDepartmentId
                        orderby c.wall_checklist_category.category_order,c.description
                        select c;



        e.Result = checklist_items;
    }

   

}
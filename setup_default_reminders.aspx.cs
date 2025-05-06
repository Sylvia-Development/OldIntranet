using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class setup_default_reminders : System.Web.UI.Page
{
    IntranetDataDataContext db = null;
    
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Page_Init(object sender, EventArgs e)
    {
        db = new IntranetDataDataContext();
    }

    protected void contact_reminder_ItemInserting(object sender, ListViewInsertEventArgs e)
    {
        e.Values["department_id"] = Page.Request.QueryString["pDepartmentId"];
        e.Values["type"] = "0";
            
        
    }

    public String getLabel(int value)
    {
        //        return value.GetType().ToString();
        string label = "";
        int val = value;

        if (val == 1)
        {
            label = "Add Section";
        }
        else if (val == 2)
        {
            label = "Set to Won";
        }
        else if (val == 3)
        {
            label = "Job Close";
        }
        else if( val == 4)
		{
            label = "In Ops Dept";
		}
        return label;
    }


    protected void workflow_reminder_ItemInserting(object sender, ListViewInsertEventArgs e)
    {
        e.Values["department_id"] = Page.Request.QueryString["pDepartmentId"];
        e.Values["type"] = "1";


    }

    protected void ContactDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {
       int pDepartmentId = -1;
        try{
            pDepartmentId =  Int32.Parse(Page.Request.QueryString["pDepartmentId"]);
        }catch(Exception ex){}
        
        var reminders = from r in db.reminder_defaults
                        where r.type == 0 && r.department_id == pDepartmentId
                       orderby r.reminder_order
                       select r;



        e.Result = reminders;
    }

    protected void WorkflowDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {
        int pDepartmentId = -1;
        try
        {
            pDepartmentId = Int32.Parse(Page.Request.QueryString["pDepartmentId"]);
        }
        catch (Exception ex) { }

        var reminders = from r in db.reminder_defaults
                        where r.type == 1 && r.department_id == pDepartmentId
                        orderby r.reminder_order
                        select r;



        e.Result = reminders;
    }


}

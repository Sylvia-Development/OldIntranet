using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class setup_default_reminders_users : System.Web.UI.Page
{
    IntranetDataDataContext db = null;
    ReminderEvents events = new ReminderEvents();

    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Page_Init(object sender, EventArgs e)
    {
        db = new IntranetDataDataContext();
    }

	protected void events_to_add_OnItemCreate(object sender, ListViewItemEventArgs e)
	{
		//if ((e.Item != null) && (e.Item.ItemType == ListViewItemType.InsertItem))
		//{
		//	System.Web.UI.Control ddlEvent = e.Item.FindControl("ddlEvent");
		//	if (ddlEvent != null)
		//	{
		//		(ddlEvent as DropDownList).DataSource = getEvent();
		//		(ddlEvent as DropDownList).DataBind();
		//		(ddlEvent as DropDownList).SelectedValue = getEvent().;
		//	}
		//}
	}
    protected override void OnDataBinding(EventArgs e)
    {
        try { base.OnDataBinding(e); }

        catch (Exception ex)
        {
            
        }

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
        else if ( val== 3)
		{
            label = "Job Closed";
		} 
        else if(val== 4)
		{
            label = "In Ops Dept";
		}
        return label;
	}
    protected void contact_reminder_ItemInserting(object sender, ListViewInsertEventArgs e)
    {

      

        //int order = Int32.Parse((String) e.Values["reminder_order"]);
        e.Values["department_id"] = Page.Request.QueryString["pDepartmentId"];
       
        e.Values["user_name"] = Context.User.Identity.Name.ToLower();

      
        //getLabel(e.Values["event_to_add"]);
		
  //      int orderNum = e.Values["reminder_order"];

  //      var reminders = from r in db.reminder_defaults_by_users
  //                      where r.user_name == Context.User.Identity.Name.ToLower()
  //                      && r.department_id == Int32.Parse(Page.Request.QueryString["pDepartmentId"])
  //                      select r;
        
  //      foreach(var rems in reminders)
		//{
  //          if(rems.reminder_order == orderNum)
		//	{

		//	}

		//}

        //IntranetDataDataContext db = new IntranetDataDataContext();

                        //foreach (var reminder in (from r in db.reminders where r.UserName == Context.User.Identity.Name select r))
                        //{
                        //	if (reminder.reminder_order >= order)
                        //	{
                        //		reminder.reminder_order = reminder.reminder_order + 1;
                        //		db.SubmitChanges();
                        //	}
                        //}
    }


	//  protected void workflow_reminder_ItemInserting(object sender, ListViewInsertEventArgs e)
	//  {
	//      e.Values["department_id"] = Page.Request.QueryString["pDepartmentId"];
	//e.Values["user_name"] = Context.User.Identity.Name;



	//  }

	protected void ContactDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {
       
        
        int pDepartmentId = Int32.Parse(Page.Request.QueryString["pDepartmentId"]);
        String user = Context.User.Identity.Name;

        var userRems = from ur in db.reminder_defaults_by_users
                       where ur.user_name.ToLower() == user.ToLower()
                       && ur.department_id == Int32.Parse(Page.Request.QueryString["pDepartmentId"])
                      // && ur.reminder_order== Array.IndexOf(reminder_defaults_by_user.reminder_order)
                       orderby ur.reminder_order
                        select ur;


        if (userRems.Count() == 0)
        {
            try
            {
                pDepartmentId = Int32.Parse(Page.Request.QueryString["pDepartmentId"]);
               
            }
            catch (Exception ex) { }

            var reminders = from r in db.reminder_defaults
                            where r.department_id == pDepartmentId
                            orderby r.reminder_order, r.event_to_add
                            select r;

            //insert code
            foreach (var rd in reminders)
            {
                reminder_defaults_by_user rem = new reminder_defaults_by_user();
             
                rem.user_name = Context.User.Identity.Name.ToLower();
                rem.department_id = (int)rd.department_id;
                rem.high_priority = rd.high_priority;
                rem.reminder_order = rd.reminder_order;
                rem.reminder = rd.reminder;
                rem.event_to_add = rd.event_to_add;

                db.reminder_defaults_by_users.InsertOnSubmit(rem);


            }
            db.SubmitChanges();

            ListView1.DataBind();



            //userRems = from ur in db.reminder_defaults_by_users
            //           where ur.user_name.ToLower() == user.ToLower()
            //           && ur.department_id == pDepartmentId
            //           select ur;

        }
        
	
            e.Result = userRems;
		
       
    }

	

}
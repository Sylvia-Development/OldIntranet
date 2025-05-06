using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class setDefaultReminders : System.Web.UI.Page
{
	IntranetDataDataContext db = null;
	protected void Page_Load(object sender, EventArgs e)
	{

	}
	protected void Page_Init(object sender, EventArgs e)
	{
		db = new IntranetDataDataContext();
	}

	protected void userReminders_OnSelecting(object sender, LinqDataSourceSelectEventArgs e)
	{
		int deptID = -1;
		//string user = "";

		try
		{
			deptID = Int32.Parse(Page.Request.QueryString["deptId"]);
			//user = Page.Request.QueryString["user"];
		}
		catch (Exception ex)
		{ }

		var reminders = from r in db.reminder_defaults
						where r.type == 1 && r.department_id == deptID //&& r.User
						orderby r.reminder_order
						select r;

		e.Result = reminders;
	}

	public void reloadClick(object sender, EventArgs e)
	{

		int pDepartmentId = -1;
		int pSectionId = -1;


		try
		{
			pDepartmentId = Int32.Parse(Page.Request.QueryString["pDepartmentId"]);
			pSectionId = Int32.Parse(Page.Request.QueryString["pSectionId"]);



		}
		catch (Exception ex) { }

		var reminder_def = from r in db.reminder_defaults
						   where r.department_id == pDepartmentId &&
						   r.type == 0
						   select r;




		foreach (var rd in reminder_def)
		{
			reminder rem = new reminder();
			rem.type = rd.type;
			rem.department_id = (int)rd.department_id;
			rem.reminder1 = rd.reminder;
			rem.high_priority = rd.high_priority;
			rem.reminder_order = rd.reminder_order;
			rem.section_id = pSectionId;
			rem.reminder_status = 0;
			rem.date_completed = new DateTime(1901, 1, 1);

			db.reminders.InsertOnSubmit(rem);


		}
		db.SubmitChanges();

		remindersListView.DataBind();

	}
	protected void UseReminder_OnInserting(object sender, ListViewInsertEventArgs e)
	{
		e.Values["department_id"] = Page.Request.QueryString["deptId"];
		//e.Values["UserName"] = Page.Request.QueryString["user"];
		e.Values["type"] = 1;
	}

}
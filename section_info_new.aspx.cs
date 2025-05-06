using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class section_info_new : System.Web.UI.Page
{
	IntranetDataDataContext db = null;

	Leadtime leads = new Leadtime();
	protected void Page_Load(object sender, EventArgs e)
	{
		if (!IsPostBack)
		{

		}


	}


	protected void formview_load(object sender, EventArgs e)
	{
		int pClientId = -1;
		String sectionId = Page.Request.QueryString["pSectionId"];
		try
		{
			pClientId = Int32.Parse(Page.Request.QueryString["pClientId"]);
		}
		catch (Exception ex) { }

		if (clientNameLabel != null)
		{

			IntranetDataDataContext db = new IntranetDataDataContext();
			var result = from c in db.clients
						 where c.client_id == pClientId
						 select c;


			foreach (client c in result)
			{
				string refNo = null;
				if (sectionId != null && !sectionId.Equals("-1"))
				{
					refNo = c.job_name;

					if (refNo != null && refNo.Length > 3)
					{
						refNo = refNo.Remove(3) + sectionId;
					}
					else
					{
						refNo = refNo + sectionId;
					}
				}
				clientNameLabel.Text = "Job Ref:  " + refNo;

			}
		}



		if (sectionId != null && sectionId.Equals("-1"))
		{

			FormView1.ChangeMode(FormViewMode.Insert);
		}
		else
		{
			FormView1.ChangeMode(FormViewMode.Edit);
		}



	}




	protected void Page_Init(object sender, EventArgs e)
	{
		db = new IntranetDataDataContext();
	}


    protected void validate_brand(object source, ServerValidateEventArgs args)
    {
		
       
        if (args.Value.ToString() == "0")
        {
            args.IsValid = false;
        }
        else
        {
            args.IsValid = true;
        }

    }

	//public String getBrand()
	//{
	//	 int sectionId = Int32.Parse(Page.Request.QueryString["pSectionId"]);

	//	 var brand = (from b in db.sections
	//				where b.section_id == sectionId
	//				select b).First();
	//	LeadTimes lead = (LeadTimes)brand.Brand;

	//		return lead.ToString(); 
	//}

	protected void section_item_created(object sender, EventArgs e)
	{
		if (FormView1.CurrentMode == FormViewMode.Insert)
		{

			TextBox clientIdTextBox = FormView1.FindControl("clientIdTextBox") as TextBox;
			TextBox quoteValueTextBox = FormView1.FindControl("quote_valueTextBox") as TextBox;


			if (clientIdTextBox != null)
			{
				clientIdTextBox.Text = Page.Request.QueryString["pClientId"];
			}
			if (quoteValueTextBox != null && quoteValueTextBox.Text.Length <= 0)
			{
				quoteValueTextBox.Text = "0";
			}

		}
	}

	protected void section_info_ItemInserting(object sender, FormViewInsertEventArgs e)
	{

		int pClientId = -1;
		String sectionId = Page.Request.QueryString["pSectionId"];
		int dept = -1;
		try
		{
			pClientId = Int32.Parse(Page.Request.QueryString["pClientId"]);
			dept = Int32.Parse(Page.Request.QueryString["pDepartmentId"]);
		}
		catch (Exception ex) { }

		DateTime dateAdded = DateTime.Now;

		if (Utils.isContractsJob(pClientId))
			dateAdded = new DateTime(2016, 01, 01); // setting the date back for contracts jobs so that they dont screw with the stats 



		e.Values["date_added"] = dateAdded;
		e.Values["in_ops_dept"] = 0;
		e.Values["active_status"] = 1;
		//e.Values["section.reminders_complete."]= false;



	}



	protected void section_info_selecting(object sender, LinqDataSourceSelectEventArgs e)
	{
		int pClientId = -1;
		int pSectionId = -1;
		try
		{
			pClientId = Int32.Parse(Page.Request.QueryString["pClientId"]);
			pSectionId = Int32.Parse(Page.Request.QueryString["pSectionId"]);
		}
		catch (Exception ex) { }

		var sections = from s in db.sections
					   where s.client_id == pClientId && s.section_id == pSectionId
					   select s;

		e.Result = sections;
	}

	protected void quote_status_selecting(object sender, LinqDataSourceSelectEventArgs e)
	{


		var statuses = from s in db.status
					   where s.department_id == 0
					   orderby s.display_order
					   select s;

		e.Result = statuses;
	}
	protected void production_status_selecting(object sender, LinqDataSourceSelectEventArgs e)
	{


		var statuses = from s in db.status
					   where s.department_id == 1
					   orderby s.display_order
					   select s;

		e.Result = statuses;
	}
	protected void project_status_selecting(object sender, LinqDataSourceSelectEventArgs e)
	{


		var statuses = from s in db.status
					   where s.department_id == 2
					   orderby s.display_order
					   select s;

		e.Result = statuses;
	}
	protected void site_status_selecting(object sender, LinqDataSourceSelectEventArgs e)
	{


		var statuses = from s in db.status
					   where s.department_id == 3
					   orderby s.display_order
					   select s;

		e.Result = statuses;
	}
	protected void service_status_selecting(object sender, LinqDataSourceSelectEventArgs e)
	{


		var statuses = from s in db.status
					   where s.department_id == 4
					   orderby s.display_order
					   select s;

		e.Result = statuses;
	}


	public int getLeadTime(String lead)

	{
	Leadtime times = (Leadtime)Enum.Parse(typeof(Leadtime), lead);
	return (int)times;

	}

	public string getBrandName(String brand)

	{

		int brands = Int32.Parse(brand);

		Brands b = (Brands)brands;

		//string day = Enum.GetName(typeof(LeadTimes), b);



		return b.ToString();



	}




	protected void section_info_itemInserted(object sender, FormViewInsertedEventArgs e)
	{
		using (IntranetDataDataContext db = new IntranetDataDataContext())
		{

			int client_id = Int32.Parse(e.Values["client_id"].ToString());
			var sect = (from s in db.sections
						where s.client_id == client_id &&
							  s.section_name == e.Values["section_name"].ToString()
						select s).FirstOrDefault();

			int secId = sect.section_id;
			string consultant = sect.client.consultant_name;
			string siteCo = sect.client.site_coordinator_name;
			int addSectionRems = 1; // the value of event_to_add (Add Section (1))   

			String deptId = "0";

			if (Context.User.IsInRole("Design Consultant") && !Context.User.IsInRole("Customer Experience Manager"))
			{
				deptId = "0";

			}
			else if (Context.User.IsInRole("Systems Integration"))
			{
				deptId = "1";

			}
			else if (Context.User.IsInRole("Design Administrator"))
			{
				deptId = "15";

			}




			if ((from r in db.reminders where r.section_id == secId select r).Count() == 0)
			{
				var userRems = from ur in db.reminder_defaults_by_users
							   where ur.event_to_add == addSectionRems
							   && ur.department_id == 0
							   && ur.user_name == consultant
							   select ur;



				foreach (var rd in userRems)
				{
					reminder rem = new reminder();
					rem.type = 0;
					rem.UserName = consultant;
					rem.department_id = 0;
					rem.reminder1 = rd.reminder;
					rem.high_priority = rd.high_priority;
					rem.reminder_order = rd.reminder_order;
					rem.section_id = secId; //pSectionId;
					rem.reminder_status = 0;
					if (rd.reminder_order == 0)
						rem.reminder_due_date = System.DateTime.Now.Date;
					rem.date_completed = new DateTime(1901, 1, 1);

					db.reminders.InsertOnSubmit(rem);


				}
				db.SubmitChanges();

			}



			// insert the section into the job timing table so that the quote time can be measured IF NOT CONTRACTS JOB

			if (!Utils.isContractsJob(client_id))
			{

				if (!db.job_times.Any(j => j.section_id == secId && j.dept_id == 0))//  check for duplicates
				{

					job_time quoteJobTime = new job_time();
					quoteJobTime.section_id = secId;
					quoteJobTime.dept_id = 0;
					//quoteJobTime.started_date = System.DateTime.Now.Date; // insert to add start date to a section 23/01/2023
					db.job_times.InsertOnSubmit(quoteJobTime);
					db.SubmitChanges();

				}
			}
			//\"management_dashboard.aspx?pDepartmentId=0\"

			if ((from c in db.clients where c.client_id == client_id select c).Count() >= 1)
			{
				// checks if there are more than 1 clients if true then its an inserted section of an existng client therefore the existing site coordinator must be assign to new section
				e.Values["site_coordinator_name"] = siteCo;
				db.SubmitChanges();
			}

			Response.Redirect("closeSBandRedirect.aspx?pRedirectUrl='section_view.aspx%3FpReminderType=0%26pSectionId=" + secId + "%26pDepartmentId=" + deptId + "%26pClientId=" + client_id + "'");
		}
	}

	protected void section_info_itemUpdating(object sender, FormViewUpdateEventArgs e)
	{

	}


	protected void section_info_itemUpdated(object sender, FormViewUpdatedEventArgs e)
	{
		IntranetDataDataContext db = new IntranetDataDataContext();

		String department_id = Page.Request.QueryString["pDepartmentId"];
		String client_id = Page.Request.QueryString["pClientId"];
		String section_id = Page.Request.QueryString["pSectionId"];
		String user = Context.User.Identity.Name;

		int deptID = int.Parse(department_id);

		var clnt = (from c in db.clients where c.client_id == Int32.Parse(client_id) select c).First();
		String client_name = clnt.job_name.ToString();
		String siteCo = clnt.site_coordinator_name;
		String consultant = clnt.consultant_name;

		int addInOpsDpt = 4; //the Ops department event_to_add value

		if (Context.User.IsInRole("Design Consultant") && !Context.User.IsInRole("Customer Experience Manager"))
		{
			department_id = "0";

		}
		else if (Context.User.IsInRole("Systems Integration"))
		{
			department_id = "1";

		}
		else if (Context.User.IsInRole("Site Coordinator"))
		{
			department_id = "2";

		}



		if (e.OldValues["in_ops_dept"].Equals("0") && e.NewValues["in_ops_dept"].Equals("1"))
		{
			if ((from s in db.sections where s.client_id == int.Parse(client_id) && s.client.site_coordinator_name != null && s.client.site_coordinator_name != "" select s.client_id).Count() > 1)
			{
				var section = (from s in db.sections where s.section_id == int.Parse(section_id) && s.client.site_coordinator_name == siteCo select s).First();


				var userRem = from ur in db.reminder_defaults_by_users
							  where
								ur.user_name == siteCo
							  && ur.department_id == 2    // hack for now to populate only site coordinators
							  && ur.event_to_add == addInOpsDpt
							  select ur;

				foreach (var rd in userRem)
				{
					reminder rem = new reminder();
					rem.type = 0;
					rem.UserName = siteCo; //section.client.site_coordinator_name;
					rem.department_id = 2;    // (int)rd.department_id;
					rem.reminder1 = rd.reminder;
					rem.high_priority = rd.high_priority;
					rem.reminder_order = rd.reminder_order;
					rem.section_id = int.Parse(section_id);
					rem.reminder_status = 0;
					if (rd.reminder_order == 0)
						rem.reminder_due_date = System.DateTime.Now.Date;
					rem.date_completed = new DateTime(1901, 1, 1);
					db.reminders.InsertOnSubmit(rem);
				}
				db.SubmitChanges();
			}

			if (e.OldValues["in_ops_dept"].Equals("0") && e.NewValues["in_ops_dept"].Equals("1"))
			{

				var userRems = from ur in db.reminder_defaults_by_users
							   where ur.event_to_add == addInOpsDpt
							   && ur.user_name == consultant
							   && ur.department_id == 0   // hack for now to populate only consultants
							   select ur;

				foreach (var rd in userRems)
				{
					reminder rem = new reminder();
					rem.type = 0;
					rem.UserName = consultant;
					rem.department_id = 0;    // (int)rd.department_id;
					rem.reminder1 = rd.reminder;
					rem.high_priority = rd.high_priority;
					rem.reminder_order = rd.reminder_order;
					rem.section_id = int.Parse(section_id);
					rem.reminder_status = 0;
					if (rd.reminder_order == 0)
						rem.reminder_due_date = System.DateTime.Now.Date;
					rem.date_completed = new DateTime(1901, 1, 1);
					db.reminders.InsertOnSubmit(rem);
				}
				db.SubmitChanges();


			}

			if (!db.reminders.Any(j => j.section_id == Int32.Parse(section_id) && (j.department_id == 1 || j.department_id == 4 || j.department_id == 7 || j.department_id == 8)))//  check for duplicates || j.department_id == 2
			{
				var reminder_def = from r in db.reminder_defaults
								   where r.department_id == deptID
								   || r.department_id == 20
								   //|| r.department_id == 2
								   || r.department_id == 4
								   || r.department_id == 7

								   orderby r.reminder_order
								   select r;

				int dept8Count = 0;
				int dept20Count = 0;
				//int dept2Count = 0;
				int dept7Count = 0;
				foreach (var rd in reminder_def)
				{
					reminder rem = new reminder();
					rem.type = rd.type;
					rem.department_id = (int)rd.department_id;
					rem.reminder1 = rd.reminder;
					rem.high_priority = rd.high_priority;
					rem.reminder_order = rd.reminder_order;
					rem.section_id = Int32.Parse(section_id);
					rem.reminder_status = 0;
					//set a reminder date for the first task
					if ((int)rd.department_id == 8)
					{
						if (dept8Count == 0)
						{
							rem.reminder_due_date = System.DateTime.Now.Date;
							dept8Count++;
						}
					}
					if ((int)rd.department_id == 20)
					{
						if (dept20Count == 0)
						{
							rem.reminder_due_date = System.DateTime.Now.Date;
							dept20Count++;
						}
					}
					//if ((int)rd.department_id == 2)
					//{
					//	if (dept2Count == 0)
					//	{
					//		rem.reminder_due_date = System.DateTime.Now.Date;
					//		dept2Count++;
					//	}
					//}

					if ((int)rd.department_id == 7)
					{
						if (dept7Count == 0)
						{
							rem.reminder_due_date = System.DateTime.Now.Date;
							dept7Count++;
						}
					}



					rem.date_completed = new DateTime(1901, 1, 1);

					db.reminders.InsertOnSubmit(rem);


				}
				db.SubmitChanges();


			}



			if (!db.job_times.Any(j => j.section_id == Int32.Parse(section_id) && j.dept_id == 2))//  check for duplicates
			{
				job_time installationJobTime = new job_time();
				installationJobTime.section_id = Int32.Parse(section_id);
				installationJobTime.dept_id = 2;
				db.job_times.InsertOnSubmit(installationJobTime);
				db.SubmitChanges();
			}

			//if ((from c in db.sections where c.client_id == int.Parse(client_id) select c).Count() > 1)
			//{
			//	job_time job = new job_time();
			//	job.section.client.site_coordinator_name = siteCo;
			//	db.SubmitChanges();
			//}

			if (!db.project_dates.Any(o => o.section_id == Int32.Parse(section_id)))//  check for duplicates
			{
				Utils util = new Utils();

				project_date projectDate = new project_date();
				projectDate.section_id = Int32.Parse(section_id);
				projectDate.in_production = false;
				projectDate.production_complete = false;
				projectDate.factory_scheduled = false;
				projectDate.stock_orders_sent = false;
				projectDate.scheduled_plan_creation = false;
				projectDate.plumbing_electrical_complete = false;
				projectDate.final_measurements_complete = false;
				projectDate.client_lead_time = getLeadTime(getBrandName((e.NewValues["section.Brand"]).ToString()));//util.getProductionDefaults().client_lead_time.Value;
				projectDate.production_buffer = util.getProductionDefaults().production_buffer.Value;
				db.project_dates.InsertOnSubmit(projectDate);
				db.SubmitChanges();
			}

			// insert the default FOR DISPATCH PURPOSES joblistitem
			job_list_item jobListItem = new job_list_item();
			jobListItem.section_id = Int32.Parse(section_id);
			jobListItem.user_logged = "System";
			jobListItem.date_logged = DateTime.Now;
			jobListItem.default_item_na = false;
			jobListItem.department_id = 1;
			jobListItem.description = "<----FOR DISPATCH PURPOSES ONLY---->";
			jobListItem.manager_has_processed_order = true;
			jobListItem.manager_processed_date = DateTime.Now;
			jobListItem.manager_processed_name = "AutoAuth";
			jobListItem.item_completed = false;
			jobListItem.is_main_material_order = false;
			db.job_list_items.InsertOnSubmit(jobListItem);
			db.SubmitChanges();


			/*
            //insert the default walls
            if (!db.walls.Any(o => o.section_id == Int32.Parse(section_id)))//  check for duplicates
            {
                wall generalWall = new wall();
                generalWall.section_id = Int32.Parse(section_id);
                generalWall.wall_label = "General Snags";
                generalWall.wall_order = -10;
                db.walls.InsertOnSubmit(generalWall);
                db.SubmitChanges();
            }*/


			ActivityLog log = new ActivityLog();
			log.sendInOpsDeptEmail(client_name + " - " + e.NewValues["section_name"].ToString(), User.Identity.Name);

		}



		// Response.Redirect("section_info.aspx?pClientId=" + client_id + "&pSectionId=" + section_id + "&pDepartmentId=" + department_id + "&pMessage=" + client_name.Single<String>() + "-" + e.NewValues["section_name"] + " Info Updated");
		Response.Redirect("closeSBandRedirect.aspx?pRedirectUrl='section_view.aspx%3FpReminderType=0%26pSectionId=" + section_id + "%26pDepartmentId=" + department_id + "%26pClientId=" + client_id + "'");

	}

}
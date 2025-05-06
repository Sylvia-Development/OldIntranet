using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class new_dir_dashboard : System.Web.UI.Page
{
	protected void Page_Load(object sender, EventArgs e)
	{

	}
	IntranetDataDataContext db = new IntranetDataDataContext();
	DateHandler dateHandler = null;

	protected void Page_Init(object sender, EventArgs e)
	{
		dateHandler = new DateHandler();
	}
	
	protected void projectsInProgressDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
	{



		IQueryable<job_time> job_times = (from j in db.job_times
										  where j.dept_id == 0
										  && j.section.active_status == 1
										  && j.started_date != null
										  && j.completed_date == null
										  orderby j.started_date descending
										  select j).Take(10);



		e.Result = job_times;

	}
	protected String GetDaysElapsed(object pStartDate, object pEndDate, int pDeptId)
	{

		DateTime startDate = (DateTime)pStartDate;
		DateTime endDate = (DateTime)pEndDate;


		bool isQuote = false;

		if (pDeptId == 0)
			isQuote = true;

		int elapsedDays = dateHandler.netWorkingDays(startDate, endDate, pDeptId, isQuote);
		return elapsedDays.ToString();

	}

	protected String GetInstallationTime(object pQuoteValue)
	{


		Utils util = new Utils();
		int allocatedDays = util.getAllocatedInstallationDays((Decimal)pQuoteValue);


		return allocatedDays.ToString();

	}
	protected string GetRowStyle(object pStartDate, object pEndDate, object pSectionObject, int pDeptId)
	{
		DateTime startDate = (DateTime)pStartDate;
		DateTime endDate = System.DateTime.Now; ;
		section thisSection = (section)pSectionObject;
		if (pEndDate != null)
			endDate = (DateTime)pEndDate;

		string result = "";

		bool isQuote = false;
		int targetLeadTime = 0;
		if (pDeptId == 0)
		{
			targetLeadTime = 7;
			isQuote = true;

		}
		else if (pDeptId == 2)
		{


			targetLeadTime = Int32.Parse(GetInstallationTime(thisSection.quote_value));

			isQuote = false;
		}

		int leadTime = dateHandler.netWorkingDays(startDate, endDate, pDeptId, isQuote);

		if (pDeptId == 0)
		{

			if (leadTime <= targetLeadTime)
				result = "greenRow";
			else if (leadTime > targetLeadTime)
				result = "redRow";
		}
		else if (pDeptId == 2)
		{
			if (leadTime <= targetLeadTime + 5)// add buffer as per performance bonus system
				result = "greenRow";
			else if ((leadTime >= targetLeadTime + 6) && (leadTime <= targetLeadTime + 10))// 75% bonus
				result = "blueRow";
			else if ((leadTime >= targetLeadTime + 11) && (leadTime <= targetLeadTime + 15))// 50% bonus
				result = "purpleRow";
			else if ((leadTime >= targetLeadTime + 16) && (leadTime <= targetLeadTime + 20))// 25% bonus
				result = "amberRow";
			else if (leadTime >= targetLeadTime + 21) // 0% bonus
				result = "redRow";

		}

		return result;

	}

	protected string GetColorCode(object pStartDate, object pEndDate, object pSectionObject, int pDeptId)
	{
		DateTime startDate = (DateTime)pStartDate;
		DateTime endDate = System.DateTime.Now; ;
		section thisSection = (section)pSectionObject;
		if (pEndDate != null)
			endDate = (DateTime)pEndDate;

		string result = "";

		bool isQuote = false;
		int targetLeadTime = 0;
		if (pDeptId == 0)
		{
			targetLeadTime = 7;
			isQuote = true;

		}
		else if (pDeptId == 2)
		{


			targetLeadTime = Int32.Parse(GetInstallationTime(thisSection.quote_value));

			isQuote = false;
		}

		int leadTime = dateHandler.netWorkingDays(startDate, endDate, pDeptId, isQuote);

		if (pDeptId == 0)
		{

			if (leadTime <= targetLeadTime)
			{

				result = "Ontime";
			}
			else if (leadTime > targetLeadTime)
				result = "Behindtime";
		}
		//else if (pDeptId == 2)
		//{
		//	if (leadTime <= targetLeadTime + 5)// add buffer as per performance bonus system
		//		result = "greenRow";
		//	else if ((leadTime >= targetLeadTime + 6) && (leadTime <= targetLeadTime + 10))// 75% bonus
		//		result = "blueRow";
		//	else if ((leadTime >= targetLeadTime + 11) && (leadTime <= targetLeadTime + 15))// 50% bonus
		//		result = "purpleRow";
		//	else if ((leadTime >= targetLeadTime + 16) && (leadTime <= targetLeadTime + 20))// 25% bonus
		//		result = "amberRow";
		//	else if (leadTime >= targetLeadTime + 21) // 0% bonus
		//		result = "redRow";

		//}

		return result;

	}

	protected void allConsultantsOnSelecting(object sender, LinqDataSourceSelectEventArgs e)
	{
		//var consultants = from c in db.consultant_allocations_news
		//				  where !(c.aspnet_User.UserName == null)
		//				  && !(c.Pause)
		//				  select c;

		IQueryable<consultant_allocations_new> consultants = from c in db.consultant_allocations_news
															 where !(c.Pause)

															 select c;


		e.Result = consultants;
	}


	protected void all_consultants_onSelecting(object sender, LinqDataSourceSelectEventArgs e)
	{
		//var consultants = from c in db.consultant_allocations_news
		//				  where !(c.aspnet_User.UserName == null)
		//				  && !(c.Pause)
		//				  select c;

		IQueryable<consultant_allocations_new> consultants = from c in db.consultant_allocations_news
															 where !(c.aspnet_User.UserName == null)

															 select c;


		e.Result = consultants;
	}
	public int numberOfConsultants()
	{
		var consultants = from c in db.consultant_allocations_news
						  where !(c.aspnet_User.UserName == null)
						  select c;
		int total = consultants.Count();
		return total;
	}

	public string loggedUser()
	{
		string user = Context.User.Identity.Name;

		return user;
	}
	public int wonLeadFromSetDate()
	{
		int totalWonCount = 0;
		DateTime date = new DateTime(2022, 1, 1); // a date to LIMIT RRSULTS TO dates after 01/01/2022 - the date that we want to start measureing from


		totalWonCount = (from s in db.sections
						 where //s.client.consultant_name.ToLower() == userName.ToLower()
						 s.quote_status == "Won"
						 && s.quote_value > 0
						 && s.date_added != null
						 && s.decision_date >= date
						 select s).Count();


		return totalWonCount;
	}

	public int wonLeadFromSetDateByCons(String userName)
	{
		int totalWonCount = 0;
		DateTime date = new DateTime(2022, 1, 1); // a date to LIMIT RRSULTS TO dates after 01/01/2022 - the date that we want to start measureing from


		totalWonCount = (from c in db.sections
						 where c.client.consultant_name.ToLower() == userName.ToLower()
						 && c.quote_status == "Won"
						 && c.quote_value > 0
						 && c.date_added != null
						 && c.decision_date >= date
						 select c).Count();


		return totalWonCount;
	}

	protected void AllocationValueLinqDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
	{
		String[] userList = Roles.GetUsersInRole("Site Coordinator");



		List<aspnet_User> resultList = new List<aspnet_User>();



		for (int i = 0; i < (userList.GetUpperBound(0) + 1); i++)
		{

			aspnet_User user = new aspnet_User();
			user.UserName = userList[i];
			resultList.Add(user);

		}

		e.Result = resultList;
	}
	protected String GetAmountAllocated(object pUserName)
	{

		string userName = pUserName.ToString();





		//NotInProduction


		var totalNotInProduction = (from j in db.job_times
									where
									j.section.client.site_coordinator_name.ToLower() == userName.ToLower()
									&& j.dept_id == 2
									&& j.section.active_status == 1
									&& j.section.in_ops_dept == 1
									&& (j.started_date == null && j.completed_date == null)
									&& j.section.project_dates.First().in_production == false
									orderby j.section.client.site_coordinator_name, j.section.client.job_name
									select j.section.quote_value).Sum();

		if (totalNotInProduction == null) totalNotInProduction = 0;

		//InProductionButNotComplete


		var totalProductionNotComplete = (from j in db.job_times
										  where
										  j.section.client.site_coordinator_name.ToLower() == userName.ToLower()
										  && j.dept_id == 2
										  && j.section.active_status == 1
										  && j.section.in_ops_dept == 1
										  && (j.started_date == null && j.completed_date == null)
										  && j.section.project_dates.First().in_production == true
										  orderby j.section.client.site_coordinator_name, j.section.client.job_name
										  select j.section.quote_value).Sum();

		if (totalProductionNotComplete == null) totalProductionNotComplete = 0;

		//Installing

		var totalBusyInstalling = (from j in db.job_times
								   where
								   j.section.client.site_coordinator_name.ToLower() == userName.ToLower()
								   && j.section.active_status == 1
								   && j.dept_id == 2
								   && j.section.in_ops_dept == 1
								   && (j.started_date != null && j.completed_date == null)
								   select j.section.quote_value).Sum();
		if (totalBusyInstalling == null) totalBusyInstalling = 0;

		decimal total = (decimal)totalNotInProduction + (decimal)totalProductionNotComplete + (decimal)totalBusyInstalling;

		total = (total * 100) / 114;


		return String.Format("{0:c}", total);

	}

	protected String GetTotalAmountAllocated()
	{

		//string userName = pUserName.ToString();





		//NotInProduction


		var totalNotInProduction = (from j in db.job_times
									where
									 //j.section.client.site_coordinator_name.ToLower() == userName.ToLower()
									 j.dept_id == 2
									&& j.section.active_status == 1
									&& j.section.in_ops_dept == 1
									&& (j.started_date == null && j.completed_date == null)
									&& j.section.project_dates.First().in_production == false
									orderby j.section.client.site_coordinator_name, j.section.client.job_name
									select j.section.quote_value).Sum();

		if (totalNotInProduction == null) totalNotInProduction = 0;

		//InProductionButNotComplete


		var totalProductionNotComplete = (from j in db.job_times
										  where
										   //j.section.client.site_coordinator_name.ToLower() == userName.ToLower()
										   j.dept_id == 2
										  && j.section.active_status == 1
										  && j.section.in_ops_dept == 1
										  && (j.started_date == null && j.completed_date == null)
										  && j.section.project_dates.First().in_production == true
										  orderby j.section.client.site_coordinator_name, j.section.client.job_name
										  select j.section.quote_value).Sum();

		if (totalProductionNotComplete == null) totalProductionNotComplete = 0;

		//Installing

		var totalBusyInstalling = (from j in db.job_times
								   where
									//j.section.client.site_coordinator_name.ToLower() == userName.ToLower()
									j.section.active_status == 1
								   && j.dept_id == 2
								   && j.section.in_ops_dept == 1
								   && (j.started_date != null && j.completed_date == null)
								   select j.section.quote_value).Sum();
		if (totalBusyInstalling == null) totalBusyInstalling = 0;

		decimal total = (decimal)totalNotInProduction + (decimal)totalProductionNotComplete + (decimal)totalBusyInstalling;

		total = (total * 100) / 114;


		return String.Format("{0:c}", total);

	}

	public int overdueRemindersCount()
	{
		IQueryable<reminder> reminders = from r in db.reminders
										 where (r.department_id == 0 || r.department_id == 2)
												&& r.reminder_due_date != null
												&& r.reminder_due_date < System.DateTime.Now.Date
												&& r.reminder_status == 0
										 //orderby r.reminder_due_date, r.reminder1
										 select r;
		int count = reminders.Count();

		return count;
	}

	protected String getOverdueConsultants()
	{

		var consultants = (from r in db.reminders
						   where r.department_id == 0 //|| r.department_id == 2)
								  && r.reminder_due_date != null
								  && r.reminder_due_date < System.DateTime.Now.Date
								  && r.reminder_status == 0
								  && !(r.UserName == "")
								  && !(r.UserName == null)
						   select r.UserName);
		String list = "";
		foreach (var c in consultants.Distinct())
		{
			list += "<a href='reminders_dashboard.aspx?pDepartmentId=0&pUserName=" + c + "&pSCUserName=' >" + c + " (" + consultants.Where(consultant => (consultant == c)).Count() + ")</a><br/>";
		}
		return list;
	}

	protected void overdueRemsDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
	{

		//foreach(var user in (from u in db.consultant_allocations_news
		//			where !(u.Pause)
		//			select u.aspnet_User.UserName))
		//{
		//	if ((from r in db.reminders
		//		 where r.UserName == user
		//				&& r.reminder_due_date != null
		//				&& r.reminder_due_date < System.DateTime.Now.Date
		//				&& r.reminder_status == 0
		//		 select r).Count() > 0)

		//		e.Result = user;

		//}



		//											var rems = from rem in db.reminders
		//											   where  rem.reminder_due_date != null
		//													  && rem.reminder_due_date < System.DateTime.Now.Date
		//													  && rem.reminder_status == 0
		//													  //&& rem.UserName == (from u in db.consultant_allocations_news
		//															//				  			where !(u.Pause)
		//															//				  			select u.aspnet_User.UserName).FirstOrDefault()

		//														select rem;

		//rems.ToList().ForEach(rem =>rem.UserName);

	}

	protected void todoRemindersDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
	{
		//String userName = Page.Request.QueryString["pUserName"];
		String user = Context.User.Identity.Name;



		IQueryable<reminder> reminders = from r in db.reminders
										 where r.UserName == user //(r.department_id == pDepartmentId || r.department_id == pSecondDepartmentId)
												&& r.reminder_due_date != null
												&& r.reminder_due_date == System.DateTime.Now.Date
												&& r.reminder_status == 0
										 orderby r.reminder_due_date, r.reminder1
										 select r;


		e.Result = reminders;

	}


}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class dc_dashboard : System.Web.UI.Page
{
	IntranetDataDataContext db = new IntranetDataDataContext();

	protected void Page_Load(object sender, EventArgs e)
	{




	}

	//public string[] maConsultants()
	//{
	//	//var macons = (from c in db.consultant_allocations_news
	//	//			  where !(c.aspnet_User.UserName == null)

	//	//			  select c.aspnet_User).ToString();
	//	//var consultantArray String[] = new String[];
	//	//foreach( var mac in macons)
	//	//{
	//	//	mac = new String[];
	//	//}
	//	//return consultantArray.ToArray();



	//	var macon = (from c in db.consultant_allocations_news
	//				 where !(c.aspnet_User.UserName == null)

	//				 select c.aspnet_User).ToString();

	//	String[] maconv = new String(macon.ToArray());

	//	var macons = (String[])maconv.Clone();

	//	return macons;


	//	//for (int i = 0; i < countmMaConsultants(); i++)
	//	//{
	//	//	macons[i] =;
	//	//}

	//	//foreach(var ma in macon)
	//	//{
	//	//	ma.ToString() = macons.ToArray();
	//	//}

	//	//var macons = (String[])macon.Clone();
	//	//try
	//	//{
	//	//	macon.CopyTo(macons, 0);
	//	//}
	//	//catch (Exception ex)
	//	//{

	//	//}


	//}

	public int countmMaConsultants()
	{
		var macons = (from c in db.consultant_allocations_news

					 select c).Count();
		return macons;

	}
	public int weekOldReminders()
	{

		String user = Context.User.Identity.Name;
		DateTime today = DateTime.Now;
		DateTime answer = today.AddDays(-7);

		var rems = from r in db.reminders
				   where r.UserName == user
				   && r.reminder_due_date != null
				   && r.reminder_due_date > System.DateTime.Now.Date
				   && r.reminder_due_date < answer
				   && r.reminder_status == 0
				   select r;

		int count = rems.Count();

		var rem = from r in db.reminders
				  where r.UserName == user
				  && r.reminder_due_date != null
				  && r.reminder_status == 0
				  select r;

		int total = rem.Count();

		int perc = (count / total) * 100;

		return perc;

	}

	public int twoWeekOldReminders()
	{
		String user = Context.User.Identity.Name;
		DateTime today = DateTime.Now;
		DateTime week = today.AddDays(-7);
		DateTime twoWeeks = today.AddDays(-14);

		var rems = from r in db.reminders
				   where r.UserName == user
				   && r.reminder_due_date != null
				   && r.reminder_due_date > week
				   && r.reminder_due_date < twoWeeks
				   && r.reminder_status == 0
				   select r;

		int count = rems.Count();

		var rem = from r in db.reminders
				  where r.UserName == user
				  && r.reminder_due_date != null
				  && r.reminder_status == 0
				  select r;

		int total = rem.Count();

		int perc = (count / total) * 100;

		return perc;
	}

	public int monthOldReminders()
	{
		String user = Context.User.Identity.Name;
		DateTime today = DateTime.Now;
		DateTime twoWeeks = today.AddDays(-14);
		DateTime month = today.AddDays(-30);

		var rems = from r in db.reminders
				   where r.UserName == user
				   && r.reminder_due_date != null
				   && r.reminder_due_date > twoWeeks
				   && r.reminder_due_date < month
				   && r.reminder_status == 0
				   select r;

		int count = rems.Count();

		var rem = from r in db.reminders
				  where r.UserName == user
				  && r.reminder_due_date != null
				  && r.reminder_status == 0
				  select r;

		int total = rem.Count();

		int perc = (count / total) * 100;

		return perc;
	}

	public int overMonthOldReminders()
	{
		String user = Context.User.Identity.Name;
		DateTime today = DateTime.Now;
		DateTime month = today.AddDays(-30);
		DateTime overaMonth = today.AddDays(-365);

	var rems = from r in db.reminders
			   where r.UserName == user
			   && r.reminder_due_date != null
			   && r.reminder_due_date > month
			   && r.reminder_due_date < overaMonth
			   && r.reminder_status == 0
			   select r;

	int count = rems.Count();

		var rem = from r in db.reminders
				  where r.UserName == user
				  && r.reminder_due_date != null
				  && r.reminder_status == 0
				  select r;

	int total = rem.Count();

		int perc =  (count / total) *100;

		return perc;
	}

	public int totalReminders()
	{
		String user = Context.User.Identity.Name;

			var rem = from r in db.reminders
				   where r.UserName == user
				   && r.reminder_due_date != null
				   && r.reminder_status == 0
				   select r;

		int total = rem.Count();

		return total; 
	}

	public int weekPec()
	{
		//int weeklyPec = Int32.Parse((weekOldReminders / totalReminders)100);
		return 1;
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
}
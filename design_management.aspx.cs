using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

public partial class design_management : System.Web.UI.Page
{
	IntranetDataDataContext db = null;




	protected void Page_Init(object sender, EventArgs e)
	{
		db = new IntranetDataDataContext();



	}

	//protected void Page_Load(object sender, EventArgs e)
	//{
	//}

	protected virtual void OnClick(EventArgs e)
	{

	}

	protected void pauseBtn(Object sender, EventArgs e)
	{
		Button button = (Button)sender;
		var id = button.CommandArgument;

		Consultant consult = ConsultantHandler.getConsultant(Guid.Parse(id));
		consult.toggleState();

	}

	protected void unpauseBtn(Object sender, EventArgs e)
	{
		Button button = (Button)sender;
		var id = button.CommandArgument;

		Consultant consult = ConsultantHandler.getConsultant(Guid.Parse(id));
		consult.toggleState();

	}


	protected void lead_transfers_DataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
	{




		var lead_transfer_items = from l in db.lead_transfers

								  where l.decision_date == null
								  orderby l.requested_date
								  select l;





		e.Result = lead_transfer_items;

	}

	protected void consultant_info_selecting(object sender, LinqDataSourceSelectEventArgs e)
	{


		String[] userList = Roles.GetUsersInRole("Design Consultant");



		List<aspnet_User> resultList = new List<aspnet_User>();

		aspnet_User firstUser = new aspnet_User();
		firstUser.UserName = null;
		resultList.Add(firstUser);



		for (int i = 0; i < (userList.GetUpperBound(0) + 1); i++)
		{

			aspnet_User user = new aspnet_User();
			user.UserName = userList[i];
			resultList.Add(user);

		}
		e.Result = resultList;

		//IntranetDataDataContext db = new IntranetDataDataContext();


		//var consultants = (from c in db.aspnet_Users
		//					where!(c.consultant_allocations_news.Pause)
		//					select c).ToList();


		//if (consultants.Count() == 0)
		//{
		//	consultants.Add(
		//		(from c in db.aspnet_Users where c.UserName == "Philip" select c).First());
		//}
		//// foreach(var consult in consultants)
		////{
		////	e.Result = consult.ToList();
		////}


		//e.Result = consultants;
	}

	protected void lead_transfer_ItemUpdating(object sender, ListViewUpdateEventArgs e)
	{


		CheckBox declinedCheckbox = (CheckBox)LeadTransferListView.EditItem.FindControl("declinedCheckBox1");
		e.NewValues["is_request_declined"] = declinedCheckbox.Checked;

		if (declinedCheckbox.Checked)
		{ // means the request was declined, make sure the consultant was not changed by mistake
			e.NewValues["client.consultant_name"] = e.OldValues["client.consultant_name"];
			e.NewValues["decision_date"] = DateTime.Now;
			e.NewValues["decision_by"] = User.Identity.Name;
		}
		else
		{
			// means the request was NOT declined
			//check if the consultant name was actually changed
			if (!e.NewValues["client.consultant_name"].ToString().Equals(e.OldValues["client.consultant_name"].ToString()))
			{
				// means request was not declined and the consultant name was changed
				HiddenField clientId = (HiddenField)LeadTransferListView.EditItem.FindControl("clientId");
				int pClientId = Int32.Parse(clientId.Value);
				var query =
					(from c in db.clients
					 where c.client_id == pClientId
					 select c).Single();

				query.consultant_name = e.NewValues["client.consultant_name"].ToString();

				//var getsec = (from s in db.sections where s.client_id == pClientId select s).First();
				//int secId = getsec.section_id;

				db.SubmitChanges();
				// if this was a ghost lead for the consultant that its changing to then deactivate the ghost lead
				try
				{

					ghost_lead ghostLead = (from g in db.ghost_leads
											where g.client_id == pClientId
											&& g.consultantName == e.NewValues["client.consultant_name"].ToString()
											select g).Single();


					ghostLead.isActive = false;


					db.SubmitChanges();


				}
				catch (Exception ex)
				{
					// it will throw an exception if it doesnt find a record of the ghost lead
				}




				e.NewValues["decision_date"] = DateTime.Now;
				e.NewValues["decision_by"] = User.Identity.Name;


			}



		}


	}

	public void deleteRems(int sec, string duser, int dept)
	{

		int pDepartmentId = dept;
		int pSectionId = sec;
		string user = duser;


		try
		{
			pDepartmentId = Int32.Parse(Page.Request.QueryString["pDepartmentId"]);
			pSectionId = Int32.Parse(Page.Request.QueryString["pSectionId"]);



		}
		catch (Exception ex) { }

		var reminders_to_delete = from r in db.reminders
								  where r.section_id == pSectionId &&
								  r.department_id == pDepartmentId &&
								  r.reminder_status == 0 &&
								  r.type == 0 &&
								  r.UserName == user
								  select r;




		foreach (var rd in reminders_to_delete)
		{
			db.reminders.DeleteOnSubmit(rd);


		}
		db.SubmitChanges();
	}

	protected void lead_transfer_ItemUpdated(object sender, ListViewUpdatedEventArgs e)
	{


		HiddenField jobName = (HiddenField)LeadTransferListView.EditItem.FindControl("jobName");
		HiddenField requestedBy = (HiddenField)LeadTransferListView.EditItem.FindControl("requestedBy");
		HiddenField clientId = (HiddenField)LeadTransferListView.EditItem.FindControl("clientId");
		int pClientId = Int32.Parse(clientId.Value);
		int addSectionRems = 1;
		int wonRems = 2;
		int inOpsRems = 4;


		if ((bool)e.NewValues["is_request_declined"])
		{ // means the request was declined, send a mail that request is declined

			ActivityLog log = new ActivityLog();
			log.sendDeclinedTransferRequestEmail(jobName.Value, requestedBy.Value, User.Identity.Name);


		}
		else
		{

			try
			{
				
				if (!e.NewValues["client.consultant_name"].ToString().Equals(e.OldValues["client.consultant_name"].ToString()))
				{
					// means request was not declined and the consultant name was changed

					ActivityLog log = new ActivityLog();
					log.sendConfirmationOfLeadTransferEmail(jobName.Value, requestedBy.Value, User.Identity.Name, e.NewValues["client.consultant_name"].ToString());

					//AddSection reminders can be inserted here 
					
					foreach (var sectId in (from c in db.sections
											where c.client_id == pClientId
											select c.section_id))
					{
						if ((from r in db.reminders where r.UserName == e.NewValues["client.consultant_name"].ToString() && r.section_id == sectId select r).Count() > 0)
							continue;

						{

							if ((from s in db.sections where s.section_id == sectId select s.quote_status).First() == "Won")
							{
								if ((from r in db.reminders where r.section_id == sectId && r.UserName == e.NewValues["client.consultant_name"].ToString() select r).Count() == 0)
								{ // This filter for reminders is necessary for transfered clients
									var userRems = from ur in db.reminder_defaults_by_users
												   where (ur.event_to_add == addSectionRems || ur.event_to_add == wonRems || ur.event_to_add == inOpsRems)
													&& ur.department_id == 0      // can only display for consultants for now
													&& ur.user_name == e.NewValues["client.consultant_name"].ToString()
												   select ur;

									foreach (var rd in userRems)
									{
										reminder rem = new reminder();
										rem.type = 0;
										rem.UserName = e.NewValues["client.consultant_name"].ToString();
										rem.department_id = 0;   //(int)rd.department_id;
										rem.reminder1 = rd.reminder;
										rem.high_priority = rd.high_priority;
										rem.reminder_order = rd.reminder_order;
										rem.section_id = sectId;
										rem.reminder_status = 0;
										if (rd.reminder_order == 0)
											rem.reminder_due_date = System.DateTime.Now.Date;
										rem.date_completed = new DateTime(1901, 1, 1);
										db.reminders.InsertOnSubmit(rem);
									}
									db.SubmitChanges();

								}
							}


							else if ((from s in db.sections where s.section_id == sectId select s.in_ops_dept).First() == 1)
							//if ((from s in db.sections where s.quote_status == "Pending" && s.in_ops_dept == 1 select s).Any())
							{

								var userRems = from ur in db.reminder_defaults_by_users
											   where (ur.event_to_add == addSectionRems || ur.event_to_add == inOpsRems)
												&& ur.department_id == 0      // can only display for consultants for now
												&& ur.user_name == e.NewValues["client.consultant_name"].ToString()
											   select ur;

								foreach (var rd in userRems)
								{
									reminder rem = new reminder();
									rem.type = 0;
									rem.UserName = e.NewValues["client.consultant_name"].ToString();
									rem.department_id = 0;   //(int)rd.department_id;
									rem.reminder1 = rd.reminder;
									rem.high_priority = rd.high_priority;
									rem.reminder_order = rd.reminder_order;
									rem.section_id = sectId;
									rem.reminder_status = 0;
									if (rd.reminder_order == 0)
										rem.reminder_due_date = System.DateTime.Now.Date;
									rem.date_completed = new DateTime(1901, 1, 1);
									db.reminders.InsertOnSubmit(rem);
								}
								db.SubmitChanges();

							}
							else if ((from s in db.sections where s.section_id == sectId select s.quote_status).First() == "Pending")
							{

								// the event_to_add is addSection which has value 1 and populate the  addsection 

								var userRems = from ur in db.reminder_defaults_by_users
											   where ur.event_to_add == addSectionRems
											   && ur.department_id == 0    //can only populate for consultant at the moment
											   && ur.user_name == e.NewValues["client.consultant_name"].ToString()
											   select ur;

								foreach (var rd in userRems)
								{
									reminder rem = new reminder();
									rem.type = 0;
									rem.UserName = e.NewValues["client.consultant_name"].ToString();
									rem.department_id = 0;    // (int)rd.department_id;
									rem.reminder1 = rd.reminder;
									rem.high_priority = rd.high_priority;
									rem.reminder_order = rd.reminder_order;
									rem.section_id = sectId;
									rem.reminder_status = 0;
									if (rd.reminder_order == 0)
										rem.reminder_due_date = System.DateTime.Now.Date;
									rem.date_completed = new DateTime(1901, 1, 1);
									db.reminders.InsertOnSubmit(rem);
								}
								db.SubmitChanges();
							}

						}
					}
				}


				foreach (var secId in (from c in db.sections
									   where c.client_id == pClientId
									   select c.section_id))
				{
					deleteRems(secId, e.OldValues["client.consultant_name"].ToString(), 0);
				}

			}
			catch (Exception ex)
			{ }
		
		}
	} 
	
	//IntranetDataDataContext db = null;
	DateHandler dateHandler = new DateHandler();
	

	public string nextEligibleConsultant()
	{
		IntranetDataDataContext db = new IntranetDataDataContext();
		
		//this fuction checks if there are any Design Consultants added to system and if any, inserts them to the table consultant_allocation_new as a puased consultant with zero stats
		var existingConsultants = (from c in db.consultant_allocations_news select c.UserId);


		foreach (var consultant in (from c in db.aspnet_UsersInRoles where c.aspnet_Role.RoleName == "Design Consultant" select c))
			if (!(existingConsultants.Contains(consultant.UserId)))
			{
				consultant_allocations_new newConsultant = new consultant_allocations_new();
				newConsultant.UserId = consultant.UserId;
				newConsultant.Pause = true;
				db.consultant_allocations_news.InsertOnSubmit(newConsultant);
			}
		db.SubmitChanges();

		ConsultantAllocationListView.DataBind();
		PausedConsultantListView.DataBind();


		//this fuction gets the next eligible consultant from the unpaused list
		List<consultant_allocations_new> consultants = (from c in db.consultant_allocations_news
														where !(c.Pause)
														select c).ToList();
		if (consultants.Count() == 0)
			return "Philip";

		int lowestActiveQuotes = getLowestActiveQuotes();

		foreach (var consultant in (
			from c in consultants
			orderby getQuoteCount(c.aspnet_User.UserName), lastSectionAddedDate(c.aspnet_User.UserName), c.aspnet_User.UserName
			select c))
		{
			if (lowestActiveQuotes < 8)
			{
				if (!(consultant.Pause) && (getActiveQuotes(consultant.aspnet_User.UserName) < 8))
				{
					return consultant.aspnet_User.UserName;
				}
				else if (!(consultant.Pause))
					incrementGhostLeads(consultant.aspnet_User.UserName);


			}
			else
				if (!(consultant.Pause) && (getActiveQuotes(consultant.aspnet_User.UserName) == lowestActiveQuotes))
			{
				return consultant.aspnet_User.UserName;
			}
			else if (!(consultant.Pause))
				incrementGhostLeads(consultant.aspnet_User.UserName);

		}
		return "";
	}

	

	protected void Page_Load(object sender, EventArgs e)
	{


	}

	protected void eligible_consultants_onSelecting(object sender, LinqDataSourceSelectEventArgs e)
	{
		IQueryable<consultant_allocations_new> consultants = from c in db.consultant_allocations_news
															 where !(c.Pause)

															 select c;


		e.Result = consultants;

	}

	protected void paused_Consultant_onSelecting(object sender, LinqDataSourceSelectEventArgs e)
	{
		IQueryable<consultant_allocations_new> consultants = from c in db.consultant_allocations_news
															 where (c.Pause)

															 select c;


		e.Result = consultants;
	}
	protected void pause_consultant_allocation_OnCommand(object sender, CommandEventArgs e)
	{

		int rowId = Int32.Parse(e.CommandArgument.ToString());


		IntranetDataDataContext db = new IntranetDataDataContext();


		var consultant = (from a in db.consultant_allocations_news
						  where a.ID == rowId
						  select a).Single();


		consultant.Pause = true;

		db.SubmitChanges();
		ConsultantAllocationListView.DataBind();
		PausedConsultantListView.DataBind();


	}

	protected void unpause_consultant_allocation_OnCommand(object sender, CommandEventArgs e)
	{
		int rowId = Int32.Parse(e.CommandArgument.ToString());


		IntranetDataDataContext db = new IntranetDataDataContext();

		updateGhostQuotes(rowId);

		var consultant = (from a in db.consultant_allocations_news
						  where a.ID == rowId
						  select a).Single();


		consultant.Pause = false;
		//incrementGhostLeads(consultant.aspnet_User.UserName);
		db.SubmitChanges();

		ConsultantAllocationListView.DataBind();
		PausedConsultantListView.DataBind();

	}

	public void incrementGhostLeads(String userName)
	{
		ghost_lead ghost = new ghost_lead();
		ghost.consultantName = userName;
		//ghost.client_id = consultant.clientID;
		ghost.added_date = DateTime.Now;
		ghost.isActive = true;
		ConsultantHandler.db.ghost_leads.InsertOnSubmit(ghost);
		ConsultantHandler.db.SubmitChanges();
	}

	

	private void updateGhostQuotes(int ID)
	{
		{

			IntranetDataDataContext db = new IntranetDataDataContext();
		
			 var consultants = (from ca in db.consultant_allocations_news
													 where !(ca.Pause)
													 select ca);
			if (consultants.Count() == 0)
			{
				return;
			}
			else
			{
				consultant_allocations_new consultant = (from c in db.consultant_allocations_news where c.ID == ID select c).First();
				int minLeads = Int32.MaxValue;
				int currentLeads = 0;
				DateTime backDate = new DateTime(System.DateTime.Now.AddMonths(-4).Year, System.DateTime.Now.AddMonths(-4).Month, 1); // a date to LIMIT RRSULTS TO 3 MONTHS BACK
																																	  //log.WriteLine("Back Date:" + backDate);

				int normalCount = 0;
				int ghostCount = 0;

				foreach (var current in (from c in db.consultant_allocations_news where !c.Pause select c))
				{
					normalCount = (from s in db.sections
								   where s.client.consultant_name.ToLower() == current.aspnet_User.UserName.ToLower()
								   && !(s.quote_status == "Lost" && s.quote_value == 0)
								   && s.date_added >= backDate
								   select s).Count();

					ghostCount = (from g in db.ghost_leads
								  where
								  g.isActive == true
								   && g.consultantName.ToLower() == current.aspnet_User.UserName.ToLower()
								  && g.added_date >= backDate
								  select g).Count();
			
					if (minLeads > (ghostCount + normalCount))
					{
						minLeads = (ghostCount + normalCount);
				
					}
				}

				normalCount = (from s in db.sections
							   where s.client.consultant_name.ToLower() == consultant.aspnet_User.UserName.ToLower()
							   && !(s.quote_status == "Lost" && s.quote_value == 0)
							   && s.date_added >= backDate
							   select s).Count();

				ghostCount = (from g in db.ghost_leads
							  where
							  g.isActive == true
							   && g.consultantName.ToLower() == consultant.aspnet_User.UserName.ToLower()
							  && g.added_date >= backDate
							  select g).Count();

			
				currentLeads = normalCount + ghostCount;
		

				for (int i = currentLeads; i < minLeads; i++)
				{
					ghost_lead ghost = new ghost_lead();
					ghost.consultantName = consultant.aspnet_User.UserName;
			
					ghost.added_date = DateTime.Now;
					ghost.isActive = true;
					db.ghost_leads.InsertOnSubmit(ghost);
				
				}
				db.SubmitChanges();
				
			}
		}
	}

	public int recentWonQuotes(String userName)
	{
		DateTime date = new DateTime(System.DateTime.Now.AddMonths(-11).Year, System.DateTime.Now.AddMonths(-11).Month, 1); // a date to LIMIT RRSULTS TO 12 MONTHS BACK

		int totalWonCount = (from s in db.sections
							 where s.client.consultant_name.ToLower() == userName.ToLower()
							 && s.quote_status == "Won"
							 && s.quote_value > 0
							 && s.date_added != null
							 && s.decision_date >= date
							 select s).Count();

		return totalWonCount;
	}

	public int recentLostQuotes(String userName)
	{
		DateTime date = new DateTime(System.DateTime.Now.AddMonths(-11).Year, System.DateTime.Now.AddMonths(-11).Month, 1); // a date to LIMIT RRSULTS TO 12 MONTHS BACK

		int totalWonCount = (from s in db.sections
							 where s.client.consultant_name.ToLower() == userName.ToLower()
							 && s.quote_status == "Lost"
							 && s.quote_value > 0
							 && s.date_added != null
							 && s.decision_date >= date
							 select s).Count();

		return totalWonCount;
	}

	public int pendingQuotes(String userName)
	{

		try
		{
			return (from s in db.sections
					where s.client.consultant_name.ToLower() == userName.ToLower()
					&& s.quote_status == "Pending"
					&& s.quote_value > 0
					&& s.date_added != null
					select s).Count();
		}
		catch (Exception e)
		{
			return 0;
		}
	}


	public float hitRatio(String userName)
	{
		try
		{
			float won = (float)wonLeadFromSetDate(userName);
			int lost = lostSinceJanuary(userName);
			if ((lost + won) == 0)
				return 0;
			return (int)(won / (won + lost) * 100);
		}
		catch (Exception)
		{
			return 0;
		}
	}

	public int wonLeadFromSetDate(String userName)
	{
		int totalWonCount = 0;
		DateTime date = new DateTime(2022, 1, 1); // a date to LIMIT RRSULTS TO dates after 01/01/2022 - the date that we want to start measureing from


		totalWonCount = (from s in db.sections
						 where s.client.consultant_name.ToLower() == userName.ToLower()
						 && s.quote_status == "Won"
						 && s.quote_value > 0
						 && s.date_added != null
						 && s.decision_date >= date
						 select s).Count();


		return totalWonCount;
	}

	public int lostSinceJanuary(String userName)
	{
		int totalLostCount = 0;

		DateTime date = new DateTime(2022, 1, 1); // a date to LIMIT RRSULTS TO dates after 01/01/2022 - the date that we want to start measureing from

		totalLostCount = (from s in db.sections
						  where s.client.consultant_name.ToLower() == userName.ToLower()
						  && s.quote_status == "Lost"
						  && s.quote_value > 0
						  && s.date_added != null
						  && s.decision_date >= date
						  select s).Count();

		return totalLostCount;
	}

	public DateTime lastSectionAddedDate(String userName)
	{

		try
		{
			DateTime? dt;

			dt = (from c in ConsultantHandler.db.job_times
				  where c.section.client.consultant_name.ToLower() == userName.ToLower()
				  select c.section.date_added).Max();
			if (dt != null)
				return (DateTime)dt;
		}
		catch (Exception e)
		{
		}
		return DateTime.MinValue;
	}

	public int getActiveQuotes(String userName)
	{
		int count = (from j in db.job_times
					 where j.dept_id == 0
					 && j.section.active_status == 1
					 && j.started_date != null
					 && j.completed_date == null
					 && j.section.client.consultant_name.ToLower() == userName.ToLower()
					 select j).Count();
		return count;
	}


	public int getRealQuotes(String userName)
	{
		int realQuote = 0;

		DateTime backDate = new DateTime(System.DateTime.Now.AddMonths(-4).Year, System.DateTime.Now.AddMonths(-4).Month, 1); // a date to LIMIT RRSULTS TO 3 MONTHS BACK

		realQuote = (from s in db.sections
					 where s.client.consultant_name.ToLower() == userName.ToLower()
					 && !(s.quote_status == "Lost" && s.quote_value == 0)
					 && s.date_added >= backDate
					 select s).Count();

		return realQuote;

	}

	public int getGhostQuotes(String userName)
	{
		int ghostQuotes = 0;

		DateTime backDate = new DateTime(System.DateTime.Now.AddMonths(-4).Year, System.DateTime.Now.AddMonths(-4).Month, 1); // a date to LIMIT RRSULTS TO 3 MONTHS BACK

		ghostQuotes = (from g in db.ghost_leads
					   where
					   g.isActive == true
						&& g.consultantName.ToLower() == userName.ToLower()
					   && g.added_date >= backDate
					   select g).Count();

		return ghostQuotes;

	}

	public int getLowestActiveQuotes()
	{
		IntranetDataDataContext db = new IntranetDataDataContext();

		try
		{
			return (int)(from c in db.consultant_allocations_news
						 where (!c.Pause)
						 orderby getActiveQuotes(c.aspnet_User.UserName)
						 select getActiveQuotes(c.aspnet_User.UserName)).Min();
		}
		catch (Exception e)
		{
			return 0;
		}
	}

	public int getQuoteCount(String userName)
	{
		int normalCount = 0;
		int ghostCount = 0;

		DateTime backDate = new DateTime(System.DateTime.Now.AddMonths(-4).Year, System.DateTime.Now.AddMonths(-4).Month, 1); // a date to LIMIT RRSULTS TO 3 MONTHS BACK

		normalCount = (from s in db.sections
					   where s.client.consultant_name.ToLower() == userName.ToLower()
					   && !(s.quote_status == "Lost" && s.quote_value == 0)
					   && s.date_added >= backDate
					   select s).Count();

		ghostCount = (from g in db.ghost_leads
					  where
					  g.isActive == true
					   && g.consultantName.ToLower() == userName.ToLower()
					  && g.added_date >= backDate
					  select g).Count();

		return normalCount + ghostCount;
	}



	protected void consultant(object sender, ListViewUpdateEventArgs e)
	{



	}

	protected void consultants(object sender, ListViewUpdatedEventArgs e)
	{



	}

	protected void changePause(object sender, CommandEventArgs e)
	{


	}

	
}


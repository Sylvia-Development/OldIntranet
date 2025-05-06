using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;


public partial class section_view : System.Web.UI.Page
{
    IntranetDataDataContext db = null;

    
    protected void after_page_load(Object sender, EventArgs e)

    {

        //set which tabs to display
        if (   (Context.User.IsInRole("Installer")
            || Context.User.IsInRole("Production Assistant")
            || Context.User.IsInRole("Processing Manager")
            || Context.User.IsInRole("Processing Assistant")
            || Context.User.IsInRole("Production Manager"))&&
            (!Context.User.IsInRole("Director")&& !Context.User.IsInRole("Technical Services Manager") && !Context.User.IsInRole("Technical Services Technician1")))
        {
            hideTaskTab.Value = "yes";

        }
        if ((Context.User.IsInRole("Processing Manager")
            || Context.User.IsInRole("Processing Assistant")) &&
            !Context.User.IsInRole("Director"))
        {
            hideNotesTab.Value = "yes";

        }
        if ((Context.User.IsInRole("Design Consultant")
            || Context.User.IsInRole("Finance Admin Manager")) &&
            !Context.User.IsInRole("Director"))
        {
            
            hideOrdersAndListTab.Value = "yes";


       }
        if (Context.User.IsInRole("Customer Experience Manager") || Context.User.IsInRole("Production Controller"))
        {

            hideOrdersAndListTab.Value = "no";


        }


        if (IsPostBack)
        {
            hideSelectFirstTab.Value = "no";
        }
        else
        {
            hideSelectFirstTab.Value = "yes";
        }


        if (!IsPostBack)
        {
            orderCountLabel.Text = getOrdersCount();
            initialSnagCountLabel.Text = getSnagCount();
            


            if (clientNameLabel.Text.Length <= 0)
            {

                int pClientId = -1;
                int pSectionId = -1;
                try
                {
                    pClientId = Int32.Parse(Page.Request.QueryString["pClientId"]);
                    pSectionId = Int32.Parse(Page.Request.QueryString["pSectionId"]);
                }
                catch (Exception ex) { }


                var result = from c in db.clients
                             where c.client_id == pClientId
                             select c;
                foreach (client c in result)
                {
                    clientNameLabel.Text = c.job_name;

                }
                var result2 = from s in db.sections
                              where s.section_id == pSectionId
                              select s;
                foreach (section s in result2)
                {
                    sectionLabel.Text = s.section_name;

                }

            }

                FormView1.ChangeMode(FormViewMode.Edit);
                
        }
        
    }


   public string getPartnerId()
    {
        int pClientId;
        try
        {
            pClientId = Int32.Parse(Page.Request.QueryString["pClientId"]);

            //return pClientId.ToString();
            var partneId = (from p in db.clients
                       where p.client_id == pClientId
                       select p.referral_partner_id).First();
		    if (partneId== null)
            {
                return "-1";
            }
        
            return partneId.ToString();
		}
		catch (Exception)
		{
			return "-1";
		}
	}

   protected void clientListDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
   {


       if (Context.User.IsInRole("Director")
        || Context.User.IsInRole("Processing Manager")
        || Context.User.IsInRole("Processing Assistant")
        || Context.User.IsInRole("Production Manager")
        || Context.User.IsInRole("Production Assistant"))
       {

           var sections = from s in db.sections
                          where s.in_ops_dept == 1 && (s.production_status_id == 9 || s.production_status_id == 26)
                          orderby s.client.job_name
                          select s;
           e.Result = sections;
       }
       else
       {

           var sections = from s in db.sections
                          where s.in_ops_dept == 1 && s.production_status_id == 26
                          orderby s.client.job_name
                          select s;
           e.Result = sections;

       }

   }
   public bool getAllowedToViewFinance()
   {

       bool result = false;

       if (User.IsInRole("Director")
        || User.IsInRole("Design Consultant")
        || User.IsInRole("Customer Experience Manager") 
        || User.IsInRole("Client Liaison")
        || User.IsInRole("Operations Manager")
        || User.IsInRole("Project Manager")
        || User.IsInRole("Finance Admin Administrator")
        || User.IsInRole("Finance Admin Manager"))
       {
           result = true;

       }



       return result;








   }


    public bool getAllowedToView()
    {

        bool result = false;

        if (User.IsInRole("Director")
         || User.IsInRole("Design Consultant")
         || User.IsInRole("Customer Experience Manager")
         || User.IsInRole("Client Liaison")
         || User.IsInRole("Operations Manager")
         || User.IsInRole("Project Manager")
         || User.IsInRole("Production Controller")
         || User.IsInRole("Finance Admin Administrator")
         || User.IsInRole("Design Administrator")
         || User.IsInRole("Finance Admin Manager"))
        {
            result = true;

        }



        return result;








    }

    public string loadBrandLogo()
    {
        int pSectionId = Int32.Parse(Page.Request.QueryString["pSectionId"]);
        

        var client = (from c in db.sections
                       where c.section_id == pSectionId
                       select c).First();
        Brands b = (Brands) client.Brand;

        return "/Images/" + b.ToString() + ".png";
    }
    public bool getSectionStatusVisiblility(int pDeptId)
    {
        int pDepartmentId = -1;
                try
                {
                    pDepartmentId = Int32.Parse(Page.Request.QueryString["pDepartmentId"]);
                }
                catch (Exception ex) { }

        // a little hack to group departments together 
        // Sales
        if (pDepartmentId == 6)
            pDepartmentId = 0;
        else if(pDepartmentId == 7 || pDepartmentId == 1 || pDepartmentId == 22 || pDepartmentId == 8)
        {
            pDepartmentId = 2;

        }

        if (pDepartmentId == pDeptId)
                {
                    return true;

                }
                else
                {
                    return false;
                }
                  
    }
   

    protected void Page_Load(object sender, EventArgs e)
    {
        if(IsPostBack)
        {
            loadBrandLogo();

        }
        //{
        //    DropDownList ddl = (DropDownList)FormView1.FindControl("DropDownList1");

        //    List<int> brands = new List<int>();
        //    brands.Add(Brands.blu_line);
        //    brands.Add(Brands.nuuma);
        //    brands.Add(Brands.twelve);
        //    brands.Add(Brands.OCD);

        //    ddl.DataSource = brands;
        //    ddl.DataBind();
        //}



    }
    
    protected void Page_Init(object sender, EventArgs e)
    {
        db = new IntranetDataDataContext();
        
    
    }


    protected void status_info_selecting(object sender, LinqDataSourceSelectEventArgs e)
    {

        int pSectionId = -1;
        try
        {
            pSectionId = Int32.Parse(Page.Request.QueryString["pSectionId"]);
        }
        catch (Exception ex) { }

        var sections = from s in db.sections
                       where s.section_id == pSectionId
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
    protected void client_categories_selecting(object sender, LinqDataSourceSelectEventArgs e)
    {


        var categories = from c in db.client_categories
                       orderby c.id
                       select c;

        e.Result = categories;
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
    protected void installation_teams_selecting(object sender, LinqDataSourceSelectEventArgs e)
    {


        var teams = from i in db.installation_teams
                       where i.active_status == 1
                       orderby i.description
                       select i;

        e.Result = teams;
    }
    protected String GetInstallationTime(object pQuoteValue)
    {


        Utils util = new Utils();

        return "Allocated installation days : "+util.getAllocatedInstallationDays((Decimal)pQuoteValue);

    }

    protected void section_status_changed(object sender, EventArgs e)
    {
        //Button updateButton = FormView1.FindControl("UpdateButton") as Button;
        //FormView1.UpdateItem;

    }
    protected void section_status_itemUpdating(object sender, FormViewUpdateEventArgs e)
    {
        //check to see is we must archive or make active based on won or lost
        int clientId = Int32.Parse(Page.Request.QueryString["pClientId"]);
        if (e.NewValues["installation_team"] == null || e.NewValues["installation_team"].ToString().Trim().Equals(""))
        {
            e.NewValues["installation_team"] = null;

        }

            if (e.NewValues["quote_status"].Equals("Lost"))
        {
            e.NewValues["active_status"] = 0;
            // ensure there is a lost reason
            TextBox lostReasonTextBox = (TextBox)FormView1.FindControl("lost_reason_otherTextBox");

            if (lostReasonTextBox.Text == null || lostReasonTextBox.Text.Trim().Length <= 0)
            {
                lostReasonTextBox.BackColor = System.Drawing.Color.IndianRed;
                lostReasonTextBox.ForeColor = System.Drawing.Color.White;
                e.Cancel = true;
                return;
            }
            // remove ghostlead record if its a lost lead and was a ghost lead
            //first check if there is a quote value 
            double quoteValue = 0;

            try
            {
                quoteValue = Double.Parse(e.NewValues["quote_value"].ToString());

            }
            catch (Exception ex) { }

            if (quoteValue <= 0)
            {
                // means it was a lost lead so we must check if it was a ghost lead and deactivate it
                

                try
                {

                    ghost_lead ghostLead = (from g in db.ghost_leads
                                            where g.client_id == clientId
                                            select g).Single();


                    ghostLead.isActive = false;
                    db.SubmitChanges();


                }
                catch (Exception ex)
                {
                    // it will throw an exception if it doesnt find a record of the ghost lead
                }

                
            }


        }
        else if (e.NewValues["quote_status"].Equals("Won") || e.NewValues["quote_status"].Equals("Pending"))
        {

            e.NewValues["active_status"] = 1;
            if (e.NewValues["quote_status"].Equals("Won"))
            {
                e.NewValues["in_ops_dept"] = "1";
            }
        }

        if (e.OldValues["quote_status"].Equals("Lost") && e.NewValues["quote_status"].Equals("Pending"))
        {
            // means it was brought out of archive 

            // re activate ghostlead record if its a lost lead and was a ghost lead
            //first check if there is a quote value 
            double quoteValue = 0;

            try
            {
                quoteValue = Double.Parse(e.NewValues["quote_value"].ToString());

            }
            catch (Exception ex) { }

            if (quoteValue <= 0)
            {
                // means it was a lost lead so we must check if it was a ghost lead and re - activate it
                

                try
                {

                    ghost_lead ghostLead = (from g in db.ghost_leads
                                            where g.client_id == clientId
                                            select g).Single();


                    ghostLead.isActive = true;
                    db.SubmitChanges();


                }
                catch (Exception ex)
                {
                    // it will throw an exception if it doesnt find a record of the ghost lead
                }


            }


        }


            // set the decision date

            if (!e.NewValues["quote_status"].Equals(e.OldValues["quote_status"]))
        {
            if (e.NewValues["quote_status"].Equals("Pending"))
            {
                e.NewValues["decision_date"] = null;

            }
            else
            {
                if (Utils.isContractsJob(clientId))
                    e.NewValues["decision_date"] = new DateTime(2016, 01, 01).ToString(); // a hack to set the descision date back to not mess the stats up
                else
                    e.NewValues["decision_date"] = DateTime.Now.ToString();

            }

        }

        if (e.NewValues["quote_status"].Equals("Pending"))
		{

		}

    }

    protected void loadTasks(object sender, EventArgs e)
	{

        //List<int> brands =new List<int> ();
        //brands.Add(Brands.blu_line);
        //brands.Add(Brands.nuuma);
        //brands.Add(Brands.twelve);
        //brands.Add(Brands.OCD);

        //DropDownList ddl = new DropDownList();
        //ddl.DataSource = brands;
        //ddl.DataBind();

        



    }

    protected void section_status_itemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        String department_id = Page.Request.QueryString["pDepartmentId"];
        String section_id = Page.Request.QueryString["pSectionId"];
        int clientId = Int32.Parse(Page.Request.QueryString["pClientId"]);
        var client = from c in db.clients where c.client_id == clientId select c;
        //getImages();

        //if (!e.OldValues["client.client_category_id"].Equals(e.NewValues["client.client_category_id"]) )
        //{
        //    // if it has do the update because it does not update in the client object

        //   client original = db.clients.First(c => c.client_id == clientId);


        //    original.client_category_id = Int32.Parse(e.NewValues["client.client_category_id"].ToString());
        //    db.SubmitChanges();



        //}



        if (!e.NewValues["quote_status"].Equals(e.OldValues["quote_status"]))
        {
            bool wasInOps = false;
            if (e.NewValues["quote_status"].Equals("Won") && (e.OldValues["in_ops_dept"].Equals("1")))
            {
                //means job was already in ops dept and has just been set to Won 

                ActivityLog log = new ActivityLog();
                log.sendJobWonThatWasInOpsEmail(client.Single<client>().job_name + " - " + e.NewValues["section_name"].ToString(), User.Identity.Name);
                wasInOps = true;

                
            }

            //if ((e.NewValues["in_ops_dept"].Equals("1")) && e.OldValues["quote_status"].Equals("Pending") || e.OldValues["quote_status"].Equals("Lost"))
            //{
            //    var section = (from s in db.sections where s.section_id == int.Parse(section_id) select s).First();

                
            //    //these are inOps reminders inserted when a new section is added to an existing client
            //        //var userRems = from ur in db.reminder_defaults_by_users
            //        //               where
            //        //                 ur.user_name == section.client.site_coordinator_name
            //        //               && ur.department_id == 2    // hack for now to populate only site coordinators
            //        //               && ur.event_to_add == addinOpsEvent
            //        //               select ur;

            //        //foreach (var rd in userRems)
            //        //{
            //        //    reminder rem = new reminder();
            //        //    rem.type = 0;
            //        //    rem.UserName = section.client.site_coordinator_name;
            //        //    rem.department_id = 2;    // (int)rd.department_id;
            //        //    rem.reminder1 = rd.reminder;
            //        //    rem.high_priority = rd.high_priority;
            //        //    rem.reminder_order = rd.reminder_order;
            //        //    rem.section_id = section.section_id;
            //        //    rem.reminder_status = 0;
            //        //    if (rd.reminder_order == 0)
            //        //        rem.reminder_due_date = System.DateTime.Now.Date;
            //        //    rem.date_completed = new DateTime(1901, 1, 1);
            //        //    db.reminders.InsertOnSubmit(rem);
            //        //}
            //        //db.SubmitChanges();

                

            //}



            if (e.NewValues["quote_status"].Equals("Won") && (e.OldValues["quote_status"].Equals("Pending") || e.OldValues["quote_status"].Equals("Lost")))
            {

                //check if section was set to won and put in ops dept

                int pDepartmentId = Int32.Parse(Page.Request.QueryString["pDepartmentId"]);
                int pSectionId = Int32.Parse(Page.Request.QueryString["pSectionId"]);
                int wonRems = 2;
                int inOpsRems = 4;


               var section = (from s in db.sections where s.section_id == pSectionId select s).First();

				if ((section.client.site_coordinator_name != null) && (section.client.site_coordinator_name != ""))
				{
					var userRems = from ur in db.reminder_defaults_by_users
								   where
									 ur.user_name == section.client.site_coordinator_name
								   && ur.department_id == 2    // hack for now to populate only site coordinators
								   && ur.event_to_add == wonRems
								   select ur;

					foreach (var rd in userRems)
					{
						reminder rem = new reminder();
						rem.type = 0;
						rem.UserName = section.client.site_coordinator_name;
						rem.department_id = 2;    // (int)rd.department_id;
						rem.reminder1 = rd.reminder;
						rem.high_priority = rd.high_priority;
						rem.reminder_order = rd.reminder_order;
						rem.section_id = section.section_id;
						rem.reminder_status = 0;
						if (rd.reminder_order == 0)
							rem.reminder_due_date = System.DateTime.Now.Date;
						rem.date_completed = new DateTime(1901, 1, 1);
						db.reminders.InsertOnSubmit(rem);
					}
					db.SubmitChanges();


				}


				if (e.OldValues["in_ops_dept"].Equals("0"))
                {

                    try
                    {

                        // the event_to_add is Won which has value 2 and the section was never in OpsDpt populate Won and InOps reminders
                        var userRems = from ur in db.reminder_defaults_by_users
                                       where (ur.event_to_add == wonRems || ur.event_to_add == inOpsRems)
                                       && ur.user_name ==section.client.consultant_name //e.OldValues["client.consultant_name"].ToString()
                                        && ur.department_id == 0      // can only display for consultants for now
                                       select ur;

                        foreach (var rd in userRems)
                        {
                            reminder rem = new reminder();
                            rem.type = 0;
                            rem.UserName = section.client.consultant_name; //e.OldValues["client.consultant_name"].ToString();
                            rem.department_id = 0;   //(int)rd.department_id;
                            rem.reminder1 = rd.reminder;
                            rem.high_priority = rd.high_priority;
                            rem.reminder_order = rd.reminder_order;
                            rem.section_id = pSectionId;
                            rem.reminder_status = 0;
                            if (rd.reminder_order == 0)
                                rem.reminder_due_date = System.DateTime.Now.Date;
                            rem.date_completed = new DateTime(1901, 1, 1);
                            db.reminders.InsertOnSubmit(rem);
                        }
                        db.SubmitChanges();

                        if ((section.client.site_coordinator_name != null) && (section.client.site_coordinator_name != ""))
						{
                            var scRems = from ur in db.reminder_defaults_by_users
                                           where (ur.event_to_add == inOpsRems)
                                           && ur.user_name == section.client.site_coordinator_name //e.OldValues["client.consultant_name"].ToString()
                                            && ur.department_id == 2      // can only display for consultants for now
                                           select ur;

                            foreach (var rd in scRems)
                            {
                                reminder rem = new reminder();
                                rem.type = 0;
                                rem.UserName = section.client.site_coordinator_name; //e.OldValues["client.consultant_name"].ToString();
                                rem.department_id = 2;   //(int)rd.department_id;
                                rem.reminder1 = rd.reminder;
                                rem.high_priority = rd.high_priority;
                                rem.reminder_order = rd.reminder_order;
                                rem.section_id = pSectionId;
                                rem.reminder_status = 0;
                                if (rd.reminder_order == 0)
                                    rem.reminder_due_date = System.DateTime.Now.Date;
                                rem.date_completed = new DateTime(1901, 1, 1);
                                db.reminders.InsertOnSubmit(rem);
                            }
                            db.SubmitChanges();

                        }

                    }
                    catch (Exception ex)
                    { }

                    
                }
                else if (e.OldValues["in_ops_dept"].Equals("1"))
                {
                    try {
                        // the event_to_add is Won which has value 3 and populate the  won reminders because inOps reminders are already there

                        var userRems = from ur in db.reminder_defaults_by_users
                                       where ur.event_to_add == wonRems
                                       && ur.user_name == section.client.consultant_name    //e.OldValues["client.consultant_name"].ToString()
                                       && ur.department_id == 0    //can only populate for consultant at the moment
                                       select ur;

                        foreach (var rd in userRems)
                        {
                            reminder rem = new reminder();
                            rem.type = 0;
                            rem.UserName = section.client.consultant_name;   //e.OldValues["client.consultant_name"].ToString();
                            rem.department_id = 0;    // (int)rd.department_id;
                            rem.reminder1 = rd.reminder;
                            rem.high_priority = rd.high_priority;
                            rem.reminder_order = rd.reminder_order;
                            rem.section_id = pSectionId;
                            rem.reminder_status = 0;
                            if (rd.reminder_order == 0)
                                rem.reminder_due_date = System.DateTime.Now.Date;
                            rem.date_completed = new DateTime(1901, 1, 1);
                            db.reminders.InsertOnSubmit(rem);
                        }
                        db.SubmitChanges();
                    } catch(Exception ex)
                    { }
                }
                

                if (!Utils.isContractsJob(clientId))
                {

                    if (!db.reminders.Any(j => j.section_id == Int32.Parse(section_id) && (j.department_id == 1|| j.department_id == 4 || j.department_id == 7 || j.department_id == 8)))//  check for duplicates;|| j.department_id == 2 
                    {
                        var reminder_def = from r in db.reminder_defaults
                                           where r.department_id == 8
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
                }

                
                    if (!db.job_times.Any(j => j.section_id == Int32.Parse(section_id) && j.dept_id == 2))//  check for duplicates
                    {
                        job_time installationJobTime = new job_time();
                        installationJobTime.section_id = Int32.Parse(section_id);
                        installationJobTime.dept_id = 2;
                        db.job_times.InsertOnSubmit(installationJobTime);
                        db.SubmitChanges();
                    }
               
                  
                if (!db.project_dates.Any(o => o.section_id == Int32.Parse(section_id) && o.is_job_list_item == false))//  check for duplicates
                {
                    Utils util = new Utils();
                    DateHandler dateHandler = new DateHandler();

                    //if its a contracts job, tick off measurements and confirm appliances 

                    bool final_measure = false;
                    if (Utils.isContractsJob(clientId))
                    {
                        final_measure = true;
                        section_appliance appliances = new section_appliance();
                        appliances.section_id = Int32.Parse(section_id);
                        appliances.confirmed = true;
                        appliances.user_confirmed = "System";
                        appliances.appliance_description = "N/A";
                        appliances.date_confirmed = DateTime.Now;
                        db.section_appliances.InsertOnSubmit(appliances);

                        db.SubmitChanges();
                    }

                    project_date projectDate = new project_date();
                    projectDate.section_id = Int32.Parse(section_id);
                    projectDate.in_production = false;
                    projectDate.production_complete = false;
                    projectDate.factory_scheduled = false;
                    projectDate.stock_orders_sent = false;
                    projectDate.plans_done = false;
                    projectDate.technical_orders_done = false;
                    projectDate.stone_done = false;
                    projectDate.scheduled_plan_creation = false;
                    projectDate.plumbing_electrical_complete = false;
                    projectDate.final_measurements_complete = final_measure;
                    projectDate.is_job_list_item = false;
                    projectDate.contract_date = dateHandler.addWorkDays(DateTime.Now, util.getProductionDefaults().client_lead_time.Value, 2);
                    projectDate.site_delivery_date = dateHandler.addWorkDays(DateTime.Now, util.getProductionDefaults().client_lead_time.Value, 2);
                    projectDate.client_lead_time = getLeadTime(getBrandName((section.Brand).ToString()));
                    projectDate.production_buffer = util.getProductionDefaults().production_buffer.Value;
                    db.project_dates.InsertOnSubmit(projectDate);
                    db.SubmitChanges();

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


                }
                //insert the default walls
                if (!db.walls.Any(o => o.section_id == Int32.Parse(section_id)))//  check for duplicates
                {
                    wall generalWall = new wall();
                    generalWall.section_id = Int32.Parse(section_id);
                    generalWall.wall_label = "General";
                    generalWall.wall_order = -10;
                    db.walls.InsertOnSubmit(generalWall);
                    db.SubmitChanges();
                    wall applainceWall = new wall();
                    applainceWall.section_id = Int32.Parse(section_id);
                    applainceWall.wall_label = "Appliances / HV Items";
                    applainceWall.wall_order = 999999;
                    db.walls.InsertOnSubmit(applainceWall);
                    db.SubmitChanges();
                    wall supplierWall = new wall();
                    supplierWall.section_id = Int32.Parse(section_id);
                    supplierWall.wall_label = "Supplier Value Adds / Returns";
                    supplierWall.wall_order = 999999;
                    db.walls.InsertOnSubmit(supplierWall);
                    db.SubmitChanges();
                }


                if (!wasInOps)
                {

                    
                    ActivityLog log = new ActivityLog();

                    log.sendJobWonEmail(client.Single<client>().job_name + " - " + e.NewValues["section_name"].ToString(), User.Identity.Name,Utils.isContractsJob(clientId));
                }


            }
            else 
            {// means the quote status has been set to lost or Pending so make sure its not in ops dept
                // remove any record that may be in project dates or job times tables for ops dept

                e.NewValues["in_ops_dept"] = "0";

                if (e.NewValues["quote_status"].Equals("Lost"))
                {
                    ActivityLog log = new ActivityLog();
                    log.sendJobLostEmail(client.Single<client>().job_name + " - " + e.NewValues["section_name"].ToString(), User.Identity.Name, e.NewValues["lost_reason_other"].ToString(), Int32.Parse(section_id));                  
                    
                 }




            }
            
        }

        if (e.NewValues["quote_status"].Equals("Lost"))
        {
            Response.Redirect(addParameters("reminders_dashboard.aspx")); 
        }
        else {
            Response.Redirect(addParameters("section_view.aspx"));
        }

        
    }


    protected void joblist_items_DataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {

        int pSectionId = -1;

        String sectionID = Page.Request.QueryString["pSectionId"];
        if (sectionID != null)
        {
            pSectionId = Int32.Parse(sectionID);
        }


        var job_list_items = from j in db.job_list_items
                             where j.section_id == pSectionId
                             && j.production_assistant_to_order == false
                             && (j.is_snag_list_item == null || j.is_snag_list_item == false)
                             && j.item_completed == false
                             && (j.default_item_na == null || j.default_item_na == false)
                             orderby j.date_logged descending
                             select j;





        e.Result = job_list_items;
        

    }
    protected void completed_items_DataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {

        int pSectionId = -1;

        String sectionID = Page.Request.QueryString["pSectionId"];
        if (sectionID != null)
        {
            pSectionId = Int32.Parse(sectionID);
        }


        var job_list_items = from j in db.job_list_items
                             where j.section_id == pSectionId
                             && j.production_assistant_to_order == false
                             && (j.is_snag_list_item == null || j.is_snag_list_item == false)
                             && (j.item_completed == true || j.default_item_na == true)

                             orderby j.date_completed descending
                             select j;





        e.Result = job_list_items;

    }

    protected void joblist_items_ItemInserting(object sender, ListViewInsertEventArgs e)
    {
        string deptId = Page.Request.QueryString["pDepartmentId"];

        e.Values["department_id"] = deptId;
        e.Values["reason_for_logging"] = "0";
        /*if (deptId != null && (deptId.Equals("1") || deptId.Equals("5") || deptId.Equals("12") || deptId.Equals("13") || deptId.Equals("14")))// means that either factory guys or productoin controller has logged
        { // if factory guys log then auto authorise because production manager will pick it up 
            
            e.Values["manager_has_processed_order"] = true;
            e.Values["order_needs_processing"] = true;
            e.Values["manager_processed_date"] = DateTime.Now;
            e.Values["manager_processed_name"] = "AutoAuth";
            e.Values["reason_for_logging"] = "Production Order";






        }*/
        
        e.Values["reason_dealt_with"] = false;
        e.Values["is_main_material_order"] = false;
        e.Values["production_assistant_to_order"] = false; // means thats its not a stock order
        e.Values["section_id"] = Page.Request.QueryString["pSectionId"];
        e.Values["date_logged"] = DateTime.Now.ToString();
        e.Values["user_logged"] = User.Identity.Name;
        e.Values["user_role"] = getUserRole();
        
        e.Values["is_snag_list_item"] = false;
        e.Values["default_item_na"] = false;
        e.Values["is_waste"] = false;
        e.Values["order_dispatched"] = false;



    }
    protected void joblist_items_ItemInserted(object sender, ListViewInsertedEventArgs e)
    {

        

        string deptId = Page.Request.QueryString["pDepartmentId"];

        e.Values["department_id"] = deptId;
        string jobName = clientNameLabel.Text + " - " + sectionLabel.Text;
        ActivityLog log = new ActivityLog();
       // if (deptId != null && (!deptId.Equals("5") && !deptId.Equals("1")))// means that either factory guys or productoin manager has NOT logged meaning its a site order
        //{

            log.sendSiteOrderAuthRequestEmail(jobName, e.Values["user_logged"].ToString(), e.Values["description"].ToString());                  

        //}
        //else
        //{
          //  log.sendProductionOrderAddedEmail(jobName, e.Values["user_logged"].ToString(), e.Values["description"].ToString());


//        }



        orderCountLabel.Text = getOrdersCount();
        

        JoblistItemsListView.DataBind();
        

    }

    protected void joblist_items_OnInserted(object sender, LinqDataSourceStatusEventArgs e)
    {

       /* job_list_item jobListItem = (job_list_item)e.Result;

        if (jobListItem.manager_has_processed_order == true)// means its a production order meaning it wont go through to technical services to auth
        {

            project_date projectDate = new project_date();
            projectDate.section_id = Convert.ToInt32(Page.Request.QueryString["pSectionId"]);
            projectDate.into_production_date = DateTime.Now;
            projectDate.in_production = true;
            projectDate.production_complete = false;
            projectDate.factory_scheduled = false;
            projectDate.stock_orders_sent = false;
            projectDate.scheduled_plan_creation = false;
            projectDate.plumbing_electrical_complete = false;
            projectDate.final_measurements_complete = false;
            projectDate.is_job_list_item = true;
            projectDate.client_lead_time = 0;
            projectDate.production_buffer = 0;
            projectDate.job_list_item_id = jobListItem.id;
            db.project_dates.InsertOnSubmit(projectDate);
            db.SubmitChanges();



            production_control productionControl = new production_control();
            productionControl.section_id = Convert.ToInt32(Page.Request.QueryString["pSectionId"]);
            productionControl.cabinets_applicable = false;
            productionControl.cabinets_before_finishes_days = 0;
            productionControl.cabinets_complete = false;
            productionControl.cabinets_days = 0;
            productionControl.communicated_site_delivery_date = false;
            productionControl.custom_structures_applicable = false;
            productionControl.custom_structures_complete = false;
            productionControl.custom_structures_days = 0;
            productionControl.finishes_applicable = false;
            productionControl.finishes_complete = false;
            productionControl.finishes_days = 0;
            productionControl.joblist_item_id = jobListItem.id;
            productionControl.order_has_been_setup = false;
            productionControl.plan_generation_applicable = false;
            productionControl.plan_generation_complete = false;
            productionControl.plan_generation_days = 0;
            productionControl.production_buffer = 0;
            productionControl.projects_dates_id = projectDate.id;
            productionControl.supplier_orders_applicable = false;
            productionControl.supplier_orders_complete = false;
            productionControl.supplier_orders_days = 0;

            db.production_controls.InsertOnSubmit(productionControl);


            db.SubmitChanges();

        }*/



    }



    protected void joblist_items_ItemUpdating(object sender, ListViewUpdateEventArgs e)
    {


        if (((Boolean)e.OldValues["material_processed"]) == false && ((Boolean)e.NewValues["material_processed"]) == true)
        {

            e.NewValues["item_completed"] = true;
            e.NewValues["date_completed"] = DateTime.Now.ToString();
            e.NewValues["user_completed"] = Context.User.Identity.Name;

        }


    }
    protected void joblist_items_ItemUpdated(object sender, ListViewUpdatedEventArgs e)
    {

        orderCountLabel.Text = getOrdersCount();
        CompletedListView.DataBind();
        
    }

    



    protected void walls_DataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {

        int pSectionId = -1;

        String sectionID = Page.Request.QueryString["pSectionId"];
        if (sectionID != null)
        {
            pSectionId = Int32.Parse(sectionID);
        }


        var sectionWalls = from w in db.walls
                             where w.section_id == pSectionId

                             orderby w.wall_order 
                             select w;

        /*if(sectionWalls != null && sectionWalls.Count() >0)
            hideWallId.Value = ((wall)sectionWalls.First()).id.ToString();*/


        e.Result = sectionWalls;

    }
    protected void WallsChecklistDataSource_Selecting_Initial(object sender, LinqDataSourceSelectEventArgs e)
    {
        int pWallId = -1;
        try
        {
            
            pWallId = Int32.Parse(hideWallId.Value);
        }
        catch (Exception ex) { }

        var checklists = from c in db.wall_checklist_items
                         where c.wall_id == pWallId 
                         && c.item_relevant_to_wall == true
                         && c.item_type == 0
                         orderby c.completed,c.wall_checklist_category.category_order,c.description,c.added_date descending
                         select c;



        e.Result = checklists;
    }
    
    protected void wall_checklist_ItemInserting_Initial(object sender, ListViewInsertEventArgs e)
    {
        e.Values["dept_id"] = 3;
        e.Values["wall_id"] = Int32.Parse(hideWallId.Value);
        e.Values["added_date"] = DateTime.Now;
        e.Values["added_user"] = Context.User.Identity.Name;
        e.Values["item_relevant_to_wall"] = true;
        e.Values["checklist_item_order"] = 0;
        e.Values["item_type"] = 0;




    }
    
    protected void wall_checklist_ItemInserted_Initial(object sender, ListViewInsertedEventArgs e)
    {

        string jobName = clientNameLabel.Text + " - " + sectionLabel.Text;
        ActivityLog log = new ActivityLog();
        log.sendSnagListAddedEmail(jobName, e.Values["added_user"].ToString(), e.Values["description"].ToString());
        

        initialSnagCountLabel.Text = getSnagCount();
        //initalCountSingleLabel.Text = getSnagCount(Int32.Parse(hideWallId.Value));



        JoblistItemsListView.DataBind();
        WallsListView.DataBind();

    }
   
    protected void change_wall(object sender, CommandEventArgs e)
    {

        hideWallId.Value = e.CommandArgument.ToString();
        wallListListViewInitial.DataBind();
        
        
        //initalCountSingleLabel.Text = getSnagCount(Int32.Parse(e.CommandArgument.ToString()));
        





        

    }
    protected void change_list_item_status(object sender, CommandEventArgs e)
    {
        
        wall_checklist_item item = db.wall_checklist_items.First(c => c.id == Int32.Parse(e.CommandArgument.ToString()));
        if (item.completed == null || item.completed == false)
        {
            item.completed = true;
            item.completed_user = Context.User.Identity.Name;
            item.completed_date = DateTime.Now;
        }
        else
        {
            item.completed = false;
            item.completed_user = null;
            item.completed_date = null;
        }
        db.SubmitChanges();
        wallListListViewInitial.DataBind();
        
        initialSnagCountLabel.Text = getSnagCount();
        
        //initalCountSingleLabel.Text = getSnagCount(item.wall_id);
        

        WallsListView.DataBind();

    }




    protected void appliance_items_DataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {

        int pSectionId = -1;

        String sectionID = Page.Request.QueryString["pSectionId"];
        if (sectionID != null)
        {
            pSectionId = Int32.Parse(sectionID);
        }


        var appliance_list_items = from s in db.section_appliances
                             where s.section_id == pSectionId
                             select s;





        e.Result = appliance_list_items;

        // hide the insert listview if there is an appliance listing found

        if (appliance_list_items != null && appliance_list_items.Count() > 0)
        {
            ApplianceInsertListView.Visible = false;

        }


    }
    protected void appliance_items_ItemInserting(object sender, ListViewInsertEventArgs e)
    {

        TextBox applianceTextBox = (TextBox)((ListView)sender).InsertItem.FindControl("descriptionTextBox");
        if (applianceTextBox.Text == null || applianceTextBox.Text.Trim().Length <= 0)
        {
            applianceTextBox.BackColor = System.Drawing.Color.IndianRed;
            applianceTextBox.ForeColor = System.Drawing.Color.White;
            e.Cancel = true;
            return;
        }


        e.Values["section_id"] = Page.Request.QueryString["pSectionId"];
        e.Values["confirmed"] = false;
        e.Values["date_logged"] = DateTime.Now.ToString();
        e.Values["user_logged"] = User.Identity.Name;




    }
    protected void appliance_items_ItemInserted(object sender, ListViewInsertedEventArgs e)
    {

        ApplianceItemsListView.DataBind();
        


    }
    protected void appliance_items_ItemUpdating(object sender, ListViewUpdateEventArgs e)
    {

        TextBox applianceTextBox = (TextBox)((ListView)sender).EditItem.FindControl("descriptionTextBox");
        if (applianceTextBox.Text == null || applianceTextBox.Text.Trim().Length <= 0)
        {
            applianceTextBox.BackColor = System.Drawing.Color.IndianRed;
            applianceTextBox.ForeColor = System.Drawing.Color.White;
            e.Cancel = true;
            return;
        }

        if (((Boolean)e.OldValues["confirmed"]) == false && ((Boolean)e.NewValues["confirmed"]) == true)
        {

           
            e.NewValues["date_confirmed"] = DateTime.Now.ToString();
            e.NewValues["user_confirmed"] = Context.User.Identity.Name;

        }
        if (((Boolean)e.OldValues["confirmed"]) == true && ((Boolean)e.NewValues["confirmed"]) == false)
        {


            e.NewValues["date_confirmed"] = null;
            e.NewValues["user_confirmed"] = null;

        }


    }
    protected void appliance_items_ItemUpdated(object sender, ListViewUpdatedEventArgs e)
    {
        ActivityLog log = new ActivityLog();
        if (!(e.OldValues["appliance_description"].ToString().Equals(e.NewValues["appliance_description"].ToString())) && ((Boolean)e.OldValues["confirmed"]) == true)
        {
            string jobName = clientNameLabel.Text + " - " + sectionLabel.Text;          
            log.sendAppliancesChangedEmail(jobName, Context.User.Identity.Name);
           
        }


        if (((Boolean)e.OldValues["confirmed"]) == false && ((Boolean)e.NewValues["confirmed"]) == true)
        {
            string jobName = clientNameLabel.Text + " - " + sectionLabel.Text;
            log.sendAppliancesConfirmedEmail(jobName, Context.User.Identity.Name);
            
        }
        if (((Boolean)e.OldValues["confirmed"]) == true && ((Boolean)e.NewValues["confirmed"]) == false)
        {
            string jobName = clientNameLabel.Text + " - " + sectionLabel.Text;
            log.sendAppliancesUnConfirmedEmail(jobName, Context.User.Identity.Name);
            
        }
    }

    protected void ops_workflow_DataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {
        int pSectionId = -1;

        String sectionID = Page.Request.QueryString["pSectionId"];
        if (sectionID != null)
        {
            pSectionId = Int32.Parse(sectionID);
        }

        var project_dates = from p in db.project_dates
                            where p.section_id == pSectionId
                            select p;

        if (project_dates != null && project_dates.Count()>0)
             e.Result = project_dates.First();
        else
            e.Result = project_dates;

    }
    protected void ops_workflow_ItemUpdating(object sender, FormViewUpdateEventArgs e)
    {
        
            if ((bool)(e.OldValues["final_measurements_complete"]) == false && (bool)(e.NewValues["final_measurements_complete"]) == true)
            {
                e.NewValues["final_measurements_complete_date"] = DateTime.Now.Date;
                e.NewValues["final_measurements_complete_by"] = Context.User.Identity.Name;
            }
            
           
        

    }
    protected void ops_workflow_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        if (e.OldValues["final_measurements_complete"] != null && e.NewValues["final_measurements_complete"] != null)
        {
            if ((bool)(e.OldValues["final_measurements_complete"]) == false && (bool)(e.NewValues["final_measurements_complete"]) == true)
            {
                string jobName = clientNameLabel.Text + " - " + sectionLabel.Text;

                ActivityLog log = new ActivityLog();
                log.sendFinalMeasurmentsEmail(jobName, Context.User.Identity.Name);

               
            }
        }





        }

    public static string GetApplianceYesNoImage(object pSectionObject)
    {
        section sectionObject = null;
        bool status = false;


        if (pSectionObject != null)
        {
            sectionObject = (section)pSectionObject;

            if (sectionObject.section_appliances != null && sectionObject.section_appliances.Count() > 0)
            {
                status = (bool)sectionObject.section_appliances.Single().confirmed;

            }

        }

        if (status)
        {
            return "images/yes.png";
        }
        else
        {
            return "images/no.png";
        }
    }
    public static string GetYesNoImage(object pStatusObject)
    {
        bool status = false;
        if (pStatusObject != null)
        {
            status = (bool)pStatusObject;
        }

        if (status)
        {
            return "images/yes.png";
        }
        else
        {
            return "images/no.png";
        }
    }
    public static bool GetCanChangeSiteDate(object pInProductionObject)
    {
        bool inProductionStatus = false;
        

        try
        {
            inProductionStatus = (bool)pInProductionObject;
            
        }
        catch (Exception ex)
        {

        }


        if (inProductionStatus == true)
        {
            return false; // only allowed to change site date if NOT in production yet
        }
        else
        {
            return true;
        }



    }




   
    private string getUserRole()
    {
        //this is a hack method - must look into it when have time

        string userRole = "";

        if (Context.User.IsInRole("Technical Services Manager"))
        {
            userRole = "Technical Services Manager";

        }
        else if (Context.User.IsInRole("Processing Manager"))
        {
            userRole = "Processing Manager";

        }
        else if (Context.User.IsInRole("Installer"))
        {
            userRole = "Installer";

        }
        else if (Context.User.IsInRole("Processing Assistant"))
        {
            userRole = "Processing Assistant";

        }
        else if (Context.User.IsInRole("Project Manager"))
        {
            userRole = "Project Manager";

        }
        else if (Context.User.IsInRole("Director"))
        {
            userRole = "Director";

        }



        return userRole;

    }

    public static string GetImage(object pStatusObject)
    {
        bool status = false;
        if (pStatusObject != null)
        {
            status = (bool)pStatusObject;
        }

        if (status)
        {
            return "images/yes.png";
        }
        else
        {
            return "images/blank.png";
        }
    }

    public static string GetPrintTarget(object pStatusObject)
    {
        bool status = false;
        if (pStatusObject != null)
        {
            status = (bool)pStatusObject;
        }

        if (status)
        {
            return "print_site_order.aspx";
        }
        else
        {
            return "print_production_order.aspx";
        }
    }



    public static string GetApplianceConfirmedImage(object pStatusObject)
    {
        bool status = false;
        if (pStatusObject != null)
        {
            status = (bool)pStatusObject;
        }

        if (status)
        {
            return "images/yes.png";
        }
        else
        {
            return "images/no.png";
        }
    }

    public static string GetYesNoImageAppliances(string pSectionIdString)
    {
        bool confirmed = false;
        IntranetDataDataContext db = new IntranetDataDataContext();
        int pSectionId = -1;
        try
        {
            pSectionId = Int32.Parse(pSectionIdString);
        }
        catch (Exception ex) { }

        var result = from s in db.section_appliances
                       where s.section_id == pSectionId
                       select s.confirmed;


        if(result != null && result.Count() >0) { 

            confirmed = (bool)result.Single();
        }




        if (confirmed)
        {
            return "images/yes_small.png";
        }
        else
        {
            return "images/no_small.png";
        }
    }

    public string getFullWallCount(object pWallIdObject)
    {
       
        int pWallId = -1;
        
        if (pWallIdObject != null)
        {
            pWallId = (int)pWallIdObject;
        }

        string initialCount = getSnagCount(pWallId);
        

        return initialCount;
    }

    public string getWallDescription()
    {
        string description = "";
        int pWallId = -1;
        try
        {
            pWallId = Int32.Parse(hideWallId.Value);
            
        }
        catch (Exception ex) { }

  

        var result = from w in db.walls
                     where w.id == pWallId
                     select w;
        if (result != null && result.Count() > 0)
            description = ((wall)result.First()).wall_label;

        return description;
    }

    
    public static string GetDispatchInfo(object pJobListIDObject)
    {
        IntranetDataDataContext db = new IntranetDataDataContext();

        int pJobListId = 0;

        if(pJobListIDObject != null)
        {
            pJobListId = (int)pJobListIDObject;

        }

        var packages = from s in db.section_dispatch_items
                     where s.job_list_order_id == pJobListId
                       select s;

        int beingManufacturing = packages.Count(i => i.current_status == "Being Manufactured");
        int verified = packages.Count(i => i.current_status == "Verified");
        int dispatched = packages.Count(i => i.current_status == "Dispatched");

        return beingManufacturing + " items being manufactured <br> "
            + verified + " items Verified and ready for Dispatch <br> "
            + dispatched + " items have been Dispatched ";



    }

    public static string GetOpenTag(object pStatusObject)
    {
        bool status = false;
        if (pStatusObject != null)
        {
            status = (bool)pStatusObject;
        }

        if (status)
        {
            return "<del>";
        }
        else
        {
            return "";
        }
    }
    public static string GetCloseTag(object pStatusObject)
    {
        bool status = false;
        if (pStatusObject != null)
        {
            status = (bool)pStatusObject;
        }

        if (status)
        {
            return "</del>";
        }
        else
        {
            return "";
        }
    }

    private string getOrdersCount()
    {



        int pSectionId = -1;
        try
        {
            pSectionId = Int32.Parse(Page.Request.QueryString["pSectionId"]);
        }
        catch (Exception ex) { }

        int count = db.job_list_items.Count(r => (r.section_id == pSectionId 
                                                   && r.item_completed == false
                                                   && r.production_assistant_to_order == false
                                                   && (r.default_item_na == null || r.default_item_na == false) 
                                                   && (r.is_snag_list_item == null || r.is_snag_list_item == false)));

        return count.ToString();

    }

	public string getBrandName(String brand)

	{

		int brands = Int32.Parse(brand);

		Brands b = (Brands)brands;

		//string day = Enum.GetName(typeof(LeadTimes), b);



		return b.ToString();



	}



	public int getLeadTime(String lead)

	{



		Leadtime times = (Leadtime)Enum.Parse(typeof(Leadtime), lead);



		return (int)times;



	}



	public string getSnagCount(int pWallId)
    {

        

        int count = db.wall_checklist_items.Count(r => (r.wall_id == pWallId
                                                        && r.item_relevant_to_wall == true
                                                        && r.item_type == 0
                                                        && (r.completed == null || r.completed == false)));

        return count.ToString();

    }


    private string getSnagCount()
    {
        


        int pSectionId = -1;
        try
        {
            pSectionId = Int32.Parse(Page.Request.QueryString["pSectionId"]);
        }
        catch (Exception ex) { }

        int count = db.wall_checklist_items.Count(r => (r.wall.section_id == pSectionId
                                                        && r.item_relevant_to_wall == true
                                                        && r.item_type == 0
                                                        && (r.completed == null || r.completed == false)));

        return count.ToString();

    }



    private String addParameters(String url)
    {
        String deptId = Page.Request.QueryString["pDepartmentId"];
        String clientId = Page.Request.QueryString["pClientId"];
        String sectionId = Page.Request.QueryString["pSectionId"];
        String reminderType = Page.Request.QueryString["pReminderType"];
        


        if (url != null && url.EndsWith("aspx"))
        {
            url = url + "?pClientId=" + clientId;

            if (deptId != null && deptId.Length > 0)
            {
                url = url + "&pDepartmentId=" + deptId;

                if (sectionId != null && sectionId.Length > 0)
                {
                    url = url + "&pSectionId=" + sectionId;

                    if (reminderType != null && reminderType.Length > 0)
                    {
                        url = url + "&pReminderType=" + reminderType;
                    }
                
                }



            }

        }

        return url;

    }

   public string Truncate(object input, int characterLimit)
    {
        if (input == null)
        {
            return null;

        }
       
       string output = input.ToString();

        // Check if the string is longer than the allowed amount
        // otherwise do nothing
        if (output != null && (output.Length > characterLimit && characterLimit > 0))
        {

            // cut the string down to the maximum number of characters
            output = output.Substring(0, characterLimit);

            
        }
        return output;
    }



    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
}

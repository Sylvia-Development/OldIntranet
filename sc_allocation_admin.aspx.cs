using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

public partial class sc_allocation_admin : System.Web.UI.Page
{

    IntranetDataDataContext db = null;
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Page_Init(object sender, EventArgs e)
    {
        db = new IntranetDataDataContext();
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

    protected String getQuoteValueEx(object pQuoteValue)
    {
        decimal value = (decimal)pQuoteValue;
        value = (value * 100) / 114;

        return String.Format("{0:c}", value);
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
            
           total = (total*100)/114;


        return String.Format("{0:c}", total);

    }

    protected void NotInProductionLinqDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {

        //NotInProduction
        
        var result = from j in db.job_times
                     where
                     j.dept_id == 2
                     && j.section.active_status == 1
                     && j.section.in_ops_dept == 1
                     && (j.started_date == null && j.completed_date == null)
                     && j.section.project_dates.First().in_production == false
                     orderby j.section.client.site_coordinator_name, j.section.client.job_name
                     select j;

        e.Result = result;
        
    }

    protected void InProductionLinqDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {
        //InProductionButNotComplete

        
        var result = from j in db.job_times
                     where
                     j.dept_id == 2
                     && j.section.active_status == 1
                     && j.section.in_ops_dept == 1
                     && (j.started_date == null && j.completed_date == null)
                     && j.section.project_dates.First().in_production == true
                     orderby j.section.client.site_coordinator_name, j.section.client.job_name
                     select j;
        e.Result = result;
    }

    protected void InstallingLinqDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {
        //Installing

        var result = from j in db.job_times
                                   where
                                   j.dept_id == 2
                                   && j.section.active_status == 1
                                   && j.section.in_ops_dept == 1
                                   && (j.started_date != null && j.completed_date == null)
                                 orderby j.section.client.site_coordinator_name,j.section.client.job_name
                                 select j;

        e.Result = result;




    }

    protected void SCLinqDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {
        String[] userList = Roles.GetUsersInRole("Site Coordinator");



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

    }

    protected void NotInProductionListView_ItemUpdating(object sender, ListViewUpdateEventArgs e)
    {
        if (e.OldValues["section.client.site_coordinator_name"] == null )
        {
            e.OldValues["section.client.site_coordinator_name"] = "";
        }
        if (!e.NewValues["section.client.site_coordinator_name"].ToString().Equals(e.OldValues["section.client.site_coordinator_name"].ToString()))
        {
            
            HiddenField clientId = (HiddenField)NotInProductionListView.EditItem.FindControl("clientId");
            int pClientId = Int32.Parse(clientId.Value);
            var query =
                (from c in db.clients
                 where c.client_id == pClientId
                 select c).Single();

            query.site_coordinator_name = e.NewValues["section.client.site_coordinator_name"].ToString();

            db.SubmitChanges();
            

        }
        

    }

    protected void NotInProductionListView_ItemUpdated(object sender, ListViewUpdatedEventArgs e)
    {
        AllocationValueListView.DataBind();
     


        HiddenField jobName = (HiddenField)NotInProductionListView.EditItem.FindControl("jobName");
        HiddenField clientId = (HiddenField)NotInProductionListView.EditItem.FindControl("clientId");
        int pClientId = Int32.Parse(clientId.Value);
        String siteco = e.NewValues["section.client.site_coordinator_name"].ToString(); //(from cl in db.clients where cl.client_id == pClientId select cl.site_coordinator_name).First();
        int wonEvents = 2;
        int inOpsEvents = 4;

        foreach (var sectionid in (from c in db.job_times
                                   where c.section.client_id == pClientId
                                   select c.section_id))
        {

            
            if ((from r in db.reminders where r.UserName == siteco && r.section_id == sectionid select r).Count() > 0)
                continue;

			if ((from s in db.sections where s.section_id == sectionid select s.in_ops_dept).First() == 0)
				continue; //this statement is for the section that is not in Ops or Won and therefore should not have reminders


            if ((from s in db.sections where s.section_id == sectionid select s.in_ops_dept).First() == 1)
            {
                var userRems = from ur in db.reminder_defaults_by_users
                               where
                                 ur.user_name == siteco
                               && ur.department_id == 2    // hack for now to populate only site coordinators
                               && ur.event_to_add == inOpsEvents
                               select ur;

                foreach (var rd in userRems)
                {
                    reminder rem = new reminder();
                    rem.type = 0;
                    rem.UserName = siteco;
                    rem.department_id = 2;    // (int)rd.department_id;
                    rem.reminder1 = rd.reminder;
                    rem.high_priority = rd.high_priority;
                    rem.reminder_order = rd.reminder_order;
                    rem.section_id = sectionid;
                    rem.reminder_status = 0;
                    if (rd.reminder_order == 0)
                        rem.reminder_due_date = System.DateTime.Now.Date;
                    rem.date_completed = new DateTime(1901, 1, 1);
                    db.reminders.InsertOnSubmit(rem);
                }
                db.SubmitChanges();

            }

            if ((from s in db.sections where s.section_id == sectionid select s.quote_status).First() == "Won")
            {
                var userRem = from ur in db.reminder_defaults_by_users
                              where
                                ur.user_name == siteco
                              && ur.department_id == 2    // hack for now to populate only site coordinators
                              && ur.event_to_add == wonEvents
                              select ur;

                foreach (var rd in userRem)
                {
                    reminder rem = new reminder();
                    rem.type = 0;
                    rem.UserName = siteco;
                    rem.department_id = 2;    // (int)rd.department_id;
                    rem.reminder1 = rd.reminder;
                    rem.high_priority = rd.high_priority;
                    rem.reminder_order = rd.reminder_order;
                    rem.section_id = sectionid;
                    rem.reminder_status = 0;
                    if (rd.reminder_order == 0)
                        rem.reminder_due_date = System.DateTime.Now.Date;
                    rem.date_completed = new DateTime(1901, 1, 1);
                    db.reminders.InsertOnSubmit(rem);
                }
                db.SubmitChanges();

                
            }


            if (!e.NewValues["section.client.site_coordinator_name"].ToString().Equals(e.OldValues["section.client.site_coordinator_name"].ToString()))
            {
                if (!(e.OldValues["section.client.site_coordinator_name"].ToString() == null) && !(e.OldValues["section.client.site_coordinator_name"].ToString() == ""))
                {

                    deleteRems(sectionid, e.OldValues["section.client.site_coordinator_name"].ToString(), 2);
                }
            }


            ActivityLog log = new ActivityLog();
            log.sendConfirmationOfReallocationOfSiteCoordinatorEmail(jobName.Value, e.OldValues["section.client.site_coordinator_name"].ToString(), User.Identity.Name, e.NewValues["section.client.site_coordinator_name"].ToString());

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

    protected void InProductionListView_ItemUpdating(object sender, ListViewUpdateEventArgs e)
    {
        if (e.OldValues["section.client.site_coordinator_name"] == null)
        {
            e.OldValues["section.client.site_coordinator_name"] = "";
        }
        if (!e.NewValues["section.client.site_coordinator_name"].ToString().Equals(e.OldValues["section.client.site_coordinator_name"].ToString()))
        {

            HiddenField clientId = (HiddenField)InProductionListView.EditItem.FindControl("clientId");
            int pClientId = Int32.Parse(clientId.Value);
            var query =
                (from c in db.clients
                 where c.client_id == pClientId
                 select c).Single();

            query.site_coordinator_name = e.NewValues["section.client.site_coordinator_name"].ToString();

            db.SubmitChanges();


        }
    }

    protected void InProductionListView_ItemUpdated(object sender, ListViewUpdatedEventArgs e)
    {
        AllocationValueListView.DataBind();

        HiddenField jobName = (HiddenField)InProductionListView.EditItem.FindControl("jobName");

        ActivityLog log = new ActivityLog();
        log.sendConfirmationOfReallocationOfSiteCoordinatorEmail(jobName.Value, e.OldValues["section.client.site_coordinator_name"].ToString(), User.Identity.Name, e.NewValues["section.client.site_coordinator_name"].ToString());

    }

    protected void InstallingListView_ItemUpdating(object sender, ListViewUpdateEventArgs e)
    {
        if (e.OldValues["section.client.site_coordinator_name"] == null)
        {
            e.OldValues["section.client.site_coordinator_name"] = "";
        }
        if (!e.NewValues["section.client.site_coordinator_name"].ToString().Equals(e.OldValues["section.client.site_coordinator_name"].ToString()))
        {

            HiddenField clientId = (HiddenField)InstallingListView.EditItem.FindControl("clientId");
            int pClientId = Int32.Parse(clientId.Value);
            var query =
                (from c in db.clients
                 where c.client_id == pClientId
                 select c).Single();

            query.site_coordinator_name = e.NewValues["section.client.site_coordinator_name"].ToString();

            db.SubmitChanges();


        }
    }

    protected void InstallingListView_ItemUpdated(object sender, ListViewUpdatedEventArgs e)
    {
        AllocationValueListView.DataBind();

        HiddenField jobName = (HiddenField)InstallingListView.EditItem.FindControl("jobName");

        ActivityLog log = new ActivityLog();
        log.sendConfirmationOfReallocationOfSiteCoordinatorEmail(jobName.Value, e.OldValues["section.client.site_coordinator_name"].ToString(), User.Identity.Name, e.NewValues["section.client.site_coordinator_name"].ToString());

    }
}
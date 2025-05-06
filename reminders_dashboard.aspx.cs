using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class reminders_dashboard : System.Web.UI.Page
{
    IntranetDataDataContext db = null;

    protected void Page_Init(object sender, EventArgs e)
    {
        db = new IntranetDataDataContext();
    }

    protected void Page_Load(object sender, EventArgs e)
    {

        /*if (today_Label != null)
        {
            DateTime today = System.DateTime.Now;
            today_Label.Text = today_Label.Text + "-" + today.DayOfWeek;


            if (!today.DayOfWeek.Equals(DayOfWeek.Saturday))
            {
                TomorrowDate.Text = today.AddDays(1).ToShortDateString();
                tomorrow_Label.Text = tomorrow_Label.Text + "-" + today.AddDays(1).DayOfWeek;
            }

        }


        */
    }

    protected void NoSectionDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {




        var clients = from c in db.clients
                      where c.sections.Count == 0
                      orderby c.job_name
                      select c;





        e.Result = clients;

    }

    protected void NoConsultantDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {


        var clients = from c in db.clients
                      where c.consultant_name == ""
                      orderby c.job_name
                      select c;



        e.Result = clients;

    }

    protected DateTime getFollowingSunday(DateTime aDate)
    { 
        return aDate.AddDays(7 - (int)aDate.DayOfWeek); 
    }


    protected void overdueRemindersDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {
        String userName = Page.Request.QueryString["pUserName"];
        //String user = Context.User.Identity.Name;
        //int pDepartmentId = -1;
        //int pSecondDepartmentId = -1; // This is for a hack to display project and service call reminders combined because our client liaison schedules service calls
        //String deptID = Page.Request.QueryString["pDepartmentId"];
        //if (deptID != null)
        //{
        //    pDepartmentId = Int32.Parse(deptID);
        //}
        //String userName = Page.Request.QueryString["pUserName"];
        //String SCuserName = Page.Request.QueryString["pSCUserName"];
        ////comment this section if you want to NOT combine department reminders again
        //if (pDepartmentId != -1 && pDepartmentId == 8 )
        //{
        //   pSecondDepartmentId = 4;
        //}
        //// this is to combine projects director reminders with projects dept tasks for clients he is handling
        //if (pDepartmentId != -1 && pDepartmentId == 7)
        //{
        //    pSecondDepartmentId = 2;
        //    SCuserName = User.Identity.Name;
        //}

        IQueryable<reminder> reminders = from r in db.reminders
                     where r.UserName == userName//(r.department_id == pDepartmentId || r.department_id == pSecondDepartmentId)
                            && r.reminder_due_date != null
                            && r.reminder_due_date < System.DateTime.Now.Date
                            && r.reminder_status == 0
                     orderby r.reminder_due_date,r.reminder1
                     select r;
        //if (userName != null && userName.Length > 0)
        //{
        //    reminders = reminders.Where(p => p.section.client.consultant_name.ToLower() == userName.ToLower());
        //}
        //if (SCuserName != null && SCuserName.Length > 0)
        //{
        //    reminders = reminders.Where(p => p.section.client.site_coordinator_name.ToLower() == SCuserName.ToLower() || p.department_id==7);
        //}


        e.Result = reminders;

    }

    protected void todayRemindersDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {
        String userName = Page.Request.QueryString["pUserName"];
        //String user = Context.User.Identity.Name;
        //int pDepartmentId = -1;
        //int pSecondDepartmentId = -1; // This is for a hack to display site and service call reminders combined because our Technical Services Manager also does service calls
        //String deptID = Page.Request.QueryString["pDepartmentId"];
        //if (deptID != null)
        //{
        //    pDepartmentId = Int32.Parse(deptID);
        //}
        //String userName = Page.Request.QueryString["pUserName"];
        //String SCuserName = Page.Request.QueryString["pSCUserName"];
        ////comment this section if you want to NOT combine department reminders again
        //if (pDepartmentId != -1 && pDepartmentId == 8)
        //{ 
        //   pSecondDepartmentId = 4;
        //}
        //// this is to combine projects director reminders with projects dept tasks for clients he is handling
        //if (pDepartmentId != -1 && pDepartmentId == 7)
        //{
        //    pSecondDepartmentId = 2;
        //    SCuserName = User.Identity.Name;
        //}

        IQueryable<reminder> reminders = from r in db.reminders
                                         where r.UserName.ToLower() == userName //(r.department_id == pDepartmentId || r.department_id == pSecondDepartmentId)
                                                && r.reminder_due_date != null
                                                && r.reminder_due_date == System.DateTime.Now.Date
                                                && r.reminder_status == 0
                                         orderby r.reminder_due_date, r.reminder1
                                         select r;
        //if (userName != null && userName.Length > 0)
        //{
        //    reminders = reminders.Where(p => p.section.client.consultant_name.ToLower() == userName.ToLower());
        //}
        //if (SCuserName != null && SCuserName.Length > 0)
        //{
        //    reminders = reminders.Where(p => p.section.client.site_coordinator_name.ToLower() == SCuserName.ToLower() || p.department_id == 7);
        //}

        e.Result = reminders;

    }
    

    protected void myremindersOnSelecting(object sender, LinqDataSourceSelectEventArgs e)
	{
        //String user = Context.User.Identity.Name;
        String userName = Page.Request.QueryString["pUserName"];
        var rems = from r in db.reminders
                   where r.UserName == userName
                   select r;

        e.Result = rems;

    }
    protected void nextRemindersDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {
        String userName = Page.Request.QueryString["pUserName"];
        //    int pDepartmentId = -1;
        //    int pSecondDepartmentId = -1; // This is for a hack to display site and service call reminders combined because our Technical Services Manager also does service calls
        //    String deptID = Page.Request.QueryString["pDepartmentId"];
        //    if (deptID != null)
        //    {
        //        pDepartmentId = Int32.Parse(deptID);
        //    }
        // string user= Context.User.Identity.Name.ToLower();
        //String userName = Page.Request.QueryString["pUserName"];
        //String SCuserName = Page.Request.QueryString["pSCUserName"];
        //comment this section if you want to NOT combine department reminders again
        //if (pDepartmentId != -1 && pDepartmentId == 8)
        //{pSecondDepartmentId = 4;}
        //// this is to combine projects director reminders with projects dept tasks for clients he is handling
        //if (pDepartmentId != -1 && pDepartmentId == 7)
        //{
        //    pSecondDepartmentId = 2;
        //    SCuserName = User.Identity.Name;
        //}





        IQueryable<reminder> reminders = from r in db.reminders
                                         where r.UserName.ToLower() == userName //(r.department_id == pDepartmentId || r.department_id == pSecondDepartmentId)
                                                && r.reminder_due_date != null
                                                && r.reminder_due_date > System.DateTime.Now.Date
                                                && r.reminder_status == 0
                                         orderby r.reminder_due_date, r.reminder1
                                         select r;
        //if (userName != null && userName.Length > 0)
        //{
        //    reminders = reminders.Where(p => p.section.client.consultant_name.ToLower() == userName.ToLower());
        //}
        //if (SCuserName != null && SCuserName.Length > 0)
        //{
        //    reminders = reminders.Where(p => p.section.client.site_coordinator_name.ToLower() == SCuserName.ToLower() || p.department_id == 7);
        //}

        e.Result = reminders;


    }

    protected void refreshPage(object sender, ListViewUpdatedEventArgs e)
    {
       
        




        this.OverdueRemindersFormView.DataBind();
        this.TodaysListView.DataBind();
        this.nextListView.DataBind();

     

        
        
    }

    private String addParameters(String url)
    {
        String deptId = Page.Request.QueryString["pDepartmentId"];
        String userName = Page.Request.QueryString["pUserName"];
        



        if (url != null && url.EndsWith("aspx"))
        {
            url = url + "?pDepartmentId=" + deptId;

            if (userName != null && userName.Length > 0)
            {
                url = url + "&pUserName=" + userName;

                



            }

        }

        return url;

    }





}

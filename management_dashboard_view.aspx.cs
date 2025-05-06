using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class management_dashboard_view : System.Web.UI.Page
{
    IntranetDataDataContext db = null;

    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Page_Init(object sender, EventArgs e)
    {
        db = new IntranetDataDataContext();
    }

    protected void SectionDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {
        int pDepartmentId = -1;
        int statusId = -1;
        String userName = null;
        String seeAll = null;

        try
        {
            pDepartmentId = Int32.Parse(Page.Request.QueryString["pDepartmentId"]);
            statusId = Int32.Parse(Page.Request.QueryString["pStatusId"]);
            userName = Page.Request.QueryString["pUserName"];
            seeAll = Page.Request.QueryString["pSeeAll"];
        }
        catch (Exception ex) { }

        if (pDepartmentId == 0)
        {

            IQueryable<section> sections = from s in db.sections
                                           where s.quote_status_id == statusId
                                                 && s.active_status == 1
                                           orderby s.client.consultant_name, s.client.job_name
                                           select s;


            if ((userName == null || userName.Length == 0) && (seeAll == null || seeAll.Length == 0))
            // check if the logged in user is a design consultant            
            {
                if (Context.User.IsInRole("Design Consultant"))
                {
                    userName = Context.User.Identity.Name;
                }

            }




            if (userName != null && userName.Length > 0)
            {
                sections = sections.Where(p => p.client.consultant_name == userName);
            }

            e.Result = sections;
        }
        else if (pDepartmentId == 1)
        {

            var sections = from s in db.sections
                           where s.production_status_id == statusId && s.active_status == 1 && s.in_ops_dept == 1
                           orderby s.client.job_name
                           select s;



            e.Result = sections;
        }
        else if (pDepartmentId == 2)
        {

            var sections = from s in db.sections
                           where s.projects_status_id == statusId && s.active_status == 1 && s.in_ops_dept == 1
                           orderby s.client.job_name
                           select s;






            e.Result = sections;
        }
    }
    protected void ContactDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {
        int pDepartmentId = -1;
        int sectionId = -1;

        try
        {
            pDepartmentId = Int32.Parse(Page.Request.QueryString["pDepartmentId"]);
            sectionId = Int32.Parse(e.SelectParameters["sectionId"].ToString());

        }
        catch (Exception ex) { }



        IQueryable<reminder> reminders = from r in db.reminders
                                         where r.section_id == sectionId
                                             && r.reminder_status == 0
                                             && r.department_id == pDepartmentId
                                             && r.type == 0
                                         orderby r.reminder_order
                                         select r;

        int count = 0;
        foreach (reminder r in reminders)
        {
            count++;
        }

        if (count == 0)
        {

            var result = from s in db.sections
                         where s.section_id == sectionId
                         select s;

            int clientId = -1;
            foreach (section se in result)
            {
                clientId = se.client_id;
            }

            List<reminder> resultList = new List<reminder>();
            reminder blankReminder = new reminder();
            blankReminder.department_id = pDepartmentId;
            blankReminder.section_id = sectionId;
            section sec = new section();
            sec.section_id = sectionId;
            sec.client_id = clientId;
            blankReminder.section = sec;
            blankReminder.reminder1 = "____";

            resultList.Add(blankReminder);
            reminders = resultList.AsQueryable();
        }








        e.Result = reminders;

    }
    protected void WorkflowDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {
        int pDepartmentId = -1;
        int sectionId = -1;

        try
        {
            pDepartmentId = Int32.Parse(Page.Request.QueryString["pDepartmentId"]);
            sectionId = Int32.Parse(e.SelectParameters["sectionId"].ToString());
        }
        catch (Exception ex) { }



        IQueryable<reminder> reminders = from r in db.reminders
                                         where r.section_id == sectionId
                                             && r.reminder_status == 0
                                             && r.department_id == pDepartmentId
                                             && r.type == 1
                                         orderby r.reminder_order
                                         select r;



        int count = 0;
        foreach (reminder r in reminders)
        {
            count++;
        }

        if (count == 0)
        {

            var result = from s in db.sections
                         where s.section_id == sectionId
                         select s;

            int clientId = -1;
            foreach (section se in result)
            {
                clientId = se.client_id;
            }

            List<reminder> resultList = new List<reminder>();
            reminder blankReminder = new reminder();
            blankReminder.department_id = pDepartmentId;
            blankReminder.section_id = sectionId;
            section sec = new section();
            sec.section_id = sectionId;
            sec.client_id = clientId;
            blankReminder.section = sec;
            blankReminder.reminder1 = "____";

            resultList.Add(blankReminder);
            reminders = resultList.AsQueryable();
        }






        e.Result = reminders;

    }


}

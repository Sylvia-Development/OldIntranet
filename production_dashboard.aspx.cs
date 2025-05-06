using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class production_dashboard : System.Web.UI.Page
{

    IntranetDataDataContext db = null;
    Dictionary<int, IEnumerable<section>> depart0sections = new Dictionary<int, IEnumerable<section>>();
    Dictionary<int, IEnumerable<section>> depart1sections = new Dictionary<int, IEnumerable<section>>();
    Dictionary<int, IEnumerable<section>> depart2sections = new Dictionary<int, IEnumerable<section>>();
    IEnumerable<section> section = null;

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Page_Init(object sender, EventArgs e)
    {
        db = new IntranetDataDataContext();
    }

    protected void StatusDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {
       

        var status = from s in db.status
                     where s.department_id == 1
                     orderby s.display_order
                     select s;


        foreach (status s in status)
        {
            
                depart1sections.Add(s.status_id, s.sections1);
                depart1sections[s.status_id] = depart1sections[s.status_id].Where(p => p.active_status == 1 && p.in_ops_dept == 1);
           


        }

        e.Result = status;

    }
    protected void SectionDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {
        
        int statusId = -1;
        

        try
        {
            
            statusId = Int32.Parse(e.SelectParameters["statusId"].ToString());
            
        }
        catch (Exception ex) { }

        
            e.Result = depart1sections[statusId].OrderBy(p => p.client.job_name);
        
    }
    protected void ContactDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {
        int pDepartmentId = -1;
        int sectionId = -1;
        int statusId = -1;


        try
        {
            pDepartmentId = Int32.Parse(Page.Request.QueryString["pDepartmentId"]);
            sectionId = Int32.Parse(e.SelectParameters["sectionId"].ToString());
            statusId = Int32.Parse(e.SelectParameters["statusId"].ToString());

        }
        catch (Exception ex) { }


        if (pDepartmentId == 0)
        {
            section = (depart0sections[statusId].Where(p => p.section_id == sectionId));
        }
        else if (pDepartmentId == 1)
        {
            section = (depart1sections[statusId].Where(p => p.section_id == sectionId));
        }
        else if (pDepartmentId == 2)
        {
            section = (depart2sections[statusId].Where(p => p.section_id == sectionId));
        }



        IEnumerable<reminder> reminders = section.First<section>().reminders;

        reminders = (reminders.Where(r => r.reminder_status == 0 && r.type == 0 && r.department_id == pDepartmentId).OrderBy(r => r.reminder_order)).Take(1);

        int count = 0;
        foreach (reminder r in reminders)
        {
            count++;
        }

        if (reminders.Count() == 0)
        {

            List<reminder> resultList = new List<reminder>();
            reminder blankReminder = new reminder();
            blankReminder.department_id = pDepartmentId;
            blankReminder.section_id = sectionId;
            section sec = new section();
            sec.section_id = sectionId;
            sec.client_id = section.First<section>().client_id;
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
        int statusId = -1;
        //IEnumerable<section> section = null;

        try
        {
            pDepartmentId = Int32.Parse(Page.Request.QueryString["pDepartmentId"]);
            sectionId = Int32.Parse(e.SelectParameters["sectionId"].ToString());
            statusId = Int32.Parse(e.SelectParameters["statusId"].ToString());
        }
        catch (Exception ex) { }

        /*if (pDepartmentId == 0)
        {
            section = (depart0sections[statusId].Where(p => p.section_id == sectionId));
        }
        else if (pDepartmentId == 1)
        {
            section = (depart1sections[statusId].Where(p => p.section_id == sectionId));
        }
        else if (pDepartmentId == 2)
        {
            section = (depart2sections[statusId].Where(p => p.section_id == sectionId));
        }*/



        IEnumerable<reminder> reminders = section.First<section>().reminders;

        reminders = (reminders.Where(r => r.reminder_status == 0 && r.type == 1 && r.department_id == pDepartmentId).OrderBy(r => r.reminder_order)).Take(1);


        int count = 0;
        foreach (reminder r in reminders)
        {
            count++;
        }

        if (reminders.Count() == 0)
        {


            List<reminder> resultList = new List<reminder>();
            reminder blankReminder = new reminder();
            blankReminder.department_id = pDepartmentId;
            blankReminder.section_id = sectionId;
            section sec = new section();
            sec.section_id = sectionId;
            sec.client_id = section.First<section>().client_id;
            blankReminder.section = sec;
            blankReminder.reminder1 = "____";

            resultList.Add(blankReminder);
            reminders = resultList.AsQueryable();
        }


        e.Result = reminders;

    }

    protected void NoSectionDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {




        var clients = from c in db.clients
                      where c.sections.Count == 0
                      orderby c.job_name
                      select c;





        e.Result = clients;

    }

    protected void CommunicationDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {


        int pClientId = -1;
        int pDepartmentId = -1;
        int sectionId = -1;
        int statusId = -1;


        try
        {
            pClientId = Int32.Parse(e.SelectParameters["clientId"].ToString());
            pDepartmentId = Int32.Parse(Page.Request.QueryString["pDepartmentId"]);
            sectionId = Int32.Parse(e.SelectParameters["sectionId"].ToString());
            statusId = Int32.Parse(e.SelectParameters["statusId"].ToString());

        }
        catch (Exception ex) { }


        /* if (pDepartmentId == 0)
         {
             section = (depart0sections[statusId].Where(p => p.section_id == sectionId));
         }
         else if (pDepartmentId == 1)
         {
             section = (depart1sections[statusId].Where(p => p.section_id == sectionId));
         }
         else if (pDepartmentId == 2)
         {
             section = (depart2sections[statusId].Where(p => p.section_id == sectionId));
         }*/



        IEnumerable<communication> notes = section.First<section>().client.communications;

        notes = notes.OrderBy(n => n.date);





        /* var communications = from c in db.communications
                              where c.client_id == pClientId

                              orderby c.date descending
                              select c;*/



        e.Result = notes;
    }

    protected void communication_ItemInserting(object sender, ListViewInsertEventArgs e)
    {
        e.Values["client_id"] = Page.Request.QueryString["pClientId"];
        e.Values["date"] = DateTime.Now.ToString();
        e.Values["user_name"] = User.Identity.Name;




    }
}

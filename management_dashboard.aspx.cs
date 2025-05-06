using System;
using System.Collections.Generic;
using System.Collections;
using System.Data.Linq;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;

public partial class management_dashboard : System.Web.UI.Page
{

    
    IntranetDataDataContext db = null;
    Dictionary<int,IEnumerable<section>> depart0sections = new Dictionary<int,IEnumerable<section>>();
    Dictionary<int, IEnumerable<section>> depart1sections = new Dictionary<int,IEnumerable<section>>();
    Dictionary<int, IEnumerable<section>> depart2sections = new Dictionary<int,IEnumerable<section>>();
    Dictionary<int, IEnumerable<section>> depart3sections = new Dictionary<int, IEnumerable<section>>();
    Dictionary<int, IEnumerable<section>> depart4sections = new Dictionary<int, IEnumerable<section>>();
    IEnumerable<section> section = null;
    IEnumerable<status> statuses = null;

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Page_Init(object sender, EventArgs e)
    {
        db = new IntranetDataDataContext();
    }

   [WebMethod]
    public static string changeStatus(int pSectionId, int pNewStatusId, int pDepatmentId)
    {

        IntranetDataDataContext db2 = new IntranetDataDataContext();
        var recordToUpdate = (from s in db2.sections
                              where s.section_id == pSectionId
                              select s).Single();

        if (pDepatmentId == 0)
        {
            recordToUpdate.quote_status_id = pNewStatusId;
        }
        else if (pDepatmentId == 2)
        {

            recordToUpdate.production_status_id = pNewStatusId;
        }
        else if (pDepatmentId == 4)
        {
            recordToUpdate.service_call_status_id = pNewStatusId;

        }
        try
        {
            db2.SubmitChanges();
        }
        catch (Exception e)
        {
            return e.Message;
        }

        return "ok";
       
    }
   public string getSelectedValue(Object pQuoteStatusId, Object pProductionStatusId, Object pServiceStatusId)
   {
       string selectedValue = "";
       int pDepartmentId = -1;

       try
       {
           pDepartmentId = Int32.Parse(Page.Request.QueryString["pDepartmentId"]);

       }
       catch (Exception ex) { }

       if (pDepartmentId == 0)
       {
           selectedValue =  pQuoteStatusId.ToString();
       }else if (pDepartmentId == 2 || pDepartmentId==10)
       {
           selectedValue = pProductionStatusId.ToString();
       }
       else if (pDepartmentId == 4)
       {
           selectedValue = pServiceStatusId.ToString();
       }




       return selectedValue;

   }

   protected void status_change_selecting(object sender, LinqDataSourceSelectEventArgs e)
   {

       if (statuses == null)
       {
           int pDepartmentId = -1;

           try
           {
               pDepartmentId = Int32.Parse(Page.Request.QueryString["pDepartmentId"]);

           }
           catch (Exception ex) { }

           //code to make all the ops dept. section use the the ops dept. statuses
           int sectionStatusDeptId = -1;
           if (pDepartmentId != -1 && pDepartmentId != 0 && pDepartmentId != 4)//check that the department is not quotes or service calls
           {
               sectionStatusDeptId = 1;
           }
           else
           {
               sectionStatusDeptId = pDepartmentId;
           }

           statuses = from s in db.status
                      where s.department_id == sectionStatusDeptId
                      orderby s.display_order
                      select s;
       }
       e.Result = statuses;
   }

    protected void StatusDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {
        int pDepartmentId = -1;
        string pSectionFilter = "";
        
        try
        {
            pDepartmentId = Int32.Parse(Page.Request.QueryString["pDepartmentId"]);
            pSectionFilter = Page.Request.QueryString["pSectionFilter"];
            
        }
        catch (Exception ex) { }

        //code to make all the ops dept. section use the the ops dept. statuses
        int sectionStatusDeptId = -1;
        if (pDepartmentId != -1 && pDepartmentId != 0 && pDepartmentId != 4)//check that the department is not quotes or service calls
        {
            sectionStatusDeptId = 1;
        }
        else
        {
            sectionStatusDeptId = pDepartmentId;
        }



        IOrderedQueryable status = null;
        if (pDepartmentId == 0) //quotes
        {
            if(pSectionFilter.Equals("maincrm")){
                status = from s in db.status
                         where s.department_id == sectionStatusDeptId && s.status_name != "Marketing Management" 
                                                                            && s.status_name != "Completed Projects" 
                         orderby s.display_order
                         select s;
            }else if(pSectionFilter.Equals("marketing")){
                status = from s in db.status
                         where s.department_id == sectionStatusDeptId && s.status_name == "Marketing Management"                                                   
                         orderby s.display_order
                         select s;

            }else if(pSectionFilter.Equals("completed")){
                status = from s in db.status
                         where s.department_id == sectionStatusDeptId && s.status_name == "Completed Projects"
                         orderby s.display_order
                         select s;
            }
        }
        else if (pDepartmentId == 2 || pDepartmentId == 1 || pDepartmentId == 10)// projects, production & finance and admin
        {
            if (pSectionFilter.Equals("maincrm"))
            {

                status = from s in db.status
                         where s.department_id == sectionStatusDeptId && s.status_name != "Completed Projects"
                         orderby s.display_order
                         select s;

            }
            else if (pSectionFilter.Equals("completed"))
            {
                status = from s in db.status
                         where s.department_id == sectionStatusDeptId && s.status_name == "Completed Projects"
                         orderby s.display_order
                         select s;
            }
        }
        else if (pDepartmentId == 4)// service calls
        {
            if (pSectionFilter.Equals("maincrm"))
            {
                status = from s in db.status
                         where s.department_id == sectionStatusDeptId && s.status_name != "Service Calls Complete"
                         orderby s.display_order
                         select s;
            }
            else if (pSectionFilter.Equals("completed"))
            {
                status = from s in db.status
                         where s.department_id == sectionStatusDeptId && s.status_name == "Service Calls Complete"
                         orderby s.display_order
                         select s;
            }
        }
        else
        {
            status = from s in db.status
                     where s.department_id == sectionStatusDeptId
                     orderby s.display_order
                     select s;
        }
          


        foreach (status s in status){
            if(pDepartmentId == 0){

               
                 depart0sections.Add(s.status_id,s.sections);
                 depart0sections[s.status_id] = depart0sections[s.status_id].Where(p => p.active_status == 1);
            }
            else if (pDepartmentId == 1)
            {
                depart1sections.Add(s.status_id, s.sections1);
                depart1sections[s.status_id] = depart1sections[s.status_id].Where(p => p.active_status == 1 && p.in_ops_dept == 1);
            }
            else if (pDepartmentId == 2 || pDepartmentId == 10)
            {
                depart2sections.Add(s.status_id, s.sections1);
                depart2sections[s.status_id] = depart2sections[s.status_id].Where(p => p.active_status == 1 && p.in_ops_dept == 1);
            }
            else if (pDepartmentId == 3)
            {
                depart3sections.Add(s.status_id, s.sections1);
                depart3sections[s.status_id] = depart3sections[s.status_id].Where(p => p.active_status == 1 && p.in_ops_dept == 1);
            }
            else if (pDepartmentId == 4)
            {
                depart4sections.Add(s.status_id, s.sections4);
                depart4sections[s.status_id] = depart4sections[s.status_id].Where(p => p.active_status == 1 && p.in_ops_dept == 1);
            }


        }

        e.Result = status;
        
    }
    protected void SectionDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {
        int pDepartmentId = -1;
        int statusId = -1;
        String userName = null;
        String seeAll = null;
        String scUserName = null;

        try
        {
             
            pDepartmentId = Int32.Parse(Page.Request.QueryString["pDepartmentId"]);
            statusId = Int32.Parse(e.SelectParameters["statusId"].ToString());
            userName = Page.Request.QueryString["pUserName"];
            scUserName = Page.Request.QueryString["pSCUserName"];
            seeAll = Page.Request.QueryString["pSeeAll"];
        }
        catch (Exception ex) { }

        if (pDepartmentId == 0)
        {
   

            if ((userName == null || userName.Length == 0)&& (seeAll== null || seeAll.Length ==0    )  )
            // check if the logged in user is a design consultant            
            {
                if (Context.User.IsInRole("Design Consultant") && !Context.User.Identity.Name.ToLower().Equals("craig"))
                {
                    userName = Context.User.Identity.Name.Trim();
                }
            
            }
 
            
            if (userName != null && userName.Length > 0)
            {
                depart0sections[statusId] = depart0sections[statusId].Where(p => (p.client.consultant_name == userName || p.client.consultant_name == ""));
            }

            e.Result = depart0sections[statusId].OrderBy(p => p.client.consultant_name).ThenBy(p => p.client.job_name);
        }else if (pDepartmentId == 1)
        {
            e.Result = depart1sections[statusId].OrderBy(p => p.client.job_name);
        }else if (pDepartmentId == 2 || pDepartmentId==10)
        {
            if (scUserName != null && scUserName.Trim().Length > 0) {
                depart2sections[statusId] = depart2sections[statusId].Where(p => (p.client.site_coordinator_name == scUserName || p.client.site_coordinator_name == ""));

            }
           e.Result = depart2sections[statusId].OrderBy(p => p.client.job_name); 
        }
        else if (pDepartmentId == 3)
        {
            e.Result = depart3sections[statusId].OrderBy(p => p.client.job_name);
        }
        else if (pDepartmentId == 4)
        {
            e.Result = depart4sections[statusId].OrderBy(p => p.client.job_name);
        }
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
        else if (pDepartmentId == 2 || pDepartmentId==10)
        {
            section = (depart2sections[statusId].Where(p => p.section_id == sectionId));
        }
        else if (pDepartmentId == 3)
        {
            section = (depart3sections[statusId].Where(p => p.section_id == sectionId));
        }
        else if (pDepartmentId == 4)
        {
            section = (depart4sections[statusId].Where(p => p.section_id == sectionId));
        }



      IEnumerable<reminder> reminders = section.First<section>().reminders;
        //get next reminder with a date set
      reminders = (reminders.Where(r =>r.reminder_due_date != null && r.reminder_status == 0 && r.type == 0 && r.department_id == pDepartmentId).OrderBy (r => r.reminder_due_date)).Take(1);
        //if we have no reminders with date set then sort by reminder order
      if (reminders.Count() == 0)
      {
          reminders = section.First<section>().reminders;
          reminders = (reminders.Where(r => r.reminder_status == 0 && r.type == 0 && r.department_id == pDepartmentId).OrderBy(r => r.reminder_order)).Take(1);


      }
        //if we really dont have any reminders then create a blank

        if (reminders.Count()==0)
        {

            List<reminder> resultList = new List<reminder>();
            reminder blankReminder = new reminder();
            blankReminder.department_id = pDepartmentId;
            blankReminder.section_id = sectionId;
            section sec = new section();
            sec.section_id = sectionId;
            sec.client_id = section.First<section>().client_id;
            blankReminder.section = sec;
            blankReminder.reminder1 = "_";


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
    protected void NoConsultantDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {


        var clients = from c in db.clients
                      where c.consultant_name == ""
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

    protected void communication_ItemInserted(object sender, ListViewInsertedEventArgs e)
    {

        /*String activityMessage = e.Values["user_name"] + " Logged a new note for " + clientNameLabel.Text + " : " + e.Values["message"];



        ActivityLog activityLog = new ActivityLog();
        activityLog.logActivity(Int32.Parse(Page.Request.QueryString["pClientId"]), Int32.Parse(Page.Request.QueryString["pSectionId"]), "Notes", activityMessage, User.Identity.Name);

*/





    }

    public string getSnagListCount(object pSectionIdObject)
    {
        
        int pSectionId = -1;
        if (pSectionIdObject != null)
        {
            pSectionId = (int)pSectionIdObject;
        }
        

        string count = getSnagCount(pSectionId);

        if(count == null || count.Equals("0"))
        {
            count = "";

        }
        else
        {

            count = "  (" + count + ")  ";
        }

        return count;
    }

    private string getSnagCount(int pSectionId)
    {

   

        int initialCount = db.wall_checklist_items.Count(r => (r.wall.section_id == pSectionId
                                                        && r.item_relevant_to_wall == true
                                                        && r.item_type == 0
                                                        && (r.completed == null || r.completed == false)));
        /*int finishingCount = db.wall_checklist_items.Count(r => (r.wall.section_id == pSectionId
                                                        && r.item_relevant_to_wall == true
                                                        && r.item_type == 1
                                                        && (r.completed == null || r.completed == false)));*/

        return initialCount.ToString();

    }










}

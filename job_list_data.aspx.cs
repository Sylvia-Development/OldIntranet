using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using System.Web.Services;
using System.Web.Security;




public partial class job_list_data : System.Web.UI.Page
{
    IntranetDataDataContext db = null;

    protected void Page_Init(object sender, EventArgs e)
    {
        db = new IntranetDataDataContext();
    }
    
    protected void Page_Load(object sender, EventArgs e)
    {

        if (IsPostBack)
        {
            ListView view = (ListView)LoginView2.FindControl("SnagListListView");
            view.DataBind();
        }

    }

   
   
//AJAX WEBMETHOD STARTS
    
    [WebMethod]
    public static string snagCompleted(int pSnagItemId, String pUser)
    {
        IntranetDataDataContext db2 = new IntranetDataDataContext();
        var recordToUpdate = (from b in db2.job_list_items
                              where b.id == pSnagItemId
                              select b).Single();
        
        recordToUpdate.date_completed = DateTime.Now;
        recordToUpdate.user_completed = pUser;
        recordToUpdate.item_completed = true;


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

    [WebMethod]
    public static string undoCompletedSnag(int pSnagItemId, String pUser)
    {
        IntranetDataDataContext db2 = new IntranetDataDataContext();
        var recordToUpdate = (from b in db2.job_list_items
                              where b.id == pSnagItemId
                              select b).Single();

        recordToUpdate.date_completed = null;
        recordToUpdate.user_completed = null;
        recordToUpdate.item_completed = false;


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

//AJAX WEBMETHOD ENDS

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

    public bool GetAllowedToUpdate()
    {
        if (Context.User.IsInRole("Director") || Context.User.IsInRole("Processing Manager"))
        {
            return true;
        }
        else
        {
            return false;
        }
    }

   /* public string GetExpectedDate(Object pExpectedDateObject, Object pSupplierLeadTimeObject, Object pDaysNeededToProcessObject)
    {
        DateTime pExpectedDate = new DateTime();
        int pSupplierLeadTime = 0;
        int pDaysNeededToProcess = 0;

        try
        {
            pExpectedDate = (DateTime)pExpectedDateObject;
            pSupplierLeadTime = Convert.ToInt32(pSupplierLeadTimeObject);
            pDaysNeededToProcess = Convert.ToInt32(pDaysNeededToProcessObject);
        }
        catch (Exception e)
        {
            return "----";
        }

        DateHandler dateHandler = new DateHandler();
        try
        {
            DateTime dateToOrderBy = dateHandler.addWorkDays(pExpectedDate, (pSupplierLeadTime + pDaysNeededToProcess + 1) * -1, 2);
            return dateToOrderBy.ToString("ddd, d MMM, yyyy");

        }
        catch (Exception e)
        {

            return "-----";
        }


    }*/


    public bool GetCompletedAllowedToUpdate(object pUserRoleObject)
    {
        bool result = false;
        string pUserRole="";
        if (pUserRoleObject != null)
        {
            pUserRole = pUserRoleObject.ToString();
        }
        else
        {
            return true;
        }

        
        
        if (Context.User.IsInRole("Processing Manager"))
        {

            if (pUserRole.Equals("Processing Manager") || pUserRole.Equals("Processing Assistant") )
            {
              result = true;
            }

        }
        else if (Context.User.IsInRole("Site Manager") || Context.User.IsInRole("Installer") || Context.User.IsInRole("Project Manager"))
            {
                if (pUserRole.Equals("Site Manager") || pUserRole.Equals("Installer") || pUserRole.Equals("Project Manager") || pUserRole.Equals("Director") || pUserRole.Equals(""))
                {
                  result = true;
                }
            }
        else if (Context.User.IsInRole("Director"))
        {
            result = true;
        }

        return result;
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
                      && (j.is_snag_list_item == null ||  j.is_snag_list_item == false)
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
                             && (j.is_snag_list_item == null || j.is_snag_list_item == false)
                             && (j.item_completed == true || j.default_item_na == true)

                             orderby j.date_completed  descending
                             select j;





        e.Result = job_list_items;

    }




    protected void snaglist_items_DataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {

        int pSectionId = -1;

        String sectionID = Page.Request.QueryString["pSectionId"];
        if (sectionID != null)
        {
            pSectionId = Int32.Parse(sectionID);
        }


        var job_list_items = from j in db.job_list_items
                             where j.section_id == pSectionId
                             && j.is_snag_list_item == true
                             orderby j.item_completed, j.date_logged descending
                             select j;





        e.Result = job_list_items;

    }

    
         
         

    


    private string getUserRole()
    {
        //this is a hack method - must look into it when have time
        
        string userRole = "";

        if (Context.User.IsInRole("Site Manager"))
        {
            userRole = "Site Manager";

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
    protected void joblist_items_ItemInserting(object sender, ListViewInsertEventArgs e)
    {
        e.Values["department_id"] = Page.Request.QueryString["pDepartmentId"];
        e.Values["section_id"] = Page.Request.QueryString["pSectionId"];
        e.Values["date_logged"] = DateTime.Now.ToString();
        e.Values["user_logged"] = User.Identity.Name;
        e.Values["user_role"] = getUserRole();
        e.Values["is_main_material_order"] = false;
        e.Values["default_item_na"] = false;
        e.Values["is_waste"] = false;
        


    }
    protected void joblist_items_ItemInserted(object sender, ListViewInsertedEventArgs e)
    {

        string jobName = getClientSectionName(Int32.Parse(e.Values["section_id"].ToString()));

        String activityMessage = e.Values["user_logged"] + " added an item to the Job List for " + jobName + " : " + e.Values["description"];

        sendJobListMailNotofication("Job List item added for " + jobName, activityMessage,"joblist");

        


       ListView view = (ListView) LoginView2.FindControl("JoblistItemsListView");
       view.DataBind();  

    }

    protected void snaglist_items_ItemInserting(object sender, ListViewInsertEventArgs e)
    {
        e.Values["department_id"] = Page.Request.QueryString["pDepartmentId"];
        e.Values["section_id"] = Page.Request.QueryString["pSectionId"];
        e.Values["date_logged"] = DateTime.Now.ToString();
        e.Values["user_logged"] = User.Identity.Name;
        e.Values["user_role"] = getUserRole();
        e.Values["is_snag_list_item"] = true;


    }
    protected void snaglist_items_ItemInserted(object sender, ListViewInsertedEventArgs e)
    {

        string jobName = getClientSectionName(Int32.Parse(e.Values["section_id"].ToString()));

        String activityMessage = e.Values["user_logged"] + " added an item to the Snag List for " + jobName + " : " + e.Values["description"];

        sendJobListMailNotofication("Snag List item added for " + jobName, activityMessage,"snag");




        ListView view = (ListView)LoginView2.FindControl("SnagListListView");
        view.DataBind();

    }

    private void sendJobListMailNotofication(string pSubject, string pMessageBody, string pType)
    {
        ArrayList addressToList = new ArrayList();
        addressToList.Add("graham");
        addressToList.Add("quinton");
        if (pType != null && pType.Equals("snag"))   
        {
            addressToList.Add("brett");
            addressToList.Add("quinton");
            addressToList.Add("carron");

        }
        
        
    
        //remove the person that is logging the note
        try
        {
            addressToList.Remove(User.Identity.Name.Trim().ToLower());
        }
        catch (Exception e)
        {
            //in case we trying to remove a user that is not in the list
        }

        //build the toAddress
        String toAddress = "";
        int count = 0;
        foreach (string i in addressToList)
        {
            if (count > 0) { toAddress = toAddress + ","; }
            toAddress = toAddress + i + "@blu-line.co.za";
            count++;
        }

        if (count > 0)
        {
            EmailSender emailSender = new EmailSender();
            emailSender.setToAddresses(toAddress);
            emailSender.setSubject(pSubject);
            emailSender.setBody(pMessageBody);
            emailSender.sendEmail();
        }


    }


    private string getClientSectionName(int pSectionId)
    {
        

        var section = (from s in db.sections
                    where s.section_id == pSectionId
                               select s).Single();



        return section.client.job_name +" - "+section.section_name;

    }
    protected void joblist_items_ItemUpdating(object sender,ListViewUpdateEventArgs e)
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



        ListView view = (ListView)LoginView2.FindControl("CompletedListView");
        view.DataBind();

    }

    


    protected void snaglist_items_ItemUpdating(object sender, ListViewUpdateEventArgs e)
    {


        if (((Boolean)e.OldValues["item_completed"]) == false && ((Boolean)e.NewValues["item_completed"]) == true)
        {


            e.NewValues["date_completed"] = DateTime.Now.ToString();
            e.NewValues["user_completed"] = Context.User.Identity.Name;

        }


    }
    protected void snaglist_items_ItemUpdated(object sender, ListViewUpdatedEventArgs e)
    {
       

    }

    public static bool GetVisible(object pStatusObject,string pButtonType)
    {
        bool status = false;
        if (pStatusObject != null)
        {
            status = (bool)pStatusObject;
        }

        if (status== true && pButtonType.Equals("snag"))
        {
            return false;
        }
        else if (status == false && pButtonType.Equals("snag")) 
        {
            return true;
        
        }
        else if(status== true && pButtonType.Equals("undo"))
        {
            return true;
        }
        else if (status == false && pButtonType.Equals("undo"))
        {
            return false;
        }
        else
        {
            return false;
        }
    }

}
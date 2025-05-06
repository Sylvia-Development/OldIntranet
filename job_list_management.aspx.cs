using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;

public partial class job_list_management : System.Web.UI.Page
{
    IntranetDataDataContext db = null;
    

    protected void Page_Init(object sender, EventArgs e)
    {
        db = new IntranetDataDataContext();
        
    }
    
    protected void Page_Load(object sender, EventArgs e)
    {

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

    public string GetRowToBeProcessedColour(Object pExpectedDateObject)
    {
        DateTime pExpectedDate = new DateTime();
        if (pExpectedDateObject != null)
        {
            pExpectedDate = (DateTime)pExpectedDateObject;
        }
        else
        {
            return "#DC143C";
        }
        
        DateHandler dateHandler = new DateHandler();
        try
        {
        int netWorkDays = dateHandler.netWorkingDays(DateTime.Now, pExpectedDate, 2, true);

            
            if (netWorkDays <= 1)
            {
                return "#DC143C";
            }
            else if (netWorkDays >= 2 && netWorkDays <= 4)
            {
                return "#FE9A2E";
            }
            else 
            {
                return "#008080";
            }
        }
        catch (Exception e)
        {
           // this means that the expected date is older than current date
            return "#DC143C";
        }
        

    }

    

    public static string GetImage(object statusObject)
    {
        bool status = false;
        if (statusObject != null)
            status = (bool)statusObject;
        
        if (status)
        {
            return "images/yes_green.png";
        }
        else
        {
            return "images/no_red.png";
        }
    }

    public bool GetTimeImage(object pLoggedDateObject,object pExpectedDateObject)
    {
        bool result = false;
        DateTime pLoggedDate = new DateTime();
        DateTime pExpectedDate = new DateTime();
        DateHandler dateHandler = new DateHandler();
        if (pLoggedDateObject != null && pExpectedDateObject != null)
        {
            pLoggedDate = (DateTime)pLoggedDateObject;
            pExpectedDate = (DateTime)pExpectedDateObject;
            int netWorkDays = dateHandler.netWorkingDays(pLoggedDate, pExpectedDate, 2, false);
            if (netWorkDays > 4)
            {
                result = true;
            }


        }

        return result;



    }




    public string getClientAndSection(int pSectionId)
    {
        

        var section = (from s in db.sections
                    where s.section_id == pSectionId
                               select s).Single();



        return section.client.job_name +" - "+section.section_name;

    }

    protected void to_be_ordered_DataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {

       


        var job_list_items = from j in db.job_list_items
                             where //j.item_completed == false
                             (j.is_snag_list_item == null || j.is_snag_list_item == false)
                           
                             orderby j.section.client.job_name,j.section_id
                             select j;

        foreach(job_list_item j in job_list_items){
            if (j.order_needs_processing == null)
                j.order_needs_processing = false;
            if (j.production_assistant_to_order == null)
                j.production_assistant_to_order = false;
            if (j.order_confirmed == null)
                j.order_confirmed = false;
            if (j.manager_has_processed_order == null)
                j.manager_has_processed_order = false;
            if (j.is_main_material_order == null)
                j.is_main_material_order = false;
            if (j.is_general_task == null)
                j.is_general_task = false;
            if (j.material_ordered == null)
                j.material_ordered = false;
            if (j.material_delivered == null)
                j.material_delivered = false;
            if (j.material_processed == null)
                j.material_processed = false;
           

        }



        e.Result = job_list_items;

    }

   


    protected void to_be_ordered_ItemUpdating(object sender, ListViewUpdateEventArgs e)
    {
        
      

     
    }
    protected void to_be_ordered_ItemUpdated(object sender, ListViewUpdatedEventArgs e)
    {
        
        
        
    }

    
  
    private string getClientSectionName(int pSectionId)
    {


        var section = (from s in db.sections
                       where s.section_id == pSectionId
                       select s).Single();



        return section.client.job_name + " - " + section.section_name;

    }

   


}
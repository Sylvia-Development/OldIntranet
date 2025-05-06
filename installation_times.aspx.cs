using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class installation_times : System.Web.UI.Page
{
    IntranetDataDataContext db = null;

    protected void Page_Init(object sender, EventArgs e)
    {
        db = new IntranetDataDataContext();
    }

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void measureTimeDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {
        

        String pShowLast = Page.Request.QueryString["pShowLast"];

        if (pShowLast == null || pShowLast.Length <= 0)
        {
            pShowLast = "false";
        }

        

        IQueryable<job_time> job_times = null;

        if (pShowLast.Equals("true"))
        {
            
                job_times = from j in db.job_times
                             where  j.dept_id == 2
                             && j.section.active_status == 1
                             && j.section.in_ops_dept == 1
                             && (j.started_date != null && j.completed_date != null)
                             orderby j.completed_date descending, j.section.client.job_name
                             select j;


                e.Result = job_times;
        }
        else 
        {

          
            job_times = from j in db.job_times
                        where
                           j.dept_id == 2
                        && j.section.active_status == 1
                        && j.section.in_ops_dept == 1
                        && (j.started_date == null || j.completed_date == null)
                        select j;

            e.Result = job_times.AsEnumerable().OrderBy(i => i, new ItemComparer()).ThenBy(p => p.section.client.job_name); ;
        }

        

    }
    private class ItemComparer : IComparer<job_time>
    {
        DateHandler dateHandler = new DateHandler();
        Utils util = new Utils();


        public int Compare(job_time x, job_time y)
        {
            int remainingDaysX = 1000000;// a bit of a hack value for sorting , 0 created a gap between negative and positive numbers
            int remainingDaysY = 1000000;

            if (x.started_date != null && x.section.quote_value != null)
            {
                int allocatedDays = util.getAllocatedInstallationDays((Decimal)x.section.quote_value);
                int netDays = dateHandler.netWorkingDays((DateTime)x.started_date, DateTime.Now, 2, false);
                remainingDaysX = allocatedDays - netDays;

            }
            if (y.started_date != null && y.section.quote_value != null)
            {
                int allocatedDays = util.getAllocatedInstallationDays((Decimal)y.section.quote_value);
                int netDays = dateHandler.netWorkingDays((DateTime)y.started_date, DateTime.Now, 2, false);
                remainingDaysY = allocatedDays - netDays;

            }

            
            return remainingDaysX.CompareTo(remainingDaysY);


        }
    }

    protected String GetInstallationTime(object pQuoteValue)
    {


        Utils util = new Utils();

        return (util.getAllocatedInstallationDays((Decimal)pQuoteValue)).ToString();

    }          
    protected String GetElapsedTime(object pStartDate)
    {
        string result = "";
        if (pStartDate != null)
        {
            DateHandler dateHandler = new DateHandler();
            DateTime startDate = (DateTime)pStartDate;
            int netDays = dateHandler.netWorkingDays(startDate, DateTime.Now, 2, false);
            result = netDays.ToString();
        }

        return result;
    }
    protected String GetRemainingTime(object pStartDate, object pQuoteValue)
    {
        string result = "";
        if (pStartDate != null && pQuoteValue != null)
        {
            DateHandler dateHandler = new DateHandler();
            Utils util = new Utils();

            int allocatedDays = util.getAllocatedInstallationDays((Decimal)pQuoteValue);
            int netDays = dateHandler.netWorkingDays((DateTime)pStartDate, DateTime.Now, 2, false);
            int remainingDays = allocatedDays - netDays;
            result = remainingDays.ToString(); 

        }

        return result;
    }
    protected String GetSiteOrders(object pSection)
    {
        string result = "";
        if (pSection != null)
        {
            section thisSection = (section)pSection;

            
            
            int listCount = thisSection.job_list_items.Count(i => i.item_completed == false && i.default_item_na == false && i.production_assistant_to_order == false);//i.production_assistant_to_order == false filters out the stock orders
            result = listCount.ToString();
        }


        return result;
    }
    protected String GetChecklists(object pSection)
    {
        string result = "";
        if (pSection != null)
        {
            section thisSection = (section)pSection;
            int count = 0;
            foreach (wall w in thisSection.walls)
            {
                count += w.wall_checklist_items.Count(i => (i.completed == false || i.completed == null) && i.item_relevant_to_wall == true && i.item_type == 0);


            }
            
            result = count.ToString();
        }


        return result;
    }

    public string GetRowColour(object pStartDate, object pQuoteValue)
    {
        DateTime startDate = new DateTime();
        Decimal quoteValue = new Decimal();
        string result = "transparentRow";

        try
        {
            startDate = (DateTime)pStartDate;
            quoteValue = (Decimal)pQuoteValue;

        }
        catch (Exception e)
        {
            return "transparentRow";
        }

        DateHandler dateHandler = new DateHandler();
        Utils util = new Utils();

        int targetLeadTime = util.getAllocatedInstallationDays((Decimal)pQuoteValue);
        int leadTime = dateHandler.netWorkingDays((DateTime)pStartDate, DateTime.Now, 2, false);
        


        if (leadTime <= targetLeadTime + 5)// add buffer as per performance bonus system
            result = "greenRow";
        else if ((leadTime >= targetLeadTime + 6) && (leadTime <= targetLeadTime + 10))// 75% bonus
            result = "blueRow";
        else if ((leadTime >= targetLeadTime + 11) && (leadTime <= targetLeadTime + 15))// 50% bonus
            result = "purpleRow";
        else if ((leadTime >= targetLeadTime + 16) && (leadTime <= targetLeadTime + 20))// 25% bonus
            result = "amberRow";
        else if (leadTime >= targetLeadTime + 21) // 0% bonus
            result = "redRow";


        return result;

    }
    public string getEditEnabled(object pSection, object pStartDate,object pEndDate)
    {
        //commented out the logic to enable to close the jobs 
        
        /*if (User.IsInRole("Director"))
        {
            return "visible";

        }
        

        if (pStartDate == null && ((section)pSection).installation_team == null) // means the job hasnt started and no installation team has been setup
            return "hidden";


        if (pStartDate == null || pEndDate != null)
            return "visible";// means the job has not started yet or it is already finished

        if (pSection != null)
        {
            section thisSection = (section)pSection;

            int listCount = thisSection.job_list_items.Count(i => i.item_completed == false && i.default_item_na == false && i.production_assistant_to_order == false);

            if (listCount != 0)
                return "hidden";

            int count = 0;
            foreach (wall w in thisSection.walls)
            {
                count += w.wall_checklist_items.Count(i => (i.completed == false || i.completed == null) && i.item_relevant_to_wall == true && i.item_type == 0);
            }

            if (count != 0)
                return "hidden";



        }*/
        return "visible";
    }

}
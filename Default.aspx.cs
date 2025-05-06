using System;
using System.Collections.Generic;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    IntranetDataDataContext db = new IntranetDataDataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Context.User.IsInRole("Design Consultant"))
       {
            Response.Redirect("dc_dashboard.aspx");
        }
        else if (Context.User.IsInRole("Director"))
		{
            Response.Redirect("dir_dashboard.aspx");
        }
        else if (Context.User.IsInRole("Site Coordinator"))
        {
            Response.Redirect("sc_dashboard.aspx");
        }
  //       else
		//{
		//	Response.Redirect("Default3.aspx");
		//}

	}
}







































 //   IntranetDataDataContext db = null;
 //   DateHandler dateHandler = null;
 //   Hashtable globalStatsHashtable = new Hashtable();
 //   Dictionary<string, string> remunerationOption = new Dictionary<string, string>(); // must change this one day to be in the database
 //   Dictionary<int, int> monthsRemainingInFinacialYear = new Dictionary<int, int>(); 

	

 //   protected void Page_Init(object sender, EventArgs e)
 //   {
 //       db = new IntranetDataDataContext();
 //       dateHandler = new DateHandler();
 //       // must change this one day to be in the database

 //       remunerationOption.Add("shaun", "Option2");
 //       remunerationOption.Add("reino", "Option2");

 //       //How many months are remaining in finacial year if the current month is ....
 //       monthsRemainingInFinacialYear.Add(3, 12); // March
 //       monthsRemainingInFinacialYear.Add(4, 11); // April
 //       monthsRemainingInFinacialYear.Add(5, 10); // May
 //       monthsRemainingInFinacialYear.Add(6, 9); // June
 //       monthsRemainingInFinacialYear.Add(7, 8); // July
 //       monthsRemainingInFinacialYear.Add(8, 7); // Aug
 //       monthsRemainingInFinacialYear.Add(9, 6); // Sep
 //       monthsRemainingInFinacialYear.Add(10, 5); // Oct
 //       monthsRemainingInFinacialYear.Add(11, 4); // Nov
 //       monthsRemainingInFinacialYear.Add(12, 3); // Dec 
 //       monthsRemainingInFinacialYear.Add(1, 2); // Jan
 //       monthsRemainingInFinacialYear.Add(2, 1); // Feb

       
 //   }
    
 //   protected void Page_Load(object sender, EventArgs e)
 //   {

 //   }
 //   protected void Page_PreRenderComplete(object sender, EventArgs e)
 //   {
 //        DataBind();

 //   }

 //   protected void getMonthHeaders(Object sender, EventArgs e)
 //   {
 //       Label label = (Label)sender;
 //       int monthsForward = (Int32.Parse(label.ID.Remove(0,5)));

 //       int currentYear = DateTime.Now.Year;
 //       int currentMonth = DateTime.Now.Month;

 //       if (currentMonth == 1 || currentMonth == 2)
 //       {

 //           currentYear = currentYear - 1; // checks if we are in jan or feb and sets year back to fall into financial year
 //       }

 //       DateTime financialYearStart = new DateTime(currentYear, 3, 1); // a date to represent march of the current finacial year

 //       label.Text = financialYearStart.AddMonths(monthsForward).ToString("MMM yy");
        
        
 //       //backx00

 //   }

 //   protected String GetInstallationTime(object pQuoteValue)
 //   {


 //       Utils util = new Utils();
 //       int allocatedDays = util.getAllocatedInstallationDays((Decimal)pQuoteValue);
        

 //       return allocatedDays.ToString();

 //   }

 //   protected void getLeadTimeAverage(Object sender, EventArgs e)
 //   {
 //       Label label = (Label)sender;
 //       bool isQuote = false;
 //       int deptId = -1;
 //       int daysBack = 0;
 //       if (label.ID.Equals("installations"))
 //       {
 //           deptId = 2;
 //           isQuote = false;
 //           daysBack = -60;
 //       }
 //       else if (label.ID.Equals("quotes"))
 //       {
 //           deptId = 0;
 //           isQuote = true;
 //           daysBack = -30;
 //       }

 //       DateTime checkDate = System.DateTime.Now.AddDays(daysBack);


 //        job_time[] job_times = (from j in db.job_times
 //                   where j.dept_id == deptId
 //                   && ((j.started_date != null && j.completed_date == null) || (j.started_date != null && j.completed_date >= checkDate))
 //                   select j).ToArray();

 //        int numberOfJobs = 0;
 //        int totalElapsedDays = 0;
 //        foreach (job_time job in job_times)
 //        {
 //            DateTime startDate = (DateTime) job.started_date;
 //            DateTime endDate = System.DateTime.Now;

 //            if (job.completed_date != null)
 //            {
 //                endDate = (DateTime)job.completed_date;
 //                totalElapsedDays += dateHandler.netWorkingDays(startDate, endDate, deptId, isQuote);
 //                numberOfJobs++;
 //            }
 //            else
 //            {
 //                if (isQuote)
 //                {
 //                    /*int netWorkDays = dateHandler.netWorkingDays(startDate, endDate, getHolidays(deptId), isQuote);
 //                    if (netWorkDays > 5)
 //                    {
 //                        totalElapsedDays += netWorkDays;
 //                        numberOfJobs++;
 //                    }*/
 //                }
 //                else
 //                {
 //                    int netWorkDays = dateHandler.netWorkingDays(startDate, endDate, deptId, isQuote);
 //                    if (netWorkDays > 10)
 //                    {
 //                        totalElapsedDays += netWorkDays;
 //                        numberOfJobs++;
 //                    }


 //                }


 //            }
             
             
         
 //        }



 //        double averageDays = 0;
 //       if(numberOfJobs>0)
 //           averageDays = totalElapsedDays / numberOfJobs;

       
 //       label.Text = Math.Round(averageDays).ToString();
 //   }

 //   protected void quotesInProgressDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
 //   {
        


 //       IQueryable< job_time> job_times = from j in db.job_times
 //                                         where j.dept_id ==0
 //                                         && j.section.active_status == 1
 //                                         && j.started_date != null
 //                                         && j.completed_date == null
 //                                        orderby j.started_date ascending
 //                                        select j;


 //       e.Result = job_times;

 //   }
 //   protected void quotesCompletedDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
 //   {

 //       DateTime checkDate = System.DateTime.Now.AddDays(-30);

 //       IQueryable<job_time> job_times = from j in db.job_times
 //                                        where j.dept_id == 0
 //                                        && j.section.active_status == 1
 //                                        && j.started_date != null
 //                                        && j.completed_date >= checkDate
 //                                        orderby j.completed_date descending
 //                                        select j;


 //       e.Result = job_times;

 //   }

 //   protected void installationsInProgressDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
 //   {



 //       IQueryable<job_time> job_times = from j in db.job_times
 //                                        where j.dept_id == 2
 //                                        && j.started_date != null
 //                                        && j.completed_date == null
 //                                        orderby j.started_date ascending
 //                                        select j;


 //       e.Result = job_times;

 //   }
 //   protected void installationsCompletedDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
 //   {

 //       DateTime checkDate = System.DateTime.Now.AddDays(-60);

 //       IQueryable<job_time> job_times = from j in db.job_times
 //                                        where j.dept_id == 2
 //                                        && j.started_date != null
 //                                        && j.completed_date >= checkDate
 //                                        orderby j.completed_date descending
 //                                        select j;


 //       e.Result = job_times;

 //   }

 //   protected void quotesNotStartedDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
 //   {

       

 //       IQueryable<job_time> job_times = from j in db.job_times
 //                                        where j.dept_id == 0
 //                                        && j.section.active_status == 1
 //                                        && j.started_date == null
 //                                        && j.completed_date == null

 //                                        orderby j.section.date_added ascending
 //                                        select j;


 //       e.Result = job_times;

 //   }


 //   protected string GetRowStyle(object pStartDate, object pEndDate, object pSectionObject, int pDeptId)
 //   {
 //       DateTime startDate = (DateTime)pStartDate;
 //       DateTime endDate = System.DateTime.Now; ;
 //       section thisSection = (section)pSectionObject;
 //       if (pEndDate != null)
 //           endDate = (DateTime)pEndDate;

 //       string result = "";

 //       bool isQuote = false;
 //       int targetLeadTime = 0;
 //       if (pDeptId == 0)
 //       {
 //           targetLeadTime = 7;
 //           isQuote = true;

 //       }
 //       else if (pDeptId == 2)
 //       {


 //           targetLeadTime = Int32.Parse(GetInstallationTime(thisSection.quote_value));

 //           isQuote = false;
 //       }

 //       int leadTime = dateHandler.netWorkingDays(startDate, endDate, pDeptId, isQuote);

 //       if (pDeptId == 0)
 //       {

 //           if (leadTime <= targetLeadTime)
 //               result = "greenRow";
 //           else if (leadTime > targetLeadTime)
 //               result = "redRow";
 //       }
 //       else if (pDeptId == 2)
 //       {
 //           if (leadTime <= targetLeadTime + 5)// add buffer as per performance bonus system
 //               result = "greenRow";
 //           else if ((leadTime >= targetLeadTime + 6) && (leadTime <= targetLeadTime + 10))// 75% bonus
 //               result = "blueRow";
 //           else if ((leadTime >= targetLeadTime + 11) && (leadTime <= targetLeadTime + 15))// 50% bonus
 //               result = "purpleRow";
 //           else if ((leadTime >= targetLeadTime + 16) && (leadTime <= targetLeadTime + 20))// 25% bonus
 //               result = "amberRow";
 //           else if (leadTime >= targetLeadTime + 21) // 0% bonus
 //               result = "redRow";

 //       }

 //       return result;

 //   }


 //   protected String GetDaysElapsed(object pStartDate, object pEndDate, int pDeptId)
 //   {

 //       DateTime startDate = (DateTime)pStartDate;
 //       DateTime endDate = (DateTime)pEndDate;


 //       bool isQuote = false;

 //       if (pDeptId == 0)
 //           isQuote = true;

 //       int elapsedDays = dateHandler.netWorkingDays(startDate, endDate, pDeptId, isQuote);
 //       return  elapsedDays.ToString();

 //   }

   

   
 //   private int getIndividualLostLeadsCount(String pUsername)
 //   {
 //       int totalLostCount;

 //       if (pUsername == null)
 //       {
 //           return 0;
 //       }

 //       //DateTime backDate = new DateTime(System.DateTime.Now.AddMonths(-11).Year, System.DateTime.Now.AddMonths(-11).Month, 1); // a date to LIMIT RRSULTS TO 12 MONTHS BACK
        
 //       DateTime fromDate = new DateTime(2022, 1, 1); // a date to LIMIT RRSULTS TO dates after 01/01/2022 - the date that we want to start measureing from


 //       totalLostCount = (from s in db.sections
 //                         where s.client.consultant_name.ToLower() == pUsername.ToLower()
 //                         && (s.quote_status == "Lost" && s.quote_value == 0)
 //                         && s.date_added >= fromDate
 //                        // && s.date_added >= backDate

 //                         select s).Count();




 //       return totalLostCount;

 //   }
 //   private int getLost(String pUsername)
 //   {
 //       int totalLostCount;




 //       //DateTime date = new DateTime(System.DateTime.Now.AddMonths(-11).Year, System.DateTime.Now.AddMonths(-11).Month, 1); // a date to LIMIT RRSULTS TO 12 MONTHS BACK
 //       DateTime date = new DateTime(2022, 1, 1); // a date to LIMIT RRSULTS TO dates after 01/01/2022 - the date that we want to start measureing from

 //       if (pUsername == null)
 //       {
 //           totalLostCount = (from s in db.sections
 //                             where s.quote_status == "Lost"
 //                             && s.quote_value > 0
 //                             && s.date_added != null
 //                             && s.decision_date >= date
 //                             select s).Count();
 //       }
 //       else
 //       {
 //           totalLostCount = (from s in db.sections
 //                             where s.client.consultant_name.ToLower() == pUsername.ToLower() 
 //                             && s.quote_status == "Lost"
 //                             && s.quote_value > 0
 //                             && s.date_added != null
 //                             && s.decision_date >= date
 //                             select s).Count();
 //       }

        

 //      return totalLostCount;
 //   }
 //   private int getWon(String pUsername)
 //   {
 //       int totalWonCount;

       

 //       //DateTime date = new DateTime(System.DateTime.Now.AddMonths(-11).Year, System.DateTime.Now.AddMonths(-11).Month, 1); // a date to LIMIT RRSULTS TO 12 MONTHS BACK
 //       DateTime date = new DateTime(2022, 1, 1); // a date to LIMIT RRSULTS TO dates after 01/01/2022 - the date that we want to start measureing from

 //       if (pUsername == null)
 //       {


 //           totalWonCount = (from s in db.sections
 //                            where s.quote_status == "Won"
 //                            && s.quote_value > 0
 //                            && s.date_added != null
 //                            && s.decision_date >= date
 //                            select s).Count();
 //       }
 //       else
 //       {
 //           totalWonCount = (from s in db.sections
 //                            where s.client.consultant_name.ToLower() == pUsername.ToLower()  
 //                            && s.quote_status == "Won"
 //                            && s.quote_value > 0
 //                            && s.date_added != null
 //                            && s.decision_date >= date
 //                            select s).Count();

 //       }

 //       return totalWonCount;
 //   }

 //   private int getPending(String pUsername)
 //   {
 //       int totalPendingCount;

 //       if (pUsername == null)
 //       {
 //           totalPendingCount = (from s in db.sections
 //                                where  s.quote_status == "Pending"
 //                                && s.quote_value > 0
 //                                && s.date_added != null
 //                                select s).Count();
 //       }
 //       else { 
 //       totalPendingCount = (from s in db.sections
 //                            where s.client.consultant_name.ToLower() == pUsername.ToLower()
 //                            && s.quote_status == "Pending"
 //                            && s.quote_value > 0
 //                            && s.date_added != null
 //                            select s).Count();

 //       }

 //       return totalPendingCount;
 //   }


 //   //protected void hitRateQuotes(Object sender, EventArgs e)
 //   //{
 //   //    Label label = (Label)sender;

 //   //    int pendingquotes = (from c in ConsultantHandler.getSortedEligibleConsultants()
 //   //                      where (!(c.pause))
 //   //                      select c.pendingQuotes()).Sum();
 //   //    int wonquotes = (from c in ConsultantHandler.getSortedEligibleConsultants()
 //   //                       where (!(c.pause))
 //   //                       select c.wonLeadFromSetDate()).Sum();
 //   //    int lostquotes = (from c in ConsultantHandler.getSortedEligibleConsultants()
 //   //                       where (!(c.pause))
 //   //                       select c.lostSinceJanuary()).Sum();

 //   //    var consultants = from c in ConsultantHandler.getSortedEligibleConsultants()
 //   //                      where (!(c.pause))
 //   //                      select c;




 //   //    string txt = "Group Hit Rate(Since 1 January 202) :  % (" +wonquotes  + " jobs won from " + (wonquotes + lostquotes) + " quotes) -Undecided quotes: " + pendingquotes + "<br/>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp";


 //   //    foreach (Consultant consultant in consultants)
 //   //    {
 //   //        txt += consultant.userName + "&nbsp;&nbsp;                  : " + Math.Round(consultant.hitRatio(), 0) + "% (" + consultant.wonLeadFromSetDate() + " jobs won from " + (consultant.wonLeadFromSetDate() + consultant.lostSinceJanuary()) + " quotes) - Undecided quotes: " + consultant.pendingQuotes()+ "<br/>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp";
 //   //        //totalquotes = consultant.getGhostQuotes();
 //   //    }
 //   //    label.Text = txt;
 //   //    // label.Text = "Total Quotes in last 3 months : " + (totalquotes) +"<br/>";



 //   //}


 ////   protected void LostQuotes(Object sender, EventArgs e)
 ////   {
 ////       Label label = (Label)sender;

 ////       int lostquotes = (from c in ConsultantHandler.getSortedEligibleConsultants()
 ////                            where (!(c.pause))
 ////                            select c.lostLeadFromSetDate()).Sum();


 ////       var consultants = from c in ConsultantHandler.getSortedEligibleConsultants()
 ////                         where (!(c.pause))
 ////                         select c;




 ////       string txt = "Total Lost Leads(Since 1 Jan 2022) : " + lostquotes + "<br/>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp";

 ////       foreach (Consultant consultant in consultants)
 ////       {
 ////           txt += consultant.userName + "                  : " + consultant.lostLeadFromSetDate() + "<br/>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp"; // + "  +  " + consultant.getGhostQuotes() + "  =  " + consultant.getQuoteCount() + " <font size=\"1\" color=\"grey\">(Working On :" + consultant.getActiveQuotes() + " | Skipped Leads :" + consultant.getGhostQuotes() + ")  </font><br/>";
           
 ////       }
 ////       label.Text = txt;
 ////       // label.Text = "Total Quotes in last 3 months : " + (totalquotes) +"<br/>";



 ////   }
 ////   protected void RealQuotes(Object sender, EventArgs e)
	////{
 ////       Label label = (Label)sender;

 ////       int quotes = (from c in ConsultantHandler.getSortedEligibleConsultants()
 ////                            where (!(c.pause))
 ////                            select c.getRealQuotes()).Sum();


 ////       var consultants = from c in ConsultantHandler.getSortedEligibleConsultants()
 ////                   where (!(c.pause))
 ////                   select c;




 ////       string txt = "Total Quotes in last 3 months : " + (quotes) + "<br/>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp";
        
 ////       foreach(Consultant consultant in consultants)
	////	{
 ////           txt += consultant.userName + "                  : " + consultant.getRealQuotes() + "  +  " + consultant.getGhostQuotes() + "  =  " + consultant.getQuoteCount() + " <font size=\"1\" color=\"grey\">(Working On :" + consultant.getActiveQuotes() + " | Skipped Leads :" + consultant.getGhostQuotes()+ ")  </font><br/>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp";
           
	////	}
 ////       label.Text = txt;
 ////      // label.Text = "Total Quotes in last 3 months : " + (totalquotes) +"<br/>";



 ////   }

 //   //var consultants = from g in ConsultantHandler.getAll()
 //   //                  select g;
 //   //foreach (var consultant in consultants)
 //   //{

 //   //    label.Text = consultant.userName + ":" + consultant.getRealQuotes();

 //   //}


 //   protected void getStatsQuotes(Object sender, EventArgs e)
 //   {
 //       Label label = (Label)sender;



 //       int sheraineQuotes = getIndividualRealQuoteCount("Sheraine");
 //       int sheraineSkipped = getGhostLeads("Sheraine");
 //       int jacqueQuotes = getIndividualRealQuoteCount("Jacque");
 //       int jacqueSkipped = getGhostLeads("Jacque");
 //       int markQuotes = getIndividualRealQuoteCount("Mark");
 //       int markSkipped = getGhostLeads("Mark");
 //       int ashleyQuotes = getIndividualRealQuoteCount("Ashley");
 //       int ashleySkipped = getGhostLeads("Ashley");



 //       int totalQuotes = sheraineQuotes + jacqueQuotes + markQuotes + ashleyQuotes;


 //       int sheraineTotal = sheraineQuotes + sheraineSkipped;
 //       int jacqueTotal = jacqueQuotes + jacqueSkipped;
 //       int markTotal = markQuotes + markSkipped;
 //       int ashleyTotal = ashleyQuotes + ashleySkipped;




 //       label.Text = "Total Quotes in last 3 months : " + totalQuotes + "<br/>" +

 //       "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp Next lead allocated to : TBC " +  nextEligibleConsultant() + "<br/>" +

 //       "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp Sheraine : " + sheraineQuotes + " + " + sheraineSkipped + " = " + sheraineTotal + " <font size=\"1\" color=\"grey\">(Working On :" + getWorkingOnQuotesCount("Sheraine") + " | Skipped Leads :" + sheraineSkipped + ")  </font><br/>" +

 //            "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp Jacque : " + jacqueQuotes + " + " + jacqueSkipped + " = " + jacqueTotal + " <font size=\"1\" color=\"grey\">(Working On :" + getWorkingOnQuotesCount("Jacque") + " | Skipped Leads :" + jacqueSkipped + ")  </font><br/>" +

 //             "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp Mark : " + markQuotes + " + " + markSkipped + " = " + markTotal + " <font size=\"1\" color=\"grey\">(Working On :" + getWorkingOnQuotesCount("Mark") + " | Skipped Leads :" + markSkipped + ")  </font><br/>" +

 //              "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp Ashley : " + ashleyQuotes + " + " + ashleySkipped + " = " + ashleyTotal + " <font size=\"1\" color=\"grey\">(Working On :" + getWorkingOnQuotesCount("Ashley") + " | Skipped Leads :" + ashleySkipped + ")  </font>";

 //      // Response.Redirect(Request.RawUrl);

 //   }

 //   // >>>>>>>>>>>>>>>> Logic to work out who gets the next quote <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
 //   private string getNextQualifyingConsultant()
 //   {
 //       string nextEligableConsultant = getConsultantWhoNextLeadShouldGoTo();
 //       if (!doesConsultantQualifyForLead(nextEligableConsultant))
 //       {
 //           // first check if anybody qualifies 
 //           if (doesAnyConsultantQualify())
 //           {
 //               //means there is a consultant that will qualify 
                
 //               return getNextConsultantThatQualifiesAfterGhost(nextEligableConsultant);
 //           }
 //           else
 //           {
 //               return getConsultantWhoNextLeadShouldGoToWhenNoOneQualifies();


 //           }
 //       }


 //       return nextEligableConsultant;
 //   }

 //   private string getNextConsultantThatQualifiesAfterGhost(string pUsername)
 //   {
 //       //this is a bit of a hack method for speed of coding - this is called when I know there is another consultant that will qualify

 //       string retunName = "";
 //       if (pUsername.Equals("Shaun"))
 //           retunName = "Sheraine";
 //       else if (pUsername.Equals("Sheraine"))
 //           retunName = "Shaun";
 //       return retunName;

 //   }

 //   private bool doesAnyConsultantQualify()
 //   {
 //       bool sheraineQualify = doesConsultantQualifyForLead("Sheraine");
 //       bool shaunQualify = doesConsultantQualifyForLead("Shaun");
 //       if (sheraineQualify || shaunQualify)
 //       {
 //           return true;
 //       }
 //       else
 //       {
 //           return false;
 //       }

 //   }

 //   private string getConsultantWhoNextLeadShouldGoTo()
 //   {
 //       //allocate the lead to the consultant next in line to take a lead
 //       // first check the number of leads
 //       string consultantName = "";
 //       int sheraineCount = getIndividualQuoteCount("Sheraine");
 //       int shaunCount = getIndividualQuoteCount("Shaun");

 //       if (sheraineCount < shaunCount)
 //       {
 //           consultantName = "Sheraine";
 //       }
 //       else if (shaunCount < sheraineCount)
 //       {
 //           consultantName = "Shaun";
 //       }

 //       else if (shaunCount == sheraineCount)//if leads are equal, check who took the last lead and assign it to the other
 //       {
 //           if (getConsultantWhoGotLastQuote().Equals("shaun"))
 //               consultantName = "Sheraine";
 //           else if (getConsultantWhoGotLastQuote().Equals("sheraine"))
 //               consultantName = "Shaun";
 //       }

 //       return consultantName;
 //   }

 //   private string getConsultantWhoNextLeadShouldGoToWhenNoOneQualifies()
 //   {
 //       //when no one qualifies the lead will go to the consultant who is working on the least amount at the time
 //       string consultantName = "";
 //       int sheraineCount = getWorkingOnQuotesCount("Sheraine");
 //       int shaunCount = getWorkingOnQuotesCount("Shaun");

 //       if (sheraineCount < shaunCount)
 //       {
 //           consultantName = "Sheraine";
 //       }
 //       else if (shaunCount < sheraineCount)
 //       {
 //           consultantName = "Shaun";
 //       }

 //       else if (shaunCount == sheraineCount)//if working on count is equal, check who took the last lead and assign it to the other
 //       {
 //           if (getConsultantWhoGotLastQuote().Equals("shaun"))
 //               consultantName = "Sheraine";
 //           else if (getConsultantWhoGotLastQuote().Equals("sheraine"))
 //               consultantName = "Shaun";
 //       }

 //       return consultantName;
 //   }

 //   private bool doesConsultantQualifyForLead(string pUsername)
 //   {

 //       int busyWorkingCount = getWorkingOnQuotesCount(pUsername);
 //       if (busyWorkingCount <= 7) // seven is the number deamed to be the max amount a consultant can work on at one time 
 //           return true;
 //       else
 //           return false;
 //   }

 //   private int getWorkingOnQuotesCount(String pUsername)
 //   {
 //       int count = (from j in db.job_times
 //                    where j.dept_id == 0
 //                    && j.section.active_status == 1
 //                    && j.started_date != null
 //                    && j.completed_date == null
 //                    && j.section.client.consultant_name.ToLower() == pUsername.ToLower()
 //                    select j).Count();

 //       return count;

 //   }

 //   private string getConsultantWhoGotLastQuote()
 //   {


 //       int maxSectionId = (from s in db.sections
 //                           where
 //                               !(s.quote_status == "Lost" && s.quote_value == 0) && (s.client.consultant_name.ToLower() != "jonathan" ) && ( s.client.consultant_name.ToLower() != "philip") && (s.client.consultant_name.ToLower() != "reino") && (s.client.consultant_name.ToLower() != "farah") && (s.client.consultant_name.ToLower() != "")
 //                           select s.section_id).Max();

 //       section pSection = (from s in db.sections
 //                           where !(s.quote_status == "Lost" && s.quote_value == 0) &&
 //                                   s.section_id == maxSectionId
 //                           select s).Single();


 //       return pSection.client.consultant_name.ToLower();


 //   }

 //   private int getIndividualQuoteCount(string pUsername)
 //   {
 //       int normalCount = 0;
 //       int ghostCount = 0;


 //       if (pUsername == null)
 //       {
 //           return 0;
 //       }

 //       DateTime backDate = new DateTime(System.DateTime.Now.AddMonths(-4).Year, System.DateTime.Now.AddMonths(-4).Month, 1); // a date to LIMIT RRSULTS TO 3 MONTHS BACK
 //       DateTime fromDate = new DateTime(2020, 6, 6); // a date to LIMIT RRSULTS TO dates after 06/06/2020 -  we chose to reset the lead count here 


 //       normalCount = (from s in db.sections
 //                      where s.client.consultant_name.ToLower() == pUsername.ToLower()
 //                      && !(s.quote_status == "Lost" && s.quote_value == 0)
 //                      && s.date_added >= fromDate
 //                      && s.date_added >= backDate

 //                      select s).Count();

 //       ghostCount = (from g in db.ghost_leads
 //                     where 
 //                     g.isActive == true
 //                      && g.consultantName.ToLower() == pUsername.ToLower()
 //                     && g.added_date >= fromDate
 //                     && g.added_date >= backDate

 //                     select g).Count();




 //       return normalCount + ghostCount;

 //   }




 //   // <<<<<<<<<<<<<<<<<<<<<<  End of who get the next quote logic  <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<


 //   private int getIndividualRealQuoteCount(string pUsername)
 //   {
 //       int normalCount = 0;
       


 //       if (pUsername == null)
 //       {
 //           return 0;
 //       }

 //       DateTime backDate = new DateTime(System.DateTime.Now.AddMonths(-4).Year, System.DateTime.Now.AddMonths(-4).Month, 1); // a date to LIMIT RRSULTS TO 3 MONTHS BACK
 //       DateTime fromDate = new DateTime(2020, 6, 6); // a date to LIMIT RRSULTS TO dates after 06/06/2020 -  we chose to reset the lead count here 


 //       normalCount = (from s in db.sections
 //                      where s.client.consultant_name.ToLower() == pUsername.ToLower()
 //                      && !(s.quote_status == "Lost" && s.quote_value == 0)
 //                      && s.date_added >= fromDate
 //                      && s.date_added >= backDate

 //                      select s).Count();

        




 //       return normalCount;

 //   }

 //   private int getGhostLeads(String pUsername)
 //   {
 //       int totalGhostCount;

 //       if (pUsername == null)
 //       {
 //           return 0;
 //       }

 //       DateTime backDate = new DateTime(System.DateTime.Now.AddMonths(-4).Year, System.DateTime.Now.AddMonths(-4).Month, 1); // a date to LIMIT RRSULTS TO 3 MONTHS BACK
 //       DateTime fromDate = new DateTime(2020, 6, 6); // a date to LIMIT RRSULTS TO dates after 06/06/2020 - the date that we want to start measureing from for sheraine and shaun when reino promoted

 //       totalGhostCount = (from g in db.ghost_leads
 //                         where g.isActive == true
 //                      && g.consultantName.ToLower() == pUsername.ToLower()
 //                      && g.added_date >= fromDate
 //                         && g.added_date >= backDate

 //                         select g).Count();




 //       return totalGhostCount;

 //   }

 //   protected void getStatsLostLeads(Object sender, EventArgs e)
 //   {
 //       Label label = (Label)sender;
        
 //       int sheraineLost = getIndividualLostLeadsCount("Sheraine");
 //       int jacqueLost = getIndividualLostLeadsCount("Jacque");
 //       int markLost = getIndividualLostLeadsCount("Mark");
 //       int ashleyLost = getIndividualLostLeadsCount("Ashley");
 //       int totalLost = sheraineLost + jacqueLost + markLost + ashleyLost;


 //       label.Text = "Total Lost Leads (Since 1 Jan 2022) : " + totalLost + "<br/>" +
 //           "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp Sheraine : " + sheraineLost + "<br/>" +
 //           "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp Jacque : " + jacqueLost + "<br/>" +
 //           "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp Mark : " + markLost + "<br/>" +
 //           "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp Ashley : " + ashleyLost;

        

       
 //   }

 //   protected void getStatsHitRate(Object sender, EventArgs e)
 //   {
 //       Label label = (Label)sender;




 //       label.Text = "Group Hit Rate (Since 1 Jan 2022) : "+getIndividualHitRate(null)+"<br/>" +
 //           "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp Sheraine : " + getIndividualHitRate("Sheraine") + "<br/>" +
 //            "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp Jacque : " + getIndividualHitRate("Jacque") + "<br/>" +
 //             "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp Mark : " + getIndividualHitRate("Mark") + "<br/>" +
 //           "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp Ashley : " + getIndividualHitRate("Ashley"); 
 //   }

 //   protected void getStatsLeadTime(Object sender, EventArgs e)
 //   {
 //       Label label = (Label)sender;




 //       label.Text = "Group Quote Lead Time (last 30 days) : " + getIndividualLeadTime(null) + "<br/>" +
 //          "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp Sheraine : " + getIndividualLeadTime("Sheraine") + "<br/>" +
 //          "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp Jacque : " + getIndividualLeadTime("Jacque") + "<br/>" +
 //          "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp Mark : " + getIndividualLeadTime("Mark") + "<br/>" +
 //          "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp Ashley : " + getIndividualLeadTime("Ashley"); 
 //   }

 //   private string getIndividualHitRate(String pUserName)
 //   {



 //       decimal numWon = getWon(pUserName);
 //       decimal numLost = getLost(pUserName);
 //       decimal hitRate=0;
 //       if (numWon > 0 || numLost > 0)
 //           hitRate = (numWon / (numWon + numLost)) * 100;
 //       decimal totalPending = getPending(pUserName);







 //       return  Math.Round(hitRate, 0).ToString() + "% (" + numWon + " jobs won from " + (numWon + numLost) + " quotes) - Undecided quotes: " + totalPending;
            
            
 //   }

 //   private string getIndividualLeadTime(String pUserName)
 //   {

 //       // work out individual lead time
 //       DateTime checkDate = System.DateTime.Now.AddDays(-30);
 //       job_time[] job_times = null;

 //       if (pUserName == null)
 //       {

 //           job_times = (from j in db.job_times
 //                        where j.dept_id == 0
 //                        && (j.started_date != null && j.completed_date >= checkDate)
 //                        select j).ToArray();

 //       }
 //       else
 //       {
 //           job_times = (from j in db.job_times
 //                        where j.dept_id == 0
 //                        && (j.started_date != null && j.completed_date >= checkDate)
 //                        && j.section.client.consultant_name.ToLower() == pUserName.ToLower()
 //                        select j).ToArray();

 //       }

 //       int numberOfJobs = 0;
 //       int totalElapsedDays = 0;
 //       foreach (job_time job in job_times)
 //       {
 //           DateTime startDate = (DateTime)job.started_date;
 //           DateTime endDate = System.DateTime.Now;

 //           if (job.completed_date != null)
 //           {
 //               endDate = (DateTime)job.completed_date;
 //               totalElapsedDays += dateHandler.netWorkingDays(startDate, endDate, 0, true);
 //               numberOfJobs++;
 //           }




 //       }



 //       double averageDays = 0;
 //       if (numberOfJobs > 0)
 //           averageDays = totalElapsedDays / numberOfJobs;






 //      return  Math.Round(averageDays).ToString() + " days";

 //   }

 //   private void addRecordsToGlobalStatsHash(string pKey)
 //   {


        
 //       Hashtable userHash = new Hashtable();
 //       DateTime firstMonthOfCurrentFinancialYear = getStartOfCurrentFinancialYear();
 //       // pupulate the hashtable with twelve months worth of data satrting at the start of the current financial year
 //       decimal targetForYear = getTargetForCurrentFianacialYear();
 //       decimal monthlyTarget = 0;
 //       if (!pKey.ToLower().Equals("group"))// means its one of the 2 design consultants
 //       {
 //           targetForYear = targetForYear / 2;
 //       }

 //       monthlyTarget = targetForYear / 12;

 //       string payOption = "";
 //       try
 //       {
 //          payOption = remunerationOption[pKey];
            

 //       }
 //       catch (Exception)
 //       {
            
            
 //       }  
            

 //       for (int i = 0; i <= 11; i++)
	//		{
	//		    DateTime monthWeAreWorkingWith = firstMonthOfCurrentFinancialYear.AddMonths(i);

 //               if (monthWeAreWorkingWith.Date < new DateTime(2015, 5, 1) || (pKey.ToLower().Equals("reino") && monthWeAreWorkingWith.Date < new DateTime(2015, 7, 1))) // some hardcoding to cater for the fact that the other pay were not avalaible before 1 May 2015 and reino only started on 1 july 2015
 //               {
 //                   payOption = "Option1";

 //               }
 //               else
 //               {
 //                   try
 //                   {
 //                       payOption = remunerationOption[pKey];
 //                   }
 //                   catch (Exception){}  
 //               }
                
 //               int monthsRemaining = 0;
 //               if (monthWeAreWorkingWith < DateTime.Now)
 //               {
 //                   monthsRemaining = monthsRemainingInFinacialYear[monthWeAreWorkingWith.Month];
 //               }
 //               else
 //               {
                    
	//		int holder = DateTime.Now.Month+1;
 //                       if (holder == 13){
	//			holder = 1;
 //                       }
	//		monthsRemaining = monthsRemainingInFinacialYear[holder];
 //               }

               
 //               StatMonth month = new StatMonth();

 //               if (i == 0) // we are in the first month of the financial year
 //               {
 //                   month.monthlyTarget = monthlyTarget;

 //               }
 //               else // not in first month so we need to work out cumulative target
 //               {



 //                   decimal cumulativeSales = getSalesForRange(firstMonthOfCurrentFinancialYear, firstMonthOfCurrentFinancialYear.AddMonths(i-1), pKey);

 //                   //if (monthWeAreWorkingWith.Month == DateTime.Now.Month)
 //                   //{
 //                     //  monthsRemaining = monthsRemaining + 1; // this is to get an acurate target for the current month
 //                   //}

 //                   month.monthlyTarget = (targetForYear - cumulativeSales) / monthsRemaining;

 //                   if (month.monthlyTarget < 0)
 //                       month.monthlyTarget = 0;
 //                   //month.monthlyTarget = (targetForYear - cumulativeSales) / 12;

                    

                    

                  

 //               }  
            
            
 //               if (monthWeAreWorkingWith.Date <= DateTime.Now.Date)// if we are populating data for months in the future then I dont want to bother making database calls for the following properties
 //               {
 //                   month.monthlySales = getSalesForRange(monthWeAreWorkingWith, monthWeAreWorkingWith, pKey);
 //                   decimal shortFall = month.monthlyTarget -month.monthlySales;
 //                   if (shortFall < 0)
 //                       shortFall = 0;
 //                   month.monthlyShortfall = shortFall;

 //                   if(payOption.Equals("Option1")){
 //                       month.monthlyBonus = (((((month.monthlySales * 100) / 114)) * 2) / 1080) * 3;
 //                       month.monthlyCarryover = 0; // NEED TO IMPLEMENT CARRYOVER LOGIC IF THEY CHOOSE OPTION 1
                        
 //                   }
 //                   else if (payOption.Equals("Option2"))
 //                   {
 //                       month.monthlyBonus = (((((month.monthlySales * 100) / 114)) * 5) / 100);
 //                       month.monthlyCarryover = 0; // there is never carryover for option 2 because they get paid if in target or not
 //                   }
 //                   else
 //                   {
 //                       month.monthlyBonus = 0; //its the group user
 //                   }

 //                   // hard coding the carryover from the previous finacial year
 //                   if (pKey.ToLower().Equals("jonathan") && (monthWeAreWorkingWith.Date == new DateTime(2015, 3, 1)))
 //                   {
 //                       month.monthlyCarryover = 10099;
 //                   }
 //                   if (pKey.ToLower().Equals("reino") && (monthWeAreWorkingWith.Date == new DateTime(2015, 3, 1)))
 //                   {
 //                       month.monthlyCarryover = 7500;
 //                   }
 //                   if (pKey.ToLower().Equals("reino") && (monthWeAreWorkingWith.Date == new DateTime(2015, 6, 1)))
 //                   {
 //                       month.monthlyCarryover = 5296;
 //                   }

 //                   month.monthlyTotalBonus = month.monthlyBonus + month.monthlyCarryover;

                        

                   
 //               }
 //               else
 //               {
 //                   month.monthlySales = 0;
 //                   month.monthlyShortfall = 0;
 //                   month.monthlyBonus = 0;
 //                   month.monthlyCarryover = 0;
 //                   month.monthlyTotalBonus = 0;
 //               }
                


 //               userHash.Add(monthWeAreWorkingWith.Date, month);

	//		}

        
 //        globalStatsHashtable.Add(pKey, userHash);



 //   }

 //   protected void getTargetByMonth(Object sender, EventArgs e)
 //    {
 //        Label label = (Label)sender;
        
 //        int monthsForward = Int32.Parse(label.ID.Remove(0,label.ID.Length-2));
 //        string tempuser = label.ID.Remove(0,14);
 //        string user = tempuser.Remove(tempuser.Length - 2);

       
 //       // if globalstatshashtable doesnt contain records for this user then populate
 //        if (!globalStatsHashtable.ContainsKey(user.ToLower()))
 //        {
 //            addRecordsToGlobalStatsHash(user.ToLower());
 //        }

 //        DateTime currentMonth = getStartOfCurrentFinancialYear().AddMonths(monthsForward);

 //       Hashtable userHash = null;
 //       Decimal target = 0;
       
 //         try 
	//      {	        
	//	      userHash = (Hashtable)globalStatsHashtable[user.ToLower()];
 //             target = ((StatMonth)userHash[currentMonth.Date]).monthlyTarget;
	//    }
	//    catch (Exception)
	//    {
		
		        
	//    } 
            
              
         




 //        label.Text = "R" + String.Format("{0:N0}", target);
 //    }
 //    protected void getSalesByMonth(Object sender, EventArgs e)
 //    {
 //        Label label = (Label)sender;

 //        int monthsForward = Int32.Parse(label.ID.Remove(0, label.ID.Length - 2));
 //        string tempuser = label.ID.Remove(0, 8);
 //        string user = tempuser.Remove(tempuser.Length - 2);
 //        // if globalstatshashtable doesnt contain records for this user then populate
 //        if (!globalStatsHashtable.ContainsKey(user.ToLower()))
 //        {
 //            addRecordsToGlobalStatsHash(user.ToLower());
 //        }




 //        //backDataJonathan00
 //        DateTime currentMonth = getStartOfCurrentFinancialYear().AddMonths(monthsForward);

 //        Hashtable userHash = null;
 //        Decimal jobValueForMonth = 0;

 //        try
 //        {
 //            userHash = (Hashtable)globalStatsHashtable[user.ToLower()];
 //            jobValueForMonth = ((StatMonth)userHash[currentMonth.Date]).monthlySales;
 //        }
 //        catch (Exception)
 //        {


 //        } 


 //        label.Text = "R" + String.Format("{0:N0}", jobValueForMonth);
 //    }
 //    protected void getShortfallByMonth(Object sender, EventArgs e)
 //    {
 //        Label label = (Label)sender;

 //        int monthsForward = Int32.Parse(label.ID.Remove(0, label.ID.Length - 2));
 //        string tempuser = label.ID.Remove(0, 17);
 //        string user = tempuser.Remove(tempuser.Length - 2);
 //        // if globalstatshashtable doesnt contain records for this user then populate
 //        if (!globalStatsHashtable.ContainsKey(user.ToLower()))
 //        {
 //            addRecordsToGlobalStatsHash(user.ToLower());
 //        }



 //        DateTime currentMonth = getStartOfCurrentFinancialYear().AddMonths(monthsForward);

 //        Hashtable userHash = null;
 //        Decimal shortfallForMonth = 0;

 //        try
 //        {
 //            userHash = (Hashtable)globalStatsHashtable[user.ToLower()];
 //            shortfallForMonth = ((StatMonth)userHash[currentMonth.Date]).monthlyShortfall;
 //        }
 //        catch (Exception)
 //        {


 //        } 


 //        label.Text = "R" + String.Format("{0:N0}", shortfallForMonth);
 //    }
 //    protected void getBonusByMonth(Object sender, EventArgs e)
 //    {
 //        Label label = (Label)sender;
 //        int monthsForward = Int32.Parse(label.ID.Remove(0, label.ID.Length - 2));
 //        string tempuser = label.ID.Remove(0, 13);
 //        string user = tempuser.Remove(tempuser.Length - 2);
 //        // if globalstatshashtable doesnt contain records for this user then populate
 //        if (!globalStatsHashtable.ContainsKey(user.ToLower()))
 //        {
 //            addRecordsToGlobalStatsHash(user.ToLower());
 //        }


 //        DateTime currentMonth = getStartOfCurrentFinancialYear().AddMonths(monthsForward);

 //        Hashtable userHash = null;
 //        Decimal jobValueForMonth = 0;

 //        try
 //        {
 //            userHash = (Hashtable)globalStatsHashtable[user.ToLower()];
 //            jobValueForMonth = ((StatMonth)userHash[currentMonth.Date]).monthlyBonus;
 //        }
 //        catch (Exception)
 //        {


 //        } 

         


 //       label.Text = "R" + String.Format("{0:N0}", jobValueForMonth);
 //   }
    
    

 //   protected void getCarryOverByMonth(Object sender, EventArgs e)
 //   {
 //       Label label = (Label)sender;
 //       int monthsForward = Int32.Parse(label.ID.Remove(0, label.ID.Length - 2));
 //       string tempuser = label.ID.Remove(0, 17);
 //       string user = tempuser.Remove(tempuser.Length - 2);
 //       // if globalstatshashtable doesnt contain records for this user then populate
 //       if (!globalStatsHashtable.ContainsKey(user.ToLower()))
 //       {
 //           addRecordsToGlobalStatsHash(user.ToLower());
 //       }

 //       DateTime currentMonth = getStartOfCurrentFinancialYear().AddMonths(monthsForward);

 //       Hashtable userHash = null;
 //       Decimal accumulatedCarryOverBonus = 0;

 //       try
 //       {
 //           userHash = (Hashtable)globalStatsHashtable[user.ToLower()];
 //           accumulatedCarryOverBonus = ((StatMonth)userHash[currentMonth.Date]).monthlyCarryover;
 //       }
 //       catch (Exception)
 //       {


 //       } 
       
 //       //carryoverBackDataJonathan00



 //        if (accumulatedCarryOverBonus > 0)
 //        {
 //            label.Text = "R" + String.Format("{0:N0}", accumulatedCarryOverBonus);
 //        }
 //        else
 //        {
 //            label.Text = "n/a";
 //        }
 //   }

 //   protected void getTotalBonusByMonth(Object sender, EventArgs e)
 //   {
 //       Label label = (Label)sender;
 //       int monthsForward = Int32.Parse(label.ID.Remove(0, label.ID.Length - 2));
 //       string tempuser = label.ID.Remove(0, 18);
 //       string user = tempuser.Remove(tempuser.Length - 2);
 //       // if globalstatshashtable doesnt contain records for this user then populate
 //       if (!globalStatsHashtable.ContainsKey(user.ToLower()))
 //       {
 //           addRecordsToGlobalStatsHash(user.ToLower());
 //       }

 //      // totalBonusBackDataJonathan00



 //       DateTime currentMonth = getStartOfCurrentFinancialYear().AddMonths(monthsForward);

 //       Hashtable userHash = null;
 //       Decimal total = 0;

 //       try
 //       {
 //           userHash = (Hashtable)globalStatsHashtable[user.ToLower()];
 //           total = ((StatMonth)userHash[currentMonth.Date]).monthlyTotalBonus;
 //       }
 //       catch (Exception)
 //       {


 //       } 


 //       label.Text = "R" + String.Format("{0:N0}", total);
 //   }






 //   private Decimal getSalesForRange(DateTime pFromDate,DateTime pToDate, string pUser)
 //   {
       
        
 //       Decimal result = 0;

        
 //       DateTime endOfMonthToDate = new DateTime(pToDate.Year, pToDate.Month, DateTime.DaysInMonth(pToDate.Year, pToDate.Month));


 //       if (pUser.Equals("group"))
 //       {
 //           var jobValueForMonth = (from s in db.sections
 //                                   where
 //                                   s.quote_status == "Won"
 //                                   && 
 //                                   (s.decision_date >= pFromDate)
 //                                   &&
 //                                   (s.decision_date <= endOfMonthToDate )

 //                                   select s.quote_value).Sum();
 //           if (jobValueForMonth == null)
 //               jobValueForMonth = 0;
 //           result = (Decimal)jobValueForMonth;
 //       }
 //       else
 //       {
 //           var jobValueForMonth = (from s in db.sections
 //                                   where
 //                                   s.quote_status == "Won"
 //                                   &&
 //                                   (s.decision_date >= pFromDate)
 //                                   &&
 //                                   (s.decision_date <= endOfMonthToDate)

 //                                   && s.client.consultant_name.ToLower() == pUser.ToLower()
 //                                   select s.quote_value).Sum();

 //           if (jobValueForMonth == null)
 //               jobValueForMonth = 0;
 //           result = (Decimal)jobValueForMonth;


 //       }

 //       return result;

 //   }
   
 //   private Decimal getBonusForMonth(DateTime pCheckdate, int pMonthsForward, string pUser)
 //   {
 //        DateTime checkDate = new DateTime();
        
 //       if (pCheckdate.Year != 9999){
 //           checkDate = pCheckdate;
 //       }
 //       else{
 //       checkDate = getStartOfCurrentFinancialYear().AddMonths(pMonthsForward);
 //       }

 //       Decimal result = 0;

        

 //           var jobValueForMonth = (from s in db.sections
 //                                   where
 //                                   s.quote_status == "Won"
 //                                   && s.decision_date.Value.Month == checkDate.Month
 //                                   && s.decision_date.Value.Year == checkDate.Year
 //                                   && s.client.consultant_name == pUser
 //                                   select s.quote_value).Sum();
 //           if (jobValueForMonth == null)
 //               jobValueForMonth = 0;

 //           result = (((((jobValueForMonth.Value * 100) / 114)) * 2) / 1080) * 3;

        
        


        
 //       return result;

 //   }
 //   private DateTime getStartOfCurrentFinancialYear()
 //   {
 //       int currentYear = DateTime.Now.Year;
 //       int currentMonth = DateTime.Now.Month;

 //       if (currentMonth == 1 || currentMonth == 2)
 //       {

 //           currentYear = currentYear - 1; // checks if we are in jan or feb and sets year back to fall into financial year
 //       }
 //       DateTime financialYearStart = new DateTime(currentYear, 3, 1); // a date to represent march of the current finacial year

 //       return financialYearStart;
 //   }
 //   private Decimal getTargetForCurrentFianacialYear()
 //   {
 //       Decimal target = 0;

 //       DateTime financialYearStart = getStartOfCurrentFinancialYear();
        

 //       try
 //       {
 //           target = (Decimal)(from t in db.monthly_targets
 //                              where
 //                                  t.target_date.Value.Month == financialYearStart.Month &&
 //                                  t.target_date.Value.Year == financialYearStart.Year

 //                              select t.target_amount).Single();
 //       }
 //       catch (Exception e) { }
        

 //       return target;
    
    
 //   }


 //   private bool wasOnTarget(int pMonthsForward, string pUser)
 //   {



 //       // if globalstatshashtable doesnt contain records for this user then populate
 //       if (!globalStatsHashtable.ContainsKey(pUser.ToLower()))
 //       {
 //           addRecordsToGlobalStatsHash(pUser.ToLower());
 //       }


 //       DateTime currentMonth = getStartOfCurrentFinancialYear().AddMonths(pMonthsForward);

 //       Hashtable userHash = null;
 //       decimal sales = 0;
 //       decimal target = 0;

 //       try
 //       {
 //           userHash = (Hashtable)globalStatsHashtable[pUser.ToLower()];
 //           sales = ((StatMonth)userHash[currentMonth.Date]).monthlySales;
 //           target = ((StatMonth)userHash[currentMonth.Date]).monthlyTarget;
 //       }
 //       catch (Exception)
 //       {


 //       }





 //       if (sales >= target)
 //               {
 //                   return true;
 //               }
 //               else
 //               {
 //                   return false;
 //               }

            
       
        

 //   }
    
 //   public string GetTargetRowStyle(int pMonthsBack, string pUser)
 //   {

 //       if (wasOnTarget(pMonthsBack,pUser))
 //       {
 //           return "greenRow";
 //       }
 //       else
 //       {
 //           return "redRow";
 //       }







 //   }






 //   // <!--

 //   //  <font size = '2' >< asp:Label runat = "server" ID="Label5"  OnLoad="RealQuotes" ></asp:Label></font> <br /><br />
 //   //  <font size = '2' >< asp:Label runat = "server" ID="Label6"  OnLoad="LostQuotes" ></asp:Label></font> <br /><br />
 //   //   <font size = '2' >< asp:Label runat = "server" ID="Label7"  OnLoad="hitRateQuotes" ></asp:Label></font> <br /><br />

 //   //-->






 //   public string nextEligibleConsultant()
 //   {
 //       IntranetDataDataContext db = new IntranetDataDataContext();
 //       List<consultant_allocations_new> consultants = (from c in db.consultant_allocations_news
 //                                                           //orderby getQuoteCount(c.aspnet_User.UserName), lastSectionAddedDate(c.aspnet_User.UserName), c.aspnet_User.UserName //, c.getActiveQuotes() //, c.latestProjectStartDate()
 //                                                       where !(c.Pause)
 //                                                       select c).ToList();
 //       if (consultants.Count() == 0)
 //           return "Philip";
 //       int lowestActiveQuotes = getLowestActiveQuotes();

 //       foreach (var consultant in (
 //           from c in consultants
 //           orderby getQuoteCount(c.aspnet_User.UserName), lastSectionAddedDate(c.aspnet_User.UserName), c.aspnet_User.UserName
 //           select c))
 //       {
 //           if (lowestActiveQuotes < 8)
 //           {
 //               if (!(consultant.Pause) && (getActiveQuotes(consultant.aspnet_User.UserName) < 8))
 //               {
 //                   return consultant.aspnet_User.UserName;
 //               }
 //               else if (!(consultant.Pause))
 //                   incrementGhostLeads(consultant.aspnet_User.UserName);


 //           }
 //           else
 //               if (!(consultant.Pause) && (getActiveQuotes(consultant.aspnet_User.UserName) == lowestActiveQuotes))
 //           {
 //               return consultant.aspnet_User.UserName;
 //           }
 //           else if (!(consultant.Pause))
 //               incrementGhostLeads(consultant.aspnet_User.UserName);

 //       }
 //       return "";
 //   }

 //   public int getLowestActiveQuotes()
 //   {
 //       IntranetDataDataContext db = new IntranetDataDataContext();

 //       try
 //       {
 //           return (int)(from c in db.consultant_allocations_news
 //                        where (!c.Pause)
 //                        orderby getActiveQuotes(c.aspnet_User.UserName)
 //                        select getActiveQuotes(c.aspnet_User.UserName)).Min();
 //       }
 //       catch (Exception e)
 //       {
 //           return 0;
 //       }
 //   }

 //   public int getQuoteCount(String userName)
 //   {
 //       int normalCount = 0;
 //       int ghostCount = 0;

 //       DateTime backDate = new DateTime(System.DateTime.Now.AddMonths(-4).Year, System.DateTime.Now.AddMonths(-4).Month, 1); // a date to LIMIT RRSULTS TO 3 MONTHS BACK

 //       normalCount = (from s in db.sections
 //                      where s.client.consultant_name.ToLower() == userName.ToLower()
 //                      && !(s.quote_status == "Lost" && s.quote_value == 0)
 //                      && s.date_added >= backDate
 //                      select s).Count();

 //       ghostCount = (from g in db.ghost_leads
 //                     where
 //                     g.isActive == true
 //                      && g.consultantName.ToLower() == userName.ToLower()
 //                     && g.added_date >= backDate
 //                     select g).Count();

 //       return normalCount + ghostCount;
 //   }

 //   public DateTime lastSectionAddedDate(String userName)
 //   {

 //       try
 //       {
 //           DateTime? dt;

 //           dt = (from c in ConsultantHandler.db.job_times
 //                 where c.section.client.consultant_name.ToLower() == userName.ToLower()
 //                 select c.section.date_added).Max();
 //           if (dt != null)
 //               return (DateTime)dt;
 //       }
 //       catch (Exception e)
 //       {
 //       }
 //       return DateTime.MinValue;
 //   }

 //   public int getActiveQuotes(String userName)
 //   {
 //       int count = (from j in db.job_times
 //                    where j.dept_id == 0
 //                    && j.section.active_status == 1
 //                    && j.started_date != null
 //                    && j.completed_date == null
 //                    && j.section.client.consultant_name.ToLower() == userName.ToLower()
 //                    select j).Count();
 //       return count;
 //   }

 //   public void incrementGhostLeads(String userName)
 //   {
 //       ghost_lead ghost = new ghost_lead();
 //       ghost.consultantName = userName;
 //       //ghost.client_id = consultant.clientID;
 //       ghost.added_date = DateTime.Now;
 //       ghost.isActive = true;
 //       ConsultantHandler.db.ghost_leads.InsertOnSubmit(ghost);
 //       ConsultantHandler.db.SubmitChanges();
 //   }







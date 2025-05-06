using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class sales_validation : System.Web.UI.Page
{
    IntranetDataDataContext db = null;

    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Page_Init(object sender, EventArgs e)
    {
        db = new IntranetDataDataContext();
    }


    protected void validation_info_selecting(object sender, LinqDataSourceSelectEventArgs e)
    {

        String pType = Page.Request.QueryString["pType"];

        

        //Jobsx_Received_jonathan_04

        int monthsForward = Int32.Parse(pType.Remove(0, pType.Length - 2));
        string tempuser = pType.Remove(0, 15);
        string user = tempuser.Remove(tempuser.Length - 3);

        

         DateTime checkDate = getStartOfCurrentFinancialYear().AddMonths(monthsForward);

        IQueryable<section> result;

        if (user.Equals("group"))
        {

            result = from s in db.sections
                           where
                           s.quote_status == "Won"
                           && s.decision_date.Value.Month == checkDate.Month
                           && s.decision_date.Value.Year == checkDate.Year

                           orderby s.decision_date descending
                           select s;

        }
        else
        {
            result = from s in db.sections
                     where
                     s.quote_status == "Won"
                     && s.decision_date.Value.Month == checkDate.Month
                     && s.decision_date.Value.Year == checkDate.Year
                     && s.client.consultant_name == user
                     orderby s.decision_date descending
                     select s;



        }
        e.Result = result;
    }

    private DateTime getStartOfCurrentFinancialYear()
    {
        int currentYear = DateTime.Now.Year;
        int currentMonth = DateTime.Now.Month;

        if (currentMonth == 1 || currentMonth == 2)
        {

            currentYear = currentYear - 1; // checks if we are in jan or feb and sets year back to fall into financial year
        }
        DateTime financialYearStart = new DateTime(currentYear, 3, 1); // a date to represent march of the current finacial year

        return financialYearStart;
    }
}
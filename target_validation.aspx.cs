using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class target_validation : System.Web.UI.Page
{
    IntranetDataDataContext db = null;

    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Page_Init(object sender, EventArgs e)
    {
        db = new IntranetDataDataContext();
    }

    protected void TargetsDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {

       
        int currentYear = DateTime.Now.Year;
        int currentMonth = DateTime.Now.Month;

        if (currentMonth == 1 || currentMonth == 2)
        {

            currentYear = currentYear - 1; // checks if we are in jan or feb and sets year back to fall into financial year
        }

        DateTime financialYearStart = new DateTime(currentYear, 3, 1); // a date to represent march of the current finacial year



        var targets = from t in db.monthly_targets
                      //where t.target_date >= financialYearStart
                      orderby t.target_date descending
                      select t;



        e.Result = targets;
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class time_management_data : System.Web.UI.Page
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

        if(pShowLast.Equals("true"))
        {
           

                job_times = from j in db.job_times
                            where   j.dept_id == 0 &&
                            (j.started_date != null && j.completed_date != null)
                            orderby j.completed_date descending, j.section.client.job_name
                            select j;

            
            


        }else 
                { 

                    job_times = from j in db.job_times
                                where  j.section.active_status == 1
                                       && j.dept_id == 0 
                                       && (j.started_date == null || j.completed_date == null)
                                orderby j.started_date descending, j.section.client.job_name
                                select j;

              


                        }

        e.Result = job_times;

    }
}
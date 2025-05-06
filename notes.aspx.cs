using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class notes : System.Web.UI.Page
{
    IntranetDataDataContext db = null;
    
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Page_Init(object sender, EventArgs e)
    {
        db = new IntranetDataDataContext();
        


    }


    protected void NotesDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {
        

        var result = (from r in db.activities
                        where r.activity_type == "Notes"
                        orderby r.date descending
                        select r).Take(500);



        e.Result = result;
    }
    protected void TasksDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {


        var result = (from r in db.activities
                      where r.activity_type == "Tasks"
                      orderby r.date descending
                      select r).Take(50);



        e.Result = result;
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class archived_clients : System.Web.UI.Page
{
    IntranetDataDataContext db = null;
    Dictionary<int, IEnumerable<section>> depart0sections = new Dictionary<int, IEnumerable<section>>();
    Dictionary<int, IEnumerable<section>> depart1sections = new Dictionary<int, IEnumerable<section>>();
    Dictionary<int, IEnumerable<section>> depart2sections = new Dictionary<int, IEnumerable<section>>();
    Dictionary<int, IEnumerable<section>> depart3sections = new Dictionary<int, IEnumerable<section>>();
    Dictionary<int, IEnumerable<section>> depart4sections = new Dictionary<int, IEnumerable<section>>();
    IEnumerable<section> section = null;

    protected void Page_Load(object sender, EventArgs e)
    {

    }






    protected void Page_Init(object sender, EventArgs e)
    {
        db = new IntranetDataDataContext();
    }


    protected void SectionDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {
        IQueryable<section> sections = null;



        sections = (from s in db.sections
                    where s.active_status == 0
                    select s).OrderBy(c => c.client.job_name);


        e.Result = sections;

    }

}
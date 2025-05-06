using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class package_dispatch_log_popup : System.Web.UI.Page
{
    IntranetDataDataContext db = null;

    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Page_Init(object sender, EventArgs e)
    {
        db = new IntranetDataDataContext();



    }

    protected void page_load_finish(Object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            if (titleLabel.Text.Length <= 0)
            {

                int pPackageId = -1;


                try
                {
                    pPackageId = Int32.Parse(Page.Request.QueryString["pPackageId"]);




                }
                catch (Exception ex) { }



                section_dispatch_item package = (from s in db.section_dispatch_items
                                            where s.id == pPackageId
                                                select s).Single();

                titleLabel.Text = package.wall.wall_label+" - "+ package.description;


            }
        }
    }

    protected void packageLogDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {
        int pPackageId = -1;


        try
        {
            pPackageId = Int32.Parse(Page.Request.QueryString["pPackageId"]);




        }
        catch (Exception ex) { }



        IOrderedQueryable logs = from n in db.section_dispatch_log_items
                                  where n.dispatch_item_id == pPackageId
                                 orderby n.datetime_stamp descending
                                  select n;



        e.Result = logs;
    }

   

   }
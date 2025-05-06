using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class setup_installation_teams : System.Web.UI.Page
{
    IntranetDataDataContext db = null;

    protected void Page_Init(object sender, EventArgs e)
    {
        db = new IntranetDataDataContext();



    }

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void ActiveInstallers_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {
        

        var installers = from i in db.installation_teams
                       where i.active_status == 1
                       orderby i.description
                       select i;



        e.Result = installers;
    }

    protected void ArchiveInstallers_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {


        var installers = from i in db.installation_teams
                         where i.active_status == 0
                         orderby i.description
                         select i;



        e.Result = installers;
    }

    protected void activeInstallers_ItemInserting(object sender, ListViewInsertEventArgs e)
    {       
            e.Values["active_status"] = 1;
    }

    protected void activeInstallers_ItemUpdated(object sender, ListViewUpdatedEventArgs e)
    {

        
        ArchiveInstallersListView.DataBind();

    }
    protected void archiveInstallers_ItemUpdated(object sender, ListViewUpdatedEventArgs e)
    {


        ActiveInstallersListView.DataBind();

    }




}
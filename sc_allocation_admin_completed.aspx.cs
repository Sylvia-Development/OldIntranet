using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

public partial class sc_allocation_admin_completed : System.Web.UI.Page
{
    IntranetDataDataContext db = null;
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Page_Init(object sender, EventArgs e)
    {
        db = new IntranetDataDataContext();
    }

    protected void CompletedLinqDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {
        var result = from j in db.job_times
                     where
                     j.dept_id == 2
                     && j.section.active_status == 1
                     && j.section.in_ops_dept == 1
                     && (j.started_date != null && j.completed_date != null)
                     orderby j.section.client.site_coordinator_name, j.section.client.job_name
                     select j;

        e.Result = result;

    }

    protected void CompletedListView_ItemUpdating(object sender, ListViewUpdateEventArgs e)
    {
        if (!e.NewValues["section.client.site_coordinator_name"].ToString().Equals(e.OldValues["section.client.site_coordinator_name"].ToString()))
        {

            HiddenField clientId = (HiddenField)CompletedListView.EditItem.FindControl("clientId");
            int pClientId = Int32.Parse(clientId.Value);
            var query =
                (from c in db.clients
                 where c.client_id == pClientId
                 select c).Single();

            query.site_coordinator_name = e.NewValues["section.client.site_coordinator_name"].ToString();

            db.SubmitChanges();


        }

    }

    protected void CompletedListView_ItemUpdated(object sender, ListViewUpdatedEventArgs e)
    {
       

        HiddenField jobName = (HiddenField)CompletedListView.EditItem.FindControl("jobName");

        ActivityLog log = new ActivityLog();
        log.sendConfirmationOfReallocationOfSiteCoordinatorEmail(jobName.Value, e.OldValues["section.client.site_coordinator_name"].ToString(), User.Identity.Name, e.NewValues["section.client.site_coordinator_name"].ToString());


    }

    protected void SCLinqDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {
        String[] userList = Roles.GetUsersInRole("Site Coordinator");



        List<aspnet_User> resultList = new List<aspnet_User>();

        aspnet_User firstUser = new aspnet_User();
        firstUser.UserName = null;
        resultList.Add(firstUser);



        for (int i = 0; i < (userList.GetUpperBound(0) + 1); i++)
        {

            aspnet_User user = new aspnet_User();
            user.UserName = userList[i];
            resultList.Add(user);

        }

        e.Result = resultList;

    }
}
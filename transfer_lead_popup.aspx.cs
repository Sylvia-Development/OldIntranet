using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class transfer_lead_popup : System.Web.UI.Page
{
    IntranetDataDataContext db = null;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
           FormView1.ChangeMode(FormViewMode.Insert);


        }

    }
    protected void Page_Init(object sender, EventArgs e)
    {
        db = new IntranetDataDataContext();

    }

    protected void lead_transfer_itemInserting(object sender, FormViewInsertEventArgs e)
    {
        e.Values["client_id"] = Page.Request.QueryString["pClientId"];
        e.Values["requested_by"] = Page.User.Identity.Name;
        e.Values["requested_date"] = DateTime.Now; 

    }

    protected void lead_transfer_itemInserted(object sender, FormViewInsertedEventArgs e)
    {
        string userRequested = (String)e.Values["requested_by"];
        e.Values["client_id"] = Page.Request.QueryString["pClientId"];

        //int clientId = Int32.Parse(Page.Request.QueryString["pClientId"]);
        String section_id = Page.Request.QueryString["pSectionId"];


        Label clientName = (Label) Page.Master.FindControl("clientNameLabel");

        if(clientName == null)
            clientName = new Label();
        if (userRequested != null && userRequested.Length > 0)
        {
            userRequested = "intranet";
        }
        

            ActivityLog log = new ActivityLog();
        log.sendLeadTransferRequestEmail(clientName.Text, userRequested, e.Values["reason"].ToString());

        Response.Redirect("transfer_lead_success.html");
    }
}
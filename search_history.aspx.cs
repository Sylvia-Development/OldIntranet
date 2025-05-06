using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class search_history : System.Web.UI.Page
{
	IntranetDataDataContext db = new IntranetDataDataContext();
	
	
	
	protected void Page_Load(object sender, EventArgs e)
	{

	}

	
		protected void btnBackToHistory(object sender, EventArgs e)
	{
		Response.Redirect("./search_history.aspx");
	}

	public bool getVisibility()
	{
		
			return true;
		
	}

	protected void seachHistory_OnSelecting(object sender, LinqDataSourceSelectEventArgs e)
	{
		String User = Page.Request.QueryString["pUser"];
		//Button button = Page.FindControl("btnBack") as Button;
		//button.Text = "BACK";
		//button.Visible = false;
		//button.Enabled = false;
		//button.Text = "BACK";
		if ((User != null) && (User != ""))
		{
			//if (button != null)
			//{
			//	button.Visible = true;
			//	button.Enabled = true;
			//}

			getVisibility();
			var results = (from r in db.search_histories
						   where r.user == User
						   orderby r.date descending
						   select r).Take(500);


			e.Result = results;
		}
		else
		{
			//if (button != null)
			//{
			//	button.Visible = false;
			//	button.Enabled = false;
			//}
			//getVisibility(0);
			var results = (from r in db.search_histories
						   orderby r.date descending
						   select r).Take(500);


			e.Result = results;
		}

	}
}
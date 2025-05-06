using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class my_data_graphs : System.Web.UI.Page
{
	IntranetDataDataContext db = new IntranetDataDataContext();
	protected void Page_Load(object sender, EventArgs e)
	{

	}

	public int wonLeadFromSetDateByCons(String userName)
	{
		int totalWonCount = 0;
		DateTime date = new DateTime(2022, 1, 1); // a date to LIMIT RRSULTS TO dates after 01/01/2022 - the date that we want to start measureing from


		totalWonCount = (from c in db.sections
						 where c.client.consultant_name.ToLower() == userName.ToLower()
						 && c.quote_status == "Won"
						 && c.quote_value > 0
						 && c.date_added != null
						 && c.decision_date >= date
						 select c).Count();


		return totalWonCount;
	}

	protected void btnSearchBar_Click(object sender, EventArgs e)
	{
		string value = txtSearch.Text.Trim();
		// Your Ado.Net code to get data from DB
		string[] itemsGotFromDB = { "aaaa", "bbbb", "etc" };
		//bltLstSearchItems.DataSource = itemsGotFromDB;
		//bltLstSearchItems.DataBind();
	}

}


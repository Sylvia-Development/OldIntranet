using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class logistics_control_notes_popup_new : System.Web.UI.Page
{
	IntranetDataDataContext db = null;


	protected void Page_Init(object sender, EventArgs e)
	{
		db = new IntranetDataDataContext();

	}

	protected void Page_Load(object sender, EventArgs e)
	{

	}

	protected void logistics_notes_DataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
	{


		int pLogisticsControlId = -1;


		try
		{
			pLogisticsControlId = Int32.Parse(Page.Request.QueryString["pLogisticsControlId"]);


		}
		catch (Exception ex) { }

		var logistics_notes = from l in db.logistics_control_notes
							  where l.logistics_control_id == pLogisticsControlId

							  orderby l.date_logged descending
							  select l;



		e.Result = logistics_notes;

	}

	protected void logistics_notes_ItemInserting(object sender, ListViewInsertEventArgs e)
	{

		int pLogisticsControlId = -1;


		try
		{
			pLogisticsControlId = Int32.Parse(Page.Request.QueryString["pLogisticsControlId"]);


		}
		catch (Exception ex) { }

		e.Values["logistics_control_id"] = pLogisticsControlId;
		e.Values["date_logged"] = DateTime.Now.ToString();
		e.Values["user_logged"] = User.Identity.Name;




	}

	protected void logistics_notes_ItemInserted(object sender, ListViewInsertedEventArgs e)
	{

		/*
        ActivityLog log = new ActivityLog();
        log.sendStockOrderNotesEmail(jobListItem.section.client.job_name + " - " + jobListItem.section.section_name, User.Identity.Name, e.Values["note_description"].ToString());
        */




	}


	public string GetJobInfo()
	{
		int pLogisticsControlId = -1;


		try
		{
			pLogisticsControlId = Int32.Parse(Page.Request.QueryString["pLogisticsControlId"]);


		}
		catch (Exception ex) { }

		logistics_control logisticsControlItem = (from l in db.logistics_controls
												  where l.id == pLogisticsControlId
												  select l).Single();

		return logisticsControlItem.job_list_item.section.client.job_name + " - " + logisticsControlItem.job_list_item.section.section_name;



	}
}
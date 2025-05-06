using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class job_list_notes_popup_new : System.Web.UI.Page
{
	IntranetDataDataContext db = null;


	protected void Page_Init(object sender, EventArgs e)
	{
		db = new IntranetDataDataContext();

	}

	protected void Page_Load(object sender, EventArgs e)
	{

	}

	protected void job_list_notes_DataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
	{


		int pJobListId = -1;

		try
		{
			pJobListId = Int32.Parse(Page.Request.QueryString["pJobListId"]);

		}
		catch (Exception ex) { }

		var job_list_notes = from c in db.job_list_item_notes
							 where c.job_list_item_id == pJobListId

							 orderby c.date_logged descending
							 select c;



		e.Result = job_list_notes;

	}

	protected void job_list_notes_ItemInserting(object sender, ListViewInsertEventArgs e)
	{

		int pJobListId = -1;

		try
		{
			pJobListId = Int32.Parse(Page.Request.QueryString["pJobListId"]);

		}
		catch (Exception ex) { }

		e.Values["job_list_item_id"] = pJobListId;
		e.Values["date_logged"] = DateTime.Now.ToString();
		e.Values["user_logged"] = User.Identity.Name;




	}

	protected void job_list_notes_ItemInserted(object sender, ListViewInsertedEventArgs e)
	{

		job_list_item jobListItem = getJobListItem(Int32.Parse(e.Values["job_list_item_id"].ToString()));

		ActivityLog log = new ActivityLog();
		log.sendStockOrderNotesEmail(jobListItem.section.client.job_name + " - " + jobListItem.section.section_name, User.Identity.Name, e.Values["note_description"].ToString());






	}

	private job_list_item getJobListItem(int pJobListItemId)
	{



		job_list_item jobListItem = (from j in db.job_list_items
									 where j.id == pJobListItemId

									 select j).Single();



		return jobListItem;



	}
	public string GetJobListInfo()
	{
		int pJobListId = -1;

		try
		{
			pJobListId = Int32.Parse(Page.Request.QueryString["pJobListId"]);

		}
		catch (Exception ex) { }

		job_list_item jobListItem = getJobListItem(pJobListId);

		return jobListItem.section.client.job_name + " - " + jobListItem.section.section_name + " : " + jobListItem.description;



	}


}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class stock_order_popup_new : System.Web.UI.Page
{
	IntranetDataDataContext db = null;


	protected void Page_Init(object sender, EventArgs e)
	{
		db = new IntranetDataDataContext();

	}

	protected void Page_Load(object sender, EventArgs e)
	{

	}
	protected void after_page_load(Object sender, EventArgs e)

	{

		if (!IsPostBack)
		{
			clientNameLabel.Text = getClientName();
		}

	}

	public string getClientName()
	{
		string clientName = "";

		int pSectionId = -1;

		try
		{

			pSectionId = Int32.Parse(Page.Request.QueryString["pSectionId"]);
			section sectionItem = (from s in db.sections
								   where s.section_id == pSectionId
								   select s).Single();

			clientName = sectionItem.client.job_name + " - " + sectionItem.section_name;

		}
		catch (Exception ex) { }



		return clientName;



	}



	protected void joblist_items_DataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
	{

		int pSectionId = -1;

		String sectionID = Page.Request.QueryString["pSectionId"];
		if (sectionID != null)
		{
			pSectionId = Int32.Parse(sectionID);
		}


		var job_list_items = from j in db.job_list_items
							 where j.section_id == pSectionId
							 && (j.is_snag_list_item == null || j.is_snag_list_item == false)
							 && j.item_completed == false
							 && j.production_assistant_to_order == true // means its a stock order
							 && (j.default_item_na == null || j.default_item_na == false)

							 orderby j.date_logged descending
							 select j;





		e.Result = job_list_items;


	}
	protected void completed_items_DataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
	{

		int pSectionId = -1;

		String sectionID = Page.Request.QueryString["pSectionId"];
		if (sectionID != null)
		{
			pSectionId = Int32.Parse(sectionID);
		}


		var job_list_items = from j in db.job_list_items
							 where j.section_id == pSectionId
							 && j.production_assistant_to_order == true
							 && (j.is_snag_list_item == null || j.is_snag_list_item == false)
							 && (j.item_completed == true || j.default_item_na == true)
							 && j.date_logged > DateTime.Now.AddDays(-365)

							 orderby j.date_completed descending
							 select j;





		e.Result = job_list_items;

	}

	protected void joblist_items_ItemInserting(object sender, ListViewInsertEventArgs e)
	{

		TextBox notesTextBox = (TextBox)((ListView)sender).InsertItem.FindControl("descriptionTextBox");
		TextBox dateRequiredTextBox = (TextBox)((ListView)sender).InsertItem.FindControl("datepicker");

		if (notesTextBox.Text == null || notesTextBox.Text.Trim().Length <= 0)
		{
			notesTextBox.BackColor = System.Drawing.Color.IndianRed;
			notesTextBox.ForeColor = System.Drawing.Color.White;


			e.Cancel = true;
			return;

		}
		if (dateRequiredTextBox.Text == null || dateRequiredTextBox.Text.Trim().Length <= 0)
		{
			dateRequiredTextBox.BackColor = System.Drawing.Color.IndianRed;
			dateRequiredTextBox.ForeColor = System.Drawing.Color.White;


			e.Cancel = true;
			return;

		}



		e.Values["department_id"] = Page.Request.QueryString["pDepartmentId"];
		e.Values["section_id"] = Page.Request.QueryString["pSectionId"];
		e.Values["date_logged"] = DateTime.Now.ToString();
		e.Values["order_reminder_date"] = DateTime.Now.ToString();
		e.Values["date_expected"] = e.Values["receive_by_date"];
		e.Values["user_logged"] = User.Identity.Name;
		e.Values["user_role"] = getUserRole();
		e.Values["is_main_material_order"] = false;
		e.Values["manager_has_processed_order"] = true;
		e.Values["order_needs_processing"] = false;
		e.Values["production_assistant_to_order"] = true;
		e.Values["manager_processed_date"] = DateTime.Now.ToString();
		e.Values["manager_processed_name"] = User.Identity.Name;
		e.Values["default_item_na"] = false;
		e.Values["is_waste"] = false;



	}
	protected void joblist_items_ItemInserted(object sender, ListViewInsertedEventArgs e)
	{

		string jobName = clientNameLabel.Text;

		ActivityLog log = new ActivityLog();
		log.sendStockOrderAddedEmail(jobName, e.Values["user_logged"].ToString(), e.Values["description"].ToString());


		JoblistItemsListView.DataBind();


	}

	protected void joblist_items_ItemUpdating(object sender, ListViewUpdateEventArgs e)
	{


		if (((Boolean)e.OldValues["material_processed"]) == false && ((Boolean)e.NewValues["material_processed"]) == true)
		{

			e.NewValues["item_completed"] = true;
			e.NewValues["date_completed"] = DateTime.Now.ToString();
			e.NewValues["user_completed"] = Context.User.Identity.Name;

		}


	}
	protected void joblist_items_ItemUpdated(object sender, ListViewUpdatedEventArgs e)
	{


		CompletedListView.DataBind();

	}

	private string getUserRole()
	{
		//this is a hack method - must look into it when have time

		string userRole = "";

		if (Context.User.IsInRole("Technical Services Manager"))
		{
			userRole = "Technical Services Manager";

		}
		else if (Context.User.IsInRole("Processing Manager"))
		{
			userRole = "Processing Manager";

		}
		else if (Context.User.IsInRole("Installer"))
		{
			userRole = "Installer";

		}
		else if (Context.User.IsInRole("Processing Assistant"))
		{
			userRole = "Processing Assistant";

		}
		else if (Context.User.IsInRole("Project Manager"))
		{
			userRole = "Project Manager";

		}
		else if (Context.User.IsInRole("Director"))
		{
			userRole = "Director";

		}



		return userRole;

	}
	public static string GetImage(object pStatusObject)
	{
		bool status = false;
		if (pStatusObject != null)
		{
			status = (bool)pStatusObject;
		}

		if (status)
		{
			return "images/yes.png";
		}
		else
		{
			return "images/blank.png";
		}
	}
	public static string GetOpenTag(object pStatusObject)
	{
		bool status = false;
		if (pStatusObject != null)
		{
			status = (bool)pStatusObject;
		}

		if (status)
		{
			return "<del>";
		}
		else
		{
			return "";
		}
	}
	public static string GetCloseTag(object pStatusObject)
	{
		bool status = false;
		if (pStatusObject != null)
		{
			status = (bool)pStatusObject;
		}

		if (status)
		{
			return "</del>";
		}
		else
		{
			return "";
		}
	}



}
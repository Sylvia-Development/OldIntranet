using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class advanced_search_page : System.Web.UI.Page
{
	IntranetDataDataContext db = new IntranetDataDataContext();
	bool loadBlank = false;
	//protected String getSections(int clientid)
	//{
	//	string ul = "";
	//	bool includeArchive = false;
	//	if (Page.Request.QueryString.Get("includeArchive") != null)
	//		includeArchive = Boolean.Parse(Page.Request.QueryString.Get("includeArchive"));

	//	var sections = from s in db.sections
	//				   where s.client_id == clientid
	//					&& s.active_status == 1
	//				   select s;
	//	if (includeArchive)
	//		sections = from s in db.sections
	//				   where s.client_id == clientid
	//				   select s;

	//	foreach (var section in sections)
	//	{
	//		ul += "<a href='./section_view.aspx?pClientName=" + section.client.job_name 
	//				+ "&pSectionId=" + section.section_id 
	//				+ "&pClientId=" + section.client_id + "&pDepartmentId=1#'>";
	//		ul += section.section_name;
	//		ul += "</a></br>";
	//	}
	//	return ul;
	//}
	protected string getDepartmentID()
	{
		string deptId = "1";

		if (Context.User.IsInRole("Design Consultant") && !Context.User.IsInRole("Customer Experience Manager"))
		{
			deptId = "0";
		}
		else if (Context.User.IsInRole("Customer Experience Manager"))
		{
			deptId = "6";

		}
		else if (Context.User.IsInRole("Systems Integration"))
		{
			deptId = "1";

		}
		else if (Context.User.IsInRole("Site Coordinator") && !Context.User.IsInRole("Projects Director"))
		{
			deptId = "2";
		}
		else if (Context.User.IsInRole("Installer") && (!Context.User.IsInRole("Technical Services Manager") && !Context.User.IsInRole("Technical Services Technician1") && !Context.User.IsInRole("Technical Services Technician2") && !Context.User.IsInRole("Technical Services Technician3") && !Context.User.IsInRole("Technical Services Technician4")))
		{
			deptId = "3";

		}
		else if (Context.User.IsInRole("Service Call Agent"))
		{
			deptId = "4";
		}
		else if (Context.User.IsInRole("Processing Assistant"))
		{
			deptId = "5";
		}
		else if (Context.User.IsInRole("Projects Director"))
		{
			deptId = "7";
		}
		else if (Context.User.IsInRole("Technical Services Manager"))
		{
			deptId = "8";
		}
		else if (Context.User.IsInRole("Finance Director"))
		{
			deptId = "9";
		}
		else if (Context.User.IsInRole("Finance Admin Administrator"))
		{
			deptId = "10";
		}
		else if (Context.User.IsInRole("Finance Admin Manager"))
		{
			deptId = "11";
		}
		else if (Context.User.IsInRole("Technical Administrator"))
		{
			deptId = "12";
		}
		else if (Context.User.IsInRole("Production Team Coordinator") || Context.User.IsInRole("Assembly Captain") || Context.User.IsInRole("Assembly Team"))
		{
			deptId = "13";
		}
		else if (Context.User.IsInRole("Finishes Coordinator"))
		{
			deptId = "14";
		}
		else if (Context.User.IsInRole("Design Administrator"))
		{
			deptId = "15";
		}
		else if (Context.User.IsInRole("Technical Services Technician1"))
		{
			deptId = "16"; //Spare

		}
		else if (Context.User.IsInRole("Technical Services Technician2"))
		{
			deptId = "17";//Des

		}
		else if (Context.User.IsInRole("Technical Services Technician3"))
		{
			deptId = "18";//spare

		}
		else if (Context.User.IsInRole("Technical Services Technician4"))
		{
			deptId = "19";//spare

		}
		else if (Context.User.IsInRole("Technical Plan Generation Head"))
		{
			deptId = "20";//Jose

		}
		else if (Context.User.IsInRole("Operations Manager"))
		{
			deptId = "21";//Michelle

		}
		else if (Context.User.IsInRole("Procurement Coordinator"))
		{
			deptId = "22";//Twilla

		}

		return deptId;
	}

	protected void Page_Load(object sender, EventArgs e)
	{

	}
	protected void btnHistory(object sender, EventArgs e)
	{
		Response.Redirect("./search_history.aspx");
	}
	protected void btnSearch(object sender, EventArgs e)
	{
		var txtadvancedSearch = txtAdvancedSearch.Text.ToString().Replace(" ","").Replace("(","").Replace(")","");
		if (txtadvancedSearch.Length < 3)
		{
			txtAdvancedSearch.BackColor = System.Drawing.Color.IndianRed;
			txtAdvancedSearch.ForeColor = System.Drawing.Color.White;
			//AdvancedSearchResultsListView.DataSource
			//txtadvancedSearch ("string too short");
			loadBlank = true;
			//Response.Redirect("./advanced_search_page.aspx?search=" + txtAdvancedSearch.Text.ToLower().Replace(" ", "") +
			//	"&includeArchive=" + searchCheckBox.Checked +
			//	"&details=" + ((searchNames.Checked) ? "clients" : "installation"));

			AdvancedSearchResultsListView.DataBind();
			//Response.Redirect("./advanced_search_page.aspx");
			return;
		}
		else
		{
			ActivityLog activity = new ActivityLog();
			activity.logActivity(txtadvancedSearch, User.Identity.Name, ((searchNames.Checked) ? "clients" : "installation"), searchCheckBox.Checked);

			Response.Redirect("./advanced_search_page.aspx?search=" + txtAdvancedSearch.Text.ToLower().Replace(" ", "").Replace("(", "").Replace(")", "") +
				  "&includeArchive=" + searchCheckBox.Checked +
				  "&details=" + ((searchNames.Checked) ? "clients" : "installation"));

			
		}
		//if (searchCheckBox.Checked == false && searchClients.Checked)
		//{
		//	string value = txtAdvancedSearch.Text.Trim();
		//	// Your Ado.Net code to get data from DB
		//	//string[] itemsGotFromDB = { "aaaa", "bbbb", "etc" };
		//	//bltLstSearchItems.DataSource = itemsGotFromDB;
		//	//bltLstSearchItems.DataBind();
		//	var search = (from c in db.clients
		//				  where c.names.Trim().Contains(value)
		//				  select c.job_name).ToList();

		//	foreach (var sea in search)
		//	{
		//		Console.WriteLine(sea);
		//	};
		//}


	}


	//protected void validate_searchWord(object source, ServerValidateEventArgs args)
	//{

	//	String inputNumbers = args.Value;

	//	CustomValidator validator = (CustomValidator)source;

	//	args.IsValid = true;

	//	if (inputNumbers == null || inputNumbers.Length <3)
	//	{
	//		//no value so just return
	//		return;
	//	}
	//}


	protected void search_results_onSelecting(object sender, LinqDataSourceSelectEventArgs e)
	{
		String addstring = "";
		if (loadBlank)
		{
			loadBlank = false;
			e.Result = (from s in db.sections
						where s.client.names.Contains("Any text that does not return a value")
						select s);
			return;
		}

		string searchText = Page.Request.QueryString.Get("search");
		string details = Page.Request.QueryString.Get("details");
		if (details == null)
			details = "client";

		bool includeArchive = false;

		if (Page.Request.QueryString.Get("includeArchive") != null)
			includeArchive = Boolean.Parse(Page.Request.QueryString.Get("includeArchive"));

		IQueryable<section> results;

		if (searchText == null)
		{
			e.Result = results = (from s in db.sections
								  where s.client.names.Contains("Any text that does not return a value")
								  select s);
			return;
		}
		else
		{
			
			

			

				if (includeArchive)
				{
					if (details == "clients")
					{
						e.Result = results = (from s in db.sections
											  where s.client.names.ToLower().Replace(" ", "").Replace("(", "").Replace(")", "").Contains(searchText)
											  select s);
					}

					else
					{
						e.Result = results = (from s in db.sections
											  where s.client.install_address.ToLower().Replace(" ", "").Replace("(", "").Replace(")", "").Contains(searchText)
											  select s);
					//foreach (var re in results)
					//{
					//	if (re.active_status == 1)
					//	{
					//		re.section_name = re.section_name.Concat(re.section_name.ToString(),"~Archive");
					//	}


					//}
				}
				}
				else
					if (details == "clients")
				{
					e.Result = results = (from s in db.sections
										  where s.client.names.ToLower().Replace(" ", "").Replace("(", "").Replace(")", "").Contains(searchText)
										   && s.active_status == 1
										  select s);
				}
				else
				{
					e.Result = results = (from s in db.sections
										  where s.client.install_address.ToLower().Replace(" ", "").Replace("(", "").Replace(")", "").Contains(searchText)
										   && s.active_status == 1
										  select s);
				}
			}

			var txtSearchCount = (Label)AdvancedSearchResultsListView.FindControl("txtSearchCount");
			txtSearchCount.Text = results.Count().ToString() + " Result(s) found";
		
	}

	//public void 

	//private String addParameters(String url)
	//{
	//	String deptId = Page.Request.QueryString["pDepartmentId"];
	

	//	if (url != null && url.EndsWith("aspx"))
	//	{
		

	//		if (deptId != null && deptId.Length > 0)
	//		{
	//			url = url + "&pDepartmentId=" + deptId;


	//			}



	//		}

	//	}

	//	return url;

	//}

}
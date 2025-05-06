using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class academy_items_upload : System.Web.UI.Page
{
	IntranetDataDataContext db = new IntranetDataDataContext();
	protected void Page_Load(object sender, EventArgs e)
	{

	}

	protected void Academy_Items_DataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
	{
		int SubMenuId = 0;
		if (Page.Request.QueryString["pSubMenuid"] != null)
		{
			SubMenuId = Int32.Parse(Page.Request.QueryString["pSubMenuid"]);
		}
		//int SubMenuId = Int32.Parse(Page.Request.QueryString["pSubMenuId"]);
		var rows = from r in db.academy_items
						where r.child_id == SubMenuId
						orderby r.item_order
						select r;

		e.Result = rows;
		AcademyItemsListView.DataBind();
	}

	protected void academy_Items_ItemInserting(object sender, ListViewInsertEventArgs e)
	{
		e.Values["child_id"] = Int32.Parse(Page.Request.QueryString["pSubMenuid"]);
		e.Values["user_added"] = Context.User.Identity.Name.ToLower();
		e.Values["added_date"] = System.DateTime.Now;
		//e.Values["item_type"] = "0";
	}

	//protected void academy_items_selecting(object sender, LinqDataSourceSelectEventArgs e)
	//{

	//	var statuses = from s in db.academy_sub_menus
	//				   orderby s.child_id
	//				   select s;

	//	e.Result = statuses;
	//}

	protected void academy_Items_ItemInserted(object sender, ListViewInsertedEventArgs e)
	{

	}

	public String getLabel(int? value)
	{
		//        return value.GetType().ToString();
		string label = "";
		int val = (Int32)value;

		if (val == 1)
		{
			label = "Video";
		}
		else if (val == 2)
		{
			label = "Document";
		}
		else if (val == 3)
		{
			label = "Image";
		}
		return label;
	}
}
using System;
using System.Activities.Expressions;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CuteWebUI;

public partial class uploaded_academy_items : System.Web.UI.Page
{
	IntranetDataDataContext db =  new IntranetDataDataContext();
	string rootUploadPath = "c:\\inetpub\\subdomains\\intranet\\sectionfiles\\";

	protected void Page_Load(object sender, EventArgs e)
	{

	}

	//public void plans_FileUploaded(object sender, UploaderEventArgs args)
	//{
 //       string subMenuId = Page.Request.QueryString["pSuBMenuId"];

 //       //args.FileName
 //       //Uploads filePath to the Database.
        
 //       string path = "C:\\Users\\User\\Dropbox\\Intranet_Sylvia\\Academy";

 //       System.IO.Directory.CreateDirectory(path);

 //       academy_item item = new academy_item();

 //       item.item_name = path + args.FileName; //path + ;
 //       item.child_id = int.Parse(subMenuId);
 //       item.user_added = Context.User.Identity.Name;
 //       item.added_date = System.DateTime.Now;
 //       db.academy_items.InsertOnSubmit(item);
 //       db.SubmitChanges();

 //       AcademyItemsListView.DataBind();



 //   }

    protected void Academy_Items_DataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {
        int SubMenuId = 0;
        if (Page.Request.QueryString["pSubMenuId"] != null)
            SubMenuId = Int32.Parse(Page.Request.QueryString["pSubMenuId"]);

        //int SubMenuId = Int32.Parse(Page.Request.QueryString["pSubMenuId"]);
        var reminders = from r in db.academy_items
                        where  (r.child_id == SubMenuId) && (r.item_type != null) 
                        orderby r.academy_sub_menu.child_menu_order, r.item_order
                        select r;

        e.Result = reminders;

    }

    protected void academy_items_selecting(object sender, LinqDataSourceSelectEventArgs e)
    {

        var statuses = from s in db.academy_sub_menus
                       orderby s.child_id
                       select s;

        e.Result = statuses;
    }

    protected void academy_Items_ItemInserting(object sender, ListViewInsertEventArgs e)
    {
        e.Values["child_id"] = Int32.Parse(Page.Request.QueryString["pSubMenuId"]);
        e.Values["user_added"] = Context.User.Identity.Name.ToLower();
        e.Values["added_date"] = System.DateTime.Now;
		//e.Values["item_type"] = "0";
	}


    protected void academy_Items_ItemInserted(object sender, ListViewInsertedEventArgs e)
	{

	}

	protected void btnBackToSetup(object sender, EventArgs e)
	{
		Response.Redirect("./academy_setup.aspx");
	}

	protected override void OnDataBinding(EventArgs e)
	{
		try { base.OnDataBinding(e); }

		catch (Exception ex)
		{

		}

	}
	public String getLabel(int? value)
	{
		//        return value.GetType().ToString();
		string label = "";
		int val =  (Int32)value;

		if (val == 1)
		{
			label = "Video";
		}
		else if (val == 2)
		{
			label = "pdf";
		}
		else if (val == 3)		
		{
			label = "Image";
		}
		return label;
	}

}
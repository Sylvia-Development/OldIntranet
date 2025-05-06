using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Default5 : System.Web.UI.Page
{
    protected IntranetDataDataContext db = new IntranetDataDataContext();

    protected void Page_Load(object sender, EventArgs e)
	{

	}

    private int getParentMenuID()
	{
        string pSMid = Page.Request.QueryString["pSubMenuid"];
        
        if ((pSMid != null) && (pSMid != ""))
		{
            int smid = Int32.Parse(pSMid);

            var menu = (from m in db.academy_sub_menus where m.child_id == smid select m).First();

            return menu.id;
		}
        return 0;
    }

    protected void items_DataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {


        int SubMenuId = 0;
        if (Page.Request.QueryString["pSubMenuid"] != null)
            SubMenuId = Int32.Parse(Page.Request.QueryString["pSubMenuid"]);
        //      if (SubMenuId < Int32.Parse(Page.Request.QueryString["pSubMenuid"]) )
        //{
        //          SubMenuId = Int32.Parse(Page.Request.QueryString["pSubMenuid"]);
        //}



        var populate_items = from p in db.academy_items
                             where p.child_id == SubMenuId
                             //&& p.item_type != 2

                             orderby p.item_order descending
                             select p;


        e.Result = populate_items;
    }

	protected void pdf_items_DataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
	{


        int SubMenuId = 0;
        if (Page.Request.QueryString["pSubMenuid"] != null)
            SubMenuId = Int32.Parse(Page.Request.QueryString["pSubMenuid"]);
        //      if (SubMenuId < Int32.Parse(Page.Request.QueryString["pSubMenuid"]) )
        //{
        //          SubMenuId = Int32.Parse(Page.Request.QueryString["pSubMenuid"]);
        //}



        var populate_items = from p in db.academy_items
                             where p.child_id == SubMenuId
                             && p.item_type != null
                             && p.item_type == 2

                             orderby p.item_order descending
                             select p;


        e.Result = populate_items;
    }

	//function hideMainMenu(userName)
	//{


 //           $("#mainmenu").hide();
	//}
}
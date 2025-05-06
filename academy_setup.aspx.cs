using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Windows.Input;
using System.Web.UI;
using System.Web.UI.WebControls;


public partial class academy_setup : System.Web.UI.Page
{
    IntranetDataDataContext db = new IntranetDataDataContext();
   

    protected void Page_Load(object sender, EventArgs e)
	{

	}

	protected void Page_init( object sender, EventArgs e)
	{
	
	}

        protected void contracts_DataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {

        int sectionId = Int32.Parse(Page.Request.QueryString["pSectionId"]);


        var section_files = from s in db.academy_items
                            where 
                            s.item_type == 2
                            && s.item_title == "current"
                            orderby s.added_date
                            select s;


        e.Result = section_files;


    }

	protected void btnBackToSetup(object sender, EventArgs e)
	{
		Response.Redirect("./academy_setup.aspx");
	}
	protected void delete_Menu_OnItemDeleting(object sender, ListViewDeleteEventArgs e)
    {
        //MessageBoxResult m = MessageBox.Show("The file will be saved here.", "File Save", MessageBoxButton.OKCancel);
        //if (m == m.Yes)
        //{
        //    // Do something
        //}
        //else if (m == m.No)
        //{
        //    e.Cancel = true;
        //}



        //var menu = from m in db.academy_menus select m.id;

        //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('cant delete last task')", true);

        //var subMenuItem = from d in db.academy_items where d.academy_sub_menu.id.ToString() == e.Values["id"].ToString() select d;

        //db.academy_items.DeleteAllOnSubmit(subMenuItem);

        //var subMenu = from d in db.academy_sub_menus where d.id.ToString() == e.Values["id"].ToString() select d;

        //db.academy_sub_menus.DeleteAllOnSubmit(subMenu);


       
    
    }
    protected void Add_Item(object sender, CommandEventArgs e)
	{

	}

    protected void contracts_ItemUpdating(object sender, ListViewUpdateEventArgs e)
    {



        if (!e.OldValues["status"].Equals(e.NewValues["status"]))
        // means the status has changed
        {
            //updated the last action username and date
            e.NewValues["last_action_user"] = User.Identity.Name;
            e.NewValues["last_action_date"] = System.DateTime.Now;

            

        }
    }


    protected void contracts_ItemUpdated(object sender, ListViewUpdatedEventArgs e)
    {


    }

   

    protected void events_to_add_OnItemCreate(object sender, ListViewItemEventArgs e)
    {
        
    }
    protected void academy_menu_ItemInserting(object sender, ListViewInsertEventArgs e)
    {

        
    }
    protected void Academy_Menu_DataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {

            var reminders = from r in db.academy_menus
                           
                            orderby r.parent_order
                            select r;
   
        e.Result = reminders;

    }
    protected void academy_menu_selecting(object sender, LinqDataSourceSelectEventArgs e)
    {

        var statuses = from s in db.academy_menus                      
                    orderby s.parent_order
                       select s;

        e.Result = statuses;
    }

    protected void Academy_Sub_Menu_DataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {

        var reminders = from r in db.academy_sub_menus

                        orderby r.academy_menu.parent_order, r.child_menu_order
                        select r;

        e.Result = reminders;

    }

    protected void academy_submenu_ItemInserting(object sender, ListViewInsertEventArgs e)
    {
        

    }

    protected void academy_submenu_ItemInserted(object sender, ListViewInsertedEventArgs e)
	{
        //var record = (from r in db.academy_sub_menus
        //              where r.child_name == e.Values["child_name"].ToString()
        //              select r).First();

        //record.child_description = "/aca.aspx?pSubMenuId=" + record.child_id.ToString();
        
        //db.SubmitChanges();

        ////e.Values["child_description"] = e.Values["child_description"].ToString() + e.Values["child_id"].ToString();
        //AcademySubMenuListView.DataBind();
    }


    

}
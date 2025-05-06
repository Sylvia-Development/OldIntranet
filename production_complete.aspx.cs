using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class production_complete : System.Web.UI.Page
{
    IntranetDataDataContext db = null;
    DateHandler dateHandler = null;

    protected void Page_Init(object sender, EventArgs e)
    {
        db = new IntranetDataDataContext();
        dateHandler = new DateHandler();



    }


    protected void Page_Load(object sender, EventArgs e)
    {
        

    }

    protected void production_complete_DataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {




        var production_control = from p in db.production_controls
                                 where p.job_list_item.item_completed == true
                                 && p.job_list_item.is_main_material_order == true
                                 && p.job_list_item.date_completed > dateHandler.addWorkDays(DateTime.Now,-522,2)
                                 orderby p.job_list_item.date_completed descending
                                 select p;


        e.Result = production_control;




        e.Result = production_control;

    }
    protected void completed_production_ItemUpdating(object sender, ListViewUpdateEventArgs e)
    {

        HiddenField hiddenJobListId = (HiddenField)((ListView)sender).EditItem.FindControl("jobListId");
        if (
            (bool)(e.NewValues["plan_generation_complete"]) == true
         || (bool)(e.NewValues["supplier_orders_complete"]) == true
         || (bool)(e.NewValues["finishes_complete"]) == true
         || (bool)(e.NewValues["custom_structures_complete"]) == true
         || (bool)(e.NewValues["cabinets_complete"]) == true
         )
        { // means that one of the items has been unchecked 

            var jobListObject = (from j in db.job_list_items where j.id == Int32.Parse(hiddenJobListId.Value) select j).Single();



            jobListObject.item_completed = false;
            jobListObject.date_completed = null;
            jobListObject.user_completed = null;

            db.SubmitChanges();



        }






    }
    protected void completed_production_ItemUpdated(object sender, ListViewUpdatedEventArgs e)
    {

        




    }






}
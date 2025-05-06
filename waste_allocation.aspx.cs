using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Collections;
using System.Text;


public partial class waste_allocation : System.Web.UI.Page
{
    IntranetDataDataContext db = null;
   


    protected void Page_Init(object sender, EventArgs e)
    {
        db = new IntranetDataDataContext();
        


    }


    protected void Page_Load(object sender, EventArgs e)
    {

       


    }


    public string GetWasteNames(Object pNamesObject)
    {
        string returnString = "-";

        if (pNamesObject != null)
        {
            IList<waste_name> nameList = (IList<waste_name>)pNamesObject;
            StringBuilder builder = new StringBuilder();
            foreach (waste_name name in nameList)
            {
                builder.Append(name.user_responsible);
                builder.Append("<br/>");

            }
            returnString = builder.ToString();
        }
        
        return returnString;


    }

    protected void waste_names_info_selecting(object sender, LinqDataSourceSelectEventArgs e)
    {


        String[] userList = Roles.GetUsersInRole("Installer");
        String[] userList1 = Roles.GetUsersInRole("Processing Assistant");
        String[] userList2 = Roles.GetUsersInRole("Production Assistant");
        
        
        ArrayList mainList = new ArrayList();
        mainList.AddRange(userList);
        mainList.AddRange(userList1);
        mainList.AddRange(userList2);
      

        List<aspnet_User> resultList = new List<aspnet_User>();

      



        for (int i = 0; i < mainList.Count; i++)
        {

            aspnet_User user = new aspnet_User();
            user.UserName = mainList[i].ToString();
            resultList.Add(user);

        }

        e.Result = resultList;


    }
    

    protected void waste_DataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {




        var job_list_items = from j in db.job_list_items

                             where j.is_waste == true && j.waste_names.Count == 0
                             orderby j.date_logged ascending
                             select j;





        e.Result = job_list_items;

    }
    protected void waste_ItemUpdating(object sender, ListViewUpdateEventArgs e)
    {

        CheckBoxList wasteNamesList = (CheckBoxList)WasteListView.EditItem.FindControl("check_box_name_list");
        if (wasteNamesList != null)
        {
            ListItemCollection items = wasteNamesList.Items;
            foreach (ListItem item in items)
            {
                if (item.Selected)
                {
                    waste_name name = new waste_name();
                    name.job_list_id = Int32.Parse(e.NewValues["id"].ToString());
                    name.user_responsible = item.Value;
                    
                    db.waste_names.InsertOnSubmit(name);

                }


            }
            db.SubmitChanges();


        }







    }
    protected void waste_ItemUpdated(object sender, ListViewUpdatedEventArgs e)
    {
        WasteListView2.DataBind();
    }

    protected void allocated_waste_DataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {




        var job_list_items = from j in db.job_list_items

                             where j.is_waste == true && j.waste_names.Count > 0
                             orderby j.date_logged ascending
                             select j;





        e.Result = job_list_items;

    }
    protected void allocated_waste_ItemUpdating(object sender, ListViewUpdateEventArgs e)
    {

        

        CheckBoxList wasteNamesList = (CheckBoxList)WasteListView2.EditItem.FindControl("check_box_name_list");
        if (wasteNamesList != null)
        {
            List<waste_name> wasteNames = (from w in db.waste_names
                                 where w.job_list_id == Int32.Parse(e.NewValues["id"].ToString())
                                 select w).ToList();

            db.waste_names.DeleteAllOnSubmit(wasteNames);

            ListItemCollection items = wasteNamesList.Items;
            foreach (ListItem item in items)
            {
                if (item.Selected)
                {
                    waste_name name = new waste_name();
                    name.job_list_id = Int32.Parse(e.NewValues["id"].ToString());
                    name.user_responsible = item.Value;

                    db.waste_names.InsertOnSubmit(name);

                }


            }
            db.SubmitChanges();


        }







    }
    protected void allocated_waste_ItemUpdated(object sender, ListViewUpdatedEventArgs e)
    {
        WasteListView.DataBind();
    }



   



   
}
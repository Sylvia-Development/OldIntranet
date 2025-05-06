using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MainMasterPage : System.Web.UI.MasterPage
{
    protected IntranetDataDataContext db = new IntranetDataDataContext();

    protected void Page_Load(object sender, EventArgs e)
    {
		
    }

	//protected void loadThemes(object sender, EventArgs e)
	//{
	//	if (Context.User.Identity.IsAuthenticated)
	//	{
	//		try
	//		{
				
	//		var theme = (from u in db.user_preferences
	//					 where ((u.username == Context.User.Identity.Name) && (u.preference == "theme"))
	//					 select u).First();

	//					 			theme.value = themeChooser.SelectedValue;
	//								db.SubmitChanges();
	//		}
	//		catch (System.Exception)
	//		{
	//			var pref = new user_preference
	//			{
	//				username = Context.User.Identity.Name,
	//				preference = "theme",
	//				value = themeChooser.SelectedValue
	//			};
	//			db.user_preferences.InsertOnSubmit(pref);
	//			db.SubmitChanges();				
	//		}

	//	}
	//}

}

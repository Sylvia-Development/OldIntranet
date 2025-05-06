using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class popup_master : System.Web.UI.MasterPage
{


	IntranetDataDataContext db = null;
	protected void Page_Init(object sender, EventArgs e)
	{
		db = new IntranetDataDataContext();



	}
	protected void Page_Load(object sender, EventArgs e)
	{
		//if (!IsPostBack)
		//{

			if (clientNameLabel.Text.Length <= 0)
			{

				int pClientId = -1;
				int pSectionId = -1;
				try
				{
					pClientId = Int32.Parse(Page.Request.QueryString["pClientId"]);
					pSectionId = Int32.Parse(Page.Request.QueryString["pSectionId"]);
				}
				catch (Exception ex) { }


				var result = from c in db.clients
							 where c.client_id == pClientId
							 select c;
				foreach (client c in result)
				{
					clientNameLabel.Text = c.job_name;

				}
				var result2 = from s in db.sections
							  where s.section_id == pSectionId
							  select s;
				foreach (section s in result2)
				{
					sectionLabel.Text = s.section_name;

				}

			}
		//}
	}

	//protected void loadThemes(object sender, EventArgs e)
	//{
	//	if (Context.User.Identity.IsAuthenticated)
	//	{
	//		try
	//		{

	//			var theme = (from u in db.user_preferences
	//						 where ((u.username == Context.User.Identity.Name) && (u.preference == "theme"))
	//						 select u).First();

	//			theme.value = themeChooser.SelectedValue;
	//			db.SubmitChanges();
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


	//   IntranetDataDataContext db = null;
	//   protected void Page_Init(object sender, EventArgs e)
	//   {
	//       db = new IntranetDataDataContext();



	//   }
	//   protected void Page_Load(object sender, EventArgs e)
	//   {
	//       if (!IsPostBack)
	//       {

	//           if (clientNameLabel.Text.Length <= 0)
	//           {

	//               int pClientId = -1;
	//               int pSectionId = -1;
	//               try
	//               {
	//                   pClientId = Int32.Parse(Page.Request.QueryString["pClientId"]);
	//                   pSectionId = Int32.Parse(Page.Request.QueryString["pSectionId"]);
	//               }
	//               catch (Exception ex) { }


	//               var result = from c in db.clients
	//                            where c.client_id == pClientId
	//                            select c;
	//               foreach (client c in result)
	//               {
	//                   clientNameLabel.Text = c.job_name;

	//               }
	//               var result2 = from s in db.sections
	//                             where s.section_id == pSectionId
	//                             select s;
	//               foreach (section s in result2)
	//               {
	//                   sectionLabel.Text = s.section_name;

	//               }

	//           }
	//       }
	//   }

	//protected void loadThemes(object sender, EventArgs e)
	//{
	//	if (Context.User.Identity.IsAuthenticated)
	//	{
	//		try
	//		{

	//			var theme = (from u in db.user_preferences
	//						 where ((u.username == Context.User.Identity.Name) && (u.preference == "theme"))
	//						 select u).First();

	//			theme.value = themeChooser.SelectedValue;
	//			db.SubmitChanges();
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

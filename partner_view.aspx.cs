using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class partner_view : System.Web.UI.Page
{
	IntranetDataDataContext db = new IntranetDataDataContext();

	


	protected void Page_Load(object sender, EventArgs e)
	{


	}

	protected void Page_Init(object sender, EventArgs e)
	{
		
	
	}

	protected void referral_partners_selecting(object sender, LinqDataSourceSelectEventArgs e)
	{

		//int pPartnerId = -1;
		
		
			int pPartnerId = Int32.Parse(Page.Request.QueryString["pPartnerId"]);
		
	

		var partners = from p in db.referral_partners
					   where p.id == pPartnerId
					   select p;

		e.Result = partners;


	}

	protected void validate_duplicate(object source, ServerValidateEventArgs args)
	{

		// check if there is an exact match
		var partners = from p in db.referral_partners
					   where p.name == args.Value
					   select p;

		var partnerList = partners.ToList();
		if (partnerList.Count > 0)
		{
			args.IsValid = false;
			return;
		}
		else
		{
			args.IsValid = true;
		}


	}

	protected void referral_partner_itemUpdating(object sender, FormViewUpdateEventArgs e)
	{

	}
	protected void referral_partner_itemUpdated(object sender, FormViewUpdatedEventArgs e)
	{


	}
	

}
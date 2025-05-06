using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class referral_partner_info : System.Web.UI.Page
{

    IntranetDataDataContext db = null;
    private string insertReturnPath;
    private string updateReturnPath;
    public string InsertReturnPath { get { return insertReturnPath; } set { insertReturnPath = value; } }
    public string UpdateReturnPath { get { return updateReturnPath; } set { updateReturnPath = value; } }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

          String partnerId = Page.Request.QueryString["pPartnerId"];
            

			if (partnerId != null && (partnerId.Equals("-1") || partnerId.Equals("-2")))
            {
                try
                {
                    FormView1.ChangeMode(FormViewMode.Insert);
                }catch  (Exception ex) { }
            }
            else 
            {
                try
                {
                    FormView1.ChangeMode(FormViewMode.Edit);
                }
                catch (Exception ex)
                { }
            }

        }
    }

    protected void after_page_load(object sender, EventArgs e) 
    { }

	protected void Page_Init(object sender, EventArgs e)
    {
        db = new IntranetDataDataContext();

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

    protected void referral_partners_selecting(object sender, LinqDataSourceSelectEventArgs e)
    {
        int pPartnerId = -1;
        try
        {
            pPartnerId = Int32.Parse(Page.Request.QueryString["pPartnerId"]);
        }
        catch (Exception ex) { }

        var partners = from p in db.referral_partners
                      where p.id == pPartnerId
                       select p;

        e.Result = partners;

    }
    protected void referral_partner_itemInserting(object sender, FormViewInsertEventArgs e)
    {

        e.Values["date_added"] = DateTime.Now;
        e.Values["user_added"] = User.Identity.Name;


    }

    protected void referral_partner_itemInserted(object sender, FormViewInsertedEventArgs e)
    {
        int pPartnerId = -1;


        var partners = from p in db.referral_partners
                      where p.name == (String)e.Values["name"]
                      select p;

        foreach (referral_partners rp in partners)
        {
            pPartnerId = rp.id;
        }

        ActivityLog logActivity = new ActivityLog();
        logActivity.sendNewReferralPartnerEmail((String)e.Values["name"], User.Identity.Name);
        // add the primary liaison as the person to added the partner 

        referral_partner_liaison partnerLiaison = new referral_partner_liaison();
        partnerLiaison.is_active = true;
        partnerLiaison.liaison_user_name = User.Identity.Name;
        partnerLiaison.referral_partner_id = pPartnerId;
        db.referral_partner_liaisons.InsertOnSubmit(partnerLiaison);
        db.SubmitChanges();

		String partnerId = Page.Request.QueryString["pPartnerId"];
        if(partnerId =="-1")
        {
            Response.Redirect("closeSBandRedirect.aspx?pRedirectUrl=window.close()");
            
        }
        else 
        {
			Response.Redirect("closeSBandRedirect.aspx?pRedirectUrl='partner_view.aspx%3FpPartnerId="+ pPartnerId+"'");

		}

	}

    protected void referral_partner_itemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
       
        Response.Redirect("closeSBandRedirect.aspx?pRedirectUrl=top.location");

    }

    private String addParameters(String url)
    {
        
        String partnerId = Page.Request.QueryString["pPartnerId"];


        if (url != null && url.EndsWith("aspx"))
        {
            url = url + "?pPartnerId=" + partnerId;

            
        }

        return url;

    }


}
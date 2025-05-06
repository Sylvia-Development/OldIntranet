<%@ Page Language="C#" AutoEventWireup="true" CodeFile="checkReferralPartner.aspx.cs" Inherits="checkReferralPartner" %>

<% 
    IntranetDataDataContext db = new IntranetDataDataContext();
    string s = Request.QueryString["search"];

    if (s != "")
    {
        try
        {
            var id = (from partner in db.referral_partners
                      where partner.name == s
                      select partner.id).First();

            Response.Write(id);
        }
        catch(Exception)
        {
            Response.Write("null");
        }
    }
%>

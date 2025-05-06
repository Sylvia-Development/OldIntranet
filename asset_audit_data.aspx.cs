using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Web.Security;

public partial class asset_audit_data : System.Web.UI.Page
{
    IntranetDataDataContext db = null;

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Page_Init(object sender, EventArgs e)
    {
        db = new IntranetDataDataContext();
    }

    protected void page_load_finish(Object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            if (titleLabel.Text.Length <= 0)
            {

                int pAuditId = -1;
               

                try
                {
                    pAuditId = Int32.Parse(Page.Request.QueryString["pAuditId"]);
                    



                }
                catch (Exception ex) { }

                if (pAuditId != -1)
                {
                    IQueryable<String> result = null;


                    result = from c in db.asset_audits
                             where c.id == pAuditId
                             select c.asset_group.description;

                    titleLabel.Text = result.First();


                }




            }
        }
    }

    protected void AssetAuditDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {
        int pAuditId = -1;


        try
        {
            pAuditId = Int32.Parse(Page.Request.QueryString["pAuditId"]);




        }
        catch (Exception ex) { }
        var assets = from a in db.asset_audit_items
                                   where a.audit_id == pAuditId &&
                                    a.audit_complete == false
                                    orderby a.asset_item.current_status descending
                                    select a;

       // close audit if there are no audit items left 
        if (assets.Count() <= 0 && pAuditId > -1)
        {
            var auditRecordToUpdate = (from a in db.asset_audits
                                       where a.id == pAuditId
                                       select a).Single();
            auditRecordToUpdate.audit_complete = true;
            db.SubmitChanges();

        }


        e.Result = assets;
    }

    [WebMethod]
    public static string auditItem(int pAssetId, int pAuditItemId, String pAuditUser, String pCurrentStatus, String pAuditStatus)
    {

        if (pAuditStatus == null || pAuditStatus.Trim().Length <= 0)
        {
            return "error";
        }
        
        
        
        IntranetDataDataContext db = new IntranetDataDataContext();
        string auditNote = "";
        // check if status changed and update if it did
        if (!pAuditStatus.Trim().ToLower().Equals(pCurrentStatus.Trim().ToLower()))
        {

            var recordToUpdate = (from a in db.asset_items
                                  where a.id == pAssetId
                                  select a).Single();

            recordToUpdate.current_status = pAuditStatus;

            auditNote = "Audit Note - " + pAuditUser + " changed item status from " + pCurrentStatus + " to " + pAuditStatus;
        }
        else
        {
            auditNote = "Audit Note - " + pAuditUser + " verified item status as " + pAuditStatus;
        }

        //change audit flat to complete
        var auditRecordToUpdate = (from a in db.asset_audit_items
                                   where a.id == pAuditItemId
                                   select a).Single();
        auditRecordToUpdate.audit_complete = true;

        // log the audit note

        asset_audit_note note = new asset_audit_note();
        note.item_id = pAssetId;
        note.date = DateTime.Now;
        note.logged_by = pAuditUser;
        note.audit_note = auditNote;

       db.asset_audit_notes.InsertOnSubmit(note);
        

        


        try
        {
            db.SubmitChanges();
        }
        catch (Exception e)
        {
            return e.Message;
        }





        

        return "ok";

    }



}
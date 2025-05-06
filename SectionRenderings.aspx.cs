using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SectionRenderings : System.Web.UI.Page
{

    IntranetDataDataContext db = null;
    string rootUploadPath = "/sectionfiles/";
   

    protected void Page_Load(object sender, EventArgs e)
    {
        

    }

    protected void Page_Init(object sender, EventArgs e)
    {
        db = new IntranetDataDataContext();



    }

    protected void getClientAndSectionName(Object sender, EventArgs e)
    {
        string returnName = "";




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
            returnName = c.job_name;

        }
        var result2 = from s in db.sections
                      where s.section_id == pSectionId
                      select s;
        foreach (section s in result2)
        {
            returnName = returnName + " : " + s.section_name;

        }

        Label label = (Label)sender;
        label.Text = returnName;


    }

    



    protected void renderingGallery_Load(object sender, EventArgs e)
    {
        string path = rootUploadPath + Page.Request.QueryString["pClientId"] + "/" + Page.Request.QueryString["pSectionId"] + "/Images/3DPics";
        System.IO.Directory.CreateDirectory(path);

        renderingGallery.AllowEdit = true;
        renderingGallery.AllowPostComment = false;
        renderingGallery.AllowShowComment = false;
        renderingGallery.UploadLimitMode = DotNetGallery.GalleryUploadLimitMode.Resize;
        

        renderingGallery.GalleryFolder = path;
    }
    
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CuteWebUI;

public partial class SectionFileManagement : System.Web.UI.Page
{
    IntranetDataDataContext db = null;
    string rootUploadPath = "c:\\inetpub\\subdomains\\intranet\\sectionfiles\\";
    

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
                returnName = returnName + " : "+s.section_name;

                }

        Label label = (Label)sender;
        label.Text = returnName;

        
    }


    // >>>>>>>>>> Contracts

    public void mainContract_FileUploaded(object sender, UploaderEventArgs args)
    {

        string fileDescription = "contracts";

        // insert a record into the section_files table
        section_file sf = new section_file();

        sf.section_id = Int32.Parse(Page.Request.QueryString["pSectionId"]);
        sf.filename = args.FileName;
        sf.type = fileDescription;
        sf.status = "current";
        sf.last_action_date = System.DateTime.Now;
        sf.last_action_user = User.Identity.Name;

        db.section_files.InsertOnSubmit(sf);
        db.SubmitChanges();

        int sf_ID = sf.id;
        

        //Copies the uploaded file to a new location.
        string path = rootUploadPath + Page.Request.QueryString["pClientId"] + "\\" + Page.Request.QueryString["pSectionId"] + "\\"+fileDescription;
        System.IO.Directory.CreateDirectory(path);
        args.MoveTo(path +"\\"+ sf_ID+"_"+args.FileName);

        ContractsListView.DataBind();
        

    }

    protected void contracts_DataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {

        int sectionId = Int32.Parse(Page.Request.QueryString["pSectionId"]);


        var section_files = from s in db.section_files
                            where s.section_id == sectionId 
                            && s.type == "contracts" 
                            && s.status == "current"
                            orderby s.last_action_date
                            select s;




        e.Result = section_files;


    }

    protected void contracts_ItemUpdating(object sender, ListViewUpdateEventArgs e)
    {



        if (!e.OldValues["status"].Equals(e.NewValues["status"]))
        // means the status has changed
        {
            //updated the last action username and date
            e.NewValues["last_action_user"] = User.Identity.Name;
            e.NewValues["last_action_date"] = System.DateTime.Now;




            /* ActivityLog log = new ActivityLog();
             log.sendJobSiteDeliveryDateChangedEmail(jobList.section.client.job_name + " - " + jobList.section.section_name, User.Identity.Name, DateTime.Parse(e.OldValues["site_delivery_date"].ToString()).ToString("ddd, d MMM, yyyy"), DateTime.Parse(e.NewValues["site_delivery_date"].ToString()).ToString("ddd, d MMM, yyyy"));
             */



        }
    }


    protected void contracts_ItemUpdated(object sender, ListViewUpdatedEventArgs e)
    {

       

        ArchivedContractsListView.DataBind();
        ContractsListView.DataBind();
        

    }

    protected void archived_contracts_DataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {

        int sectionId = Int32.Parse(Page.Request.QueryString["pSectionId"]);


        var section_files = from s in db.section_files
                            where s.section_id == sectionId
                            && s.type == "contracts"
                            && s.status == "archived"
                            orderby s.last_action_date
                            select s;




        e.Result = section_files;


    }

    protected void archived_contracts_ItemUpdating(object sender, ListViewUpdateEventArgs e)
    {

       


           
           if (!e.OldValues["status"].Equals(e.NewValues["status"]))
            // means the status has changed
           {
            //updated the last action username and date
            e.NewValues["last_action_user"] = User.Identity.Name;
            e.NewValues["last_action_date"] = System.DateTime.Now;




           /* ActivityLog log = new ActivityLog();
            log.sendJobSiteDeliveryDateChangedEmail(jobList.section.client.job_name + " - " + jobList.section.section_name, User.Identity.Name, DateTime.Parse(e.OldValues["site_delivery_date"].ToString()).ToString("ddd, d MMM, yyyy"), DateTime.Parse(e.NewValues["site_delivery_date"].ToString()).ToString("ddd, d MMM, yyyy"));
            */



           }
    }


    protected void archived_contracts_ItemUpdated(object sender, ListViewUpdatedEventArgs e)
    {

      

        ArchivedContractsListView.DataBind();
        ContractsListView.DataBind();


    }

    // >>>>>>>>>> AO's
    public void AO_FileUploaded(object sender, UploaderEventArgs args)
    {

        string fileDescription = "AO";

        // insert a record into the section_files table
        section_file sf = new section_file();

        sf.section_id = Int32.Parse(Page.Request.QueryString["pSectionId"]);
        sf.filename = args.FileName;
        sf.type = fileDescription;
        sf.status = "current";
        sf.last_action_date = System.DateTime.Now;
        sf.last_action_user = User.Identity.Name;

        db.section_files.InsertOnSubmit(sf);
        db.SubmitChanges();

        int sf_ID = sf.id;


        //Copies the uploaded file to a new location.
        string path = rootUploadPath + Page.Request.QueryString["pClientId"] + "\\" + Page.Request.QueryString["pSectionId"] + "\\" + fileDescription;
        System.IO.Directory.CreateDirectory(path);
        args.MoveTo(path + "\\" + sf_ID + "_" + args.FileName);

        AOListView.DataBind();


    }

    protected void AO_DataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {

        int sectionId = Int32.Parse(Page.Request.QueryString["pSectionId"]);


        var section_files = from s in db.section_files
                            where s.section_id == sectionId
                            && s.type == "AO"
                            && s.status == "current"
                            orderby s.last_action_date
                            select s;




        e.Result = section_files;


    }

    protected void AO_ItemUpdating(object sender, ListViewUpdateEventArgs e)
    {



        if (!e.OldValues["status"].Equals(e.NewValues["status"]))
        // means the status has changed
        {
            //updated the last action username and date
            e.NewValues["last_action_user"] = User.Identity.Name;
            e.NewValues["last_action_date"] = System.DateTime.Now;




            /* ActivityLog log = new ActivityLog();
             log.sendJobSiteDeliveryDateChangedEmail(jobList.section.client.job_name + " - " + jobList.section.section_name, User.Identity.Name, DateTime.Parse(e.OldValues["site_delivery_date"].ToString()).ToString("ddd, d MMM, yyyy"), DateTime.Parse(e.NewValues["site_delivery_date"].ToString()).ToString("ddd, d MMM, yyyy"));
             */



        }
    }


    protected void AO_ItemUpdated(object sender, ListViewUpdatedEventArgs e)
    {



        ArchivedAOListView.DataBind();
        AOListView.DataBind();


    }

    protected void archived_AO_DataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {

        int sectionId = Int32.Parse(Page.Request.QueryString["pSectionId"]);


        var section_files = from s in db.section_files
                            where s.section_id == sectionId
                            && s.type == "AO"
                            && s.status == "archived"
                            orderby s.last_action_date
                            select s;




        e.Result = section_files;


    }

    protected void archived_AO_ItemUpdating(object sender, ListViewUpdateEventArgs e)
    {





        if (!e.OldValues["status"].Equals(e.NewValues["status"]))
        // means the status has changed
        {
            //updated the last action username and date
            e.NewValues["last_action_user"] = User.Identity.Name;
            e.NewValues["last_action_date"] = System.DateTime.Now;




            /* ActivityLog log = new ActivityLog();
             log.sendJobSiteDeliveryDateChangedEmail(jobList.section.client.job_name + " - " + jobList.section.section_name, User.Identity.Name, DateTime.Parse(e.OldValues["site_delivery_date"].ToString()).ToString("ddd, d MMM, yyyy"), DateTime.Parse(e.NewValues["site_delivery_date"].ToString()).ToString("ddd, d MMM, yyyy"));
             */



        }
    }


    protected void archived_AO_ItemUpdated(object sender, ListViewUpdatedEventArgs e)
    {



        ArchivedAOListView.DataBind();
        AOListView.DataBind();


    }



    // >>>>>>>>>> VO's
    public void VO_FileUploaded(object sender, UploaderEventArgs args)
    {

        string fileDescription = "VO";

        // insert a record into the section_files table
        section_file sf = new section_file();

        sf.section_id = Int32.Parse(Page.Request.QueryString["pSectionId"]);
        sf.filename = args.FileName;
        sf.type = fileDescription;
        sf.status = "current";
        sf.last_action_date = System.DateTime.Now;
        sf.last_action_user = User.Identity.Name;

        db.section_files.InsertOnSubmit(sf);
        db.SubmitChanges();

        int sf_ID = sf.id;


        //Copies the uploaded file to a new location.
        string path = rootUploadPath + Page.Request.QueryString["pClientId"] + "\\" + Page.Request.QueryString["pSectionId"] + "\\" + fileDescription;
        System.IO.Directory.CreateDirectory(path);
        args.MoveTo(path + "\\" + sf_ID + "_" + args.FileName);

        AOListView.DataBind();


    }

    protected void VO_DataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {

        int sectionId = Int32.Parse(Page.Request.QueryString["pSectionId"]);


        var section_files = from s in db.section_files
                            where s.section_id == sectionId
                            && s.type == "VO"
                            && s.status == "current"
                            orderby s.last_action_date
                            select s;




        e.Result = section_files;


    }

    protected void VO_ItemUpdating(object sender, ListViewUpdateEventArgs e)
    {



        if (!e.OldValues["status"].Equals(e.NewValues["status"]))
        // means the status has changed
        {
            //updated the last action username and date
            e.NewValues["last_action_user"] = User.Identity.Name;
            e.NewValues["last_action_date"] = System.DateTime.Now;




            /* ActivityLog log = new ActivityLog();
             log.sendJobSiteDeliveryDateChangedEmail(jobList.section.client.job_name + " - " + jobList.section.section_name, User.Identity.Name, DateTime.Parse(e.OldValues["site_delivery_date"].ToString()).ToString("ddd, d MMM, yyyy"), DateTime.Parse(e.NewValues["site_delivery_date"].ToString()).ToString("ddd, d MMM, yyyy"));
             */



        }
    }


    protected void VO_ItemUpdated(object sender, ListViewUpdatedEventArgs e)
    {



        VOListView.DataBind();
        ArchiveVOListView.DataBind();


    }

    protected void archived_VO_DataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {

        int sectionId = Int32.Parse(Page.Request.QueryString["pSectionId"]);


        var section_files = from s in db.section_files
                            where s.section_id == sectionId
                            && s.type == "VO"
                            && s.status == "archived"
                            orderby s.last_action_date
                            select s;




        e.Result = section_files;


    }

    protected void archived_VO_ItemUpdating(object sender, ListViewUpdateEventArgs e)
    {





        if (!e.OldValues["status"].Equals(e.NewValues["status"]))
        // means the status has changed
        {
            //updated the last action username and date
            e.NewValues["last_action_user"] = User.Identity.Name;
            e.NewValues["last_action_date"] = System.DateTime.Now;




            /* ActivityLog log = new ActivityLog();
             log.sendJobSiteDeliveryDateChangedEmail(jobList.section.client.job_name + " - " + jobList.section.section_name, User.Identity.Name, DateTime.Parse(e.OldValues["site_delivery_date"].ToString()).ToString("ddd, d MMM, yyyy"), DateTime.Parse(e.NewValues["site_delivery_date"].ToString()).ToString("ddd, d MMM, yyyy"));
             */



        }
    }


    protected void archived_VO_ItemUpdated(object sender, ListViewUpdatedEventArgs e)
    {



        ArchiveVOListView.DataBind();
        VOListView.DataBind();


    }




    // >>>>>>>>>> Other Docs
    public void Other_FileUploaded(object sender, UploaderEventArgs args)
    {

        string fileDescription = "Other";

        // insert a record into the section_files table
        section_file sf = new section_file();

        sf.section_id = Int32.Parse(Page.Request.QueryString["pSectionId"]);
        sf.filename = args.FileName;
        sf.type = fileDescription;
        sf.status = "current";
        sf.last_action_date = System.DateTime.Now;
        sf.last_action_user = User.Identity.Name;

        db.section_files.InsertOnSubmit(sf);
        db.SubmitChanges();

        int sf_ID = sf.id;


        //Copies the uploaded file to a new location.
        string path = rootUploadPath + Page.Request.QueryString["pClientId"] + "\\" + Page.Request.QueryString["pSectionId"] + "\\" + fileDescription;
        System.IO.Directory.CreateDirectory(path);
        args.MoveTo(path + "\\" + sf_ID + "_" + args.FileName);

        OtherListView.DataBind();


    }

    protected void other_DataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {

        int sectionId = Int32.Parse(Page.Request.QueryString["pSectionId"]);


        var section_files = from s in db.section_files
                            where s.section_id == sectionId
                            && s.type == "Other"
                            && s.status == "current"
                            orderby s.last_action_date
                            select s;




        e.Result = section_files;


    }

    protected void other_ItemUpdating(object sender, ListViewUpdateEventArgs e)
    {



        if (!e.OldValues["status"].Equals(e.NewValues["status"]))
        // means the status has changed
        {
            //updated the last action username and date
            e.NewValues["last_action_user"] = User.Identity.Name;
            e.NewValues["last_action_date"] = System.DateTime.Now;




            /* ActivityLog log = new ActivityLog();
             log.sendJobSiteDeliveryDateChangedEmail(jobList.section.client.job_name + " - " + jobList.section.section_name, User.Identity.Name, DateTime.Parse(e.OldValues["site_delivery_date"].ToString()).ToString("ddd, d MMM, yyyy"), DateTime.Parse(e.NewValues["site_delivery_date"].ToString()).ToString("ddd, d MMM, yyyy"));
             */



        }
    }


    protected void other_ItemUpdated(object sender, ListViewUpdatedEventArgs e)
    {



        otherArchivedListView.DataBind();
        OtherListView.DataBind();


    }

    protected void other_archived_DataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {

        int sectionId = Int32.Parse(Page.Request.QueryString["pSectionId"]);


        var section_files = from s in db.section_files
                            where s.section_id == sectionId
                            && s.type == "Other"
                            && s.status == "archived"
                            orderby s.last_action_date
                            select s;




        e.Result = section_files;


    }

    protected void other_archived_ItemUpdating(object sender, ListViewUpdateEventArgs e)
    {





        if (!e.OldValues["status"].Equals(e.NewValues["status"]))
        // means the status has changed
        {
            //updated the last action username and date
            e.NewValues["last_action_user"] = User.Identity.Name;
            e.NewValues["last_action_date"] = System.DateTime.Now;




            /* ActivityLog log = new ActivityLog();
             log.sendJobSiteDeliveryDateChangedEmail(jobList.section.client.job_name + " - " + jobList.section.section_name, User.Identity.Name, DateTime.Parse(e.OldValues["site_delivery_date"].ToString()).ToString("ddd, d MMM, yyyy"), DateTime.Parse(e.NewValues["site_delivery_date"].ToString()).ToString("ddd, d MMM, yyyy"));
             */



        }
    }


    protected void other_archived_ItemUpdated(object sender, ListViewUpdatedEventArgs e)
    {



        OtherListView.DataBind();
        otherArchivedListView.DataBind();


    }




    // >>>>>>>>>> Signoffs

    public void signoff_FileUploaded(object sender, UploaderEventArgs args)
    {

        string fileDescription = "Signoff";

        // insert a record into the section_files table
        section_file sf = new section_file();

        sf.section_id = Int32.Parse(Page.Request.QueryString["pSectionId"]);
        sf.filename = args.FileName;
        sf.type = fileDescription;
        sf.status = "current";
        sf.last_action_date = System.DateTime.Now;
        sf.last_action_user = User.Identity.Name;

        db.section_files.InsertOnSubmit(sf);
        db.SubmitChanges();

        int sf_ID = sf.id;


        //Copies the uploaded file to a new location.
        string path = rootUploadPath + Page.Request.QueryString["pClientId"] + "\\" + Page.Request.QueryString["pSectionId"] + "\\" + fileDescription;
        System.IO.Directory.CreateDirectory(path);
        args.MoveTo(path + "\\" + sf_ID + "_" + args.FileName);

        signoffListView.DataBind();


    }

    protected void signoff_DataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {

        int sectionId = Int32.Parse(Page.Request.QueryString["pSectionId"]);


        var section_files = from s in db.section_files
                            where s.section_id == sectionId
                            && s.type == "Signoff"
                            && s.status == "current"
                            orderby s.last_action_date
                            select s;




        e.Result = section_files;


    }

    protected void signoff_ItemUpdating(object sender, ListViewUpdateEventArgs e)
    {



        if (!e.OldValues["status"].Equals(e.NewValues["status"]))
        // means the status has changed
        {
            //updated the last action username and date
            e.NewValues["last_action_user"] = User.Identity.Name;
            e.NewValues["last_action_date"] = System.DateTime.Now;




            /* ActivityLog log = new ActivityLog();
             log.sendJobSiteDeliveryDateChangedEmail(jobList.section.client.job_name + " - " + jobList.section.section_name, User.Identity.Name, DateTime.Parse(e.OldValues["site_delivery_date"].ToString()).ToString("ddd, d MMM, yyyy"), DateTime.Parse(e.NewValues["site_delivery_date"].ToString()).ToString("ddd, d MMM, yyyy"));
             */



        }
    }


    protected void signoff_ItemUpdated(object sender, ListViewUpdatedEventArgs e)
    {



        archivedSignoffListView.DataBind();
        signoffListView.DataBind();


    }

    protected void archived_signoff_DataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {

        int sectionId = Int32.Parse(Page.Request.QueryString["pSectionId"]);


        var section_files = from s in db.section_files
                            where s.section_id == sectionId
                            && s.type == "Signoff"
                            && s.status == "archived"
                            orderby s.last_action_date
                            select s;




        e.Result = section_files;


    }

    protected void archived_signoff_ItemUpdating(object sender, ListViewUpdateEventArgs e)
    {





        if (!e.OldValues["status"].Equals(e.NewValues["status"]))
        // means the status has changed
        {
            //updated the last action username and date
            e.NewValues["last_action_user"] = User.Identity.Name;
            e.NewValues["last_action_date"] = System.DateTime.Now;




            /* ActivityLog log = new ActivityLog();
             log.sendJobSiteDeliveryDateChangedEmail(jobList.section.client.job_name + " - " + jobList.section.section_name, User.Identity.Name, DateTime.Parse(e.OldValues["site_delivery_date"].ToString()).ToString("ddd, d MMM, yyyy"), DateTime.Parse(e.NewValues["site_delivery_date"].ToString()).ToString("ddd, d MMM, yyyy"));
             */



        }
    }


    protected void archived_signoff_ItemUpdated(object sender, ListViewUpdatedEventArgs e)
    {



        archivedSignoffListView.DataBind();
        signoffListView.DataBind();


    }





    // >>>>>>>>>> Signoff Plans

    public void plans_FileUploaded(object sender, UploaderEventArgs args)
    {

        string fileDescription = "Plans";
        

        // insert a record into the section_files table
        section_file sf = new section_file();

        sf.section_id = Int32.Parse(Page.Request.QueryString["pSectionId"]);
        sf.filename = args.FileName;
        sf.type = fileDescription;
        sf.status = "current";
        sf.last_action_date = System.DateTime.Now;
        sf.last_action_user = User.Identity.Name;

        db.section_files.InsertOnSubmit(sf);
        db.SubmitChanges();

        int sf_ID = sf.id;


        //Copies the uploaded file to a new location.

        string path = rootUploadPath + Page.Request.QueryString["pClientId"] + "\\" + Page.Request.QueryString["pSectionId"] + "\\" + fileDescription;
        System.IO.Directory.CreateDirectory(path);
        
        args.MoveTo(path + "\\"+ sf_ID + "_" + args.FileName);

        PlansListView.DataBind();


    }

    protected void plans_DataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {

        int sectionId = Int32.Parse(Page.Request.QueryString["pSectionId"]);


        var section_files = from s in db.section_files
                            where s.section_id == sectionId
                            && s.type == "Plans"
                            && s.status == "current"
                            orderby s.last_action_date
                            select s;




        e.Result = section_files;


    }

    protected void plans_ItemUpdating(object sender, ListViewUpdateEventArgs e)
    {



        if (!e.OldValues["status"].Equals(e.NewValues["status"]))
        // means the status has changed
        {
            //updated the last action username and date
            e.NewValues["last_action_user"] = User.Identity.Name;
            e.NewValues["last_action_date"] = System.DateTime.Now;




            /* ActivityLog log = new ActivityLog();
             log.sendJobSiteDeliveryDateChangedEmail(jobList.section.client.job_name + " - " + jobList.section.section_name, User.Identity.Name, DateTime.Parse(e.OldValues["site_delivery_date"].ToString()).ToString("ddd, d MMM, yyyy"), DateTime.Parse(e.NewValues["site_delivery_date"].ToString()).ToString("ddd, d MMM, yyyy"));
             */



        }
    }


    protected void plans_ItemUpdated(object sender, ListViewUpdatedEventArgs e)
    {



        PlansListView.DataBind();
        ArchivedPlansListView.DataBind();


    }

    protected void archived_plans_DataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {

        int sectionId = Int32.Parse(Page.Request.QueryString["pSectionId"]);


        var section_files = from s in db.section_files
                            where s.section_id == sectionId
                            && s.type == "Plans"
                            && s.status == "archived"
                            orderby s.last_action_date
                            select s;




        e.Result = section_files;


    }

    protected void archived_plans_ItemUpdating(object sender, ListViewUpdateEventArgs e)
    {





        if (!e.OldValues["status"].Equals(e.NewValues["status"]))
        // means the status has changed
        {
            //updated the last action username and date
            e.NewValues["last_action_user"] = User.Identity.Name;
            e.NewValues["last_action_date"] = System.DateTime.Now;




            /* ActivityLog log = new ActivityLog();
             log.sendJobSiteDeliveryDateChangedEmail(jobList.section.client.job_name + " - " + jobList.section.section_name, User.Identity.Name, DateTime.Parse(e.OldValues["site_delivery_date"].ToString()).ToString("ddd, d MMM, yyyy"), DateTime.Parse(e.NewValues["site_delivery_date"].ToString()).ToString("ddd, d MMM, yyyy"));
             */



        }
    }


    protected void archived_plans_ItemUpdated(object sender, ListViewUpdatedEventArgs e)
    {



        ArchivedPlansListView.DataBind();
        PlansListView.DataBind();


    }




    // >>>>>>>>>> PE Plans

    public void PEPlans_FileUploaded(object sender, UploaderEventArgs args)
    {

        string fileDescription = "PEPlans";

        // insert a record into the section_files table
        section_file sf = new section_file();

        sf.section_id = Int32.Parse(Page.Request.QueryString["pSectionId"]);
        sf.filename = args.FileName;
        sf.type = fileDescription;
        sf.status = "current";
        sf.last_action_date = System.DateTime.Now;
        sf.last_action_user = User.Identity.Name;

        db.section_files.InsertOnSubmit(sf);
        db.SubmitChanges();

        int sf_ID = sf.id;


        //Copies the uploaded file to a new location.
        string path = rootUploadPath + Page.Request.QueryString["pClientId"] + "\\" + Page.Request.QueryString["pSectionId"] + "\\" + fileDescription;
        System.IO.Directory.CreateDirectory(path);
        args.MoveTo(path + "\\" + sf_ID + "_" + args.FileName);

        PEPlansListView.DataBind();


    }

    protected void PEPlans_DataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {

        int sectionId = Int32.Parse(Page.Request.QueryString["pSectionId"]);


        var section_files = from s in db.section_files
                            where s.section_id == sectionId
                            && s.type == "PEPlans"
                            && s.status == "current"
                            orderby s.last_action_date
                            select s;




        e.Result = section_files;


    }

    protected void peplans_ItemUpdating(object sender, ListViewUpdateEventArgs e)
    {



        if (!e.OldValues["status"].Equals(e.NewValues["status"]))
        // means the status has changed
        {
            //updated the last action username and date
            e.NewValues["last_action_user"] = User.Identity.Name;
            e.NewValues["last_action_date"] = System.DateTime.Now;




            /* ActivityLog log = new ActivityLog();
             log.sendJobSiteDeliveryDateChangedEmail(jobList.section.client.job_name + " - " + jobList.section.section_name, User.Identity.Name, DateTime.Parse(e.OldValues["site_delivery_date"].ToString()).ToString("ddd, d MMM, yyyy"), DateTime.Parse(e.NewValues["site_delivery_date"].ToString()).ToString("ddd, d MMM, yyyy"));
             */



        }
    }


    protected void peplans_ItemUpdated(object sender, ListViewUpdatedEventArgs e)
    {



        PEPlansListView.DataBind();
        ArchivedPEPlansListView.DataBind();


    }

    protected void archived_peplans_DataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {

        int sectionId = Int32.Parse(Page.Request.QueryString["pSectionId"]);


        var section_files = from s in db.section_files
                            where s.section_id == sectionId
                            && s.type == "PEPlans"
                            && s.status == "archived"
                            orderby s.last_action_date
                            select s;




        e.Result = section_files;


    }

    protected void archived_PEPlans_ItemUpdating(object sender, ListViewUpdateEventArgs e)
    {





        if (!e.OldValues["status"].Equals(e.NewValues["status"]))
        // means the status has changed
        {
            //updated the last action username and date
            e.NewValues["last_action_user"] = User.Identity.Name;
            e.NewValues["last_action_date"] = System.DateTime.Now;




            /* ActivityLog log = new ActivityLog();
             log.sendJobSiteDeliveryDateChangedEmail(jobList.section.client.job_name + " - " + jobList.section.section_name, User.Identity.Name, DateTime.Parse(e.OldValues["site_delivery_date"].ToString()).ToString("ddd, d MMM, yyyy"), DateTime.Parse(e.NewValues["site_delivery_date"].ToString()).ToString("ddd, d MMM, yyyy"));
             */



        }
    }


    protected void archived_PEPlans_ItemUpdated(object sender, ListViewUpdatedEventArgs e)
    {



        ArchivedPEPlansListView.DataBind();
        PEPlansListView.DataBind();


    }













    public string GetFilePath(Object pFileIdObject,Object pTypeObject, Object pSectionObject, Object pFilenameObject)
    {

        try
        {
            string pType = pTypeObject.ToString();
            section pSection = (section)pSectionObject;
            int pFileId = (int)pFileIdObject;
            int pSectionId = pSection.section_id;
            int pClientId = pSection.client_id;
            string pFileName = pFilenameObject.ToString();


            return "/sectionfiles/" + pClientId + "/" + pSectionId + "/" + pType + "/" + pFileId+"_"+pFileName;

           
        }
        catch (Exception e)
        {
            
            return "error :"+e.Message;
        }


    }




}
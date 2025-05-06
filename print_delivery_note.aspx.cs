using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class print_delivery_note : System.Web.UI.Page
{
    IntranetDataDataContext db = null;
    ActivityLog log = null;
    static DateTime pNewDispatchEvent = new DateTime();
    static int packageCount = 0;
    


    protected void Page_Init(object sender, EventArgs e)
    {
        db = new IntranetDataDataContext();
        log = new ActivityLog();


    }
    protected void Page_Load(object sender, EventArgs e)
    {
        pNewDispatchEvent = new DateTime();
        packageCount = 0;

        DateTime eventId = DateTime.Parse(Page.Request.QueryString["pEvent"]);
        int sectionId = Int32.Parse(Page.Request.QueryString["pSectionId"]);

        DateTime pOpenEvent = new DateTime(8888, 8, 8); // this is the date of the current open event 
        if (pOpenEvent.Equals(eventId)) // means that this was an open event that now needs to be closed 
        {
            DateTime newDispatchEvent = DateTime.Now;
            pNewDispatchEvent = newDispatchEvent;

            (from p in db.section_dispatch_items
             where p.wall.section_id == sectionId &&
             p.dispatch_event == eventId
             select p).ToList().ForEach(x => x.dispatch_event = newDispatchEvent);

            db.SubmitChanges();


        }



    }

    public static string GetDeliveryAddress(object pSectionIdObject)
    {

        IntranetDataDataContext db = new IntranetDataDataContext();
        int pSectionId = -1;
        string result = "";
        if (pSectionIdObject != null)
        {

            pSectionId = Int32.Parse(pSectionIdObject.ToString());


            section theSection = (from s in db.sections
                                  where s.section_id == pSectionId
                                  select s).Single();
            result = theSection.client.install_address;
        }

        return result.ToString().Replace("\n", "<br/>");


    }

    public static string GetClientRef(object pSectionIdObject)
    {

        IntranetDataDataContext db = new IntranetDataDataContext();
        int pSectionId = -1;
        string result = "";
        if (pSectionIdObject != null)
        {

            pSectionId = Int32.Parse(pSectionIdObject.ToString());


            section theSection = (from s in db.sections
                                  where s.section_id == pSectionId
                                  select s).Single();
            result = theSection.client.job_name + " - " + theSection.section_name;
        }

        return result;


    }
    public static string GetDispatchEvent(object pEventObject)
    {

        IntranetDataDataContext db = new IntranetDataDataContext();
        DateTime pDispatchEvent = new DateTime();
        string result = "";
        if (pEventObject != null)
        {

            pDispatchEvent = DateTime.Parse(pEventObject.ToString());

            DateTime pOpenEvent = new DateTime(8888, 8, 8); // this is the date of an open event 
            if (pOpenEvent.Equals(pDispatchEvent)) // means that this was an open event so must use the closed event created in page load
            {
                pDispatchEvent = pNewDispatchEvent;


            }



            }

        result = pDispatchEvent.ToString("dd MMM yyyy HH:mm:ss");

        return result;


    }

    public static string GetPackageCount()
    {

        

        return packageCount.ToString();


    }

    

    protected void WallsDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {
        int pSectionId = -1;
        DateTime pOpenEvent = new DateTime(8888, 8, 8); // this is the date of an open event 
        DateTime pEvent = new DateTime();
        try
        {
            pSectionId = Int32.Parse(Page.Request.QueryString["pSectionId"]);
            pEvent = DateTime.Parse(Page.Request.QueryString["pEvent"]);
            if (pOpenEvent.Equals(pEvent)) // means that this was an open event so must use the closed event created in page load
            {
                pEvent = pNewDispatchEvent;


            }


        }
        catch (Exception ex) { }


        var theWalls = (from p in db.section_dispatch_items
                      where p.wall.section_id == pSectionId
                      &&
                       (p.dispatch_event.Value.Date == pEvent.Date &&
                       p.dispatch_event.Value.Hour == pEvent.Hour &&
                       p.dispatch_event.Value.Minute == pEvent.Minute &&
                       p.dispatch_event.Value.Second == pEvent.Second) 
                      orderby p.wall.wall_order
                      select p).GroupBy(i => i.wall_id).Select(g => g.First());



        e.Result = theWalls;
    }

    protected void packageDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {
        
        int pWallId = -1;       
        int pSectionId = -1;
        DateTime pOpenEvent = new DateTime(8888, 8, 8); // this is the date of an open event 
        DateTime pEvent = new DateTime();
        try
        {
            pSectionId = Int32.Parse(Page.Request.QueryString["pSectionId"]);
            pWallId = Int32.Parse(e.SelectParameters["wallId"].ToString());
            pEvent = DateTime.Parse(Page.Request.QueryString["pEvent"]);
            if (pOpenEvent.Equals(pEvent)) // means that this was an open event so must use the closed event created in page load
            {
                pEvent = pNewDispatchEvent;


            }


        }
        catch (Exception ex) { }

        var packages = from p in db.section_dispatch_items
                       where p.wall.section_id == pSectionId &&
                       (p.dispatch_event.Value.Date == pEvent.Date &&
                       p.dispatch_event.Value.Hour == pEvent.Hour &&
                       p.dispatch_event.Value.Minute == pEvent.Minute &&
                       p.dispatch_event.Value.Second == pEvent.Second) &&
                       p.wall_id == pWallId &&
                       p.current_status == "Dispatched"
                       orderby p.id
                       select p;


        packageCount += packages.Count();

        

        e.Result = packages;
    }







    protected void ordersDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {
        
        int pSectionId = -1;
        DateTime pOpenEvent = new DateTime(8888, 8, 8); // this is the date of an open event 
        DateTime pEvent = new DateTime();
        try
        {
            pSectionId = Int32.Parse(Page.Request.QueryString["pSectionId"]);
            
            pEvent = DateTime.Parse(Page.Request.QueryString["pEvent"]);
            if (pOpenEvent.Equals(pEvent)) // means that this was an open event so must use the closed event created in page load
            {
                pEvent = pNewDispatchEvent;


            }


        }
        catch (Exception ex) { }

        var packages = (from p in db.section_dispatch_items
                       where p.wall.section_id == pSectionId &&
                       (p.dispatch_event.Value.Date == pEvent.Date &&
                       p.dispatch_event.Value.Hour == pEvent.Hour &&
                       p.dispatch_event.Value.Minute == pEvent.Minute &&
                       p.dispatch_event.Value.Second == pEvent.Second) &&
                       p.current_status == "Dispatched"
                       orderby p.id
                       select p).GroupBy(i => i.job_list_order_id).Select(g => g.First()); 
                       

       

        e.Result = packages; 

    }
}
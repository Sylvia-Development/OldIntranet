using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class LeftNavMasterPage : System.Web.UI.MasterPage
{
    IntranetDataDataContext db = null;
    
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Page_Init(object sender, EventArgs e)
    {
        db = new IntranetDataDataContext();
    }

    protected void new_client_button_Click(object sender, EventArgs e)
    {
        Response.Redirect("client_info.aspx?pClientId=-1");
    }

    protected void new_section_button_Click(object sender, EventArgs e)
    {
        String clientId = Page.Request.QueryString["pClientId"];
        Response.Redirect("section_info.aspx?pClientId=" + clientId+"&pSectionId=-1");
    }

  


    



   


    protected void TreeView1_TreeNodePopulate(object sender, TreeNodeEventArgs e)
    {
        switch (e.Node.Depth)
        {
            case 0:
                if(e.Node.Text.Equals("Active Jobs")){
                    fillJobs(e.Node,1);
                }else{
                    if(e.Node.Text.Equals("Archive Jobs")){
                        fillJobs(e.Node,0);
                    }  
                }
                break;
            case 1:
                if(e.Node.ValuePath.StartsWith("Active Jobs")){
                    fillSections(e.Node,1);
                }else{
                    if (e.Node.ValuePath.StartsWith("Archive Jobs"))
                    {
                        fillSections(e.Node,0);
                    }  
                }
                break;
        }
    }

    private void fillJobs(TreeNode parent,int activeStatus)
    {
       
        IEnumerable<client> clients =
        from c in db.clients
        orderby c.job_name
        select c;

        foreach (client c in clients)
          {
              Boolean correctStatus = false;
              foreach (section s in c.sections) {
                  if (s.active_status == activeStatus) {
                      correctStatus = true;
                      break;
                  }
              }
              if (c.sections.Count == 0 && activeStatus == 1) {
                  correctStatus = true;
              }  

              if (correctStatus)
              {
                  String currentClientId = Page.Request.QueryString["pClientId"];
                  TreeNode node = new TreeNode();
                  node.Text = c.job_name;
                  node.Value = c.client_id.ToString();
                  node.NavigateUrl = "client_info.aspx?pClientId=" + c.client_id.ToString();
                  node.PopulateOnDemand = true;
                  node.SelectAction = TreeNodeSelectAction.SelectExpand;
                  if (node.Value.Equals(currentClientId))
                  {
                    node.Expanded = true;
                  }
                  else{
                    node.Expanded = false;
                  }
                  parent.ChildNodes.Add(node);
              }
           }
    }

    private void fillSections(TreeNode parent,int activeStatus)
    {
        

        IEnumerable<section> sections =
        from s in db.sections
        where s.client_id == Int32.Parse(parent.Value) && s.active_status == activeStatus
        orderby s.section_name
        select s;

        foreach (section s in sections)
        {

            TreeNode node = new TreeNode();
            node.Text = s.section_name;
            node.Value = s.section_id.ToString();
            node.NavigateUrl = "section_info.aspx?pDepartmentId=0&pClientId=" + s.client_id.ToString() + "&pSectionId=" + s.section_id.ToString();
            
            node.PopulateOnDemand = false;
            node.SelectAction = TreeNodeSelectAction.SelectExpand;
            parent.ChildNodes.Add(node);
        }
    }




}

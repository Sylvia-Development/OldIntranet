<%@ Page Title="" EnableViewState="False" Language="C#" MasterPageFile="~/ManagementLeftNavMasterPage.master" AutoEventWireup="true" CodeFile="management_dashboard_view.aspx.cs" Inherits="management_dashboard_view" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentPlaceHolder" Runat="Server">

<div id="one_column">
 <h1><%  String deptId = Page.Request.QueryString["pDepartmentId"];
         String userName = Page.Request.QueryString["pUserName"];
         String pSeeAll = Page.Request.QueryString["pSeeAll"];

         if (pSeeAll != null && pSeeAll.Equals("yes"))
         {
             userName = "";
         }
         else
         {

             if ((userName == null || userName.Length <= 0) && Context.User.IsInRole("Design Consultant"))
             {
                 userName = Context.User.Identity.Name;
             }
         }



         Response.Write(Page.Request.QueryString["pStatusName"]);
            
    
%> </h1>


<a 

style="background-color:#C0C0C0;
	border-top: 1px solid #ececcf;
	border-left: 1px solid #ececcf;
	border-bottom: 1px solid #86866b;
	border-right: 1px solid #86866b;
	height:100%;
	padding:5px;
	color:Black;
	font-weight:bold;
	text-decoration:none;"
	href="reminders_dashboard.aspx?pDepartmentId=<%Response.Write(Page.Request.QueryString["pDepartmentId"]); %>&pUserName=<%Response.Write(userName); %>">Reminders</a>
<br />
&nbsp
<hr />


<%  String Message = Page.Request.QueryString["pMessage"];
    if (Message != null && Message.Length > 0)
    {
        Response.Write("<div style=\"margin-left:40px;\"><font color='red' size='3'>" + Message + "</font><br/><br/><br/></div>");
    }
        %> 


<%
    
    String seeAll = Page.Request.QueryString["pSeeAll"];

    if (deptId != null && deptId.Equals("0"))
    {
        if(Context.User.IsInRole("Design Consultant"))
        {
            if (seeAll == null || seeAll.Length == 0)
            {
                Response.Write("<a href=\"management_dashboard_view.aspx?pDepartmentId=0&pStatusId=" + (Page.Request.QueryString["pStatusId"]) + "&pStatusName=" + (Page.Request.QueryString["pStatusName"])  +"&pSeeAll=yes\"><font color=\"black\">  All Consultants</font>   </a>"); 
                
            }
            
        }
        else{

            if (userName != null && userName.Length > 0)
            {
                Response.Write("<a href=\"management_dashboard_view.aspx?pDepartmentId=0&pStatusId=" + (Page.Request.QueryString["pStatusId"]) + "&pStatusName=" + (Page.Request.QueryString["pStatusName"]) + "&pSeeAll=yes\"><font color=\"black\">  All Consultants</font>   </a>");

            }
            
            
                   
        }
        
     
        
    }
    
 
    
  %>
 <br />
    
<asp:ListView ID="ListView2" runat="server"
                DataSourceID="SectionLinqDataSource">
                <ItemTemplate>
                <input type="hidden" id="hiddenInput2" value='<%# Eval("section_id") %>' runat="server" />
                <tr style="background-color:#DCDCDC;color: #000000;">
                    <td>
                    
                        <a      style="color:black"  
                                href="management_client_info.aspx?pDepartmentId=<%Response.Write(Page.Request.QueryString["pDepartmentId"]);%>&pClientId=<%# Eval("client_id")%> "> 
                                <b><u>   <%# Eval("client.job_name") %></u></b>
                        </a>
                                
                         - 
                         <a      style="color:black"  
                                href="section_info.aspx?pDepartmentId=<%Response.Write(Page.Request.QueryString["pDepartmentId"]);%>&pClientId=<%# Eval("client_id")%>&pSectionId=<%# Eval("section_id")%>"> 
                                <b>  <%# Eval("section_name") %></b>
                        </a>        

                      </td>
                    
                    
                    
                    
                    
                    
                    
                    <td align="center"> 
                        <asp:FormView ID="ContactFormView" runat="server"
                            DataSourceID="ContactLinqDataSource">
                            <ItemTemplate>
                                <a href="section_view.aspx?pReminderType=0&pSectionId=<%# Eval("section_id")%>&pDepartmentId=<%# Eval("department_id")%>&pClientId=<%# Eval("section.client_id")%>    "><%# Eval("reminder1") %></a>
                                                
                                
                            </ItemTemplate>
                        </asp:FormView>      </td>
                    <td align="center"> <asp:FormView ID="WorkflowFormView" runat="server"
                            DataSourceID="WorkflowLinqDataSource">
                            <ItemTemplate>
                                <a href="section_view.aspx?pReminderType=1&pSectionId=<%# Eval("section_id")%>&pDepartmentId=<%# Eval("department_id")%>&pClientId=<%# Eval("section.client_id")%>    "><%# Eval("reminder1") %></a>
                
                                
                            </ItemTemplate>
                        </asp:FormView>  </td>
                        
                    <td> <a href="management_dashboard_view.aspx?pDepartmentId=<%Response.Write(Page.Request.QueryString["pDepartmentId"]);%>&pUserName=<%# Eval("client.consultant_name") %>&pStatusId=<%Response.Write(Page.Request.QueryString["pStatusId"]);%>&pStatusName=<%Response.Write(Page.Request.QueryString["pStatusName"]);%>"><font color="black">  <%# Eval("client.consultant_name") %></font>   </a>
                    
                        
                </tr>
                
                
                <asp:LinqDataSource ID="ContactLinqDataSource" runat="server"
                ContextTypeName="IntranetDataDataContext"  
                 OnSelecting="ContactDataSource_Selecting">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="hiddenInput2" Name="sectionId" PropertyName="value" Type="Int32" />
                    </SelectParameters>
                
                </asp:LinqDataSource>
                <asp:LinqDataSource ID="WorkflowLinqDataSource" runat="server"
                ContextTypeName="IntranetDataDataContext"  
                 OnSelecting="WorkflowDataSource_Selecting">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="hiddenInput2" Name="sectionId" PropertyName="value" Type="Int32" />
                    </SelectParameters>
                
                </asp:LinqDataSource>
                
                
                </ItemTemplate>
                <LayoutTemplate>
                
              
                        <table cellpadding="4" ID="itemPlaceholderContainer" runat="server" border="1" 
                            style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;font-family: Verdana, Arial, Helvetica, sans-serif;">
                            <tr class="tableheaderrow">
                            <th >&nbsp</th>
                            <th>Next Contact Task</th>
                            <th>Next Workflow Task</th>
                            <th>Consultant Name</th>
                            
                            </tr>
                            <tr ID="itemPlaceholder" runat="server">
                            
                            </tr>
                        </table>

            </LayoutTemplate>
            <EmptyDataTemplate>
                <font size = "2px"bold="true" color="red">No Sections in this status</font>
            
            </EmptyDataTemplate>
            
                </asp:ListView>
                
                <asp:LinqDataSource ID="SectionLinqDataSource" runat="server"
                ContextTypeName="IntranetDataDataContext"  
                TableName="sections" OnSelecting="SectionDataSource_Selecting">
                </asp:LinqDataSource>
                
















    
    </div>









</asp:Content>


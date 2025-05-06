<%@ Page Title="" Language="C#" MasterPageFile="~/ManagementLeftNavMasterPage.master" AutoEventWireup="true" CodeFile="management_dashboard.aspx.cs" Inherits="management_dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentPlaceHolder" Runat="Server">
 <script type="text/javascript">
     $(function () {
         $('.changeStatusDropdown').change(function () {


             var $this = $(this), // the drop down that changed
             $thisRow = $this.closest('tr'), // the drop down's row
             $thisSectionId = $thisRow.find('.sectionIdHolder');
             $thisDeptId = $thisRow.find('.deptIdIdHolder'); 

             $.ajax({
                 type: "POST",
                 url: "management_dashboard.aspx/changeStatus",
                 data: '{pSectionId: ' + $thisSectionId.val() + ',pNewStatusId:' + $this.val() + ',pDepatmentId:' + $thisDeptId.val() + ' }',
                 contentType: "application/json; charset=utf-8",
                 dataType: "json",
                 success: OnSuccess,
                 failure: function (response) {
                     alert(response.d);
                 }
             });



         });
     });
     function OnSuccess(response) {
        
         saveScroll();
         location.reload();
     }
 
 </script>
 <div class="titleDiv">
 <% String deptId = Page.Request.QueryString["pDepartmentId"];
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
         } %>
 
 <h1>
         
        <% if (deptId != null && deptId.Equals("0"))
         {
             Response.Write("DESIGN CRM");
             if (userName != null && userName.Length > 0)
             {
                 Response.Write(" - " + userName);
             }
             else
             {
                 Response.Write(" - all consultants");
             }   
             
         }
         else if (deptId != null && deptId.Equals("1"))
         {
             Response.Write("Production Management");
         }
         else if (deptId != null && deptId.Equals("2"))
         {
             Response.Write("PROJECTS CRM");
         }
         else if (deptId != null && deptId.Equals("3"))
         {
             Response.Write("Set Reminders");
         }
         else if (deptId != null && deptId.Equals("4"))
         {
             Response.Write("SERVICE CALL CRM");
         }
           else if (deptId != null && deptId.Equals("10"))
           {
               Response.Write("FINANCE & ADMIN");
           }          
    
%> </h1>
<div id="toolbar">
<%
    
    String seeAll = Page.Request.QueryString["pSeeAll"];

    if (deptId != null && deptId.Equals("0"))
    {
        if(Context.User.IsInRole("Design Consultant"))
        {
            if (seeAll == null || seeAll.Length == 0)
            {
                Response.Write("<a href=\"management_dashboard.aspx?pDepartmentId=0&pSectionFilter="+Page.Request.QueryString["pSectionFilter"]+"&pSeeAll=yes\">  <img src=\"Images/allconsultants.png\" title=\"all consultants\" />   </a>"); 
                
            }
            
        }
        else{

            if (userName != null && userName.Length > 0)
            {
                Response.Write("<a href=\"management_dashboard.aspx?pDepartmentId=0&pSectionFilter=" + Page.Request.QueryString["pSectionFilter"] + "&pSeeAll=yes\"><img src=\"Images/allconsultants.png\" title=\"all consultants\" />  </a>");

            }
            
            
                   
        }
        
    } %>&nbsp&nbsp
<a  href="reminders_dashboard.aspx?pDepartmentId=<%Response.Write(Page.Request.QueryString["pDepartmentId"]); %>&pUserName=<%Response.Write(userName); %>" >
    <img src="Images/reminder.png" title="reminders"/></a>
    </div>
</div>

<%if (deptId != null && deptId.Equals("0"))
  { %>



<%  String Message = Page.Request.QueryString["pMessage"];
    if (Message != null && Message.Length > 0)
    {
        Response.Write("<div ><font color='#9d0d0d' size='4'>" + Message + "</font><br/><br/><br/></div>");
    }
        %> 



      
     
                
                
        
      <asp:ListView ID="NoSectionListView" runat="server"
        DataSourceID="NoSectionLinqDataSource">
        <ItemTemplate>
        <tr >
        <td><a href="client_info_new.aspx?pDepartmentId=0&pClientId=<%# Eval("client_id")%>&pSectionId=-1" rel="shadowbox;height=490;width=650">
            
              <font color="black"> <u><%# Eval("job_name") %></u> </font>
            
            </a>
        </td>
        <td><a href="section_info.aspx?pClientId=<%# Eval("client_id")%>&pSectionId=-1">
            
                >> Add Section >>
            
            </a>
        </td>
        </tr>    
                            
            
        </ItemTemplate>
          <LayoutTemplate>
          <div class="smallheading"> Clients with no Sections</div>
        
            <table cellpadding="4" ID="itemPlaceholderContainer" runat="server" border="1">
                <tr ID="itemPlaceholder" runat="server">
                
                </tr>
            </table>
            </LayoutTemplate>
            
      </asp:ListView>
      <asp:LinqDataSource ID="NoSectionLinqDataSource" runat="server"
        ContextTypeName="IntranetDataDataContext"  
         OnSelecting="NoSectionDataSource_Selecting">
      </asp:LinqDataSource>
     
     <br />

     
      <asp:ListView ID="NoConsultantListView" runat="server"
        DataSourceID="NoConsultantLinqDataSource">
        <ItemTemplate>
        <tr >
        <td>
        <%# Eval("job_name") %>
        </td>
        <td>
            <a href="client_info_new.aspx?pDepartmentId=0&pClientId=<%# Eval("client_id")%>&pSectionId=-1" rel="shadowbox;height=500;width=700">
            
              <font color="black"> <u> >> Assign Consultant >></u> </font>
            
            </a>
        </td>
        </tr>    
                            
            
        </ItemTemplate>
          <LayoutTemplate>
          <div class="smallheading"> Clients with no Consultant </div>
        
            <table ID="itemPlaceholderContainer" runat="server" border="0" class="themeContent">
                
                
                
                
                <tr ID="itemPlaceholder" runat="server">
                
                </tr>
            </table>
            </LayoutTemplate>
            
      </asp:ListView>
      <asp:LinqDataSource ID="NoConsultantLinqDataSource" runat="server"
        ContextTypeName="IntranetDataDataContext"  
         OnSelecting="NoConsultantDataSource_Selecting">
      </asp:LinqDataSource>
  
        
      <%
        
    }%>
    
 <br />
    <asp:ListView ID="ListView1" runat="server" DataKeyNames="status_id" 
        DataSourceID="StatusLinqDataSource">
        <ItemTemplate>
            
                
                <br />
                <div class="smallheading"><%# Eval("status_name") %></div>
                
                
                
                <input type="hidden" id="hiddenInput" value='<%# Eval("status_id") %>' runat="server" />
                
                
                <asp:ListView ID="ListView2" runat="server"
                DataSourceID="SectionLinqDataSource">
                <ItemTemplate>
                <input type="hidden" id="hiddenInput2" value='<%# Eval("section_id") %>' runat="server" />

                
                <tr >
                    
                        <td nowrap>
                       
                        <a onclick="saveScroll()"  href="client_info_new.aspx?pDepartmentId=<%Response.Write(Page.Request.QueryString["pDepartmentId"]);%>&pClientId=<%# Eval("client_id")%>" rel="shadowbox;height=500;width=700"> 
                                  <%# Eval("client.job_name") %>
                        </a>
                                
                         - 
                         <a  href="section_info.aspx?pDepartmentId=<%Response.Write(Page.Request.QueryString["pDepartmentId"]);%>&pClientId=<%# Eval("client_id")%>&pSectionId=<%# Eval("section_id")%>" rel="shadowbox;height=400;width=600"> 
                                 <%# Eval("section_name") %>
                             
                        </a> &nbsp <font color="maroon"><asp:Label runat="server" Visible='<%# Eval("in_ops_dept").ToString().Equals("1")?true :false%>' Text='<%# getSnagListCount(Eval("section_id")) %>'></asp:Label></font>
                                    

                      </td>
                    <td><%# Eval("section_id") %></td>
                    
                    
                   <td >  
                    
                    <asp:FormView ID="ContactFormView" runat="server"
                            DataSourceID="ContactLinqDataSource">
                            <ItemTemplate>
                    
                    
                                <a href="section_view.aspx?pReminderType=0&pSectionId=<%# Eval("section_id")%>&pDepartmentId=<%# Eval("department_id")%>&pClientId=<%# Eval("section.client_id")%>    "><%# Eval("reminder1") %></a>
                               
                               
                                    
                                    
                                </ItemTemplate>
                        </asp:FormView>
                   
                   
                   
                   </td>
                   <td nowrap >  
                     <asp:FormView ID="FormView1" runat="server"
                            DataSourceID="ContactLinqDataSource">
                            <ItemTemplate>
                    
                    
                                
                               
                                <%# Eval("reminder_due_date", "{0:dddd, d MMM, yyyy}")%>
                                    
                                    
                                </ItemTemplate>
                        </asp:FormView>
                   </td>
                    
                     
                      
                        
                    <td> <a href="management_dashboard.aspx?pDepartmentId=<%Response.Write(Page.Request.QueryString["pDepartmentId"]);%>&pSectionFilter=<%Response.Write(Page.Request.QueryString["pSectionFilter"]); %>&pUserName=<%# Eval("client.consultant_name") %>"><font color="black">  <%# Eval("client.consultant_name") %></font>   </a>
                    
                    <td nowrap>
                        
                        
                        
                       <a  href="client_category_popup.aspx?pClientId=<%# Eval("client_id")%>" rel="shadowbox;height=500;width=800"> 
                                 <img src="Images/responses.png" title="client responses" />
        </a>       
       &nbsp&nbsp 
                        
                        
                    <%String deptId = Page.Request.QueryString["pDepartmentId"];
                      if (deptId != null && deptId.Equals("0"))
                      { %><a  href="section_info.aspx?pDepartmentId=<%Response.Write(Page.Request.QueryString["pDepartmentId"]);%>&pClientId=<%# Eval("client_id")%>&pSectionId=-1" rel="shadowbox;height=280;width=400"> 
                          <img src="Images/add_section.png" title="add section" />
                        </a> &nbsp&nbsp
                        <%} %>
                        <a  href="task_view_popup.aspx?pDepartmentId=<%Response.Write(Page.Request.QueryString["pDepartmentId"]);%>&pClientId=<%# Eval("client_id")%>&pSectionId=<%# Eval("section_id")%>" rel="shadowbox;height=550;width=750"> 
                        <img src="Images/tasks.png" title="tasks" />
                        </a>&nbsp&nbsp
                        <a  href="notes_view_popup.aspx?pDepartmentId=<%Response.Write(Page.Request.QueryString["pDepartmentId"]);%>&pClientId=<%# Eval("client_id")%>&pSectionId=<%# Eval("section_id")%>" rel="shadowbox;height=550;width=750"> 
                        <img src="Images/notes.png" title="notes"/>
                        </a>&nbsp&nbsp
                         <%
                      if (deptId != null && deptId.Equals("0"))
                      { %>
                      <a  href="sms_log_popup.aspx?pDepartmentId=<%Response.Write(Page.Request.QueryString["pDepartmentId"]);%>&pClientId=<%# Eval("client_id")%>" rel="shadowbox;height=550;width=750"> 
                        <img src="Images/cell-phone.png" title="sms logs" />
                        </a>&nbsp&nbsp

                         <%} %>

                       
                       <a href="javascript:void(0)"  onclick="toggle_visibility(<%# Eval("section_id")%>)">
                         <img  src="Images/change_status.png" title="change status" />
                     </a><br />
                     <asp:TextBox Width="1%" style="display:none;"  ID="sectionIdHolder" class="sectionIdHolder" runat="server" Text='<%# Eval("section_id")%>' />
                         <asp:TextBox Width="1%" style="display:none;"  ID="deptIdIdHolder" class="deptIdIdHolder" runat="server" Text='<%# Page.Request.QueryString["pDepartmentId"]%>' />
                   
                     <div id="<%# Eval("section_id")%>"   style="display:none;">
                       
                        
                         <asp:DropDownList  id="changeStatusDropdown" class="changeStatusDropdown" Width="100%" 
                                                      DataSourceID = "StatusChangeLinqDataSource" 
                                                      DataValueField = "status_id"  
                                                      DataTextField="status_name"
                                                      SelectedValue='<%# getSelectedValue(Eval("quote_status_id"),Eval("production_status_id"),Eval("service_call_status_id")) %>'   
                                                      runat="server">
                            
                        </asp:DropDownList> 
                       
                        
                    
                     </div>

                        </td>
                        
                </tr>
                
                
                <asp:LinqDataSource ID="ContactLinqDataSource" runat="server"
                ContextTypeName="IntranetDataDataContext"  
                 OnSelecting="ContactDataSource_Selecting">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="hiddenInput2" Name="sectionId" PropertyName="value" Type="Int32" />
                        <asp:ControlParameter ControlID="hiddenInput" Name="statusId" PropertyName="value" Type="Int32" />
                    </SelectParameters>
                
                </asp:LinqDataSource>
               <asp:LinqDataSource ID="StatusChangeLinqDataSource" runat="server"
                 ContextTypeName="IntranetDataDataContext" 
                 TableName="status" OnSelecting="status_change_selecting"> 
                </asp:LinqDataSource>
                
                
                </ItemTemplate>
                <LayoutTemplate>
                
              
                        <table ID="itemPlaceholderContainer" runat="server" border="0" class="themeContent">
                            
                            <tr  class="tableheaderrow">
                            <th  >&nbsp</th>
                                <th  >&nbsp</th>
                            <th>Next Task Due</th>
                            <th>Reminder Date</th>
                            <th>Consultant</th>
                            <th  >&nbsp</th>
                            
                            </tr>
                            <tr ID="itemPlaceholder" runat="server">
                            
                            </tr>
                        </table>

            </LayoutTemplate>
            
                </asp:ListView>
                
                <asp:LinqDataSource ID="SectionLinqDataSource" runat="server"
                ContextTypeName="IntranetDataDataContext"  
                TableName="sections" OnSelecting="SectionDataSource_Selecting">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="hiddenInput" Name="statusId" PropertyName="value" Type="Int32" />
                    </SelectParameters>
                
                </asp:LinqDataSource>
                
                
                
                
                
                
                
                
               
            </li>
        </ItemTemplate>
        
        <EmptyDataTemplate>
            No data was returned.
        </EmptyDataTemplate>
        
        <LayoutTemplate>
            <ul ID="itemPlaceholderContainer" runat="server" >
                
                <li ID="itemPlaceholder" runat="server" />
                </ul>
                
            </LayoutTemplate>
            
       
       
    </asp:ListView>




    <asp:LinqDataSource ID="StatusLinqDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" OrderBy="display_order" 
        TableName="status" OnSelecting="StatusDataSource_Selecting">
    </asp:LinqDataSource>
  
</asp:Content>


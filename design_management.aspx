<%@ Page Title="" Language="C#" MasterPageFile="~/ManagementLeftNavMasterPage.master" AutoEventWireup="true" CodeFile="design_management.aspx.cs" Inherits="design_management" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentPlaceHolder" Runat="Server">
<script type="text/javascript">
    if (sessionStorage["design_management.activeTab"] == undefined)
        sessionStorage["design_management.activeTab"] = 0;

	$(function () {
		$("#tabs").tabs({
			show: function () {
                var selectedTab = $('#tabs').tabs('option', 'selected');

                sessionStorage["design_management.activeTab"] = selectedTab;
                $("#hidLastTab").val(selectedTab);
                                                       },
			selected: sessionStorage["design_management.activeTab"]
                
                                     });
    });
</script>


  
     <asp:HiddenField ID="hdnSelectedTab" runat="server" Value="0" />


    <div id="tabs" border="0px" style="background:white; border:white;">
    <ul class="ui-widget" border="0px" style="background:white; border:white;">


            <li id="tabs1"><a href="#tabs-1">Lead Transfer Requests</a></li>
            <li id="tabs2"><a href="#tabs-2">Consultant Allocation</a></li>
                      
        
    </ul>
    <div id="tabs-1">
    <asp:ListView ID="LeadTransferListView" runat="server" DataKeyNames="id" 
        DataSourceID="LeadTransferDataSource" 
         OnItemUpdating = "lead_transfer_ItemUpdating"
          OnItemUpdated="lead_transfer_ItemUpdated">
        <ItemTemplate>
                
            <tr >

                <td><%# Eval("client.job_name")%> &nbsp&nbsp<a  href="notes_view_popup.aspx?pDepartmentId=0&pClientId=<%# Eval("client.client_id")%>" rel="shadowbox;height=550;width=750"> 
                        <img src="Images/notes.png" title="notes"/>
                        </a>&nbsp&nbsp   </td>
                
                 <td >
                    <%#Eval("requested_by") %> - <%#Eval("requested_date","{0:ddd, d MMM, yyyy}") %>  

                </td>
                <td style="width:40%;" >
  
                        <%#Eval("reason").ToString().Replace("\n", "<br/>") %>

                </td>
 
              
                <td   align="center">
               
    
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Process Request" /> &nbsp
                   
                </td>
                
            </tr>
            
        </ItemTemplate>
        <EmptyDataTemplate>
            <table id="Table1" runat="server" >
                <tr>
                    <td>
                        You have no transfers to process.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        
        <LayoutTemplate>
         
                        <table ID="tablesorter" cellpadding="3" runat="server" border="0" class="themeContent" >
                            
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                   
        </LayoutTemplate>
        <EditItemTemplate>



            <asp:HiddenField ID="jobName" runat="server"  Value='<%# Bind("client.job_name") %>'/>
            <asp:HiddenField ID="clientId" runat="server"  Value='<%# Bind("client.client_id") %>'/>
            <asp:HiddenField ID="requestedBy" runat="server"  Value='<%# Bind("requested_by") %>'/>

            <tr class="editrow">

                   <td nowrap>  <%# Eval("client.job_name")%>  </td>
                
                 <td nowrap >
                    <%#Eval("requested_by") %> - <%#Eval("requested_date","{0:ddd, d MMM, yyyy}") %>  

                </td>

                    <td nowrap style="width:40%;" >
  
                        <%#Eval("reason").ToString().Replace("\n", "<br/>") %>

                </td>
                  
               
                
               
                 <td nowrap align="left" valign="top">
                 
                  <table>
                    <tr>
                         <td nowrap>
                  <asp:CheckBox ID="declinedCheckBox1" class="declined_checkbox"  Text="Declined" TextAlign="Right" runat="server" Checked=' <%# Eval("is_request_declined") != null ? Eval("is_request_declined") : false %>' Enabled='true' />
                         </td>  
                        <td nowrap>                                                                                                                                                                        
                  <asp:DropDownList ID="Consultant_DropDownList" Width="100%" class="ui-corner-all ui-widget-header ui-autocomplete-input ui-accordion-content-active ui-accordion ui-widget ui-helper-reset"
                                                     DataSourceID = "ConsultantLinqDataSource" 
                                                      DataValueField = "UserName"  
                                                      DataTextField="UserName"
                                                      
                                                      SelectedValue='<%# Bind("client.consultant_name") %>'
                                                         
                                                      runat="server">
                               
                            
                        </asp:DropDownList>
                  

          </td>
                   <td nowrap>
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                        Text="Save" />
                       </td> 
                        <td nowrap>
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                        Text="X" />
                            </td>
                       </tr>
                      </table>  
                        
                </td>
                
            </tr>
        </EditItemTemplate>
        
    </asp:ListView>

<asp:LinqDataSource ID="LeadTransferDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="True" 
        EnableInsert="False" EnableUpdate="True" TableName="lead_transfers"
        OnSelecting="lead_transfers_DataSource_Selecting">
</asp:LinqDataSource>
    <asp:LinqDataSource ID="ConsultantLinqDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableInsert="False" 
        EnableUpdate="False" TableName="aspnet_Users"
         OnSelecting ="consultant_info_selecting">
    </asp:LinqDataSource>

    </div>
  
<br />
     <div id ="tabs-2">


         <br />
        <h1 class="ui-widget-content ui-corner-all">The next Eligible Consultant is<strong> <%= nextEligibleConsultant()  %> </strong></h1>
    <br />
    <h3 class="ui-widget-content ui-corner-all">Eligible Consultants for Allocation</h3>
    <br />
	<asp:ListView ID="ConsultantAllocationListView" runat="server" DataKeyNames="ID" 
        DataSourceID="ConsultantsDataSource" >
         
        <ItemTemplate>
                
           <tr >
                <td nowrap>                
               <%# Eval("aspnet_User.UserName")%>           
                </td>
                    
                    <td nowrap align="center"> <%# getActiveQuotes((String) Eval("aspnet_User.UserName")) %></td>
                    <td nowrap align="center"> <%# getRealQuotes((String) Eval("aspnet_User.UserName")) %></td>
                    <td nowrap align="center"> <%# getGhostQuotes((String) Eval("aspnet_User.UserName")) %></td>
                    <td nowrap align="center"> <%# getQuoteCount((String) Eval("aspnet_User.UserName")) %></td>
           
                <td nowrap >        
                    <asp:Button ID="PauseButton" runat="server" CommandName="Pause" Text="Pause" CommandArgument= '<%# Eval("ID") %>' OnCommand="pause_consultant_allocation_OnCommand" />                     
                </td>
                
            </tr>
            
        </ItemTemplate>
        <LayoutTemplate>
         
                        <table ID="tablesorter" cellpadding="3" runat="server" border="0" class="themeContent">
                            <tr id="Tr2" runat="server">  
                                <th  align="center" ><font size="2">Consultant Name</font></th>
                                <th  align="center" ><font size="2">Active Quotes Count</font></th>
                                <th  align="center" ><font size="2">Real Qoutes Count</font></th>
                                <th  align="center" ><font size="2">Skipped Qoutes Count</font></th>
                                <th  align="center" ><font size="2">Total Qoute Count</font></th>
                                <th colspan="4" align="center" ><font size="2"></font></th>
                            </tr>
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                   
      </LayoutTemplate>     

    </asp:ListView>


    <asp:LinqDataSource ID="ConsultantsDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="False" 
        EnableInsert="False" EnableUpdate="False" TableName="consultant_allocations_new"
        OnSelecting="eligible_consultants_onSelecting">
    </asp:LinqDataSource>
    
    <br />
    <h3 style="padding:5px; width:50%;" class="ui-widget-content ui-corner-all">Paused Consultants</h3>
    <br />


    <asp:ListView ID="PausedConsultantListView" runat="server" DataKeyNames="ID" 
        DataSourceID="pausedConsultantsDataSource"  >
         
        <ItemTemplate>
                
           <tr >
                <td nowrap>                
               <%# Eval("aspnet_User.UserName")%>           
                </td>
               
                <td nowrap align="center"> <%# getActiveQuotes((String) Eval("aspnet_User.UserName")) %></td>
                <td nowrap align="center"> <%# getRealQuotes((String) Eval("aspnet_User.UserName")) %></td>
                <td nowrap align="center"> <%# getGhostQuotes((String) Eval("aspnet_User.UserName")) %></td>
                <td nowrap align="center"> <%# getQuoteCount((String) Eval("aspnet_User.UserName")) %></td>
               
                       
                  <td nowrap>  <asp:Button ID="PauseButton" runat="server" CommandName="UnPause" Text="UnPause" CommandArgument= '<%# Eval("ID") %>' OnCommand="unpause_consultant_allocation_OnCommand" /> </td>
                
            </tr>
            
        </ItemTemplate>
        <LayoutTemplate>
         
                        <table ID="tablesorter" runat="server" border="0" class="tableSpacing paddedTable themeContent" >
                            <tr id="Tr2" runat="server">  
                                <th  align="center" ><font size="2">Consultant Name</font></th>
                                <th  align="center" ><font size="2">Active Quotes Count</font></th>
                                <th  align="center" ><font size="2">Real Quotes Count</font></th>
                                <th  align="center" ><font size="2">Skipped Quotes Count</font></th>
                                <th  align="center" ><font size="2">Total Qoute Count</font></th>
                                <th colspan="2" align="center" ><font size="2"></font></th>
                            </tr>
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                   
      </LayoutTemplate>

    </asp:ListView>


    <asp:LinqDataSource ID="pausedConsultantsDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="False" 
        EnableInsert="False" EnableUpdate="False" TableName="consultant_allocations_new"
        OnSelecting="paused_Consultant_onSelecting">
    </asp:LinqDataSource>

     </div>

</div>


</asp:Content>


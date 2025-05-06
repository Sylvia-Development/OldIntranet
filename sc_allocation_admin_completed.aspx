<%@ Page Title="" Language="C#" MasterPageFile="~/ManagementLeftNavMasterPage.master" AutoEventWireup="true" CodeFile="sc_allocation_admin_completed.aspx.cs" Inherits="sc_allocation_admin_completed" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentPlaceHolder" Runat="Server">
     <h1>Site Coordinator Allocation - Completed Projects</h1>

    



     <asp:ListView ID="CompletedListView" runat="server" 
        DataSourceID="CompletedLinqDataSource"
         OnItemUpdating="CompletedListView_ItemUpdating"
          OnItemUpdated="CompletedListView_ItemUpdated"
         DataKeyNames="id" >
        <ItemTemplate>
        <tr >
        <td>
            <%# Eval("section.client.job_name") %>-<%# Eval("section.section_name") %>
        </td>
        <td><%# Eval("section.section_id") %></td>
        <td>
           
             <%# Eval("section.client.site_coordinator_name") %>

        </td>
           
            <td   align="center">
               
    
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Reallocate Site Coordinator" /> 
                   
                </td>
        </tr>    
                            
            
        </ItemTemplate>
          <LayoutTemplate>
          
        
            <table ID="itemPlaceholderContainer" runat="server" border="0" class="tableSpacing paddedTable themeContent">
                <tr>
                <th colspan="5" >Completed Projects</th>
                
                </tr>
                
                
                
                <tr ID="itemPlaceholder" runat="server">
                
                </tr>
            </table>
            </LayoutTemplate>
          <EditItemTemplate>

              <asp:HiddenField ID="clientId" runat="server"  Value='<%# Bind("section.client.client_id") %>'/>
              <asp:HiddenField ID="jobName" runat="server"  Value='<%# Bind("section.client.job_name") %>'/>

         

            <tr class="editrow">

                  <td>
            <%# Eval("section.client.job_name") %>-<%# Eval("section.section_name") %>
        </td>
                  
        <td><%# Eval("section.section_id") %></td>
     
          <td>                                                                                                                                                                        
                  <asp:DropDownList ID="SC_DropDownList" Width="100%" class="ui-corner-all ui-widget-header ui-autocomplete-input ui-accordion ui-widget ui-helper-reset"
                                                     DataSourceID = "SCLinqDataSource" 
                                                      DataValueField = "UserName"  
                                                      DataTextField="UserName"
                                                      SelectedValue='<%# Bind("section.client.site_coordinator_name") %>'                                                          
                                                      runat="server">
                            
                        </asp:DropDownList>
                  

          </td>
          <td>
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                        Text="Transfer" />
                      
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                        Text="X" />             
                        
          </td>
                
            </tr>
        </EditItemTemplate>
            
      </asp:ListView>
      <asp:LinqDataSource ID="CompletedLinqDataSource" runat="server"
        ContextTypeName="IntranetDataDataContext" EnableDelete="True" 
        EnableInsert="True" EnableUpdate="True" TableName="job_times"  
         OnSelecting="CompletedLinqDataSource_Selecting">
      </asp:LinqDataSource>

     <asp:LinqDataSource ID="SCLinqDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableInsert="False" 
        EnableUpdate="False" TableName="aspnet_Users"
         OnSelecting ="SCLinqDataSource_Selecting">
    </asp:LinqDataSource>

    <br />
</asp:Content>


<%@ Page Title="" Language="C#" MasterPageFile="~/ManagementLeftNavMasterPage.master" AutoEventWireup="true" CodeFile="sc_allocation_admin.aspx.cs" Inherits="sc_allocation_admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentPlaceHolder" Runat="Server">
    <h1>Site Coordinator Allocation</h1>

     <asp:ListView ID="AllocationValueListView" runat="server"
        DataSourceID="AllocationValueLinqDataSource">
        <ItemTemplate>
        <tr >
        <td>
        <%# Eval("UserName") %>
        </td>
        <td>
           
            <%# GetAmountAllocated(Eval("UserName"))%>

        </td>
        </tr>    
                            
            
        </ItemTemplate>
          <LayoutTemplate>
          
        
            <table ID="itemPlaceholderContainer" runat="server" border="0" class="themeContent">
                
                
                
                
                <tr ID="itemPlaceholder" runat="server">
                
                </tr>
            </table>
            </LayoutTemplate>
            
      </asp:ListView>
      <asp:LinqDataSource ID="AllocationValueLinqDataSource" runat="server"
        ContextTypeName="IntranetDataDataContext"  
         OnSelecting="AllocationValueLinqDataSource_Selecting">
      </asp:LinqDataSource>

<br />
    <hr />

     <asp:ListView ID="NotInProductionListView" runat="server" 
        DataSourceID="NotInProductionLinqDataSource"
         OnItemUpdating="NotInProductionListView_ItemUpdating"
          OnItemUpdated="NotInProductionListView_ItemUpdated"
         DataKeyNames="id" >
        <ItemTemplate>
        <tr >
        <td>
            <%# Eval("section.client.job_name") %>-<%# Eval("section.section_name") %>
        </td>
            <td><%# Eval("section.section_id") %></td>
        <td>
           
             <%# getQuoteValueEx(Eval("section.quote_value")) %>

        </td>
        <td>
           
             <%# Eval("section.client.site_coordinator_name") %>

        </td>
           
            <td   align="center">
               
    
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Reallocate Site Coordinator" /> 
                   
                </td>
        </tr>    
                            
            
        </ItemTemplate>
          <LayoutTemplate>
          
        
            <table cellpadding="4" ID="itemPlaceholderContainer" runat="server" border="0" class="themeContent">
                <tr>
                <th colspan="6" ><font color="black">Jobs Not Yet In Production</font> </th>
                
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
           
             <%# getQuoteValueEx(Eval("section.quote_value")) %>

        </td>
                  
               
                
         
          <td>                                                                                                                                                                        
                  <asp:DropDownList ID="SC_DropDownList" Width="100%" class="ui-corner-all ui-widget-header ui-autocomplete-input ui-accordion-content-active ui-accordion ui-widget ui-helper-reset"
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
      <asp:LinqDataSource ID="NotInProductionLinqDataSource" runat="server"
        ContextTypeName="IntranetDataDataContext" EnableDelete="True" 
        EnableInsert="True" EnableUpdate="True" TableName="job_times"  
         OnSelecting="NotInProductionLinqDataSource_Selecting">
      </asp:LinqDataSource>

    <br />

       <asp:ListView ID="InProductionListView" runat="server"
        DataSourceID="InProductionLinqDataSource"
           OnItemUpdating="InProductionListView_ItemUpdating"
          OnItemUpdated="InProductionListView_ItemUpdated"
         DataKeyNames="id" >
        <ItemTemplate>
        <tr >
       <td>
            <%# Eval("section.client.job_name") %>-<%# Eval("section.section_name") %>
        </td>
            <td><%# Eval("section.section_id") %></td>
        <td>
           
             <%# getQuoteValueEx(Eval("section.quote_value")) %>

        </td>
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
                <th colspan="5" >Jobs In Production, Pre Installation</th>
                
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
           
             <%# getQuoteValueEx(Eval("section.quote_value")) %>

        </td>
          

               
         
          <td>                                                                                                                                                                        
                  <asp:DropDownList ID="SC_DropDownList1" Width="100%" class="ui-corner-all ui-widget-header ui-autocomplete-input ui-accordion-content-active ui-accordion ui-widget ui-helper-reset"
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
      <asp:LinqDataSource ID="InProductionLinqDataSource" runat="server"
        ContextTypeName="IntranetDataDataContext"  EnableDelete="True" 
        EnableInsert="True" EnableUpdate="True" TableName="job_times" 
         OnSelecting="InProductionLinqDataSource_Selecting">
      </asp:LinqDataSource>
    <br />

     <asp:ListView ID="InstallingListView" runat="server"
        DataSourceID="InstallingLinqDataSource"
         OnItemUpdating="InstallingListView_ItemUpdating"
          OnItemUpdated="InstallingListView_ItemUpdated"
         DataKeyNames="id" >
        <ItemTemplate>
        <tr >
       <td>
            <%# Eval("section.client.job_name") %>-<%# Eval("section.section_name") %>
        </td>
            <td><%# Eval("section.section_id") %></td>
        <td>
           
             <%# getQuoteValueEx(Eval("section.quote_value")) %>

        </td>
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
                <th colspan="5" >Jobs Busy Installing </th>
                
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
        <td>
           
             <%# getQuoteValueEx(Eval("section.quote_value")) %>

        </td>
                  
               
                
         
          <td>                                                                                                                                                                        
                  <asp:DropDownList ID="SC_DropDownList2" Width="100%" 
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
      <asp:LinqDataSource ID="InstallingLinqDataSource" runat="server"
        ContextTypeName="IntranetDataDataContext" EnableDelete="True" 
        EnableInsert="True" EnableUpdate="True" TableName="job_times"   
         OnSelecting="InstallingLinqDataSource_Selecting">
      </asp:LinqDataSource>


     <asp:LinqDataSource ID="SCLinqDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableInsert="False" 
        EnableUpdate="False" TableName="aspnet_Users"
         OnSelecting ="SCLinqDataSource_Selecting">
    </asp:LinqDataSource>




</asp:Content>


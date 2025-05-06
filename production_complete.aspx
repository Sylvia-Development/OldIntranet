<%@ Page Title="" Language="C#" MasterPageFile="~/ManagementLeftNavMasterPage.master" AutoEventWireup="true" CodeFile="production_complete.aspx.cs" Inherits="production_complete" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentPlaceHolder" Runat="Server">

<h1>Production Completed</h1>
<asp:ListView ID="ProductionCompleteListView" runat="server" DataKeyNames="id" 
        DataSourceID="ProductionCompleteDataSource" 
         OnItemUpdating = "completed_production_ItemUpdating"
          OnItemUpdated="completed_production_ItemUpdated">
        <ItemTemplate>
                
             <tr >

                <td> 
               
                <%# Eval("section.client.job_name")%> - <%# Eval("section.section_name")%> <br />
          
                
                </td>
               
                
                <td >
                  <b>  <%#Eval("job_list_item.date_expected", "{0:ddd, d MMM, yyyy}")%>  </b>

                </td>
                <td >
                    <%# Eval("job_list_item.date_completed", "{0:ddd, d MMM, yyyy}") %> 

                </td>
                              
              
               
                
            </tr>
            
        </ItemTemplate>
        <EmptyDataTemplate>
            <table id="Table1" runat="server" >
                <tr>
                    <td>
                        No completed Jobs to view.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        
        <LayoutTemplate>
         
                        <table ID="tablesorter" cellpadding="3" runat="server" border="0" class="tableSpacing paddedTable themeContent">
                            <tr id="Tr2" runat="server" class="tableheaderrow">  
                                <th class="tblhead" > </th>
                                
                                <th  align="left" class="tblhead" ><font size="2">Expected Date</font></th>
                                <th  align="left" class="tblhead"><font size="2">Completed Date</font></th>
                           
                                
                               
                                
                                    
                            </tr>
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                   
        </LayoutTemplate>
    
        
    </asp:ListView>

      <asp:LinqDataSource ID="ProductionCompleteDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="True" 
        EnableInsert="False" EnableUpdate="True" TableName="production_controls"
        OnSelecting="production_complete_DataSource_Selecting">
</asp:LinqDataSource>
    











</asp:Content>


<%@ Page Title="" Language="C#" MasterPageFile="~/ManagementLeftNavMasterPage.master" AutoEventWireup="true" CodeFile="plan_generation_complete.aspx.cs" Inherits="plan_generation_complete" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentPlaceHolder" Runat="Server">
    Plan Generation Complete
      <asp:ListView ID="CompleteListView" runat="server" DataKeyNames="id" 
        DataSourceID="ProductionCompleteDataSource" 
         OnItemUpdating = "production_complete_ItemUpdating"
          OnItemUpdated="production_complete_ItemUpdated">
        <ItemTemplate>
                
             <tr >

                <td> 
               
                <%# Eval("section.client.job_name")%> - <%# Eval("section.section_name")%> 
                
                </td>
                <td align="center">
                       <%#Eval("site_delivery_date", "{0:ddd, d MMM, yyyy}")%> <br />
                    <font size="1" color="black">into production on <%#Eval("into_production_date", "{0:ddd, d MMM, yyyy}")%></font><br />
                    
                    <font size="1" color="black">production complete on <%#Eval("job_list_item.date_completed", "{0:ddd, d MMM, yyyy}")%></font>

                </td>
                
                
             
                 <td align="center">
                    <a href="section_walls.aspx?pSectionId=<%# Eval("section.section_id") %>">
                    <asp:Image ID="Image3" runat="server" CssClass="label" ImageURL='<%# GetWallsImage(Eval("section.section_id")) %>' />
                 </a>
                      <br />
                   <div style="float:right">  <font size="1" color="black">Wall Checklists</font></div>
                </td>
               
              
               
                
            </tr>
            
        </ItemTemplate>
        <EmptyDataTemplate>
            <table id="Table1" runat="server" 
                style="border:0px;" class="tableSpacing paddedTable themeContent">
                <tr>
                    <td>
                        No new jobs complete.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        
        <LayoutTemplate>
         
                        <table ID="tablesorter" runat="server" border="0" class="tableSpacing paddedTable themeContent">
                            <tr id="Tr2" runat="server">  
                                <th colspan="2" id="Th1"     runat="server"> Production Completed Jobs</th>
                             
                               
                                <th  align="center" ><font size="2">Wall Checklists</font></th>
                                
                               
                                      
                            </tr>
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                   
        </LayoutTemplate>
     
        
    </asp:ListView>

      <asp:LinqDataSource ID="ProductionCompleteDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="False" 
        EnableInsert="False" EnableUpdate="False" TableName="project_dates"
        OnSelecting="production_complete_DataSource_Selecting">
</asp:LinqDataSource>




</asp:Content>


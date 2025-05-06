<%@ Page Title="" Language="C#" MasterPageFile="~/ManagementLeftNavMasterPage.master" AutoEventWireup="true" CodeFile="plan_generation.aspx.cs" Inherits="plan_generation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentPlaceHolder" Runat="Server">
 <script type="text/javascript">
      
     $(function  () {
               $("#tabs").tabs({
                   show: function() {
                       var selectedTab = $('#tabs').tabs('option', 'selected');
                       $("#<%= hdnSelectedTab.ClientID %>").val(selectedTab);
                   },
                   selected: <%= hdnSelectedTab.Value %>
                   });
           });    
     
 
      </script>
     <asp:HiddenField ID="hdnSelectedTab" runat="server" Value="0" />


    <div id="tabs"  style="background:white; border:0px;">
    <ul style="background:white; border:0px;">
        <li><a href="#tabs-1">Plan Generation Workflow</a></li>      
    </ul>
  
    <div id="tabs-1">
    
        <asp:ListView ID="ProductionScheduleListView" runat="server" DataKeyNames="id" 
        DataSourceID="ProductionScheduleDataSource" 
         OnItemUpdating = "production_schedule_ItemUpdating"
          OnItemUpdated="production_schedule_ItemUpdated">
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
                    <asp:Image ID="imgStatus" runat="server" CssClass="label" ImageURL='<%# GetYesNoImage(Eval("plumbing_electrical_complete")) %>' />
                    <br />
                   <div style="text-align:center">  <font size="1" color="black">P&E Plans</font></div>
                </td>
                 <td align="center">
                    <asp:Image ID="Image1" runat="server" CssClass="label" ImageURL='<%# GetYesNoImage(Eval("final_measurements_complete")) %>' />
                     <br />
                   <div style="text-align:center">  <font size="1" color="black">Final Measurements</font></div>
                </td>
                 <td align="center">
                    <asp:Image ID="Image2" runat="server" CssClass="label" ImageURL='<%# GetYesNoImage(Eval("plans_done")) %>' />
                     <br />
                   <div style="text-align:center">  <font size="1" color="black">Plan Generation</font></div>
                </td>
                 <td align="center">
                    <asp:Image ID="Image4" runat="server" CssClass="label" ImageURL='<%# GetYesNoImage(Eval("technical_orders_done")) %>' />
                      <br />
                   <div style="text-align:center">  <font size="1" color="black">Technical Orders</font></div>
                </td>
                 <td align="center">
                    <asp:Image ID="Image5" runat="server" CssClass="label" ImageURL='<%# GetYesNoImage(Eval("stone_done")) %>' />
                      <br />
                   <div style="text-align:center">  <font size="1" color="black">Stone / Concrete</font></div>
                </td>
                 <td align="center">
                    <a href="section_walls.aspx?pSectionId=<%# Eval("section.section_id") %>">
                    <asp:Image ID="Image3" runat="server" CssClass="label" ImageURL='<%# GetWallsImage(Eval("section.section_id")) %>' />
                 </a>
                      <br />
                   <div style="text-align:center">  <font size="1" color="black">Wall Checklists</font></div>
                </td>
               
              
                <td class="TDwithButtons"  align="center">
               
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" /> 
                     
                </td>
                
            </tr>
            
        </ItemTemplate>
        <EmptyDataTemplate>
            <table id="Table1" runat="server" 
                style="border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;">
                <tr>
                    <td>
                        You have no new jobs to work on.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        
        <LayoutTemplate>
         
                        <table ID="tablesorter" runat="server" border="0" class="tableSpacing paddedTable themeContent" >
                            <tr id="Tr2" runat="server">  
                                <th id="Th1"     runat="server"></th>
                             
                                <th  align="center" ><font size="2">Site Delivery Date</font></th>
                                <th  align="center" ><font size="2">Plumbing Electrical</font></th>
                                <th  align="center" ><font size="2">Final Measurements Done</font></th>
                                <th  align="center" ><font size="2">Plan Generation Done</font></th>
                                <th  align="center" ><font size="2">Technical Orders Done</font></th>
                                <th  align="center" ><font size="2">Stone / Concrete Done</font></th>
                                <th  align="center" ><font size="2">Wall Checklists</font></th>
                                
                                <th  align="center" ><font size="2">&nbsp </font></th>
                                      
                            </tr>
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                   
        </LayoutTemplate>
        <EditItemTemplate>

            <tr class="editrow" >

                    <td> 
                        <asp:HiddenField ID="sectionId" runat="server"  Value='<%# Bind("section.section_id") %>'/>
                       <%# Eval("section.client.job_name")%> - <%# Eval("section.section_name")%> 
                        <asp:HiddenField ID="hiddenClientName" runat="server"  Value=' <%# Eval("section.client.job_name")%>'/>
                        <asp:HiddenField ID="hiddenSectionName" runat="server"  Value=' <%# Eval("section.section_name")%>'/>
                        <asp:HiddenField ID="hiddenId" runat="server"  Value=' <%# Bind("id")%>'/>
                    </td>               
                
                <td >
                    
                       <%#Eval("site_delivery_date", "{0:ddd, d MMM, yyyy}")%> <br />
                    <font size="1" color="black">into production on <%#Eval("into_production_date", "{0:ddd, d MMM, yyyy}")%></font>
                </td>
                <td >
                  
                   <asp:CheckBox ID="CheckBox6"  Text="Plumbing Electrical" TextAlign="Right" runat="server" Checked='<%# Bind("plumbing_electrical_complete") %>' Enabled='true' />
                </td>
                <td align="center" >
                    
                    <asp:Image ID="Image1" runat="server" CssClass="label" ImageURL='<%# GetYesNoImage(Eval("final_measurements_complete")) %>' />
                </td>
                <td >
                  
                   <asp:CheckBox ID="CheckBox1"  Text="Plans" TextAlign="Right" runat="server" Checked='<%# Bind("plans_done") %>' Enabled='true' />
                </td>
                <td >
                  
                   <asp:CheckBox ID="CheckBox2"  Text="Orders" TextAlign="Right" runat="server" Checked='<%# Bind("technical_orders_done") %>' Enabled='true' />
                </td>
                <td >
                  
                   <asp:CheckBox ID="CheckBox3"  Text="Stone" TextAlign="Right" runat="server" Checked='<%# Bind("stone_done") %>' Enabled='true' />
                </td>
                <td >
                  &nbsp

                </td>
                
                <td class="TDwithButtons">
               
                    
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                        Text="Save" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                        Text="X" />
                </td>
                
            </tr>
        </EditItemTemplate>
        
    </asp:ListView>

      <asp:LinqDataSource ID="ProductionScheduleDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="True" 
        EnableInsert="False" EnableUpdate="True" TableName="project_dates"
        OnSelecting="production_schedule_DataSource_Selecting">
</asp:LinqDataSource>

      <br />
        <br />

         <asp:ListView ID="NotProductionListView" runat="server" DataKeyNames="id" 
        DataSourceID="ProductionNotScheduleDataSource" 
         OnItemUpdating = "production_not_ItemUpdating"
          OnItemUpdated="production_not_ItemUpdated">
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
                    <asp:Image ID="imgStatus" runat="server" CssClass="label" ImageURL='<%# GetYesNoImage(Eval("plumbing_electrical_complete")) %>' />
                     <br />
                   <div style="text-align:center">  <font size="1" color="black">P&E Plans</font></div>
                </td>
                 <td align="center">
                    <asp:Image ID="Image1" runat="server" CssClass="label" ImageURL='<%# GetYesNoImage(Eval("final_measurements_complete")) %>' />
                      <br />
                   <div style="text-align:center">  <font size="1" color="black">Final Measurements</font></div>
                </td>
                <td align="center">
                    <a href="section_walls.aspx?pSectionId=<%# Eval("section.section_id") %>">
                    <asp:Image ID="Image3" runat="server" CssClass="label" ImageURL='<%# GetWallsImage(Eval("section.section_id")) %>' />
                 </a>
                      <br />
                   <div style="text-align:center">  <font size="1" color="black">Wall Checklists</font></div>
                </td> 
               

              
                <td class="TDwithButtons"  align="center">
               
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" /> 
                     
                </td>
                
            </tr>
            
        </ItemTemplate>
        <EmptyDataTemplate>
            <table id="Table1" runat="server" 
                style="border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;">
                <tr>
                    <td>
                        You have no new jobs not in production.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        
        <LayoutTemplate>
         
                        <table ID="tablesorter" runat="server" border="0" >
                            <tr id="Tr2" runat="server">  
                                <th id="Th1"     runat="server">Jobs NOT in proudction YET</th>
                             
                                <th  align="center" ><font size="2">Site Delivery Date</font></th>
                                <th  align="center" ><font size="2">Plumbing Electrical</font></th>
                                <th  align="center" ><font size="2">Final Measurements Done</font></th>
                               <th  align="center" ><font size="2">Wall Checklists</font></th>
                                
                                <th  align="center" ><font size="2">&nbsp </font></th>
                                      
                            </tr>
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                   
        </LayoutTemplate>
        <EditItemTemplate>

            <tr class="editrow" >

                    <td> 
                        <asp:HiddenField ID="sectionId" runat="server"  Value='<%# Bind("section.section_id") %>'/>
                       <%# Eval("section.client.job_name")%> - <%# Eval("section.section_name")%> 
                        <asp:HiddenField ID="hiddenClientName" runat="server"  Value=' <%# Eval("section.client.job_name")%>'/>
                        <asp:HiddenField ID="hiddenSectionName" runat="server"  Value=' <%# Eval("section.section_name")%>'/>
                        <asp:HiddenField ID="hiddenId" runat="server"  Value=' <%# Bind("id")%>'/>
                    </td>
                <td >
                    
                       <%#Eval("site_delivery_date", "{0:ddd, d MMM, yyyy}")%> <br />
                    <font size="1" color="black">into production on <%#Eval("into_production_date", "{0:ddd, d MMM, yyyy}")%></font>
                </td>
                <td >
                  
                   <asp:CheckBox ID="CheckBox6"  Text="Plumbing Electrical" TextAlign="Right" runat="server" Checked='<%# Bind("plumbing_electrical_complete") %>' Enabled='true' />
                </td>
                <td align="center">
                    
                    <asp:Image ID="Image1" runat="server" CssClass="label" ImageURL='<%# GetYesNoImage(Eval("final_measurements_complete")) %>' />
                </td>
                <td >
                  &nbsp

                </td>
                               
                <td class="TDwithButtons">
                    
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                        Text="Save" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                        Text="X" />
                                               
                </td>               
            </tr>
        </EditItemTemplate>
        
    </asp:ListView>

      <asp:LinqDataSource ID="ProductionNotScheduleDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="True" 
        EnableInsert="False" EnableUpdate="True" TableName="project_dates"
        OnSelecting="production_not_DataSource_Selecting">
</asp:LinqDataSource>

      <br />
        <br />
      
</div>








</asp:Content>


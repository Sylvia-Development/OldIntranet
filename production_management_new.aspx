<%@ Page Title="" Language="C#" MasterPageFile="~/ManagementLeftNavMasterPage.master" AutoEventWireup="true" CodeFile="production_management_new.aspx.cs" Inherits="production_management_new" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentPlaceHolder" Runat="Server">

    <script type="text/javascript">

     $(function () {
         $("input[id$='datepicker']").datepicker({ dateFormat: 'D, d M, yy', showOtherMonths: true, selectOtherMonths: true });

     });
     $(function () {
         $("input[id$='datepicker2']").datepicker({ dateFormat: 'D, d M, yy', showOtherMonths: true, selectOtherMonths: true });

     });
     $(function () {
         $("input[id$='datepicker3']").datepicker({ dateFormat: 'D, d M, yy', showOtherMonths: true, selectOtherMonths: true });

     });
     $(function () {
         $("input[id$='datepicker4']").datepicker({ dateFormat: 'D, d M, yy', showOtherMonths: true, selectOtherMonths: true });

     });
     $(function () {
         $("input[id$='datepicker5']").datepicker({ dateFormat: 'D, d M, yy', showOtherMonths: true, selectOtherMonths: true });

     });

     $(function () {
         $("#tabs").tabs();
     });

   
     


 $(function () {
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

<br />
 
<div id="tabs" >
    <ul>
        <li><a href="#tabs-1">Urgent Orders</a></li>
      
        <li><a href="#tabs-2">Production Schedule</a></li>

        
        
    </ul>
    <div id="tabs-1">
   
<asp:ListView ID="OrdersListView" runat="server" DataKeyNames="id" 
        DataSourceID="OrdersLinqDataSource" 
         OnItemUpdating = "orders_schedule_ItemUpdating"
          OnItemUpdated="orders_schedule_ItemUpdated">
        <ItemTemplate>
                
             <tr style="background-color: <%# GetOrdersRowColour(Eval("processing_completed_by")) %>; color: #000000;">

                <td> 
               
                <%# Eval("section.client.job_name")%> - <%# Eval("section.section_name")%> 
                    <br />
                   production control id : <%# GetProductionControlId(Eval("production_controls")) %>
                    <br />
                   project date id : <%# GetProductionDateId(Eval("project_dates")) %>
                     <br />
                   joblist id <%# Eval("id")%> 
                
                
                </td>
                 <td align="left" >
                     <asp:Image ID="high_pri_image" Visible='<%# Eval("is_main_material_order") %>' runat="server" ImageUrl="Images/priority-high.png" />
                      <%#Eval("description").ToString().Replace("\n", "<br/>") %><br /><br />
                      <font size="1" color="grey"> Logged by: <%#Eval("user_logged") %> - <%#Eval("date_logged","{0:ddd, d MMM, yyyy}") %> - blu<%# Eval("id")%> </font>


                 </td>

                <td align="center">
                       <%#Eval("processing_completed_by", "{0:ddd, d MMM, yyyy}")%> <br />
                   

                </td>
                
                
                <td align="center">

                <a  href="stock_order_popup.aspx?pDepartmentId=5&pSectionId=<%#Eval("section_id") %>" rel="shadowbox;height=550;width=750"> 
                        <img src="Images/tasks.png" title="stock orders" />
                </a> 
                
                </td>
  
                
              
                <td class="TDwithButtons"  align="center">
               
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" /> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
                    
                    <a href="<%# GetPrintTarget( Eval("is_main_material_order")) %>?pSectionId=<%#Eval("section_id") %>&itemId=<%#Eval("id") %>" target="new" > 
          <img src="Images/print.png" align="middle" />  


                    </a>
                    
                     
                </td>
                
            </tr>
            
        </ItemTemplate>
        <EmptyDataTemplate>
            <table id="Table1" runat="server" 
                style="border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;">
                <tr>
                    <td>
                        You have no Urgent Orders to process.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        
        <LayoutTemplate>
         
                        <table ID="tablesorter" cellpadding="3" runat="server" border="0" >
                            <tr id="Tr2" runat="server" class="tableheaderrow">  
                                <th id="Th1"     runat="server" colspan="2"></th>
                             
                                <th  align="center" ><font size="2">To Be Completed By 16h30 on</font></th>
                                <th  align="center" ><font size="2">Order Stock</font></th>
                                
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
                        <asp:HiddenField ID="jobListId" runat="server"  Value='<%# Bind("id") %>'/>
                       <%# Eval("section.client.job_name")%> - <%# Eval("section.section_name")%> 
                        <asp:HiddenField ID="hiddenClientName" runat="server"  Value=' <%# Eval("section.client.job_name")%>'/>
                        <asp:HiddenField ID="hiddenSectionName" runat="server"  Value=' <%# Eval("section.section_name")%>'/>
                        <asp:HiddenField ID="hiddenDeptId" runat="server"  Value=' <%# Eval("department_id")%>'/>
                    </td>
                   
                
                
                <td >
                <asp:TextBox TextMode="MultiLine" Rows="10" Width="99%" ID="textbox1" runat="server" Text='<%# Bind("description") %>' />
                
                     </td>
                <td >
                   
                    
                       <asp:TextBox  style="border-color:Gray" placeholder="completed date..." ID="datepicker"  runat="server" Text='<%# Bind("processing_completed_by","{0:ddd, d MMM, yyyy}") %>' />

                </td>
                
                <td align="center">

                <asp:CheckBox ID="CheckBox4" Text="Order Complete"  runat="server" Checked='<%# Bind("item_completed") %>' Enabled='true' />
                
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

      <asp:LinqDataSource ID="OrdersLinqDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="True" 
        EnableInsert="False" EnableUpdate="True" TableName="job_list_items"
        OnSelecting="orders_schedule_DataSource_Selecting">
</asp:LinqDataSource>



    </div>
   
    <div id="tabs-2">
    
<asp:ListView ID="ProductionScheduleListView" runat="server" DataKeyNames="id" 
        DataSourceID="ProductionScheduleDataSource" 
         OnItemUpdating = "production_schedule_ItemUpdating"
          OnItemUpdated="production_schedule_ItemUpdated">
        <ItemTemplate>
                
             <tr class="<%# GetRowColour(Eval("site_delivery_date")) %> " style=" color: #000000;">

                <td> 
               
                <%# Eval("section.client.job_name")%> - <%# Eval("section.section_name")%> 
                
                </td>
                <td align="center">
                       <%#Eval("site_delivery_date", "{0:ddd, d MMM, yyyy}")%> <br />
                    <font size="1" color="black">into production on <%#Eval("into_production_date", "{0:ddd, d MMM, yyyy}")%></font>

                </td>
                
                
                <td align="center">
                    <asp:Image ID="imgStatus" runat="server" CssClass="label" ImageURL='<%# GetYesNoImage(Eval("factory_scheduled")) %>' />
                </td>
                 <td align="center">
                    <asp:Image ID="Image1" runat="server" CssClass="label" ImageURL='<%# GetYesNoImage(Eval("scheduled_plan_creation")) %>' />
                </td>
                 <td align="center">
                    <asp:Image ID="Image4" runat="server" CssClass="label" ImageURL='<%# GetYesNoImage(Eval("stock_orders_sent")) %>' />
                </td>
                 <td align="center">
                    <asp:Image ID="Image5" runat="server" CssClass="label" ImageURL='<%# GetYesNoImage(Eval("production_complete")) %>' />
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
                        You have no new jobs to produce.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        
        <LayoutTemplate>
         
                        <table ID="tablesorter" cellpadding="3" runat="server" border="1" >
                            <tr id="Tr2" runat="server" class="tableheaderrow">  
                                <th id="Th1"     runat="server"></th>
                             
                                <th  align="center" ><font size="2">Site Delivery Date</font></th>
                                <th  align="center" ><font size="2">Scheduled in Factory</font></th>
                                <th  align="center" ><font size="2">Scheduled Plan Generation</font></th>
                                <th  align="center" ><font size="2">Sent Stock Orders</font></th>
                                <th  align="center" ><font size="2">Production Complete</font></th>
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
                    </td>
                   
                
                <td >
                   
                    
                       <asp:TextBox  style="border-color:Gray" placeholder="Site Delivery Date..." ID="datepicker"  runat="server" Text='<%# Bind("site_delivery_date","{0:ddd, d MMM, yyyy}") %>' />

                </td>
                <td >
                  
                   <asp:CheckBox ID="CheckBox6"  Text="Scheduled Factory" TextAlign="Right" runat="server" Checked='<%# Bind("factory_scheduled") %>' Enabled='true' />
                </td>
                <td >
                    
                    <asp:CheckBox ID="CheckBox7"  Text="Scheduled Plans" TextAlign="Right" runat="server" Checked='<%# Bind("scheduled_plan_creation") %>' Enabled='true' />
                </td>
                <td >
                  <div style=" float:none;"><asp:CheckBox ID="CheckBox1"  Text="Send Orders" TextAlign="Right" runat="server" Checked='<%# Bind("stock_orders_sent") %>' Enabled='true' /></div>
                  <asp:TextBox  style="border-color:Gray" placeholder="Set Orders Date..." ID="datepicker4"  runat="server"  />
                </td>
                <td align="center">

                <asp:CheckBox ID="CheckBox4" Text="Production Complete"  runat="server" Checked='<%# Bind("production_complete") %>' Enabled='<%# GetCanTickComplete(Eval("factory_scheduled"),Eval("scheduled_plan_creation"),Eval("stock_orders_sent")) %>' />
                
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

<h1>Production Complete</h1>
<asp:ListView ID="ProductionCompleteListView" runat="server" DataKeyNames="id" 
        DataSourceID="ProductionCompleteDataSource" >
        <ItemTemplate>
                
             <tr >

                <td> 
               
                <%# Eval("section.client.job_name")%> - <%# Eval("section.section_name")%> <br />
                
                </td>
               
                
              
                  <td align="center">
                       <%#Eval("site_delivery_date", "{0:ddd, d MMM, yyyy}")%> <br />
                    <font size="1" color="black">into production on <%#Eval("into_production_date", "{0:ddd, d MMM, yyyy}")%></font>

                </td>

               
                <td align="center">
                    <%#Eval("production_complete_date", "{0:ddd, d MMM, yyyy}")%>
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
         
                        <table ID="tablesorter" cellpadding="3" runat="server" border="1">
                            <tr id="Tr2" runat="server" class="tableheaderrow">  
                                <th id="Th1"     runat="server"></th>
                                
                                <th  align="center" ><font size="2">Site Delivery Date</font></th>
                                <th  align="center" ><font size="2">Production Complete Date</font></th>
                                
                                
                                
                               
                                
                                    
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
    </div>


</div>










</asp:Content>


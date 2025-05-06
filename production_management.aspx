<%@ Page Title="" Language="C#" MasterPageFile="~/ManagementLeftNavMasterPage.master" AutoEventWireup="true" CodeFile="production_management.aspx.cs" Inherits="production_management" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentPlaceHolder" Runat="Server">

 <script type="text/javascript">

    



     var sbx = window.parent.Shadowbox;
     function openTopSBX(el) {
         if (sbx) {
             sbx.open({
                 content: el.href
                    , player: 'iframe'
                    , width: 650
                    , height: 490
             }
                 );
             return false;
         } else { //no Shadowbox in parent window! 
             return true;
         }
     }

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

    

    


     
     


 



  </script>
  
<br />
 

 <%if    (Context.User.IsInRole("Director")
         ||Context.User.IsInRole("Production Controller")
         ||Context.User.IsInRole("Systems Integration")
         ||Context.User.IsInRole("Procurement Coordinator")
         ||Context.User.IsInRole("Projects Director"))
     { %>   
<h1>Process New Orders</h1>

<asp:ListView ID="NewOrdersListView" runat="server" DataKeyNames="id" 
        DataSourceID="NewOrdersDataSource" 
         OnItemUpdating = "new_orders_ItemUpdating"
          OnItemUpdated="new_orders_ItemUpdated">
        <ItemTemplate>
                
             <tr>

                <td > 
               
                <%# Eval("section.client.job_name")%> - <%# Eval("section.section_name")%> 
                
                </td>
                 <td colspan="2" style="text-align:center;vertical-align: middle;">
                     Expected Date : <%# Eval("project_date.site_delivery_date","{0:ddd, d MMM, yyyy}")%> 
                     
                     
                     <br />
                     <br />

                     <font size="1" color="black"> 
                         Client Site Delivery : <%# Eval("job_list_item.date_expected","{0:ddd, d MMM, yyyy}")%><br />
                         Into Production : <%#Eval("project_date.into_production_date","{0:ddd, d MMM, yyyy}") %> 
                     </font>

                </td>             
                <td class="TDwithButtons"  align="center">
               
    
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Process New Order" /> 
                     
                </td>
                
            </tr>
            
        </ItemTemplate>
        <EmptyDataTemplate>
            <table id="Table1" runat="server" 
                style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;">
                <tr>
                    <td>
                        No new items to process.

                    </td>
                </tr>
            </table>
        </EmptyDataTemplate>
        
        <LayoutTemplate>
         
                        <table ID="tablesorter" cellpadding="3" runat="server" border="0" class="themeContent">
                            <tr style="background-color:#694141" id="Tr2" runat="server">  
                                
                                <th colspan="4" align="left" >&nbsp</th>
                                    
                            </tr>
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                   
        </LayoutTemplate>
        <EditItemTemplate>

             <tr class="editrow">

                <td> 
               
                <asp:HiddenField ID="sectionId" runat="server"  Value='<%# Bind("section.section_id") %>'/>
                    <asp:HiddenField ID="projectsDatesId" runat="server"  Value='<%# Bind("projects_dates_id") %>'/>
                       <%# Eval("section.client.job_name")%> - <%# Eval("section.section_name")%> 
                  
                
                </td>  
                 <td colspan="2">
                    Expected Date : <%# Eval("project_date.site_delivery_date","{0:ddd, d MMM, yyyy}")%> 
                     <br />
                     <br />
                    I have planned Production in JPI and can confirm Completion Date of 
                    <asp:TextBox  style="border-color:Gray" placeholder="Completion Date..." ID="datepicker"  runat="server"  />
                     <br />

                </td>        
              
                <td class="TDwithButtons"  align="center">
    
                    <asp:Button ID="Button1" runat="server" CommandName="Update" Text="Process Order" />
                    <asp:Button ID="Button2" runat="server" CommandName="Cancel" Text="X" />
                     
                </td>
                
            </tr>

       
        </EditItemTemplate>
        
    </asp:ListView>

      <asp:LinqDataSource ID="NewOrdersDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="True" 
        EnableInsert="False" EnableUpdate="True" TableName="production_controls"
        OnSelecting="new_orders_DataSource_Selecting">
</asp:LinqDataSource>


        <br />
        <br />

        <%} %>

     
    <asp:ListView ID="ProductionScheduleListView" runat="server" DataKeyNames="id" 
        DataSourceID="ProductionScheduleDataSource" 
         OnItemUpdating = "production_schedule_ItemUpdating"
          OnItemUpdated="production_schedule_ItemUpdated">
        <ItemTemplate>
                
             <tr class="<%# GetRowColour(Eval("project_date.site_delivery_date")) %>" style="color:#000000;">

                <td  > 
               
                <%# Eval("section.client.job_name")%> - <%# Eval("section.section_name")%> 
                
                </td>
                <td style="text-align:center;vertical-align: middle;" >

                    Into Production On : <%#Eval("project_date.into_production_date","{0:ddd, d MMM, yyyy}") %>
                    <br />
                    Elapsed Time : <%# GetLeadTimeInWeeks(Eval("project_date.into_production_date")) %>

                   

                </td>          
                <td align="center"  >
                    <%# Eval("project_date.site_delivery_date","{0:ddd, d MMM, yyyy}") %> <br />
                    <br />
                    <asp:ImageButton ID="confirmButton" runat="server" CommandArgument='<%# Eval("job_list_item.id") %>'  OnCommand="confirmClick" OnClientClick="if (!confirm('Are you 100% sure that the job is on track?')) return false;"  ImageURL='<%# GetConfirmButtonImage(Eval("job_list_item")) %>'/>

                       <br />
                    <font size="1" color="black"> Last Confimation : <%# GetLastConfirmationDetails(Eval("job_list_item")) %> </font>
                    <br />
                    <font size="1" color="black"> Client Site Delivery : <%#Eval("job_list_item.date_expected","{0:ddd, d MMM, yyyy}") %> </font>
                     
                </td>
                <td align="center" >
                  
                  <a  href="stock_order_popup_new.aspx?pDepartmentId=5&pSectionId=<%# Eval("section.section_id") %>" rel="shadowbox;height=550;width=750"> 
                        <img src="Images/tasks.png" title="supplier orders" />
                    </a>

                </td>
                <td align="center" >
                  
                 <a href="section_add_packages.aspx?pType=Site%20Order&pOrderId=<%# Eval("job_list_item.id") %>&pClientId=<%# Eval("section.client.client_id") %>&pSectionId=<%# Eval("section.section_id") %>" target="_blank">
                    <asp:Image ID="Image3" runat="server" CssClass="label" ImageURL='<%# GetPackageImage(Eval("job_list_item.id")) %>' />
                 </a>
                   
                </td>
                <td class="TDwithButtons" nowrap  align="center">
               
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Update" /> &nbsp&nbsp&nbsp     
                      
                   <a href="production_control_notes_popup_new.aspx?pProductionControlId=<%#Eval("id") %>&pProcessType=MainProduction" rel="nofollow" target="_top" onclick="return openTopSBX(this);">
     <img src="Images/notes.png" title="site order notes" />  </a>
     &nbsp&nbsp&nbsp
                    <a  href="section_dispatch.aspx?pDepartmentId=1&pClientId=<%# Eval("section.client.client_id") %>&pSectionId=<%# Eval("section.section_id") %>" target="_blank" > 
                        <img src="Images/dispatch_package.png" title="dispatch packages" />
                        </a>            
                     
                </td>
                
            </tr>
            
        </ItemTemplate>
        <EmptyDataTemplate>
            <table id="Table1" runat="server" 
                style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;">
                <tr>
                    <td>
                        No items in Production.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        
        <LayoutTemplate>
         
                        <table ID="tablesorter" runat="server" border="0" class="themeContent">
                            <tr id="Tr2" runat="server">  
                                <th></th>
                                <th><font size="2">Description</font></th>
                                <th  align="left" class="tblhead" ><font size="2">Committed Completion Date</font></th>
                                                       
                                <th  align="left" class="tblhead" ><font size="2">Supplier Order Status</font></th>
                              
                                <th  align="left" class="tblhead" ><font size="2">Package Labels</font></th>
                              
                                <th  align="left" class="tblhead" ><font size="2">&nbsp</font></th>
                                                             
                                    
                            </tr>
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                   
        </LayoutTemplate>
        <EditItemTemplate>

             <tr class="editrow">

                <td  > 
               
                <asp:HiddenField ID="sectionId" runat="server"  Value='<%# Bind("section.section_id") %>'/>
                    <asp:HiddenField ID="jobListId" runat="server"  Value='<%# Bind("joblist_item_id") %>'/>
                    <asp:HiddenField ID="projectsDatesId" runat="server"  Value='<%# Bind("projects_dates_id") %>'/>
                    <asp:HiddenField ID="siteDeliveryDate" runat="server"  Value='<%# Eval("project_date.site_delivery_date") %>'/>
                    <asp:HiddenField ID="hiddenJobName" runat="server"  Value='<%# Eval("section.client.job_name")%>' />
                    <asp:HiddenField ID="hiddenSectionName" runat="server"  Value='<%# Eval("section.section_name")%> '/>
                       <%# Eval("section.client.job_name")%> - <%# Eval("section.section_name")%>              
                </td>
                 <td  >
                     Into Production On : <%#Eval("project_date.into_production_date","{0:ddd, d MMM, yyyy}") %>
                    <br />
                    Elapsed Time : <%# GetLeadTimeInWeeks(Eval("project_date.into_production_date")) %>


                </td>          
                 <td align="center"  >
                   
                     <asp:TextBox  style="border-color:Gray" placeholder="Completion Date..." Text='<%# Bind("project_date.site_delivery_date","{0:ddd, d MMM, yyyy}") %>' ID="datepicker"  runat="server"  />
                     <br />
                 <br />
                     <asp:CheckBox ID="itemCompleteCheckBox"  runat="server" Text="Order is COMPLETE in FULL"  Enabled='true'  />

                </td>
                 
                <td align="center" >
                  
                  <a  href="stock_order_popup_new.aspx?pDepartmentId=5&pSectionId=<%# Eval("section.section_id") %>" rel="shadowbox;height=550;width=750"> 
                        <img src="Images/tasks.png" title="supplier orders" />
                    </a>

                </td>
                <td align="center" >              
                 <a href="section_add_packages.aspx?pType=Site%20Order&pOrderId=<%# Eval("job_list_item.id") %>&pClientId=<%# Eval("section.client.client_id") %>&pSectionId=<%# Eval("section.section_id") %>" target="_blank">
                    <asp:Image ID="Image3" runat="server" CssClass="label" ImageURL='<%# GetPackageImage(Eval("job_list_item.id")) %>' />
                 </a>                  
                </td>            
                <td nowrap  class="TDwithButtons"  align="center">   
                    <asp:Button ID="Button1" runat="server" CommandName="Update" Text="Save" />
                    <asp:Button ID="Button2" runat="server" CommandName="Cancel" Text="X" />                   
                </td>               
            </tr>
       
        </EditItemTemplate>
        
    </asp:ListView>

      <asp:LinqDataSource ID="ProductionScheduleDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="True" 
        EnableInsert="False" EnableUpdate="True" TableName="production_controls"
        OnSelecting="production_schedule_DataSource_Selecting">
</asp:LinqDataSource>


<br />







</asp:Content>


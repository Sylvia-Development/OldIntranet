<%@ Page Title="" Language="C#" MasterPageFile="~/ManagementLeftNavMasterPage.master" AutoEventWireup="true" CodeFile="logistics_control_completed.aspx.cs" Inherits="logistics_control_completed" %>

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
         $("input[id$='datepicker']").datetimepicker({
             minDate: '-1970/01/01'//today - so that they can set a date yesterday 
             
             
         });

     });

     $(function () {
         $("input[id$='datepicker2']").datetimepicker({
             


         });

     });


    

    
    
     


    


     
     


 



  </script>

    <h1>Logistics Control</h1>

     <asp:ListView ID="LogisticsScheduleListView" runat="server" DataKeyNames="id" 
        DataSourceID="LogisticsScheduleDataSource" 
         OnItemUpdating = "logistics_schedule_ItemUpdating"
          OnItemUpdated="logistics_schedule_ItemUpdated">
        <ItemTemplate>
                
             <tr >

                <td nowrap > 
               
                <%# Eval("job_list_item.section.client.job_name")%> <br /> 
                <%# Eval("job_list_item.section.section_name")%> <br />
                    <br />

                <asp:Label runat="server" Text='<%# GetOrderDescriptionDetails(Eval("job_list_item"))%>' ToolTip='<%# Eval("job_list_item.description")%>' > </asp:Label>  
                    
                
                </td>
                      
                
                 
                
                 <td nowrap align="center" style="width:200px"  >
                     Delivery Vehicle Booked<br /><br />
                      <asp:Image ID="Image1" runat="server" CssClass="label" ImageURL='<%# GetYesNoImage(Eval("vehicle_confirmed")) %>' /><br />
                     <br />
                     
                    <asp:TextBox style="resize:none;" placeholder="Vehicle Details..." readonly="true" ID="vehicleTextBox" runat="server" 
                            Text='<%# Eval("vehicle_notes") %>' 
                            TextMode="MultiLine" Rows="8" 
                            Width="98%"/>  

                </td>
                 <td nowrap align="center" style="width:200px"  >
                    Delivery Team Booked<br /><br />
                      <asp:Image ID="Image2" runat="server" CssClass="label" ImageURL='<%# GetYesNoImage(Eval("team_confirmed")) %>' /><br />
                     <br />
                     <asp:TextBox style="resize:none;" placeholder="Team Details..." readonly="true" ID="TextBox1" runat="server" 
                            Text='<%# Eval("team_notes") %>' 
                            TextMode="MultiLine" Rows="8" 
                            Width="98%"/> 
                </td>
                 <td nowrap align="center" style="width:200px"  >
                     Accommodation Confirmed<br /><br />
                      <asp:Image ID="Image4" runat="server" CssClass="label" ImageURL='<%# GetYesNoImage(Eval("accommodation_confirmed")) %>' /><br />
                     <br />
                     <asp:TextBox style="resize:none;" placeholder="Accommodation Details..." readonly="true" ID="TextBox2" runat="server" 
                            Text='<%# Eval("accommodation_notes") %>' 
                            TextMode="MultiLine" Rows="8" 
                            Width="98%"/> 
                </td>

                 <td nowrap align="center" style="vertical-align:top;">
                    
                     
                   

                    Actual Delivery Date & Time <br /><br />
                       <%# Eval("delivery_complete_date","{0:ddd, d MMM, yyyy, HH:mm}")%> <br /><br />



                     Planned Delivery Date & Time <br /><br />
                       <%# Eval("site_delivery_date","{0:ddd, d MMM, yyyy, HH:mm}")%> 
                                    
                </td>

                                      
                            
              
                <td nowrap class="TDwithButtons" nowrap  align="center">
               
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Update" /> &nbsp&nbsp&nbsp     
                      
                   <a href="logistics_control_notes_popup.aspx?pLogisticsControlId=<%#Eval("id") %>" rel="nofollow" target="_top" onclick="return openTopSBX(this);">
     <img src="Images/notes.png" title="logistics control notes" />  </a>
     &nbsp&nbsp&nbsp
     
                           
                             
                  
                     
                </td>
                
            </tr>
            
        </ItemTemplate>
        <EmptyDataTemplate>
            <table id="Table1" runat="server" 
                style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;">
                <tr>
                    <td>
                        No items in Logistics Control Complete.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        
        <LayoutTemplate>
         
                        <table ID="tablesorter" cellpadding="3" runat="server" border="1" >
                            <tr id="Tr2" runat="server" class="tableheaderrow">  
                                <th id="Th1" colspan="8"    runat="server"></th>
                             
                                
                              
                               
                              
                                
                                                             
                                    
                            </tr>
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                   
        </LayoutTemplate>
        <EditItemTemplate>

             <tr class="editrow">

                <td nowrap > 
                <asp:HiddenField ID="hiddenJobName" runat="server"  Value='<%# Eval("job_list_item.section.client.job_name")%>' />
                <asp:HiddenField ID="hiddenSectionName" runat="server"  Value='<%# Eval("job_list_item.section.section_name")%> '/>
                    <asp:HiddenField ID="logisticsControlId" runat="server"  Value='<%# Eval("id") %>'/>

               
                <%# Eval("job_list_item.section.client.job_name")%> <br /> 
                <%# Eval("job_list_item.section.section_name")%> <br />
                    <br />

                <asp:Label ID="descriptionLabel" runat="server" Text='<%# GetOrderDescriptionDetails(Eval("job_list_item"))%>' ToolTip='<%# Eval("job_list_item.description")%>' > </asp:Label>  
                    
                
                </td>
                      
               

                 
                 
                
               <td nowrap align="center" style="width:200px"  >
                     Delivery Vehicle Booked<br /><br />
                      <asp:Image ID="Image1" runat="server" CssClass="label" ImageURL='<%# GetYesNoImage(Eval("vehicle_confirmed")) %>' /><br />
                     <br />
                     
                    <asp:TextBox style="resize:none;" placeholder="Vehicle Details..." readonly="true" ID="vehicleTextBox" runat="server" 
                            Text='<%# Eval("vehicle_notes") %>' 
                            TextMode="MultiLine" Rows="8" 
                            Width="98%"/>  

                </td>
                 <td nowrap align="center" style="width:200px"  >
                    Delivery Team Booked<br /><br />
                      <asp:Image ID="Image2" runat="server" CssClass="label" ImageURL='<%# GetYesNoImage(Eval("team_confirmed")) %>' /><br />
                     <br />
                     <asp:TextBox style="resize:none;" placeholder="Team Details..." readonly="true" ID="TextBox1" runat="server" 
                            Text='<%# Eval("team_notes") %>' 
                            TextMode="MultiLine" Rows="8" 
                            Width="98%"/> 
                </td>
                 <td nowrap align="center" style="width:200px"  >
                     Accommodation Confirmed<br /><br />
                      <asp:Image ID="Image4" runat="server" CssClass="label" ImageURL='<%# GetYesNoImage(Eval("accommodation_confirmed")) %>' /><br />
                     <br />
                     <asp:TextBox style="resize:none;" placeholder="Accommodation Details..." readonly="true" ID="TextBox2" runat="server" 
                            Text='<%# Eval("accommodation_notes") %>' 
                            TextMode="MultiLine" Rows="8" 
                            Width="98%"/> 
                </td>


                 <td nowrap align="left" style="vertical-align:middle;">

                   
                     
                      <asp:CheckBox ID="deliveryCompleteCheckBox" Text="Delivery Complete" TextAlign="Right"  runat="server" Checked='<%# Bind("delivery_complete") %>' Enabled='true' />
                   <br />
                      
                                    
                </td>
                
              
                <td nowrap  class="TDwithButtons"  align="center">
               
    
                    <asp:Button ID="Button1" runat="server" CommandName="Update" Text="Save" />
                    <asp:Button ID="Button2" runat="server" CommandName="Cancel" Text="X" />
                     
                </td>
                
            </tr>

       
        </EditItemTemplate>
        
    </asp:ListView>

      <asp:LinqDataSource ID="LogisticsScheduleDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="True" 
        EnableInsert="False" EnableUpdate="True" TableName="logistics_controls"
        OnSelecting="logistics_schedule_DataSource_Selecting">
</asp:LinqDataSource>


</asp:Content>
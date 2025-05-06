<%@ Page Title="" Language="C#" MasterPageFile="~/ManagementLeftNavMasterPage.master" AutoEventWireup="true" CodeFile="logistics_control.aspx.cs" Inherits="logistics_control" %>

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
         $("input[id$='datepicker2']").datetimepicker({dateFormat: 'D, d M, yy', showOtherMonths: true, selectOtherMonths: true 
             


         });

     });


 

  </script>

    <h1>Logistics Control</h1>

     <asp:ListView ID="LogisticsScheduleListView" runat="server" DataKeyNames="id" 
        DataSourceID="LogisticsScheduleDataSource" 
         OnItemUpdating = "logistics_schedule_ItemUpdating"
          OnItemUpdated="logistics_schedule_ItemUpdated">
        <ItemTemplate>
                
             <tr class="<%# GetRowColour(Eval("site_delivery_date")) %>" style="color: #000000;">

                <td nowrap style="text-align:left;vertical-align: middle;" > 
               
                <%# Eval("job_list_item.section.client.job_name")%> <br /> 
                <%# Eval("job_list_item.section.section_name")%> <br />
                    <br />

                <asp:Label runat="server" Text='<%# GetOrderDescriptionDetails(Eval("job_list_item"))%>' ToolTip='<%# Eval("job_list_item.description")%>' > </asp:Label>  
                    
                
                </td>
                      
                <td nowrap style="text-align:center;vertical-align: middle;"  >
                    
                    <asp:Label ID="productionCompleteLabel" Font-Size="Small" runat="server" Text='Production Complete :' > </asp:Label>  
                    <br />
                    <asp:Image ID="Image3" runat="server" CssClass="label" ImageURL='<%# GetYesNoImage(Eval("job_list_item.item_completed")) %>' /><br /><br />
                    <font size="2" color="black">Expected Date : </font><br />
                    <asp:Label runat="server" Text='<%# GetProductionCompleteDate(Eval("job_list_item")) %>' > </asp:Label>  
                    <br />
                    

                   

                     
                    </td>

                 <td nowrap style="text-align:center;vertical-align: middle;" >

                  <div style="text-align:center"><a href="section_dispatch.aspx?pDepartmentId=1&pClientId=<%# Eval("job_list_item.section.client.client_id")%>&pSectionId=<%# Eval("job_list_item.section.section_id")%>" target="_blank">
                     <asp:Label runat="server"  Text='<%# GetPackagesBeingManufactured(Eval("job_list_item")) %>' > </asp:Label> Packages <br />
                     being Manufactured
                     <br /><br />
                      <asp:Label runat="server"  Text='<%# GetPackagesVerified(Eval("job_list_item")) %>' > </asp:Label> Packages <br />
                     ready for Dispatch
                     <br /><br />
                     <asp:Label runat="server"  Text='<%# GetDispatch(Eval("job_list_item")) %>' > </asp:Label> Open<br />
                     Dispatch Events
                 </a></div>
                </td>
                 
                
                 <td nowrap align="center" style="width:200px"  >
                     Delivery Vehicle Booked<br /><br />
                      <asp:Image ID="Image1" runat="server" CssClass="label" ImageURL='<%# GetYesNoImage(Eval("vehicle_confirmed")) %>' /><br />
                     <br />
                     
                    <asp:TextBox style="resize:none;" CssClass="ui-corner-all" placeholder="Vehicle Details..." readonly="true" ID="vehicleTextBox" runat="server" 
                            Text='<%# Eval("vehicle_notes") %>' 
                            TextMode="MultiLine" Rows="8" 
                            Width="98%"/>  

                </td>
                 <td nowrap align="center" style="width:200px"  >
                    Delivery Team Booked<br /><br />
                      <asp:Image ID="Image2" runat="server" CssClass="label" ImageURL='<%# GetYesNoImage(Eval("team_confirmed")) %>' /><br />
                     <br />
                     <asp:TextBox style="resize:none;" CssClass="ui-corner-all" placeholder="Team Details..." readonly="true" ID="TextBox1" runat="server" 
                            Text='<%# Eval("team_notes") %>' 
                            TextMode="MultiLine" Rows="8" 
                            Width="98%"/> 
                </td>
                 <td nowrap align="center" style="width:200px"  >
                     Accommodation Confirmed<br /><br />
                      <asp:Image ID="Image4" runat="server" CssClass="label" ImageURL='<%# GetYesNoImage(Eval("accommodation_confirmed")) %>' /><br />
                     <br />
                     <asp:TextBox style="resize:none;" CssClass="ui-corner-all" placeholder="Accommodation Details..." readonly="true" ID="TextBox2" runat="server" 
                            Text='<%# Eval("accommodation_notes") %>' 
                            TextMode="MultiLine" Rows="8" 
                            Width="98%"/> 
                            
                </td>

                 <td nowrap style="text-align:center; vertical-align:middle;">
                     Site Delivery Date & Time <br /><br />
                       <%# Eval("site_delivery_date","{0:ddd, d MMM, yyyy, HH:mm}")%> <br />
                     
                     <br />

                    <asp:ImageButton ID="confirmButton" runat="server" CommandArgument='<%# Eval("id") %>'  OnCommand="confirmClick" OnClientClick="if (!confirm('Are you 100% sure that everything is on track?')) return false;"  ImageURL='<%# GetConfirmButtonImage(Eval("job_list_item")) %>'/>

                       <br />
                    <font size="2" color="black"> Last Confimation :<br />
                         <%# GetLastConfirmationDetails(Eval("job_list_item")) %> </font>
                                    
                </td>

                                      
                            
              
                <td nowrap class="TDwithButtons" style="text-align:center;vertical-align: middle;">
               
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Update" /> &nbsp&nbsp&nbsp     
                      
                   <a href="logistics_control_notes_popup_new.aspx?pLogisticsControlId=<%#Eval("id") %>" rel="nofollow" target="_top" onclick="return openTopSBX(this);">
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
                        No items in Logistics Control.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        
        <LayoutTemplate>
         
                        <table ID="tablesorter" cellpadding="3" runat="server" border="0" class="themeContent" >
                            <tr id="Tr2" runat="server">  
                                <th id="Th1" colspan="8"    runat="server">&nbsp;</th>
                             
                                
                              
                               
                              
                                
                                                             
                                    
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
                    <asp:HiddenField ID="productionCompleteHF" runat="server"  Value='<%# Eval("job_list_item.item_completed") %>'/>

               
                <%# Eval("job_list_item.section.client.job_name")%> <br /> 
                <%# Eval("job_list_item.section.section_name")%> <br />
                    <br />

                <asp:Label ID="descriptionLabel" runat="server" Text='<%# GetOrderDescriptionDetails(Eval("job_list_item"))%>' ToolTip='<%# Eval("job_list_item.description")%>' > </asp:Label>  
                    
                
                </td>
                      
                <td nowrap align="center"  >
                    <asp:Label ID="productionCompleteLabel" Font-Size="Small" runat="server" Text='Production Complete :' > </asp:Label>  
                    <br />
                    <asp:Image ID="Image3" runat="server" CssClass="label" ImageURL='<%# GetYesNoImage(Eval("job_list_item.item_completed")) %>' /><br /><br />
                    <font size="2" color="black">Expected Date : </font><br />
                    <asp:Label runat="server" Text='<%# GetProductionCompleteDate(Eval("job_list_item")) %>' > </asp:Label>  
                    <br />
                    
       
                    </td>

                 <td nowrap align="center"  >
                     <asp:Label runat="server" ID="manufacturedLabel" Text='<%# GetPackagesBeingManufactured(Eval("job_list_item")) %>' > </asp:Label> Packages <br />
                     being Manufactured
                     <br /><br />
                      <asp:Label runat="server" ID="verifiedLabel" Text='<%# GetPackagesVerified(Eval("job_list_item")) %>' > </asp:Label> Packages <br />
                     ready for Dispatch
                     <br /><br />
                     <asp:Label runat="server" ID="dispatchLabel" Text='<%# GetDispatch(Eval("job_list_item")) %>' > </asp:Label> Open<br />
                     Dispatch Events
                </td>
                 
                
                 <td nowrap align="center" style="width:200px"  >
                     Delivery Vehicle Booked<br /><br />
                      
                   <asp:CheckBox ID="vehicleCheckBox"  runat="server" Checked='<%# Bind("vehicle_confirmed") %>' Enabled='true' />

                     <br />
                     <br />
                     
                    <asp:TextBox CssClass="ui-corner-all" style="resize:none;" placeholder="Vehicle Details..." readonly="false" ID="vehicleTextBox" runat="server" 
                            Text='<%# Bind("vehicle_notes") %>' 
                            TextMode="MultiLine" Rows="8" 
                            Width="98%"/>  
                            
                </td>
                 <td nowrap align="center" style="width:200px"  >
                    Delivery Team Booked<br /><br />
                     <asp:CheckBox CssClass="ui-checkboxradio-label" ID="teamCheckBox"  runat="server" Checked='<%# Bind("team_confirmed") %>' Enabled='true' />
                     <br />
                     <br />
                     <asp:TextBox CssClass="ui-corner-all" style="resize:none;" placeholder="Team Details..." readonly="false" ID="teamTextBox" runat="server" 
                            Text='<%# Bind("team_notes") %>' 
                            TextMode="MultiLine" Rows="8" 
                            Width="98%"/> 
                </td>
                 <td nowrap align="center" style="width:200px"  >
                     Accommodation Confirmed<br /><br />
                      <asp:CheckBox ID="accomCheckBox"  runat="server" Checked='<%# Bind("accommodation_confirmed") %>' Enabled='true' />

                     <br />
                     <br />
                     <asp:TextBox CssClass="ui-corner-all" style="resize:none;" placeholder="Accommodation Details..." readonly="false" ID="accomTextBox" runat="server" 
                            Text='<%# Bind("accommodation_notes") %>' 
                            TextMode="MultiLine" Rows="8" 
                            Width="98%"/> 
                </td>

                 <td nowrap align="left" style="vertical-align:top;">

                     <asp:HiddenField ID="originalSiteDeliveryDate" runat="server"  Value='<%# Eval("site_delivery_date") %>'/>

                     Site Delivery Date & Time <br /><br />
                     
          <asp:TextBox  style="border-color:Gray" autocomplete="off" placeholder="Site Delivery Date..." Text='<%# Bind("site_delivery_date","{0:yyyy/MM/dd HH:mm}") %>' ID="datepicker"  runat="server"  />
                                                                                                                             
                     
                     <br />
                     <br />
                     ---------------------------
                     <br />
                     <br />
                     
                      <asp:CheckBox ID="deliveryCompleteCheckBox" Text="Delivery Complete" TextAlign="Right"  runat="server" Checked='<%# Bind("delivery_complete") %>' Enabled='true' />
                   <br />
                      <asp:CheckBox ID="deliveryNoteUploaded" Text="Delivery Note Uploaded" TextAlign="Right"  runat="server" Checked='<%# Bind("delivery_note_uploaded") %>' Enabled='true' />
                     <br />
                 <asp:TextBox placeholder="Delivery Complete Date..." Text='<%# Bind("delivery_complete_date","{0:ddd, d MMM, yyyy}") %>' ID="datepicker2"  runat="server"  />
                         
                                    
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


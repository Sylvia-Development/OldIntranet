<%@ Page Title="" Language="C#" MasterPageFile="~/ManagementLeftNavMasterPage.master" AutoEventWireup="true" CodeFile="orders_management.aspx.cs" Inherits="orders_management" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentPlaceHolder" Runat="Server">
<script type="text/javascript">

    var sbx = window.parent.Shadowbox;
    function openTopSBX(el) {
        if (sbx) {
            sbx.open({ content: el.href
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
<div id="tabs" style="background:white; border:0px;">
    <ul style="background:white; border:0px; white-space:nowrap;">
        
        <li><a href="#tabs-1">New Orders <font style="color:#DC143C"> <%= GetListCount("New Orders")%></font></a></li>
        <li><a href="#tabs-2">Orders To Be Confirmed <font style="color:#DC143C"> <%= GetListCount("Orders Confirmed")%></font></a></li>
        <li><a href="#tabs-3">Orders To Be Received <font style="color:#DC143C"> <%= GetListCount("Orders Receiving")%></font></a></li>
         
        
    </ul>
   
    <div id="tabs-1">
    <asp:ListView ID="ToBeOrderedListView" runat="server" DataKeyNames="id" 
        DataSourceID="ToBeOrderedDataSource" 
         OnItemUpdating = "to_be_ordered_ItemUpdating"
          OnItemUpdated="to_be_ordered_ItemUpdated">
        <ItemTemplate>
                
             <tr class=" <%# GetRowToBeProcessedColour(Eval("order_reminder_date"))%>" style="color: #000000;">

                <td nowrap> 
               
                <%# Eval("section.client.job_name")%> - <%# Eval("section.section_name")%> 
                
                </td>
                <td style="width:40%;">
  
                        <%#Eval("description").ToString().Replace("\n", "<br/>") %>
                    <br />
                    <font size="1" color="white"> Logged by: <%#Eval("user_logged") %> on <%#Eval("date_logged","{0:ddd, d MMM, yyyy}") %> : Requested to be received by  <%#Eval("receive_by_date", "{0:ddd, d MMM, yyyy}")%></font>


                </td>
                
                <td nowrap >
                    <%#Eval("order_reminder_date", "{0:ddd, d MMM, yyyy}")%> 

                </td>
                
                
              
                <td class="TDwithButtons" nowrap>
               
    
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Process Order" /> &nbsp&nbsp
                    <!--a href="print_site_order.aspx?pSectionId=<%#Eval("section_id") %>&itemId=<%#Eval("id") %>"  target="new" > 
     <img src="Images/print.png" />  </a-->
                    
     <%--<a href="job_list_notes_popup_new.aspx?pJobListId=<%#Eval("id") %>" rel="nofollow" target="_top" onclick="return openTopSBX(this);" rel="shadowbox;height=550;width=750";> 
     <img src="Images/notes.png" />  </a>
     --%> 

                    <a href="job_list_notes_popup_new.aspx?pJobListId=<%#Eval("id") %>"  rel="shadowbox;height=550;width=750"> 
     <img src="Images/notes.png" title="Job list orders" />  </a>
                    
                </td>
                
            </tr>
            
        </ItemTemplate>
        <EmptyDataTemplate>
            <table id="Table1" runat="server" >
                <tr>
                    <td>
                        You have no orders to process.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        
        <LayoutTemplate>
         
                        <table ID="tablesorter" runat="server" border="0"  class="themeContent" >
                            
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                   
        </LayoutTemplate>
        <EditItemTemplate>





            <tr class="editrow">

                    <td nowrap> 
                        <asp:HiddenField ID="jobListId" runat="server"  Value='<%# Bind("id") %>'/>
                         <asp:HiddenField ID="jobName" runat="server"  Value='<%# Bind("section.client.job_name") %>'/>
                          <asp:HiddenField ID="section_name" runat="server"  Value='<%# Bind("section.section_name") %>'/>
                          <asp:HiddenField ID="list_description" runat="server"  Value='<%# Bind("description") %>'/>
                       <%# Eval("section.client.job_name")%> - <%# Eval("section.section_name")%> 
                    </td>
                    <td style="width:40%;">
  
                        <%#Eval("description").ToString().Replace("\n", "<br/>") %><br />
                        <font size="1" color="black"><%#Eval("id") %></font>

                </td>

                
                <td nowrap valign="top">


                <asp:TextBox Width="60%" style="border-color:Gray" placeholder="Enter Reminder Date..." ID="datepicker"  runat="server" Text='<%# Bind("order_reminder_date","{0:ddd, d MMM, yyyy}") %>' />
                <div style=" float:right;"><asp:CheckBox ID="CheckBox1"  Text="Ordered" TextAlign="Left" runat="server" Checked='<%# Bind("material_ordered") %>' Enabled='true' /></div>
                <br />
                <asp:TextBox Width="60%" style="border-color:Gray" placeholder="Enter Order No..." ID="order_no_TextBox"  runat="server" Text='<%# Bind("order_no") %>' />
                
                <br />
                <asp:TextBox Width="97%" style="border-color:Gray" TextMode="MultiLine" Rows="3" placeholder="Enter Notes ..." ID="notes_TextBox"  runat="server" class="ui-corner-all" />
                
                
                 
                    


                </td>
                 
               
                <td class="TDwithButtons" nowrap>
               <div >
<%--                    <div style=" float:right;"><asp:CheckBox ID="CheckBox2"  Text="Item N/A" TextAlign="Left" runat="server" Checked='<%# Bind("default_item_na") %>' Enabled='true' /></div><br />--%>
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                        Text="Save" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                        Text="X" />
                   <asp:CheckBox ID="CheckBox3"  Text="Item N/A" TextAlign="Left" runat="server" Checked='<%# Bind("default_item_na") %>' Enabled='true' />
                    </div>    
                        
                        
                </td>
                
            </tr>
        </EditItemTemplate>
        
    </asp:ListView>
    </div>
    <div id="tabs-2">
    <asp:ListView ID="ToBeConfirmedListView" runat="server" DataKeyNames="id" 
        DataSourceID="ToBeConfirmedDataSource" 
         OnItemUpdating = "to_be_confirmed_ItemUpdating"
          OnItemUpdated="to_be_confirmed_ItemUpdated">
        <ItemTemplate>
                
             <tr class=" <%# GetRowToBeProcessedColour(Eval("material_ordered_date")) %>" style="color: #000000;">

                <td nowrap> 
               
                <%# Eval("section.client.job_name")%> - <%# Eval("section.section_name")%> 
                
                </td>
                <td style="width:40%;">
  
                        <%#Eval("description").ToString().Replace("\n", "<br/>") %>
                    <br />
                    <font size="1" color="white"> Logged by: <%#Eval("user_logged") %> on <%#Eval("date_logged","{0:ddd, d MMM, yyyy}") %> : Requested to be received by  <%#Eval("receive_by_date", "{0:ddd, d MMM, yyyy}")%></font>


                </td>
                <td >
                    <%#Eval("order_no")%> 

                </td>
                <td nowrap colspan="2">
                    <%#Eval("material_ordered_date", "{0:ddd, d MMM, yyyy}")%> 

                </td>
                
                
              
                <td class="TDwithButtons" nowrap>
               
    
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Confirm Order" /> &nbsp&nbsp
                     
     <%--<a href="job_list_notes_popup.aspx?pJobListId=<%#Eval("id") %>" rel="nofollow" target="_top" onclick="return openTopSBX(this);"> 
     <img src="Images/notes.png" />  </a>
     --%>               
         
                    <a href="job_list_notes_popup_new.aspx?pJobListId=<%#Eval("id") %>"  rel="shadowbox;height=550;width=750"> 
     <img src="Images/notes.png" title="Job list orders" />  </a>
                    </td>
                
            </tr>
            
        </ItemTemplate>
        <EmptyDataTemplate>
            <table id="Table1" runat="server" >
                <tr>
                    <td>
                        You have no orders to confirm.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        
        <LayoutTemplate>
         
                        <table ID="tablesorter" runat="server" border="0"  class="themeContent">
                            <tr id="Tr1" runat="server">
                                
                                
                                <th id="Th1"  colspan="2" runat="server">
                                    &nbsp</th>
                                <th >
                                <font size="2">Order No</font> </th>
                                <th colspan="2">
                                <font size="2">Ordered Date</font> </th>
                                
                               
                                <th>&nbsp</th>
                            
                                
                                
                                
                            </tr>
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                   
        </LayoutTemplate>
        <EditItemTemplate>





            <tr  class="editrow">

                    <td nowrap> 
                        <asp:HiddenField ID="jobListId" runat="server"  Value='<%# Bind("id") %>'/>
                        <asp:HiddenField ID="jobName" runat="server"  Value='<%# Bind("section.client.job_name") %>'/>
                        <asp:HiddenField ID="section_name" runat="server"  Value='<%# Bind("section.section_name") %>'/>
                          
                       <%# Eval("section.client.job_name")%> - <%# Eval("section.section_name")%> 
                    </td>
                    <td style="width:40%;" >
  
                        <%#Eval("description").ToString().Replace("\n", "<br/>") %>

                </td>
                <td >
                    <%#Eval("order_no")%> 

                </td>
                <td nowrap >
                    <%#Eval("material_ordered_date", "{0:ddd, d MMM, yyyy}")%> 

                </td>

                
                <td  valign="top">
                
                <asp:DropDownList  id="OrderConfirmedMethodDropDown" SelectedValue='<%# Bind("order_confirmed_method") %>' Width="99%"  runat="server" CssClass="ui-corner-all ui-widget-header ui-autocomplete-input ui-accordion-content-active ui-accordion ui-widget ui-helper-reset">
                                <asp:ListItem Value="" Text="<< Select Method >>"></asp:ListItem>
                                <asp:ListItem Value="Email" Text="Email"></asp:ListItem>
                                <asp:ListItem Value="Verbal" Text="Verbal Confirmation"></asp:ListItem>
                                
                            
                      </asp:DropDownList>
                <br />
                <div style=" float:left;"><asp:CheckBox ID="CheckBox1"  Text="Confirmed" TextAlign="Right" runat="server" Checked='<%# Bind("order_confirmed") %>' Enabled='true' /></div>
               
 


                </td>
                 
               
                <td  class="TDwithButtons" nowrap>
               <div >
                    
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                        Text="Save" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                        Text="X" />
                    </div>    
                        
                        
                </td>
                
            </tr>
        </EditItemTemplate>
        
    </asp:ListView>
    </div>
    <div id="tabs-3">
    <asp:ListView ID="ToBeReceivedListView" runat="server" DataKeyNames="id" 
        DataSourceID="ToBeReceivedDataSource" 
         OnItemUpdating = "to_be_received_ItemUpdating"
          OnItemUpdated="to_be_received_ItemUpdated">
        <ItemTemplate>
                
             <tr class="<%# GetRowToBeProcessedColour(Eval("receive_by_date")) %>" syle="color: #000000;">

                <td nowrap> 
             
                <%# Eval("section.client.job_name")%> - <%# Eval("section.section_name")%> 
                
                </td>
                <td style="width:40%;">
  
                        <%#Eval("description").ToString().Replace("\n", "<br/>") %>
                    <br />
                    <font size="1" color="white"> Logged by: <%#Eval("user_logged") %> - <%#Eval("date_logged","{0:ddd, d MMM, yyyy}") %> </font>


                </td>
                
                <td nowrap >
                    <%#Eval("receive_by_date", "{0:ddd, d MMM, yyyy}")%> <br />
                    <%#Eval("order_no")%>

                </td>
                
                
              
                <td  class="TDwithButtons" nowrap>
               
    
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Receive Order" /> &nbsp&nbsp
                     <a href="print_generic_job_list_info.aspx?pSectionId=<%#Eval("section_id") %>&pJobListId=<%#Eval("id") %>&pType=Order Received"  target="new" > 
     <img src="Images/print.png" />  </a>&nbsp
     <%--<a href="job_list_notes_popup.aspx?pJobListId=<%#Eval("id") %>" rel="nofollow" target="_top" onclick="return openTopSBX(this);"> 
     <img src="Images/notes.png" />  </a>
     --%>    
                    <a href="job_list_notes_popup_new.aspx?pJobListId=<%#Eval("id") %>"  rel="shadowbox;height=550;width=750"> 
     <img src="Images/notes.png" title="Job list orders" />  </a>
                </td>
                
            </tr>
            
        </ItemTemplate>
        <EmptyDataTemplate>
            <table id="Table1" runat="server" >
                <tr>
                    <td>
                        You have no orders to receive.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        
        <LayoutTemplate>
         
                        <table ID="tablesorter" runat="server" border="0" class="themeContent" >
                            
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                   
        </LayoutTemplate>
        <EditItemTemplate>





            <tr class="editrow">

                    <td nowrap> 
                        <asp:HiddenField ID="jobListId" runat="server"  Value='<%# Bind("id") %>'/>
                         <asp:HiddenField ID="jobName" runat="server"  Value='<%# Bind("section.client.job_name") %>'/>
                          <asp:HiddenField ID="section_name" runat="server"  Value='<%# Bind("section.section_name") %>'/>
                          <asp:HiddenField ID="list_description" runat="server"  Value='<%# Bind("description") %>'/>
                           <asp:HiddenField ID="needProcessing" runat="server"  Value='<%# Bind("order_needs_processing") %>'/>
                           <asp:HiddenField ID="procdaysneeded" runat="server"  Value='<%# Bind("processing_days_needed") %>'/>
                       <%# Eval("section.client.job_name")%> - <%# Eval("section.section_name")%> 
                    </td>
                    <td style="width:40%;">
  
                        <%#Eval("description").ToString().Replace("\n", "<br/>") %>

                </td>

                
                <td  valign="top">


                <asp:TextBox Width="60%" style="border-color:Gray" placeholder="Receive By Date..." ID="datepicker"  runat="server" Text='<%# Bind("receive_by_date","{0:ddd, d MMM, yyyy}") %>' />
                <div style=" float:right;"><asp:CheckBox ID="CheckBox1"  Text="Received" TextAlign="Left" runat="server" Checked='<%# Bind("material_delivered") %>' Enabled='true' /></div>
                <br />
                
                 <asp:TextBox Width="60%" style="border-color:Gray" placeholder="Order No..." ID="TextBox1"  runat="server" Text='<%# Bind("order_no") %>' />
                
                <br />
                <asp:TextBox Width="97%" style="border-color:Gray" TextMode="MultiLine" Rows="3" placeholder="Enter Notes ..." ID="notes_TextBox"  runat="server" class="ui-corner-all" />
                
                
                 
                    


                </td>
                 
               
                <td class="TDwithButtons" nowrap>
               <div >
                    
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                        Text="Save" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                        Text="X" />
                    </div>    
                        
                        
                </td>
                
            </tr>
        </EditItemTemplate>
        
    </asp:ListView>
    </div>
    
   
<asp:LinqDataSource ID="ToBeOrderedDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="False" 
        EnableInsert="False" EnableUpdate="True" TableName="job_list_items"
        OnSelecting="to_be_ordered_DataSource_Selecting">
</asp:LinqDataSource>
<asp:LinqDataSource ID="ToBeConfirmedDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="False" 
        EnableInsert="False" EnableUpdate="True" TableName="job_list_items"
        OnSelecting="to_be_confirmed_DataSource_Selecting">
</asp:LinqDataSource>
<asp:LinqDataSource ID="ToBeReceivedDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="False" 
        EnableInsert="False" EnableUpdate="True" TableName="job_list_items"
        OnSelecting="to_be_received_DataSource_Selecting">
</asp:LinqDataSource>
</div>





</asp:Content>


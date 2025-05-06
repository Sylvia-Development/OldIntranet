<%@ Page Language="C#" AutoEventWireup="true" CodeFile="job_list_data.aspx.cs" Inherits="job_list_data" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="iframes.css" rel="stylesheet" type="text/css" />

    <link href="Scripts/jquery-ui-1.8.7.custom/css/smoothness/jquery-ui-1.8.7.custom.css" rel="stylesheet" type="text/css" />
   
    <link href="Scripts/jquery-ui-themes-1.10.2/themes/smoothness/jquery-ui.css" rel="stylesheet"
        type="text/css" />
    <link href="joblistdata.css" rel="stylesheet" type="text/css" />
    <script src="Scripts/jquery-1.8.2.js" type="text/javascript"></script>
    
    <script src="Scripts/jquery.ui.datepicker.js" type="text/javascript"></script>

    

    <script src="Scripts/jquery-ui-1.9.1.custom/jquery-ui-1.9.1.custom/js/jquery-ui-1.9.1.custom.min.js"
        type="text/javascript"></script>

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
            $("#blocker").hide();
        });
        $(function () {
            $("#maincontent").show();
        });

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

      $(function() {
    $( "#accordion" ).accordion({
      collapsible: true
      
      
      
      
    });
  });

  </script>
  
    


</head>
<body class="iframeBody">
    <form id="form1" runat="server">
    <asp:HiddenField ID="hdnSelectedTab" runat="server" Value="0" />
    <div id="wrapper" style="width: 100%; height: 100%; overflow: auto; ">
      <asp:LoginView ID="LoginView2" runat="server">
    <LoggedInTemplate>
    <div id="blocker">
       <div>Loading...</div>
   </div>
        <div id="maincontent" style=" display:none">
        <div id="one_column">
        <div style="z-index: 2;  margin-left:88%; position: absolute; top: 12px; left: 0px;">
<a href="print_job_list.aspx?pSectionId=<%Response.Write(Page.Request.QueryString["pSectionId"]); %>"  target="new" > 
     <img src="Images/print.png" title="print snag list" />  </a>
&nbsp&nbsp
    <a href="client_info_new.aspx?pClientId=<%Response.Write(Page.Request.QueryString["pClientId"]); %>" rel="nofollow" target="_top" onclick="return openTopSBX(this);"> 
        <img src="Images/client_info.png" title="client info" /> </a>
 &nbsp&nbsp
 
 <a href="notes_view_popup.aspx?pSectionId=<%Response.Write(Page.Request.QueryString["pSectionId"]); %>&pClientId=<%Response.Write(Page.Request.QueryString["pClientId"]); %>" rel="nofollow" target="_top" onclick="return openTopSBX(this);"> 
     <img src="Images/notes.png" title="client notes" />  </a>

</div>

 

<div id="tabs" style="z-index: 1; width:99%; position: absolute; top: 0px; left: 0px;">
    <ul>
        <li><a href="#tabs-1">Orders List</a></li>
        <li><a href="#tabs-2">Site Snag List</a></li>
        
    </ul>
    <div id="tabs-1">
  <div id="accordion">
  <h3><b><font size="2">Current Items</font></b></h3>
  <div>
    
    <asp:ListView ID="JoblistItemsInsertListView" runat="server" DataKeyNames="id" 
        DataSourceID="JoblistItemsInsertDataSource" InsertItemPosition="FirstItem"
        OnItemInserting="joblist_items_ItemInserting" 
         OnItemInserted="joblist_items_ItemInserted" >
         
        
        
        <InsertItemTemplate>
            <tr class="newJobList">
            
                <td >
                    <asp:TextBox TextMode="MultiLine" Rows="7" Width="100%" ID="descriptionTextBox" runat="server" Text='<%# Bind("description") %>' />
                    <br />
                     <asp:Button ID="InsertButton" runat="server" CommandName="Insert" 
                        Text="Save" />
                
                
            </tr>
        </InsertItemTemplate>
        <ItemTemplate>
                
           
            
        </ItemTemplate>
        <LayoutTemplate>
           
                        <table ID="JobListTable" cellpadding="3" runat="server" border="0" 
                            style=" background-color: #FFFFFF; width:50%; border-collapse: collapse;border-color: #999999;border-style:none;border-width:0px;font-family: Verdana, Arial, Helvetica, sans-serif;">
                            <tr id="Tr2" runat="server" style="background-color:transparent;  font-size:11pt; color:Gray;">  
                                <th id="Th1"   runat="server">New Order</th>
                                
                            </tr>
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                    
        </LayoutTemplate>
        
        
    </asp:ListView>
<br />
<asp:LinqDataSource ID="JoblistItemsInsertDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="False" 
        EnableInsert="True" EnableUpdate="False" TableName="job_list_items">
</asp:LinqDataSource>

     <asp:ListView ID="JoblistItemsListView" runat="server" DataKeyNames="id" 
        DataSourceID="JoblistItemsDataSource" 
         OnItemUpdating = "joblist_items_ItemUpdating"
          OnItemUpdated="joblist_items_ItemUpdated">
        <ItemTemplate>
                
            <tr style="background-color:#DCDCDC;color: #000000;">

                <td style="width:30%;">
  
                        <%#Eval("description").ToString().Replace("\n", "<br/>") %><br /><br />
                      <font size="1" color="grey"> Logged by: <%#Eval("user_logged") %> - <%#Eval("date_logged","{0:ddd, d MMM, yyyy}") %> </font>

                </td>
                <td align="center">
                    <asp:Image ID="imgStatus" runat="server" CssClass="label" ImageURL='<%# GetImage( Eval("material_ordered")) %>' /><br />
                  <font size="1" color="grey">  <%#Eval("material_ordered_date", "{0:ddd, d MMM, yyyy}")%> &nbsp <%# Eval("order_no")%></font>
                </td>
                
                <td align="center">

                 <a href="print_generic_job_list_info.aspx?pSectionId=<%#Eval("section_id") %>&pJobListId=<%#Eval("id") %>&pType=Order Received"  target="new" > 
    <asp:Image ID="Image2" runat="server" CssClass="label" ImageURL='<%# GetImage( Eval("material_delivered")) %>' /> </a>
                    
                    
                    
                    
                    <br />
                  <font size="1" color="grey">  <%#Eval("material_received_date", "{0:ddd, d MMM, yyyy}")%></font>
                </td>    
                <td align="center">
                    <asp:Image ID="Image1" runat="server" CssClass="label" ImageURL='<%# GetImage( Eval("material_processed")) %>' /><br />
                  <font size="1" color="grey">  <%#Eval("date_completed", "{0:ddd, d MMM, yyyy}")%></font>
                </td>

                <td align="center">
                   <%# Eval("date_expected", "{0:ddd, d MMM, yyyy}")%> 
                
                
                </td>
               
                
                
                <td class="TDwithButtons" colspan="2"  align="center" >
                
                 
                     <a href="print_site_order.aspx?pSectionId=<%#Eval("section_id") %>&itemId=<%#Eval("id") %>"  target="new" > 
     <img src="Images/print.png" />  </a>&nbsp
     <a href="job_list_notes_popup.aspx?pJobListId=<%#Eval("id") %>" rel="nofollow" target="_top" onclick="return openTopSBX(this);"> 
     <img src="Images/notes.png" title="log order note" />  </a>&nbsp
    <% if (Context.User.IsInRole("Director"))
       {  %>
      <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Update" />

      <%} %>
                </td>
                
            </tr>
            
        </ItemTemplate>
        <EmptyDataTemplate>
            <table id="Table1" runat="server" 
                style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;">
                <tr>
                    <td>
                        No Current Orders.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
          <EditItemTemplate>





            <tr style="background-color:Gray;color: #FFFFFF;">
 

                <td style="width:30%;">
                    <asp:TextBox TextMode="MultiLine" Rows="7" Width="95%"  ID="descriptionTextBox" runat="server" Text='<%# Bind("description") %>' />
                     
                </td>
                <td align="center">
                <asp:CheckBox ID="CheckBox1"  runat="server" Checked='<%# Bind("material_ordered") %>'  /><br />
                  <asp:TextBox  style=" border-color:Gray" placeholder="Enter Order No..." ID="order_no_textbox"  runat="server" Text='<%# Bind("order_no") %>' />
                </td>
                
                <td align="center">
                 <asp:CheckBox ID="CheckBox2"  runat="server" Checked='<%# Bind("material_delivered") %>'  />
                    
                    
                    
                    
                    
                </td>    
                <td align="center">
                 <asp:CheckBox ID="CheckBox3"  runat="server" Checked='<%# Bind("material_processed") %>'  />
                    
                </td>

                <td align="center">
                   <%# Eval("date_expected", "{0:ddd, d MMM, yyyy}")%> 
                
                
                </td>
               
                
                
                <td class="TDwithButtons" colspan="2"  align="center" >
                
                  <div style=" float:right;">
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                        Text="Save" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                        Text="X" />
                        <asp:CheckBox ID="CheckBox4"  runat="server" Text="Waste" Checked='<%# Bind("is_waste") %>'  />

                        

                    </div>    
                </td>
                
            </tr>






        </EditItemTemplate>
        <LayoutTemplate>
         
                        <table ID="itemPlaceholderContainer" cellpadding="3" runat="server" border="1" 
                            style=" background-color: #FFFFFF; width:95%; border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;font-family: Verdana, Arial, Helvetica, sans-serif;">
                            <tr id="Tr2" runat="server" style="background-color:Gray;  font-size:11pt; color:White;">  
                                <th id="Th1"   runat="server">&nbsp</th>
                                <th align="center" ><font size="1">Ordered</font></th>
                                <th align="center" ><font size="1">Received</font></th>
                                <th align="center" ><font size="1">Processed/Completed</font></th>
                                <th align="center" ><font size="1">Expected Date</font></th>
                                
                                <th colspan="2">&nbsp</th>
                                    
                            </tr>
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                   
        </LayoutTemplate>
        
        
    </asp:ListView>

<asp:LinqDataSource ID="JoblistItemsDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="True" 
        EnableInsert="False" EnableUpdate="True" TableName="job_list_items"
        OnSelecting="joblist_items_DataSource_Selecting">
</asp:LinqDataSource>

    
  </div>      
  <h3><b><font size="2">Completed Items</font></b></h3>
  <div>
   
    <asp:ListView ID="CompletedListView" runat="server" DataKeyNames="id" 
        DataSourceID="CompletedItemsDataSource" >
        <ItemTemplate>
                
            <tr style="background-color:#DCDCDC;color: #000000;">

                <td style="width:30%;">
  
                    <%# GetOpenTag(Eval("default_item_na")) %>    <%#Eval("description").ToString().Replace("\n", "<br/>") %><br /><br />
                      <font size="1" color="grey"> Logged by: <%#Eval("user_logged") %> - <%#Eval("date_logged","{0:ddd, d MMM, yyyy}") %> </font>
                    <%# GetCloseTag(Eval("default_item_na")) %>
                </td>
                <td align="center">
                    <asp:Image ID="imgStatus" runat="server" CssClass="label" ImageURL='<%# GetImage(Eval("material_ordered")) %>' /><br />
                  <font size="1" color="grey">  <%#Eval("material_ordered_date", "{0:ddd, d MMM, yyyy}")%> &nbsp <%# Eval("order_no")%></font>
                </td>
                
                <td align="center">
                    <a href="print_generic_job_list_info.aspx?pSectionId=<%#Eval("section_id") %>&pJobListId=<%#Eval("id") %>&pType=Order Received"  target="new" > 
    <asp:Image ID="Image2" runat="server" CssClass="label" ImageURL='<%# GetImage( Eval("material_delivered")) %>' /> </a><br />
                  <font size="1" color="grey">  <%#Eval("material_received_date", "{0:ddd, d MMM, yyyy}")%></font>
                </td>    
                <td align="center">
                    <asp:Image ID="Image1" runat="server" CssClass="label" ImageURL='<%# GetImage(Eval("material_processed")) %>' /><br />
                  <font size="1" color="grey">  <%#Eval("date_completed", "{0:ddd, d MMM, yyyy}")%></font>
                </td>
<td>
               
               <a href="print_generic_job_list_info.aspx?pSectionId=<%#Eval("section_id") %>&pJobListId=<%#Eval("id") %>&pType=Order Received"  target="new" > 
     <img src="Images/print.png" />  </a>&nbsp
                
                
     </td>          
                
            </tr>
            
        </ItemTemplate>
        <EmptyDataTemplate>
            <table id="Table1" runat="server" 
                style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;">
                <tr>
                    <td>
                        No Completed Items.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        
        <LayoutTemplate>
         
                        <table ID="itemPlaceholderContainer" cellpadding="3" runat="server" border="1" 
                            style=" background-color: #FFFFFF; width:95%; border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;font-family: Verdana, Arial, Helvetica, sans-serif;">
                            <tr id="Tr2" runat="server" style="background-color:Gray;  font-size:11pt; color:White;">  
                                <th id="Th1"   runat="server">&nbsp</th>
                                <th align="center" ><font size="1">Ordered</font></th>
                                <th align="center" ><font size="1">Received</font></th>
                                <th align="center" ><font size="1">Processed/Completed</font></th>
                                 <th align="center" >&nbsp</th>
                                
                                
                               
                                    
                            </tr>
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                   
        </LayoutTemplate>
        
        
    </asp:ListView>

<asp:LinqDataSource ID="CompletedItemsDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="True" 
        EnableInsert="False" EnableUpdate="True" TableName="job_list_items"
        OnSelecting="completed_items_DataSource_Selecting">
</asp:LinqDataSource>











  </div>
   </div>
    </div>
    <div id="tabs-2">
      
     <asp:ListView ID="SnagInsertListView" runat="server" DataKeyNames="id" 
        DataSourceID="SnaglistItemsInsertDataSource" InsertItemPosition="FirstItem"
        OnItemInserting="snaglist_items_ItemInserting" 
         OnItemInserted="snaglist_items_ItemInserted" >
         
        
        
        <InsertItemTemplate>
            <tr class="newJobList">
            
                <td >
                    <asp:TextBox TextMode="MultiLine" Rows="7" Width="100%" ID="descriptionTextBox" runat="server" Text='<%# Bind("description") %>' />
                    <br />
                     <asp:Button ID="InsertButton" runat="server" CommandName="Insert" 
                        Text="Save" />
                
                
            </tr>
        </InsertItemTemplate>
        <ItemTemplate>
                
           
            
        </ItemTemplate>
        <LayoutTemplate>
           
                        <table ID="JobListTable" cellpadding="3" runat="server" border="0" 
                            style=" background-color: #FFFFFF; width:50%; border-collapse: collapse;border-color: #999999;border-style:none;border-width:0px;font-family: Verdana, Arial, Helvetica, sans-serif;">
                            <tr id="Tr2" runat="server" style="background-color:transparent;  font-size:11pt; color:Gray;">  
                                <th id="Th1"   runat="server">New Snag List Item</th>
                                
                            </tr>
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                    
        </LayoutTemplate>
        
        
    </asp:ListView>
<br />
<asp:LinqDataSource ID="SnaglistItemsInsertDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="False" 
        EnableInsert="True" EnableUpdate="False" TableName="job_list_items">
</asp:LinqDataSource>

     <asp:ListView ID="SnagListListView" runat="server" DataKeyNames="id" 
        DataSourceID="SnaglistItemsDataSource" 
         OnItemUpdating = "snaglist_items_ItemUpdating"
          OnItemUpdated="snaglist_items_ItemUpdated">
        <ItemTemplate>
                
            <tr style="background-color:#DCDCDC;color: #000000;">

                <td style="width:60%;">
  
                        <%#Eval("description").ToString().Replace("\n", "<br/>") %><br /><br />
                        <font size="1" color="grey"> 
                      Logged by: <%#Eval("user_logged") %> - <%#Eval("date_logged","{0:ddd, d MMM, yyyy}") %><br />
                       Completed by: <%#Eval("user_completed")%> - <%#Eval("date_completed", "{0:ddd, d MMM, yyyy}")%>
                      </font>

                </td>
                <td align="center">
                    <asp:Image ID="imgStatus" runat="server" CssClass="label" ImageURL='<%# GetImage( Eval("item_completed")) %>' />
                </td>
                

                
                
                
                <td   align="center" style="width:110px;">
                
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Update" />
                    
                </td>
                
            </tr>
            
        </ItemTemplate>
        <EmptyDataTemplate>
            <table id="Table1" runat="server" 
                style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;">
                <tr>
                    <td>
                        No Snag List Items.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        
        <LayoutTemplate>
         
                        <table ID="itemPlaceholderContainer" cellpadding="3" runat="server" border="1" 
                            style=" background-color: #FFFFFF; width:95%; border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;font-family: Verdana, Arial, Helvetica, sans-serif;">
                            <tr id="Tr2" runat="server" style="background-color:Gray;  font-size:11pt; color:White;">  
                                <th id="Th1"   runat="server">&nbsp</th>
                                
                                <th align="center" ><font size="1">Item Completed</font></th>
                                
                                
                                <th >&nbsp</th>
                                    
                            </tr>
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                   
        </LayoutTemplate>
        <EditItemTemplate>





            <tr style="background-color:Gray;color: #FFFFFF;">

                    <td style="width:60%;">
                    <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Bind("description") %>' />
                          <%#Eval("description").ToString().Replace("\n", "<br/>") %><br /><br />
                       
     
                     </td> 
                  
                
                <td align="center">
                    <asp:CheckBox ID="CheckBox1"  runat="server" Checked='<%# Bind("item_completed") %>' Enabled='<%# GetCompletedAllowedToUpdate(Eval("user_role")) %>' />
                </td>
                
                <td >
                   
               <div style=" float:right;">
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                        Text="Save" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                        Text="X" />
                    </div>    
                        
                        
                </td>
                
            </tr>
        </EditItemTemplate>
        
    </asp:ListView>

<asp:LinqDataSource ID="SnaglistItemsDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="True" 
        EnableInsert="False" EnableUpdate="True" TableName="job_list_items"
        OnSelecting="snaglist_items_DataSource_Selecting">
</asp:LinqDataSource>
    </div>
    
</div>







    
    </div>
    </div>    
    </LoggedInTemplate>
    
    <AnonymousTemplate>
    
    
    <div align="center">
    <br /><br />
       You are not Logged in anymore!
        
     </div>  
    
    
    </AnonymousTemplate>
    
 </asp:LoginView>
   
        
        
        
    
    
    
   
    
    </div>
    </form>
</body>
</html>

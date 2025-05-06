<%@ Page Title="" Language="C#" MasterPageFile="~/ManagementLeftNavMasterPage.master" AutoEventWireup="true" CodeFile="technical_services.aspx.cs" Inherits="technical_services" %>

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
        $(function () {
            $('.OrderActionDropDown').each(function () {
                var $this = $(this), // the drop down that changed
           $thisRow = $this.closest('tr'), // the drop down's row
               
                $thisWaste = $thisRow.find('.waste_checkbox');
             
                if ($(this).val() == '1') {
                    
                    $thisWaste.css({ 'visibility': 'visible' });
                } else if ($(this).val() == '2') {
                    
                    $thisWaste.css({ 'visibility': 'hidden' });
                } 
            });
        });

        $(function () {
            $('.OrderActionDropDown').change(function () {
                var $this = $(this), // the drop down that changed
           $thisRow = $this.closest('tr'), // the drop down's row
               
                $thisWaste = $thisRow.find('.waste_checkbox');


                if ($(this).val() == '1') {
                    
                    $thisWaste.css({ 'visibility': 'visible' });
                } else if ($(this).val() == '2') {
                    
                    $thisWaste.css({ 'visibility': 'hidden' });
                } 
            });
        });



  </script>
  <asp:HiddenField ID="hdnSelectedTab" runat="server" Value="0" />

<br />
 
<div id="tabs" style="background:white; border:white;">
    <ul style="background:white; border:white;">
        <li><a href="#tabs-1">Site Orders</a></li>
    </ul>
  
    <div id="tabs-1">
    <asp:ListView ID="ToBeOrderedListView" runat="server" DataKeyNames="id" 
        DataSourceID="ToBeOrderedDataSource" 
         OnItemUpdating = "to_be_ordered_ItemUpdating"
          OnItemUpdated="to_be_ordered_ItemUpdated">
        <ItemTemplate>
                
            <tr >

                <td>  <%# Eval("section.client.job_name")%> - <%# Eval("section.section_name")%>  </td>
                <td style="width:40%;">
  
                        <%#Eval("description").ToString().Replace("\n", "<br/>") %>

                </td>
                
                
                <td nowrap colspan="3">
                    <%#Eval("user_logged") %> - <%#Eval("date_logged","{0:ddd, d MMM, yyyy}") %> (blu<%#Eval("id")%>/R) 

                </td>
              
                <td   align="center">
               
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Process Order" /> &nbsp
                   
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
         
                        <table ID="tablesorter" runat="server" border="0" class="tableSpacing paddedTable themeContent">
                            
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                   
        </LayoutTemplate>
        <EditItemTemplate>
            <tr class="editrow">

                    <td> 
                        <asp:HiddenField ID="sectionId" runat="server"  Value='<%# Bind("section.section_id") %>'/>
                        <asp:HiddenField ID="hiddenJobListId" runat="server"  Value=' <%# Bind("id")%>'/>
                    <asp:HiddenField ID="jobName" runat="server"  Value='<%# Bind("section.client.job_name") %>'/>
                    <asp:HiddenField ID="section_name" runat="server"  Value='<%# Bind("section.section_name") %>'/>
                     <%# Eval("section.client.job_name")%> - <%# Eval("section.section_name")%>  </td>
                    <td style="width:40%;">
                    <asp:TextBox TextMode="MultiLine" Rows="10" Width="99%" ID="textbox1" runat="server" Text='<%# Bind("description") %>'  CssClass="ui-corner-all"/>

                     </td> 
                
                <td  valign="top">
                     <%#Eval("user_logged") %> - <%#Eval("date_logged","{0:ddd, d MMM, yyyy}") %> <br /> (blu<%#Eval("id")%>/R)
                </td>
                 <td align="left" valign="top">

                     <asp:DropDownList  id="ReasonDropDownList"  Width="100%"  SelectedValue='<%# Bind("reason_for_logging") %>'  runat="server" CssClass="ui-corner-all ui-widget-header ui-autocomplete-input ui-accordion-content-active ui-accordion ui-widget ui-helper-reset">
                                <asp:ListItem Value="0" Text="<< Select Reason >>"></asp:ListItem>
                                <asp:ListItem Value="Final Measurement Mistake" Text="Final Measurement Mistake"></asp:ListItem>
                         <asp:ListItem Value="Plan Generation Mistake" Text="Plan Generation Mistake"></asp:ListItem>                       
                         <asp:ListItem Value="Production Mistake" Text="Production Mistake"></asp:ListItem>
                         <asp:ListItem Value="Delivery Damage" Text="Delivery Damage"></asp:ListItem>
                         <asp:ListItem Value="Installation or Site Work Mistake" Text="Installation or Site Work Mistake"></asp:ListItem>
                         <asp:ListItem Value="On Site Instruction Client" Text="On Site Instruction Client"></asp:ListItem>
                         <asp:ListItem Value="On Site Instruction Site Coordinator" Text="On Site Instruction Site Coordinator"></asp:ListItem>
                         <asp:ListItem Value="Supplier Error" Text="Supplier Error"></asp:ListItem>
                                <asp:ListItem Value="NA" Text="N/A"></asp:ListItem>
                                                          
                      </asp:DropDownList>
                                        
                </td>
                 <td align="left" valign="top">
                                  
                     <asp:DropDownList  id="OrderActionDropDown" class="OrderActionDropDown" Width="100%"  runat="server" CssClass="ui-corner-all ui-widget-header ui-autocomplete-input ui-accordion-content-active ui-accordion ui-widget ui-helper-reset">
                                <asp:ListItem Value="0" Text="<< Select Action >>"></asp:ListItem>
                                <asp:ListItem Value="1" Text="Authorised - Send >>"></asp:ListItem>
                                <asp:ListItem Value="2" Text="Declined - N/A"></asp:ListItem>
                                                           
                      </asp:DropDownList>
                                      
                </td>
               
                <td align="center">
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

<asp:LinqDataSource ID="ToBeOrderedDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="True" 
        EnableInsert="False" EnableUpdate="True" TableName="job_list_items"
        OnSelecting="to_be_ordered_DataSource_Selecting">
</asp:LinqDataSource>

    </div>
</div>

</asp:Content>


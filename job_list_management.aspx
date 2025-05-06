<%@ Page Title="" Language="C#" MasterPageFile="~/ManagementLeftNavMasterPage.master" AutoEventWireup="true" CodeFile="job_list_management.aspx.cs" Inherits="job_list_management" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentPlaceHolder" Runat="Server">
<script type="text/javascript">

    $(function() {
        $("input[id$='datepicker']").datepicker({ dateFormat: 'D, d M, yy', showOtherMonths: true, selectOtherMonths: true });
    });

        
    


</script>

<h1>Job List Management</h1>


   <asp:ListView ID="ToBeOrderedListView" runat="server" DataKeyNames="id" 
        DataSourceID="ToBeOrderedDataSource" 
         OnItemUpdating = "to_be_ordered_ItemUpdating"
          OnItemUpdated="to_be_ordered_ItemUpdated">
        <ItemTemplate>
                
            <tr style="background-color:#DCDCDC;color: #000000;">

                <td> <%# getClientAndSection((int)Eval("section_id")) %> </td>
                <td style="width:40%;">
  
                        <%#Eval("description").ToString().Replace("\n", "<br/>") %><br />
                        <%#Eval("user_logged") %> - <%#Eval("date_logged","{0:ddd, d MMM, yyyy}") %>

                </td>
                
                
                <td align="center">
                    <asp:Image ID="imgStatus" runat="server" CssClass="label" ImageURL='<%# GetImage(Eval("material_ordered")) %>' />
                </td>
                <td align="center">
                    <asp:Image ID="Image1" runat="server" CssClass="label" ImageURL='<%# GetImage(Eval("material_delivered")) %>' />
                </td>
                <td align="center">
                    <asp:Image ID="Image2" runat="server" CssClass="label" ImageURL='<%# GetImage(Eval("material_processed")) %>' />
                </td>
                <td align="center">
                    <asp:Image ID="Image3" runat="server" CssClass="label" ImageURL='<%# GetImage(Eval("order_needs_processing")) %>' />
                </td>
                <td align="center">
                    <asp:Image ID="Image4" runat="server" CssClass="label" ImageURL='<%# GetImage(Eval("production_assistant_to_order")) %>' />
                </td>
                <td align="center">
                    <asp:Image ID="Image5" runat="server" CssClass="label" ImageURL='<%# GetImage(Eval("order_confirmed")) %>' />
                </td>
                <td align="center">
                    <asp:Image ID="Image6" runat="server" CssClass="label" ImageURL='<%# GetImage(Eval("manager_has_processed_order")) %>' />
                </td>
                <td align="center">
                    <asp:Image ID="Image7" runat="server" CssClass="label" ImageURL='<%# GetImage(Eval("is_main_material_order")) %>' />
                </td>
                <td align="center">
                    <asp:Image ID="Image8" runat="server" CssClass="label" ImageURL='<%# GetImage(Eval("is_general_task")) %>' />
                </td>
                 <td align="center">
                    <asp:Image ID="Image9" runat="server" CssClass="label" ImageURL='<%# GetImage(Eval("item_completed")) %>' />
                </td>
                
                
              
                <td   align="center">
               
    
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" /> &nbsp&nbsp
                    
                    
                </td>
                
            </tr>
            
        </ItemTemplate>
        <EmptyDataTemplate>
            <table id="Table1" runat="server" 
                style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;">
                <tr>
                    <td>
                        No Data.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        
        <LayoutTemplate>
         
                        <table ID="itemPlaceholderContainer" cellpadding="3" runat="server" border="1" 
                            style=" background-color: #FFFFFF; width:95%; border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;font-family: Arial, Helvetica, sans-serif;">
                            <tr id="Tr2" runat="server" class="tableheaderrow">  
                                <th  colspan="2"   runat="server">&nbsp</th>
                                <th  align="center" ><font size="1">Ordered</font></th>
                                <th  align="center" ><font size="1">Received</font></th>
                                <th  align="center" ><font size="1">Processed</font></th>
                                <th  align="center" ><font size="1">Needs Processing</font></th>
                                <th  align="center" ><font size="1">PA to Order</font></th>
                                <th  align="center" ><font size="1">Order Confirmed</font></th>
                                <th  align="center" ><font size="1">Manager Processed</font></th>
                                <th  align="center" ><font size="1">Is Main Material</font></th>
                                <th  align="center" ><font size="1">Is General Task</font></th>
                                <th  align="center" ><font size="1">Item Completed</font></th>
                                
                                
                               
                                <th >&nbsp</th>
                                    
                            </tr>
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                   
        </LayoutTemplate>
        <EditItemTemplate>





            <tr style="background-color:Gray;color: #FFFFFF;">

                    <td> <%# getClientAndSection((int)Eval("section_id")) %> </td>
                <td style="width:40%;">
  
                       <asp:TextBox TextMode="MultiLine" Rows="10" Width="99%" ID="textbox1" runat="server" Text='<%# Bind("description") %>' /><br />
                        <%#Eval("user_logged") %> - <%#Eval("date_logged","{0:ddd, d MMM, yyyy}") %>

                </td>
                  
               <td align="center">
                    <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("material_ordered") %>'  />
                </td>
                <td align="center">
                    <asp:CheckBox ID="CheckBox2" runat="server" Checked='<%# Bind("material_delivered") %>'  />
                </td>
                <td align="center">
                    <asp:CheckBox ID="CheckBox4" runat="server" Checked='<%# Bind("material_processed") %>'  />
                </td>
                <td align="center">
                    <asp:CheckBox ID="CheckBox5" runat="server" Checked='<%# Bind("order_needs_processing") %>'  />
                </td>
                <td align="center">
                    <asp:CheckBox ID="CheckBox6" runat="server" Checked='<%# Bind("production_assistant_to_order") %>'  />
                </td>
                <td align="center">
                    <asp:CheckBox ID="CheckBox7" runat="server" Checked='<%# Bind("order_confirmed") %>'  />
                </td>
                <td align="center">
                    <asp:CheckBox ID="CheckBox8" runat="server" Checked='<%# Bind("manager_has_processed_order") %>'  />
                </td>
                <td align="center">
                    <asp:CheckBox ID="CheckBox9" runat="server" Checked='<%# Bind("is_main_material_order") %>'  />
                </td>
                 <td align="center">
                    <asp:CheckBox ID="CheckBox3" runat="server" Checked='<%# Bind("is_general_task") %>'  />
                </td>
                 <td align="center">
                    <asp:CheckBox ID="CheckBox10" runat="server" Checked='<%# Bind("item_completed") %>'  />
                </td>
               
                <td align="center"  >
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
        ContextTypeName="IntranetDataDataContext" EnableDelete="False" 
        EnableInsert="False" EnableUpdate="True" TableName="job_list_items"
        OnSelecting="to_be_ordered_DataSource_Selecting">
</asp:LinqDataSource>




</asp:Content>


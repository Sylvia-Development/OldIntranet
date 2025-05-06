<%@ Page Title="" Language="C#" MasterPageFile="~/SetupLeftNavMasterPage.master" validateRequest="false" AutoEventWireup="true" CodeFile="setup_sms_templates.aspx.cs" Inherits="setup_sms_templates" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentPlaceHolder" Runat="Server">

<asp:LinqDataSource ID="SmsDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" 
        TableName="sms_templates"
        OnSelecting="SmsTemplatesDataSource_Selecting" EnableDelete="True" 
        EnableInsert="True" EnableUpdate="True">
    </asp:LinqDataSource>
    

<h1><%  String deptId = Page.Request.QueryString["pDepartmentId"];
        if (deptId !=null && deptId.Equals("0")) 
        { 
                Response.Write("Quote"); 
        }else if (deptId !=null && deptId.Equals("1")) 
        { 
                Response.Write("Production"); 
        }else if (deptId !=null && deptId.Equals("2")) 
        { 
                Response.Write("Projects"); 
        }
        else if (deptId != null && deptId.Equals("3"))
        {
            Response.Write("Site");
        }
        else if (deptId != null && deptId.Equals("4"))
        {
            Response.Write("Service call");
        }
        else if (deptId != null && deptId.Equals("6"))
        {
            Response.Write("CEM");
        }
        
        
        
        
        %>   - Sms Templates</h1>
        <br />
 <asp:ListView ID="ListView1" runat="server" DataKeyNames="id" 
            DataSourceID="SmsDataSource" InsertItemPosition="LastItem"
            OnItemInserting="sms_template_ItemInserting">
        <ItemTemplate>
            <tr >
                
               
                
                
                
                <td>
                    <asp:Label ID="Label1" runat="server" 
                        Text='<%# Eval("template_name") %>' />
                </td>
                <td>
                   <asp:TextBox Columns="50" Rows="7" ReadOnly="true"  BorderStyle="None" BorderWidth="0" BackColor="Transparent" TextMode="MultiLine" ID="messageLabel" runat="server" 
                        Text='<%# Eval("message") %>' />
                </td>
                <td>
                    <asp:Label ID="Label3" runat="server" 
                        Text='<%# Eval("display_order") %>' />
                </td>
                <td class="TDwithButtons">
                    
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" />
                    <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" 
                        Text="Delete" />
                </td>
                
            </tr>
        </ItemTemplate>
      
        <EmptyDataTemplate>
            <table id="Table1" runat="server" >
                <tr>
                    <td>
                        No data was returned.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        <InsertItemTemplate>
            <tr class="insertrow">
                
                
                
                
                <td>
                    <asp:TextBox ID="template_nameTextBox" runat="server" 
                        Text='<%# Bind("template_name") %>' />
                </td>
                <td>
                    <asp:TextBox Columns="50" Rows="7" TextMode="MultiLine" ID="TextBox2" runat="server" 
                        Text='<%# Bind("message") %>' />
                </td>
                <td>
                    <asp:TextBox Columns="5" ID="TextBox1" runat="server" 
                        Text='<%# Bind("display_order") %>' />        
                </td>
                <td class="TDwithButtons">
                    <asp:Button ID="InsertButton" runat="server" CommandName="Insert" 
                        Text="Insert" />
                   
                </td>
                
            </tr>
        </InsertItemTemplate>
        <LayoutTemplate>
            <table id="Table2" runat="server">
                <tr id="Tr1" runat="server">
                    <td id="Td1" runat="server">
                        <table ID="itemPlaceholderContainer" runat="server" border="1" >
                            <tr id="Tr2" runat="server" class="tableheaderrow">
                                
                                 
                                
                                
                                <th id="Th3" runat="server">
                                    Template Name</th>
                                <th id="Th4" runat="server">
                                    Template Message</th>
                                   <th id="Th1" runat="server">
                                    Dispay Order
                                </th>   
                                 <th id="Th5" runat="server">
                                   </th>
                                
                            </tr>
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                    </td>
                </tr>
               
            </table>
        </LayoutTemplate>
        <EditItemTemplate>
            <tr class="editrow">
                
                
                
                
                <td>
                    <asp:TextBox ID="template_nameTextBox" runat="server" 
                        Text='<%# Bind("template_name") %>' />
                </td>
                <td>
                    <asp:TextBox ID="TextBox2" Columns="50" Rows="7" TextMode="MultiLine" runat="server" 
                        Text='<%# Bind("message") %>' />
                </td>
                <td>
                    <asp:TextBox  ID="TextBox1" runat="server" 
                        Text='<%# Bind("display_order") %>' />        
                </td>
                <td>
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                        Text="Save" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                        Text="X" />
                </td>
                
            </tr>
        </EditItemTemplate>
       
    </asp:ListView>



</asp:Content>


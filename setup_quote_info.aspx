<%@ Page Title="" Language="C#" MasterPageFile="~/SetupLeftNavMasterPage.master" AutoEventWireup="true" CodeFile="setup_quote_info.aspx.cs" Inherits="quote_info_setup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentPlaceHolder" Runat="Server">

<h1>Referred From</h1>
<asp:LinqDataSource ID="LinqDataSource3" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="True" 
        EnableInsert="True" EnableUpdate="True"  
        TableName="referrers"
        OnSelecting="LinqDataSource3_Selecting">
    </asp:LinqDataSource>
    

    <asp:LinqDataSource ID="LinqDataSource6" runat="server" 
        ContextTypeName="IntranetDataDataContext" 
        TableName="referrers"
        OnSelecting="LinqDataSource6_Selecting">
    </asp:LinqDataSource>
    

    <asp:ListView ID="ListView5" runat="server" DataKeyNames="referrer_id" 
        DataSourceID="LinqDataSource3" InsertItemPosition="LastItem" 
        OnItemInserting="ListView5_ItemInserting">
        <ItemTemplate>
            <tr >
                
                
                <td>
                    <asp:Label ID="referrer_nameLabel" runat="server" 
                        Text='<%# Eval("referrer_name") %>' />
                </td>
                <td>
                    <asp:Label ID="referrer_parent_idLabel" runat="server" 
                        Text='<%# Eval("referrer1.referrer_name") %>' />
                </td>
                <td>
                   
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" />
                     <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" 
                        Text="Delete" />
                </td>
                
            </tr>
        </ItemTemplate>
       
        <EmptyDataTemplate>
            <table runat="server" >
                <tr>
                    <td>
                        No data was returned.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        <InsertItemTemplate>
            <tr class="insertrow">
                
                
                <td>
                    <asp:TextBox ID="referrer_nameTextBox" runat="server" 
                        Text='<%# Bind("referrer_name") %>' />
                </td>
                <td>
                    
                    <asp:DropDownList ID="parentList" 
                                      DataSourceID = "LinqDataSource6" 
                                      DataValueField = "referrer_id" 
                                      DataTextField="referrer_name" 
                                      AppendDataBoundItems="true" 
                                      AutoPostBack="true"
                                       
                                      runat="server">
                    
                            <asp:ListItem Value="" Text="      "></asp:ListItem>
                    </asp:DropDownList>
                    
                    
                    
                </td>
                <td>
                    <asp:Button ID="InsertButton" runat="server" CommandName="Insert" 
                        Text="Insert" />
                    
                </td>
                
            </tr>
        </InsertItemTemplate>
        <LayoutTemplate>
            <table runat="server">
                <tr runat="server">
                    <td runat="server">
                        <table ID="itemPlaceholderContainer" runat="server" border="1" >
                            <tr runat="server" class="tableheaderrow">
                                
                                
                                <th runat="server">
                                    Referrer Name</th>
                                <th runat="server">
                                    Referrer Type</th>
                                    <th id="Th1" runat="server">
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
                    <asp:TextBox ID="referrer_nameTextBox" runat="server" 
                        Text='<%# Bind("referrer_name") %>' />
                </td>
                <td>
                    <asp:DropDownList ID="parentList1" 
                                      DataSourceID = "LinqDataSource6" 
                                      DataValueField = "referrer_id" 
                                      DataTextField="referrer_name" 
                                      AppendDataBoundItems="true" 
                                      AutoPostBack="true"
                                      SelectedValue='<%# Bind("referrer_parent_id") %>'
                                       
                                      runat="server">
                        <asp:ListItem Value="" Text="      "></asp:ListItem>
                            
                    </asp:DropDownList>
                
                    
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
    

<h1>Competition List</h1>
<asp:LinqDataSource ID="LinqDataSource4" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="True" 
        EnableInsert="True" EnableUpdate="True" OrderBy="lost_to_name" 
        TableName="competitions">
    </asp:LinqDataSource>
    

    <asp:ListView ID="ListView3" runat="server" DataKeyNames="lost_to_id" 
        DataSourceID="LinqDataSource4" InsertItemPosition="LastItem">
        <ItemTemplate>
            <tr >
                
                
                <td>
                    <asp:Label ID="lost_to_nameLabel" runat="server" 
                        Text='<%# Eval("lost_to_name") %>' />
                </td>
                <td>
                   
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" />
                     <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" 
                        Text="Delete" />
                </td>
                
            </tr>
        </ItemTemplate>
      
        <EmptyDataTemplate>
            <table runat="server">
                <tr>
                    <td>
                        No data was returned.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        <InsertItemTemplate>
            <tr class="insertrow">
                
                
                <td>
                    <asp:TextBox ID="lost_to_nameTextBox" runat="server" 
                        Text='<%# Bind("lost_to_name") %>' />
                </td>
                <td>
                    <asp:Button ID="InsertButton" runat="server" CommandName="Insert" 
                        Text="Insert" />
                   
                </td>
                
            </tr>
        </InsertItemTemplate>
        <LayoutTemplate>
            <table runat="server">
                <tr runat="server">
                    <td runat="server">
                        <table ID="itemPlaceholderContainer" runat="server" border="1" >
                            <tr runat="server" class="tableheaderrow">
                                
                                
                                <th runat="server">
                                    Competition Name</th>
                                    <th id="Th2" runat="server">
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
                    <asp:TextBox ID="lost_to_nameTextBox" runat="server" 
                        Text='<%# Bind("lost_to_name") %>' />
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
    

<h1>Quote Lost Reasons</h1>
<asp:LinqDataSource ID="LinqDataSource5" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="True" 
        EnableInsert="True" EnableUpdate="True" OrderBy="lost_reason_description" 
        TableName="lost_reasons">
    </asp:LinqDataSource>
    

    <asp:ListView ID="ListView4" runat="server" DataKeyNames="lost_reason_id" 
        DataSourceID="LinqDataSource5" InsertItemPosition="LastItem">
        <ItemTemplate>
            <tr >
                
                
                <td>
                    <asp:Label ID="lost_reason_descriptionLabel" runat="server" 
                        Text='<%# Eval("lost_reason_description") %>' />
                </td>
                <td>
                   
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" />
                     <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" 
                        Text="Delete" />
                </td>
                
            </tr>
        </ItemTemplate>
        
        <EmptyDataTemplate>
            <table runat="server" 
                style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;">
                <tr>
                    <td>
                        No data was returned.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        <InsertItemTemplate>
            <tr class="insertrow">
                
                
                <td>
                    <asp:TextBox ID="lost_reason_descriptionTextBox" runat="server" 
                        Text='<%# Bind("lost_reason_description") %>' />
                </td>
                <td>
                    <asp:Button ID="InsertButton" runat="server" CommandName="Insert" 
                        Text="Insert" />
                   
                </td>
                
            </tr>
        </InsertItemTemplate>
        <LayoutTemplate>
            <table runat="server">
                <tr runat="server">
                    <td runat="server">
                        <table ID="itemPlaceholderContainer" runat="server" border="1" >
                            <tr runat="server" class="tableheaderrow">
                               
                                
                                <th runat="server">
                                    Reason Description</th>
                                 <th id="Th3" runat="server">
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
                    <asp:TextBox ID="lost_reason_descriptionTextBox" runat="server" 
                        Text='<%# Bind("lost_reason_description") %>' />
                </td>
                <td>
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                        Text="save" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                        Text="X" />
                </td>
                
            </tr>
        </EditItemTemplate>
     
    </asp:ListView>
    

<h1>Geographical Regions</h1>

<asp:LinqDataSource ID="LinqDataSource1" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="True" 
        EnableInsert="True" EnableUpdate="True" OrderBy="geographical_name" 
        TableName="geographical_regions">
    </asp:LinqDataSource>
    <asp:ListView ID="ListView1" runat="server" DataKeyNames="geographical_id" 
        DataSourceID="LinqDataSource1" InsertItemPosition="LastItem">
        <ItemTemplate>
            <tr>
                
                
                <td>
                    <asp:Label ID="geographical_nameLabel" runat="server" 
                        Text='<%# Eval("geographical_name") %>' />
                </td>
                <td>
                    
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" />
                    <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" 
                        Text="Delete" />
                </td>
                
            </tr>
        </ItemTemplate>
     
        <EmptyDataTemplate>
            <table runat="server" >
                <tr>
                    <td>
                        No data was returned.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        <InsertItemTemplate>
            <tr class="insertrow">
                
                
                <td>
                    <asp:TextBox ID="geographical_nameTextBox" runat="server" 
                        Text='<%# Bind("geographical_name") %>' />
                </td>
                <td>
                    <asp:Button ID="InsertButton" runat="server" CommandName="Insert" 
                        Text="Insert" />
                   
                </td>
                
            </tr>
        </InsertItemTemplate>
        <LayoutTemplate>
            <table runat="server">
                <tr runat="server">
                    <td runat="server">
                        <table ID="itemPlaceholderContainer" runat="server" border="1" >
                            <tr runat="server" class="tableheaderrow">
                                
                                <th runat="server">
                                    Geographical Name</th>
                                    <th id="Th4" runat="server">
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
                    <asp:TextBox ID="geographical_nameTextBox" runat="server" 
                        Text='<%# Bind("geographical_name") %>' />
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
    

<h1>Races</h1>







    <asp:LinqDataSource ID="LinqDataSource2" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="True" 
        EnableInsert="True" EnableUpdate="True" OrderBy="race_description" 
        TableName="races">
    </asp:LinqDataSource>
    <asp:ListView ID="ListView2" runat="server" DataKeyNames="race_id" 
        DataSourceID="LinqDataSource2" InsertItemPosition="LastItem">
        <ItemTemplate>
            <tr >
                
                
                <td>
                    <asp:Label ID="race_descriptionLabel" runat="server" 
                        Text='<%# Eval("race_description") %>' />
                </td>
                <td>
                    
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" />
                    <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" 
                        Text="Delete" />
                </td>
                
            </tr>
        </ItemTemplate>
       
        <EmptyDataTemplate>
            <table runat="server" >
                <tr>
                    <td>
                        No data was returned.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        <InsertItemTemplate>
            <tr class="insertrow">
                
                
                <td>
                    <asp:TextBox ID="race_descriptionTextBox" runat="server" 
                        Text='<%# Bind("race_description") %>' />
                </td>
                <td>
                    <asp:Button ID="InsertButton" runat="server" CommandName="Insert" 
                        Text="Insert" />
                   
                </td>
                
            </tr>
        </InsertItemTemplate>
        <LayoutTemplate>
            <table runat="server">
                <tr runat="server">
                    <td runat="server">
                        <table ID="itemPlaceholderContainer" runat="server" border="1" >
                            <tr runat="server" class="tableheaderrow">
                               
                                
                                <th runat="server">
                                    Race Description</th>
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
                    <asp:TextBox ID="race_descriptionTextBox" runat="server" 
                        Text='<%# Bind("race_description") %>' />
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


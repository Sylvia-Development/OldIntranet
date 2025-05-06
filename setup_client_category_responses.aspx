<%@ Page Title="" Language="C#" MasterPageFile="~/SetupLeftNavMasterPage.master" AutoEventWireup="true" CodeFile="setup_client_category_responses.aspx.cs" Inherits="setup_client_category_responses" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentPlaceHolder" Runat="Server">

<asp:LinqDataSource ID="catLinqDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="False" 
        EnableInsert="False" EnableUpdate="False" OrderBy="id" 
        TableName="client_categories">
    </asp:LinqDataSource>
  <asp:ListView ID="ListView1" runat="server" DataKeyNames="id" 
        DataSourceID="catLinqDataSource">
        <ItemTemplate>
            
                
                <br />
                <div class="smallheading"><%# Eval("description") %></div>
                
                
                
                <input type="hidden" id="hiddenInput" value='<%# Eval("id") %>' runat="server" />

    <asp:ListView ID="responseListView" runat="server" DataKeyNames="id" 
        DataSourceID="responseLinqDataSource" InsertItemPosition="LastItem">
        <ItemTemplate>
            <tr >
                
                
                <td>
                    <asp:TextBox style="background-color:transparent; border:0 none;" enabled="false" TextMode="MultiLine" Rows="45" Columns="150" ID="TextBox" runat="server" 
                        Text=' <%# Eval("description") %>' />
                     


                </td>
                <td>
                   
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" />
                     <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" 
                        Text="Delete" />
                </td>
                
            </tr>
        </ItemTemplate>
      
        <EmptyDataTemplate>
            <table id="Table1" runat="server">
                <tr>
                    <td>
                        No data was returned.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        <InsertItemTemplate>
            <tr class="insertrow">
                
                
                <td>
                    <asp:TextBox TextMode="MultiLine" Rows="2" Columns="150" ID="TextBox" runat="server" 
                        Text='<%# Bind("description") %>' />
                </td>
                <td>
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
                    <asp:TextBox TextMode="MultiLine" Rows="35" Columns="150" ID="TextBox" runat="server" 
                        Text='<%# Bind("description") %>' />
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
                
                
                <asp:LinqDataSource ID="responseLinqDataSource" runat="server" 
                ContextTypeName="IntranetDataDataContext"  
                EnableDelete="True" EnableInsert="True" EnableUpdate="True" 
                OrderBy="id"
                TableName="client_category_responses" 
                Where="category_id == @cat_id">
                <WhereParameters>
                    <asp:ControlParameter ControlID="hiddenInput" Name="cat_id" PropertyName="value" Type="Int32" />
                </WhereParameters>
                <InsertParameters>
                    <asp:ControlParameter ControlID="hiddenInput" Name="category_id" PropertyName="value" Type="Int32" />
                </InsertParameters>
            </asp:LinqDataSource>

               
                
                
                
                
                
                
                
                
               
            </li>
        </ItemTemplate>
        
        <EmptyDataTemplate>
            No data was returned.
        </EmptyDataTemplate>
        
        <LayoutTemplate>
            <ul ID="itemPlaceholderContainer" runat="server" >
                
                <li ID="itemPlaceholder" runat="server" />
                </ul>
                
            </LayoutTemplate>
            
       
       
    </asp:ListView>




    


</asp:Content>


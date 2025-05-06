<%@ Page Title="" Language="C#" MasterPageFile="~/MainMasterPage.master" AutoEventWireup="true" CodeFile="notes.aspx.cs" Inherits="notes" %>

<asp:Content  ID="Content1" ContentPlaceHolderID="MenuContentPlaceHolder" Runat="Server">
<br />

 <br />
<h1>Recent Activity - Notes</h1>
    <asp:ListView ID="ListViewNotes" runat="server" DataSourceID="NotesDataSource">
        <ItemTemplate>
            <tr >
                <td nowrap>
                    <asp:Label ID="dateLabel" runat="server" Text='<%# Eval("date") %>' />
                </td>
                <td>
                    <asp:Label ID="activity_messageLabel" runat="server" 
                        Text='<%# Eval("activity_message") %>' />
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
        
        <LayoutTemplate>
            <table  runat="server">
                <tr runat="server">
                    <td runat="server">
                        <table ID="itemPlaceholderContainer" runat="server" border="0" class="themeContent" width="80%">
                            
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr runat="server">
                    <td runat="server" >
                        <asp:DataPager ID="DataPager1" runat="server">
                            <Fields>
                                <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" 
                                    ShowNextPageButton="False" ShowPreviousPageButton="True" />
                                <asp:NumericPagerField />
                                <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="True" 
                                    ShowNextPageButton="True" ShowPreviousPageButton="False" />
                            </Fields>
                        </asp:DataPager>
                    </td>
                </tr>
            </table>
        </LayoutTemplate>
      
       
    </asp:ListView>

    <br />
    <br />

    <asp:LinqDataSource ID="NotesDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" 
        OnSelecting="NotesDataSource_Selecting" TableName="activities">
    </asp:LinqDataSource>

    <br />
<h1>Recent Activity - Tasks</h1>
    <asp:ListView ID="ListViewTasks" runat="server" DataSourceID="TasksDataSource">
        <ItemTemplate>
            <tr >
                 <td nowrap>
                    <asp:Label ID="dateLabel" runat="server" Text='<%# Eval("date") %>' />
                </td>
                <td>
                    <asp:Label ID="activity_messageLabel" runat="server" 
                        Text='<%# Eval("activity_message") %>' />
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
       
        <LayoutTemplate>
            <table runat="server">
                <tr runat="server">
                    <td runat="server">
                        <table ID="itemPlaceholderContainer" runat="server" border="0" class="themeContent" >
                            
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr runat="server">
                    <td runat="server" >
                        <asp:DataPager ID="DataPager1" runat="server">
                            <Fields>
                                <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" 
                                    ShowNextPageButton="False" ShowPreviousPageButton="True" />
                                <asp:NumericPagerField />
                                <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="True" 
                                    ShowNextPageButton="True" ShowPreviousPageButton="False" />
                            </Fields>
                        </asp:DataPager>
                    </td>
                </tr>
            </table>
        </LayoutTemplate>
     
      
    </asp:ListView>
    
    
    <asp:LinqDataSource ID="TasksDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" 
        OnSelecting="TasksDataSource_Selecting" TableName="activities">
    </asp:LinqDataSource>

</asp:Content>


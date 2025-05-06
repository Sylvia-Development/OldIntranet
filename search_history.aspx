<%@ Page Title="" Language="C#" MasterPageFile="~/MainMasterPage.master" AutoEventWireup="true" CodeFile="search_history.aspx.cs" Inherits="search_history" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MenuContentPlaceHolder" Runat="Server">

	<h1>Recent Search History</h1><br />
    <%

		String User = Page.Request.QueryString["pUser"];

		if (!(User == null || User.Length == 0))
		{		
        %>
                <asp:Button runat="server" ID="Button1" Style="background-color: #c9302c;" CssClass="btn btn-danger" Text="All Users" OnClick="btnBackToHistory" /> 
<%

	}%>

    
    <br /><br />
    <asp:ListView ID="SearchHistoryListView" runat="server" DataSourceID="searchHistoryDataSource">
        <ItemTemplate>
            <tr >
                <td nowrap style="width:200px">
<%--                    <asp:Label ID="nameLabel" runat="server" Text='<%# Eval("user") %>' />--%>
                  <a href="search_history.aspx?pUser=<%# Eval("user")%> "><%# Eval("user")%></a>
                </td>
                <td nowrap style="width:200px">
                    <asp:Label ID="dateLabel" runat="server" Text='<%# Eval("date") %>' />
                </td>
                <td nowrap style="width:400px">
                    <asp:Label ID="termLabel1" runat="server" Text='<%# Eval("search_term") %>' />
                </td>
                <td nowrap style="width:200px">
                    <asp:Label ID="typeLabel" runat="server" Text='<%# Eval("search_type") %>' />
                </td>
                <td nowrap style="width:100px">
                    <asp:Label ID="archiveLabel" runat="server" Text='<%# Eval("archive") %>' />
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
                        <table ID="table23" runat="server" border="0" class="tableSpacing paddedTable themeContent" >
                            
                            <tr ID="tr2" runat="server">
                                <th>User</th>
                                <th>Date</th>
                                <th>Search Term</th>
                                <th>Type</th>
                                <th>Archive</th>
                               
                            </tr>
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr runat="server">
                    <td runat="server" >
                        <asp:DataPager ID="DataPager1" runat="server" PageSize="20">
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
    <asp:LinqDataSource ID="searchHistoryDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" 
        OnSelecting="seachHistory_OnSelecting" TableName="search_history">
    </asp:LinqDataSource>

</asp:Content>


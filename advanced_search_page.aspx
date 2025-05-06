<%@ Page Title="" Language="C#" MasterPageFile="~/MainMasterPage.master" AutoEventWireup="true" CodeFile="advanced_search_page.aspx.cs" Inherits="advanced_search_page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MenuContentPlaceHolder" Runat="Server">

<%--    <%
		IntranetDataDataContext db = new IntranetDataDataContext();
		string value = Page.Request.QueryString.Get("search");
		//bltLstSearchItems.DataBind();
		var search = (from c in db.clients
					  where c.names.ToLower().Trim().Contains(value)
					  select c.job_name).ToList();
        %>
    <ul>
        <%
		foreach(var sea in search)
		{
                %>
        <li><%= sea %></li>
        <%
		};
        %>--%>
    <br />
	<div>
	<br />
	
		<asp:RadioButton Text="Client Details" Checked="true" ID="searchNames" CssClass="advancedRadioWidth" runat="server" GroupName="searchFile"/>
		<asp:RadioButton Text="Installation Address" ID="searchInstallations" CssClass="advancedRadioWidth" runat="server" GroupName="searchFile"/><br /><br />
	    <asp:TextBox runat="server" ID="txtAdvancedSearch" CssClass="ui-corner-all ui-widget-content" Style="width:15.65em; padding:8px;"  />
       <%--<asp:CustomValidator  id="CustomValidator7" 
                             runat="server" 
                             ControlToValidate="txtAdvancedSearch" 
                             ErrorMessage="Search string too short"
                             OnServerValidate="validate_searchWord">*
                         </asp:CustomValidator> 
    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Search cannot be blank" ControlToValidate="txtAdvancedSearch" ForeColor="Red"></asp:RequiredFieldValidator> 
   <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtAdvancedSearch" ErrorMessage="Mobile number must be 10 digit" ForeColor="Red" ValidationExpression="\d{10}"></asp:RegularExpressionValidator>  --%>
    <asp:Button runat="server" ID="btnAdvSearchBar" CssClass="btn btn-danger" Text="Search"  OnClientClick="validate()" OnClick="btnSearch" /> 
        <asp:CheckBox ID="searchCheckBox" Text="Include Archive Clients" runat="server" />
        <asp:Button runat="server" ID="btnAdvSearchHistory" Style="float:right; margin-right:200px" CssClass="btn btn-danger" Text="Search History" OnClick="btnHistory" /> 
<br />
</div>
    <br />
<div>
    <br />
    <% String addtext = "~Archive"; %>
<asp:ListView ID="AdvancedSearchResultsListView" runat="server" 
        DataSourceID="AdvancedSearchResultsDataSource" >
        <ItemTemplate>
            <tr >
                <td align="center" style="width:400px;text-align:center; vertical-align: middle;" nowrap>
                    <asp:Label  ID="reminder1Label" runat="server" Text='<%# Eval("client.job_name") %>' />
                    <asp:Label  style="text-align:justify;" ForeColor="Red"  ID="Label2" runat="server" Text=' - ' />
                    <asp:Label style="text-align:justify;"  ID="Label1" runat="server" Text='<%# Eval("section_name") %>' />
                    <asp:Label style="text-align:justify;"  ID="Label3" runat="server" Text='<%#  Eval("active_status").ToString() =="1"?"":"~Archive" %>' /><br />
                    <asp:Label style="text-align:justify;"  ID="Label5" runat="server" Text='Job Status: ' />
                    <asp:Label style="text-align:justify;" ID="Label4" runat="server" Text='<%#  Eval("quote_status") %>' />
                </td>
                <td align="center" nowrap>
                    <div style="margin:5px; text-align: center;vertical-align: middle;">
                    <asp:TextBox ID="namesTextBox" CssClass="ui-corner-all" runat="server" Text='<%# Eval("client.names") %>' TextMode="MultiLine" Rows="10" Width="100%"/>
                    </div>
                        </td>
                <td nowrap><div style="margin:5px; text-align:center;">
                    <asp:TextBox ID="TextBox1"  CssClass="ui-corner-all" runat="server" Text='<%# Eval("client.install_address") %>' TextMode="MultiLine" Rows="10" Width="100%"/>
                    </div> 
                    </td>
                <td nowrap align="center" style="width:200px;text-align:center;vertical-align: middle;">

			        <a href='./section_view.aspx?pClientName=<%# Eval("client.job_name") %>&pSectionId=<%# Eval("section_id") %>&pClientId=<%# Eval("client_id") %>&pDepartmentId=<%= getDepartmentID() %>' >
                         <%# Eval("section_name") %> >>>
			        </a>
                </td>
            </tr>
        </ItemTemplate>
         <EmptyDataTemplate>
          <table id="Table1" runat="server" >
                <tr>
                    <td><h3> No Results Found</h3></td>
                </tr>
            </table>  
        </EmptyDataTemplate>
      
        
        <LayoutTemplate>
            <table id="Table2" runat="server" style="width:100%">
                <tr id="Tr1" runat="server">
                    <td id="Td1" runat="server">
                        <table ID="itemPlaceholderContainer" runat="server" border="0"  style="width:90%" class="themeContent">
                            <tr id="Tr2" runat="server">
                                
                                <th colspan ="4" id="Th2" runat="server">
                                   <asp:Label runat="server" ID="txtSearchCount"></asp:Label> </th>
                                
                             
                            </tr>
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                    </td>
                </tr>
                
            </table>
        </LayoutTemplate>
        
       
    </asp:ListView>


<asp:LinqDataSource ID="AdvancedSearchResultsDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" 
        EnableInsert="True" EnableUpdate="True" TableName="sections"
        OnSelecting="search_results_onSelecting">
</asp:LinqDataSource>
</div>
    <%--<script>
        function validate() {
            var word = document.getElementById("txtAdvancedSearch").value;
			if (word == null || word == "") {
				alert("Search Box can't be blank");
				return false;
			} else if (word.length > 3) {
				alert("search must be at least 3 characters long.");
				return false;
			}
		}

        <table id="Table1" runat="server" >
                <tr>
                    <td></td>
                </tr>
            </table>
        <EmptyDataTemplate>
            
        </EmptyDataTemplate>
        
	</script>--%>
    <script>
        var txtSearch = jQuery("#ctl00_LoginView2_MenuContentPlaceHolder_txtAdvancedSearch")[0];
        //var textSearch = $("input[name*='txtAdvancedSearch']").val();
;

        //txtSearch.onchange = function () {
        //        if ((txtSearch == null) || (txtSearch == ""))
        //            alert("Please enter a search query");
        //        else
        //            if (txtSearch.value.length < 3)
        //                alert("Please enter at least 3 characters");
        //};location.href = "./advanced_search_page.aspx?search=BrilliantFireFighters";

        //var btnSearch = jQuery("#ctl00_LoginView2_MenuContentPlaceHolder_btnAdvSearchBar");
		//var btnSearch = $('#btnAdvSearchBar');
        function validate()
        {
            if ((txtSearch == null) || (txtSearch == "")) {
                alert("Please enter a search text");
				
               
            }
            else
                if (txtSearch.value.length < 3) {
                    alert("Please enter at least 3 characters");

                }
        }

        jQuery(
            function () {
                if (jQuery("#ctl00_LoginView2_MenuContentPlaceHolder_txtAdvancedSearch")[0].value == "") {

                    jQuery("#ctl00_LoginView2_MenuContentPlaceHolder_txtAdvancedSearch")[0].value = "<%= Page.Request.QueryString.Get("search") %>";
                }
                else
                    jQuery("#ctl00_LoginView2_MenuContentPlaceHolder_txtAdvancedSearch")[0].value = jQuery("#ctl00_LoginView2_MenuContentPlaceHolder_txtAdvancedSearch")[0].value;

                var clientDetails = jQuery("#ctl00_LoginView2_MenuContentPlaceHolder_searchNames")[0];
                var installationDetails = jQuery("#ctl00_LoginView2_MenuContentPlaceHolder_searchInstallations")[0];

                clientDetails.checked = <%= (Page.Request.QueryString.Get("details")=="clients")?"true":"false" %>;
                installationDetails.checked = <%= (Page.Request.QueryString.Get("details")=="installation")?"true":"false" %>;
                if (!(clientDetails.checked || installationDetails.checked))
                    clientDetails.checked = true;
                jQuery("#ctl00_LoginView2_MenuContentPlaceHolder_searchCheckBox")[0].checked = <%= (Page.Request.QueryString.Get("includeArchive")=="True")?"true":"false" %>;
            });
	</script>
</asp:Content>

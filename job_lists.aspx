<%@ Page Title="" Language="C#" MasterPageFile="~/ManagementLeftNavMasterPage.master" AutoEventWireup="true" CodeFile="job_lists.aspx.cs" Inherits="job_lists" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentPlaceHolder" Runat="Server">
<script type="text/javascript">
    function autoResize(id) {
        var newheight;
        

        if (document.getElementById) {
            newheight = document.getElementById(id).contentWindow.document.body.scrollHeight;
           
        }
        //alert(id + '---' + newheight);
        if (newheight > 0) {
            document.getElementById(id).height = (newheight) + "px";
        }
            
            //$("#accordion").accordion("refresh");
            //alert(id + ' set height -' + document.getElementById(id).height);
            
        }
        
    $(function () {
        $("#accordion").accordion({
            active: false,
            heightStyle: "content",
            collapsible: true,
            alwaysOpen: false,
            autoHeight: false,
            change: function (event, ui) {
                var newframe = '#' + $(ui.newContent).attr("title");
                var oldframe = '#' + $(ui.oldContent).attr("title");

                $(oldframe).attr('src', "about:blank");
                $(newframe).attr('src', $(ui.newContent).attr("id"));
                
              
             

            }

        })
    });
    </script>
<h1>Job Lists</h1>

<br />


<asp:ListView ID="clientListListView" runat="server"
             DataSourceID="clientListLinqDataSource"
              DataKeyNames="section_id">
        <ItemTemplate>

          <h3><a href="#"><%# Eval("client.job_name")%>-<%# Eval("section_name")%> <font size="2" style="color:#DC143C"> <%# GetListCount(Eval("job_list_items"),"Orders")%> <%# GetListCount(Eval("job_list_items"),"Snags")%></font></a></h3>
    <div id="job_list_data.aspx?pClientId=<%# Eval("client_id")%>&pDepartmentId=<%Response.Write(Page.Request.QueryString["pDepartmentId"]);  %>&pSectionId=<%# Eval("section_id")%>"   title="frame<%# Eval("section_id")%>">
       <iframe  id="frame<%# Eval("section_id")%>" width="100%" height="0px" onLoad="autoResize('frame<%# Eval("section_id")%>');"  frameborder="0"    scrolling="auto"  src=""  ></iframe>
    </div>         
         
                 
        </ItemTemplate>
        <LayoutTemplate>
            <div id="accordion">
                <asp:PlaceHolder ID="itemPlaceholder" runat="server" />
            </div>
        </LayoutTemplate>   
</asp:ListView>


<asp:LinqDataSource ID="clientListLinqDataSource" runat="server"
                ContextTypeName="IntranetDataDataContext"  
                 OnSelecting="clientListDataSource_Selecting"
                 TableName="sections">
                  
</asp:LinqDataSource>



















</asp:Content>


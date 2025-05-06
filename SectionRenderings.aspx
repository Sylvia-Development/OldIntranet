<%@ Page Title="" Language="C#" MasterPageFile="~/ManagementLeftNavMasterPage.master" AutoEventWireup="true" CodeFile="SectionRenderings.aspx.cs" Inherits="SectionRenderings" %>
 <%@ Register TagPrefix="DotNetGallery" Namespace="DotNetGallery" Assembly="DotNetGallery" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentPlaceHolder" Runat="Server">
     <script type="text/javascript">
      
     $(function  () {
               $("#tabs").tabs({
                   show: function() {
                       var selectedTab = $('#tabs').tabs('option', 'selected');
                       $("#<%= hdnSelectedTab.ClientID %>").val(selectedTab);
                   },
                   selected: <%= hdnSelectedTab.Value %>
                   });
           });    
     
     
    

      </script>
     <asp:HiddenField ID="hdnSelectedTab" runat="server" Value="0" />
<h1> 
    <font color="black"><asp:Label runat="server" ID="Label4"  OnLoad="getClientAndSectionName" ></asp:Label> - Images</font>

</h1>
    <div align="right" style="margin: 0 100px 0px 0">

      
        
        
  
        <a  href="SectionFileManagement.aspx?pDepartmentId=<%Response.Write(Page.Request.QueryString["pDepartmentId"]);%>&pClientId=<%Response.Write(Page.Request.QueryString["pClientId"]);%>&pSectionId=<%Response.Write(Page.Request.QueryString["pSectionId"]);%>" class="ui-button ui-corner-all ui-widget"> 
                        <img src="Images/docs.png" title="documents" />
                        </a> 
        
      </div>
    <br />
    <a href="section_view.aspx?pDepartmentId=<%Response.Write(Page.Request.QueryString["pDepartmentId"]);%>&pClientId=<%Response.Write(Page.Request.QueryString["pClientId"]);%>&pSectionId=<%Response.Write(Page.Request.QueryString["pSectionId"]);%>" > << Back To Section Page</a>
    
    <br />
    <br />

     <div id="tabs" style="background:white; border:0px;" >
    <ul style="background:white; border:0px;">
       
        

        
      
        <li id="Tabs1"><a href="#renderings">3D Pics &nbsp&nbsp&nbsp &nbsp&nbsp&nbsp &nbsp&nbsp&nbsp</a></li>
       

        
       
       
         
    </ul>
        

    <div id="renderings">


    <div id="CommonBody" align="center">
					<div align="left" style="margin: 0 100px 0px 0">
            <a href="#" onclick="thegallerybrowser.ShowEditor();return false;"><img src="Images/pics_edit.png" /></a> &nbsp&nbsp&nbsp
					
	        <a href="#" onclick="thegallerybrowser.ShowSlider();return false;"><img src="Images/slideshow.png" /></a>
   
    </div>
		<dotnetgallery:gallerybrowser runat="server"  OnLoad="renderingGallery_Load" id="renderingGallery" Width="1000" Height="700" CssClass="ui-widget ui-all- ui-corner-all" />
	</div>	
    	
        </div>

  
 </div>








</asp:Content>


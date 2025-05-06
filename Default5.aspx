<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default5.aspx.cs" Inherits="Default5" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
            <%
                if (Context.User.Identity.Name == "")
            {
                %>
                    <script>
                        location.href = "AcademyLogin.aspx";
                    </script>
                        <%
                            }
                %>
    <script src="https://code.jquery.com/jquery-3.6.3.slim.min.js"></script>
    <script>
		var currentSelectedMenuID = 0;
        <%
        string selMenuID = Page.Request.QueryString["pSubMenuid"];

        IntranetDataDataContext db = new IntranetDataDataContext();

        if ((selMenuID != null) && (selMenuID != ""))
        {
            int mID = Int32.Parse(selMenuID);
            //var mainMenuID = (from m in db.submenuRoles where (m.))
            var mainMenuID = (from m in db.academy_sub_menus where m.child_id == mID select m.id).First();
            //var mainMenuID = (from m in db.submenuRoles where (m.academy_sub_menu.child_id == mID) && (m.assigned) select m.submenuid).First();
        %>
        currentSelectedMenuID = <%= mainMenuID %>;
        <%
		}

        var selectedSubMenu = 0;

		string mainMenu = Page.Request.QueryString["mainMenu"];

		if ((mainMenu != null) && (mainMenu != ""))
		{
            %>
        //showSubmenu(<%= mainMenu %>);
            <%
            var submenuid = (from s in db.submenuRoles where (s.academy_sub_menu.id == Int32.Parse(mainMenu)) && (s.assigned) orderby s.academy_sub_menu.child_menu_order select s.submenuid).First();
            %>
        window.alert(<%= submenuid %>);
        location.href == "default5.aspx?pSubMenuid=" + <%= submenuid %>;
        <%
        }
        %>

		function displayMenu(menuid )
        {
            location.href = "default5.aspx?mainMenu=" + menuid;
        }

		function showSubmenu(menuid)
        {
			$("#submenu" + currentSelectedMenuID).hide();
			$("#mainmenu" + currentSelectedMenuID).removeClass("mainSelected");
			currentSelectedMenuID = menuid;
			$("#mainmenu" + currentSelectedMenuID).addClass("mainSelected");
			$("#submenu" + menuid).show();
        }

        function menuClicked(menuid)
        {
            location.href = "Default5.aspx?pSubMenuid=" + menuid;
        }

        

		//function applyCss(submenuid) {
		//	$("#submenu" + currentSelectedMenuID).hide();
		//	currentSelectedMenuID = menuid;
		//	$("#submenu" + menuid).show();
		//}

		//document.addEventListener('click', function classClicked(event) {

  //          event.target.classList.add('subMenuShow');


		//	function myFunction() {
		//		var x = document.getElementById("menu");
		//		if (x.className === "menu") {
		//			x.className += " responsive";
		//		} else {
		//			x.className = "menu";
		//		}
		//	}








    </script>

    <style>
        .selectedMenu 
        {
            /*font-size: larger;
            font-style: italic;*/
            border-style:solid;
            border: 0,5px thin black;
            border-radius:40px;
           
        }

        .selectedMenu :first-child{

            
            
        }

        .mainSelected{

            font-weight:900;
            font-size:xx-large;
            text-decoration:underline;
              text-decoration-thickness: 3px;  

/*               text-shadow: 0px 0px 5px #000;
*/
/*        box-shadow: 2px 2px 7px 1px #000000;
*/           
            /*padding:2px;
            color: #FFFFFF;
background: #FFFFFF;
text-shadow: 2px 2px 0 #000000, 2px -2px 0 #000000, -2px 2px 0 #000000, -2px -2px 0 #000000, 2px 0px 0 #000000, 0px 2px 0 #000000, -2px 0px 0 #000000, 0px -2px 0 #000000;
color: #FFFFFF;
background: #FFFFFF;*/


        }

         .menu    
        {    display:flex;
            justify-content:center;     
            width: 100%;    
            font-family: verdana, Segoe UI;    
            margin: 0px;    
 /*           border: 1px solid white;    
            border-radius: 4px; 
 */           font-size:x-large;
            background-color:white;
            color: black;
         font-weight:400;
            align-content:space-around;
        }

         .menu span{
            display: block;
            padding: 10px;
         }

         .subMenuHide{
             display: none;

         }

         .subMenuShow{
                 
/*            float: left;    
*/            display: flex; 
/*            border: 2px thick white; */
             font-size:x-large;
           font-weight:bold;
            width:60%;
            justify-content:center;
/*            margin-bottom: 5px;
*/            margin:10px;
              font-family: verdana, Segoe UI;
           
         }

         .center {
  display: block;
  margin-left: auto;
  margin-right: auto;
  width: 50%;
}

         .subMenuShow span a{
             display:block;
             padding:5px;
/*             margin: 5px;
*/            
              text-decoration-line:none;
            color: black !important;
         }

       
            
         .logoTag{

             padding-bottom:25px;
             margin:0 0 0 5px; 
             font-size:42px; 
             align-content:flex-start;
             font-family: verdana, Segoe UI;
             font-weight: bold;
             color:#5c5c5c;
         }

         #OrdeLogo{
             display:flex;
            width:100%;
            background-color: white;
          
            padding:10px;
        }

        hr.solid {
  border-top: 3px solid black;
  margin:0px;
}

        @media screen and (max-width: 600px) {

            .menu span {
                float: right;
                display: block;
            }

            .menu.responsive span {
    float: none;
    display: block;
    text-align: left;
  }

        }
    </style>
</head>
<body>
     <form id="form1" runat="server">

         <asp:LoginView ID="LoginView2" runat="server">
    <LoggedInTemplate>

        <%         
            String deptId = "1";
            String userName = "";
            String SCuserName = ""; // site coordinator name

            if (Context.User.IsInRole("Design Consultant") && !Context.User.IsInRole("Customer Experience Manager"))
            {
                deptId = "0";
                userName = Context.User.Identity.Name;
            }
            else if (Context.User.IsInRole("Customer Experience Manager"))
            {
                deptId = "6";

            }
            else if ( Context.User.IsInRole("Systems Integration") )
            {
                deptId = "1";

            }
            else if (Context.User.IsInRole("Site Coordinator") && !Context.User.IsInRole("Projects Director") )
            {
                deptId = "2";
                SCuserName = Context.User.Identity.Name;
            }
            else if (Context.User.IsInRole("Installer") && (!Context.User.IsInRole("Technical Services Manager") && !Context.User.IsInRole("Technical Services Technician1") && !Context.User.IsInRole("Technical Services Technician2")&& !Context.User.IsInRole("Technical Services Technician3")&& !Context.User.IsInRole("Technical Services Technician4") ))
            {
                deptId = "3";

            }
            else if (Context.User.IsInRole("Service Call Agent") )
            {
                deptId = "4";
            }
            else if (Context.User.IsInRole("Processing Assistant") )
            {
                deptId = "5";
            }
            else if (Context.User.IsInRole("Projects Director"))
            {
                deptId = "7";
            }
            else if (Context.User.IsInRole("Technical Services Manager"))
            {
                deptId = "8";
            }
            else if (Context.User.IsInRole("Finance Director"))
            {
                deptId = "9";
            }
            else if (Context.User.IsInRole("Finance Admin Administrator"))
            {
                deptId = "10";
            }
            else if (Context.User.IsInRole("Finance Admin Manager"))
            {
                deptId = "11";
            }
            else if (Context.User.IsInRole("Technical Administrator"))
            {
                deptId = "12";
            }
            else if (Context.User.IsInRole("Production Team Coordinator") || Context.User.IsInRole("Assembly Captain")|| Context.User.IsInRole("Assembly Team"))
            {
                deptId = "13";
            }
            else if (Context.User.IsInRole("Finishes Coordinator"))
            {
                deptId = "14";
            }
            else if (Context.User.IsInRole("Design Administrator"))
            {
                deptId = "15";
            }
            else if (Context.User.IsInRole("Technical Services Technician1"))
            {
                deptId = "16"; //Spare

            }
            else if (Context.User.IsInRole("Technical Services Technician2"))
            {
                deptId = "17";//Des

            }
            else if (Context.User.IsInRole("Technical Services Technician3"))
            {
                deptId = "18";//spare

            }
            else if (Context.User.IsInRole("Technical Services Technician4"))
            {
                deptId = "19";//spare

            }
            else if (Context.User.IsInRole("Technical Plan Generation Head"))
            {
                deptId = "20";//Jose

            }
            else if (Context.User.IsInRole("Operations Manager"))
            {
                deptId = "21";//Michelle

            }
            else if (Context.User.IsInRole("Procurement Coordinator"))
            {
                deptId = "22";//Twilla

            }
            else { deptId = "1"; }


            /*Assembly Captain
             Assembly Team
             Dispatch Transport Manager
             Finishes Captain
             Finishes Team
             Machining Captain
             Machining Team*/

        %>


        <div id="OrdeLogo">
            <img style="height:41px; margin-top:5px;" src="Images/logo2.png"/><p class="logoTag"> Academy</p>
     </div>
        <hr class="solid" />
        <div class="menu" id="myMenu" style="width: 100%">
            <% 
                var user = Context.User.Identity.Name;
                var roles = (from r in db.aspnet_UsersInRoles where r.aspnet_User.UserName.ToLower() == user.ToLower() select r.RoleId);
                List<int> doneMenus = new List<int>();

                foreach (var menur in (from m in db.menuRoles where (roles.Contains(m.roleid)) && (m.assigned) orderby m.academy_menu.parent_order select m ))
                {
                    var menuitem = menur.academy_menu;

                    if (doneMenus.Contains(menuitem.id))
                        continue;

                    doneMenus.Add(menuitem.id);

                    //var firstSubMenu = (from m in db.academy_sub_menus where (m.id == menuitem.id) orderby m.child_menu_order select m.child_id).First();
                    //var firstSubMenu = (from s in db.submenuRoles where (s.academy_sub_menu.id == menuitem.id && (s.assigned)) orderby s.academy_sub_menu.child_menu_order select s.submenuid).First();
                    var firstSubMenu = (from s in db.submenuRoles where (roles.Contains(s.roleid) && (s.academy_sub_menu.id == menuitem.id) && (s.assigned)) orderby s.academy_sub_menu.child_menu_order select s.submenuid).First();
                    %>
            
                    <span id="mainmenu<%= menuitem.id %>" onclick="menuClicked('<%= firstSubMenu %>')" class="subMenuShow">
                        <%= menuitem.parent_name %>
                
                </span>
                <%
			    }
                %>
        </div>
                <hr class="solid"/>

        <div style="width: 100%">
            <%
                List<int> doneSubmenus = new List<int>();

                foreach(var menuitem in (from m in db.menuRoles where (roles.Contains(m.roleid)) && (m.assigned) orderby m.academy_menu.parent_order select m.academy_menu ))
                {
                    %>
            <div style="display:none;" id="submenu<%= menuitem.id %>" class="subMenuShow"  <%--class=" <%=(menuitem.id>0) ?"subMenuShow":"subMenuHide" %>"--%>>
                <%
					foreach (var submenu in (from m in db.submenuRoles where (roles.Contains(m.roleid)) && (m.academy_sub_menu.id == menuitem.id) && (m.assigned) orderby m.academy_sub_menu.child_menu_order select m.academy_sub_menu))
				    {
                        if (doneSubmenus.Contains(submenu.child_id))
                            continue;
                        doneSubmenus.Add(submenu.child_id);
                        %>
                <span class="subMenuShow <%= (submenu.child_id == Int32.Parse((Page.Request.QueryString["pSubMenuid"] != null)?Page.Request.QueryString["pSubMenuid"]:"0"))?"selectedMenu":"" %>">
                    <a href="<%= "Default5.aspx?pSubMenuid=" + submenu.child_id %>"><%= submenu.child_name %></a>                
                </span>
                <%
				    }
                 %>
            </div>
            <%     
				}
                %>
        </div>
     
        <div style="margin:50px">
        <asp:ListView ID="AcademyListView" runat="server" DataKeyNames="item_id" 
        DataSourceID="PopulateItemsDataSource" >
        <ItemTemplate>
                   <table  style="display: inline-block;">
     
             <tr style="display:flex; flex-direction:column; margin:20px;" >

                <td> 
               
                
            <video width="300px" controls> <source src="<%# Eval("item_name")%>" type="video/mp4"></video>
                
                </td>
               
                
                <td >
                  <b>  <%#Eval("item_title")%>  </b>

                </td>
                <td >
                    <%# Eval("item_description") %> 

                </td>
                
            </tr>
      </table>      
        </ItemTemplate>
        <EmptyDataTemplate>
            <table id="Table1" runat="server" >
                <tr>
                    <td></td>
                </tr>
            </table>
        </EmptyDataTemplate>
        
        <LayoutTemplate>
         
                        <table ID="tablesorter" cellpadding="3" runat="server" border="1" class="fixTable" style="display:inline-block;">
                            <%--<tr id="Tr2" runat="server" class="tableheaderrow">  
                                <th class="tblhead" > </th>
                                 document.getElementById("mainmenu:first").style.display = "none";
                                <th  align="left" class="tblhead" ><font size="2">Title</font></th>
                                <th  align="left" class="tblhead"><font size="2">Description</font></th>
                           
                                
                               
                                
                                    
                            </tr>--%>
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                   
        </LayoutTemplate>
    
        
    </asp:ListView>

      <asp:LinqDataSource ID="PopulateItemsDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="False" 
        EnableInsert="False" EnableUpdate="False" TableName="academy_items"
        OnSelecting="items_DataSource_Selecting">
</asp:LinqDataSource>
    

    </div>
<hr  style="border-color:transparent; margin:5px;" />
       <div style="margin:50px">
        <asp:ListView ID="ListView1" runat="server" DataKeyNames="item_id" 
        DataSourceID="PopulatePdfItemsDataSource" >
        <ItemTemplate>
                  
     
             <tr >

                <td> 
               
                <br />
                        <%# Eval("item_name")%>" type="video/mp4">
                
                </td>
               
                
                <td >
                  <b>  <%#Eval("item_title")%>  </b>

                </td>
                <td >
                    <%# Eval("item_description") %> 

                </td>
                
            </tr>
            
        </ItemTemplate>
        <EmptyDataTemplate>
            <table id="Table1" runat="server" >
                <tr>
                    <td></td>
                </tr>
            </table>
        </EmptyDataTemplate>
        
        <LayoutTemplate>
         
                        <table ID="tablesorter" cellpadding="3" runat="server" border="1" class="fixTable">
                            <tr id="Tr2" runat="server" class="tableheaderrow">  
                                <th class="tblhead" >Pdf Tutorials </th>
                                
                                <th  align="left" class="tblhead" ><font size="2">Title</font></th>
                                <th  align="left" class="tblhead"><font size="2">Description</font></th>
                           
                                
                               
                                
                                    
                            </tr>
                           <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                   
        </LayoutTemplate>
    
        
    </asp:ListView>

      <asp:LinqDataSource ID="PopulatePdfItemsDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="False" 
        EnableInsert="False" EnableUpdate="False" TableName="academy_items"
        OnSelecting="items_DataSource_Selecting">
</asp:LinqDataSource>
    

    </div>

     <div id="blocker">
       <div><img class="center" src="Images/icons-academy.png"/></div>
   </div>
        <div>
             <%--<asp:ContentPlaceHolder id="MenuContentPlaceHolder" runat="server">
                    </asp:ContentPlaceHolder>--%>
        </div>
        
	         <%-- }
             else
             {%>
                   <div align ="center">
                     <br /><br />YOU HAVE NO ACCESS RIGHTS ASSIGNED TO YOUR PROFILE, PLEASE CONTACT THE SYSTEM ADMINISTRATOR   
                    </div>
             <%} --%>
	              
    </LoggedInTemplate>
    
    
    <AnonymousTemplate>
    
    <div align="center" margin="100px">
    <br /><br />
        <asp:Login CssClass="logincontrol" ID="Login2"  runat="server" >
        </asp:Login>
       </div>  
     <br /> 
    <div align="center">  
    <a href="create_user.aspx">Register</a>
    </div>
    
    </AnonymousTemplate>
    
 </asp:LoginView>
      
      
    </form>

    <script>
        if (currentSelectedMenuID != 0)
        {
            var setid = currentSelectedMenuID;

            currentSelectedMenuID = 0;
            showSubmenu(setid);
		}
    </script>
</body>
</html>

<%@ Page Language="C#" MasterPageFile="~/popup_master.master" AutoEventWireup="true" CodeFile="referral_partner_info.aspx.cs" Inherits="referral_partner_info" %>

<%--<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    

    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.min.js"></script>
    <link href="Scripts/theme/jquery-ui.css" rel="Stylesheet" type="text/css" />--%>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


   <script type="text/javascript">
       $(document).ready(function () {
           $('#txtSearch').autocomplete({

               source: function (request, response) {
                   $.ajax({
                       url: "ReferralPartnerList.asmx/FetchPartnerList",
                       data: "{ 'name': '" + request.term + "' }",
                       dataType: "json",
                       type: "POST",
                       contentType: "application/json; charset=utf-8",
                       dataFilter: function (data) { return data; },
                       success: function (data) {
                           response($.map(data.d, function (item) {
                               return {
                                   label: item.partnerName,
                                   partnerId: item.partnerId
                                   
                               }
                           }))
                       },
                       error: function (XMLHttpRequest, textStatus, errorThrown) {
                           alert(errorThrown);
                       }
                   });
               },
               appendTo: "#results",
               minLength: 1,
               select: function (event, ui) {
                   doSearch(ui.item.partnerId);
               }


           });
           

       });
       function doSearch(partnerId) {

           window.location.href = 'closeSBandRedirect.aspx?pRedirectUrl=\'partner_view.aspx?pPartnerId=' + partnerId + '\''

           }



   </script>
    <style>
        .textbox {
            padding:6px;
           left:auto;
        }
    </style>
<%--</head>
<body>
     <form id="form1" runat="server">--%>

     <%--<asp:ScriptManager ID="ToolkitScriptManager1"  runat="server">
        <Services>
            <asp:ServiceReference
                path="~/ReferralPartnerList.asmx" />
        </Services>
    </asp:ScriptManager>--%>

    <div>
    <div id="container">

<div id="one_column" style="background: white; color:black;" >

  <a  id="sbclose" style="float:right; margin: -10px 0px 00px 0px;" href="#" onclick="parent.clearScroll();parent.Shadowbox.close();"><img src="close.png" style="border: none;" /></a>
  <div style=" padding-left:20px;">
<%  String Message = Page.Request.QueryString["pMessage"];
    if (Message != null && Message.Length > 0)
    {
        Response.Write("<font color='black' size='4'>" + Message + "</font>");
    }
        %>
       
  </div> 
  
     <asp:FormView ID="FormView1" runat="server" 
        DataKeyNames="id" 
        DataSourceID="LinqDataSource"
         
         OnItemInserted = "referral_partner_itemInserted"
          OnItemInserting = "referral_partner_itemInserting"
          OnItemUpdated = "referral_partner_itemUpdated"
         OnDataBound="after_page_load">
          
        <EditItemTemplate>
        <asp:ValidationSummary ID="ValidationSummary1"
            
            DisplayMode="List"
            EnableClientScript="true"
            runat="server"/>
            <table id="referral_partner">
              <tr>
                    <td><asp:requiredfieldvalidator id="RequiredFieldValidator1" 
                             runat="server" 
                             ControlToValidate="partner_nameTextBox" 
                             ErrorMessage="Partner Name cannot be blank">*
                         </asp:requiredfieldvalidator>
                         <asp:CustomValidator  id="customValidator1" 
                             runat="server" 
                             ControlToValidate="partner_nameTextBox" 
                             ErrorMessage="Partner Name already exists OR is too similar to another Partner Name already in the system, please check carefully"
                             OnServerValidate="validate_duplicate">*
                         </asp:CustomValidator>
                         
                        Referral Partner Name
                    </td>
                    <td>
                        <asp:TextBox ID="partner_nameTextBox" runat="server" Text='<%# Bind("name") %>'  Width="100%"/>
                        
                       


                           
                    </td>
                    <td>    
                     
                    </td>
                    <td>
                     
                    </td>   
                </tr>
              
              
                
              
                    <tr>
                    <td>&nbsp</td>
                    <td>&nbsp</td>
                    <td>&nbsp</td>
                    <td> 
                        <asp:Button ID="LinkButton1" runat="server" 
                            CausesValidation="True" 
                            CommandName="Update" 
                            Text="Save" /> 
                        

                    </td>
                    
                    </tr>
               
               
                

            </table>
            
            
        </EditItemTemplate>
        <InsertItemTemplate>
            <asp:ValidationSummary ID="ValidationSummary1"
            
            DisplayMode="List"
            EnableClientScript="true"
            runat="server"/>
            <table id="referral_partner" width="100%">
                
                 <tr>
                   <td>&nbsp;</td>
                   <td>&nbsp;</td>
                    <td>&nbsp;</td>
                   <td>&nbsp;</td>
                </tr>
                <tr>
                    <td colspan="3" style="padding:3px; margin-block:3px 12px; text-align:justify;">  
                        <font style="font-size:12px;">
                        Please do a quick check that the Referral Partner you want to add is not saved under a similar name. 
                        The system will block exact matches but not similar matches. This is to avoid different people loading the same Referral 
                        Partner with slight variations in the name. If you do find the Partner that you were about to add then you must rather go 
                        and register yourself as a Referral Partner Liaison on the Referral Partner main page as opposed to adding a duplicate 
                        </font>
                    </td>
                    <td><div><input id="txtSearch" type="text" class="ui-corner-all textbox"  placeholder="search any part of name..." ></div>
    <div id="results"></div> </td>

                </tr>
                 <tr>
                   <td>&nbsp;</td>
                   <td>&nbsp;</td>
                    <td>&nbsp;</td>
                   <td>&nbsp;</td>
                </tr>
                <tr>
                   <td>&nbsp;</td>
                   <td>&nbsp;</td>
                    <td>&nbsp;</td>
                   <td>&nbsp;</td>
                </tr>
                 
                <tr >
                    <div style="text-align:left">
                    <td style="padding:6px;" nowrap>
                        
                        <asp:requiredfieldvalidator id="RequiredFieldValidator1" 
                             runat="server" 
                             ControlToValidate="partner_nameTextBox" 
                             ErrorMessage="Referral Partner Name cannot be blank">*
                         </asp:requiredfieldvalidator>
                         <asp:CustomValidator  id="CustomValidator" 
                             runat="server" 
                             ControlToValidate="partner_nameTextBox" 
                             ErrorMessage="Referral Partner Name already exists"
                             OnServerValidate="validate_duplicate">*
                         </asp:CustomValidator>
                         
                       <div style="text-align:right;"> Referral Partner Name to add </div>
                    </td>
                    <td colspan="2">
                        <div style="text-align:left; padding:6px !important;">
                        <asp:TextBox ID="partner_nameTextBox" runat="server" 
                            Text='<%# Bind("name") %>'
                            CssClass="ui-corner-all textbox" 
                            Width="100%"/>

                        </div>   
                        </td>
                        <td>

                        </td>
                       </div>
                    </tr>
                    <tr>

                    <td></td>
                    <td></td>
                    <td><div style="text-align:right; padding:6px;"> 
                        <asp:Button ID="LinkButton2" runat="server" 
                        CausesValidation="True" 
                        CommandName="Insert"
                            CssClass="ui-button ui-corner-all"
                        Text="Save" />
                        </div>
                    </td>
                    <td></td>
                    </tr>
          
              
              
              <tr>
                   <td>&nbsp;</td>
                   <td>&nbsp;</td>
                    <td>&nbsp;</td>
                   <td>&nbsp;</td>
                </tr>
               
                
               
               
                <tr>
                   <td>&nbsp;</td>
                   <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    
                </tr>
                 <tr>
                   <td colspan="4"><font style="color:#3b3c3d;">** Please note that once you add the new Referral Partner, 
                       you will automatically be added as the primary Referral Partner Liaison. Other Liaisons can be added later 
                       but you will be the primary Liaison </font></td>
                  
                    
                </tr>
                <tr>
                   <td>&nbsp;</td>
                   <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    
                </tr>
               
                <tr>
                   <td>&nbsp;</td>
                   <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    
                </tr>
               

            </table>

            
            
        </InsertItemTemplate>
        
        <EmptyDataTemplate>
            
           No Data
            
            
        
        </EmptyDataTemplate>
    </asp:FormView>

<asp:LinqDataSource ID="LinqDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableInsert="True" 
        EnableUpdate="True" TableName="referral_partners"
         OnSelecting ="referral_partners_selecting">
    </asp:LinqDataSource>

      
        

 </div>
 </div>
                        
    </div>


 <%--   </form>
</body>
</html>--%>
</asp:Content>

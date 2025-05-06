<%@ Page Language="C#" AutoEventWireup="true" validateRequest="false" CodeFile="sms_send.aspx.cs" Inherits="sms_send" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   <link href="page.css" rel="stylesheet" type="text/css" />
   <script src="Scripts/jquery-1.4.4.min.js" type="text/javascript"></script>
</head>
<script type="text/javascript">


   /* $(function () {
 

        $('[id$=SendButton]').click(function () {

            $(this).css('display', 'none');

            $('span#spanMsg').show();

        });

    });  

    $.ValidationSummary1.setDefaults({



    }*/

</script>  
<body>
    <form id="form1" method="post" runat="server">
    <div id="container">

<div id="one_column">
    
  <asp:LinqDataSource ID="templateLinqDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableInsert="False" 
        EnableUpdate="False" TableName="sms_templates"
         OnSelecting ="SmsTemplatesDataSource_Selecting">
    </asp:LinqDataSource> 
   
   
   
    <asp:LoginView ID="LoginView2" runat="server">
    <LoggedInTemplate>
  <asp:ValidationSummary ID="ValidationSummary1"
            HeaderText="Please note the following errors:"
            DisplayMode="BulletList"
            EnableClientScript="true"
             ShowSummary="true"
            runat="server"/>  
  <table>
    <tr>
        <td>    
            &nbsp
        </td>
        <td align="right">
            <asp:DropDownList onchange="LoginView2_messageTextBox.value=this.value" ID="Template_DropDownList"  
                                                     DataSourceID = "TemplateLinqDataSource" 
                                                      DataValueField = "message"  
                                                      DataTextField="template_name"
                                                      
                                                       AppendDataBoundItems ="true" 
                                                    
                                                          
                                                      runat="server">
                      <asp:ListItem Value="-1" Text="Select Template..."></asp:ListItem>
                            
                        </asp:DropDownList>
        </td>
    </tr>
    <tr>
        <td align="right"> 
            sms no: 
        </td>
        <td align="right">
        <asp:CustomValidator  id="CustomValidator1" 
                             runat="server" 
                             ControlToValidate="numbers" 
                             ErrorMessage="Sms number/s invalid"
                             OnServerValidate="validate_smsnumbers">*
                         </asp:CustomValidator>
         <asp:RequiredFieldValidator ID="required_numberValidator"
                                    runat="server"
                                     ControlToValidate="numbers"
                                      ErrorMessage="Numbers cannot be blank">*</asp:RequiredFieldValidator>
            <asp:TextBox ID="numbers" Columns="37" OnInit="getClientNumbers"  runat="server">
            </asp:TextBox>    
        </td>
    </tr>
    <tr>
        <td  align="right" colspan="2">
        <asp:CustomValidator ID="messageValidator" runat="server" 
                               ControlToValidate="messageTextBox"
                                OnServerValidate="validate_smsmessage">*</asp:CustomValidator>

        <asp:RequiredFieldValidator ID="required_messageValidator"
                                    runat="server"
                                     ControlToValidate="messageTextBox"
                                      ErrorMessage="Message cannot be blank">*</asp:RequiredFieldValidator>
       
            <asp:TextBox Columns="50" Rows="5" TextMode="MultiLine" ID="messageTextBox" runat="server" />
        </td>
    </tr>
    <tr>
    <td>&nbsp</td>
    <td align="right">  <asp:Button ID="SendButton" runat="server" CausesValidation="True"   OnCommand="Send" 
                        Text="Send" />
                        <!--span id="spanMsg" style="display: none;">Sending...</span>  </td-->
                        
    </tr>     
  </table>     
        
        
        
    </LoggedInTemplate>
    <AnonymousTemplate>
    
    
    
    You need to be logged in to use this functionality
    
    </AnonymousTemplate>
    
 </asp:LoginView>
    
    
    
   
   
   
   
   
   
    
    
    
  </div> 
    
    
    </div>
    
    </form>
</body>




</html>

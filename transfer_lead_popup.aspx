<%@ Page Title="" Language="C#" MasterPageFile="~/popup_master.master" AutoEventWireup="true" CodeFile="transfer_lead_popup.aspx.cs" Inherits="transfer_lead_popup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div style="background:white; color:black; padding:10px; ">

  <h3>Transfer Lead Request</h3>
    <br />
    <asp:FormView ID="FormView1" runat="server" 
        DataKeyNames="id" 
        DataSourceID="LinqDataSource"
         
         OnItemInserted = "lead_transfer_itemInserted"
          OnItemInserting = "lead_transfer_itemInserting">
          
        
        <InsertItemTemplate>
            
           <td style="border:0px;" class=" ui-widget-content ui-corner-all ui-widget ui-helper-reset">
                   
                    <asp:requiredfieldvalidator id="RequiredFieldValidator1" 
                             runat="server" 
                             ControlToValidate="reasonTextBox" 
                             ErrorMessage="Reason cannot be left blank">
                         </asp:requiredfieldvalidator>
                   
                       <div> Reason to transfer</div>
          
            <div style="width:600px;border:0px;">
                        <asp:TextBox ID="reasonTextBox" runat="server"
                            Text='<%# Bind("reason") %>' 
                            TextMode="MultiLine" Rows="10" 
                            Width="98%" BorderColor="Transparent"/>
                </div>
            <br />
            <div style="float:right;">
                        <asp:Button ID="LinkButton2" runat="server"
                        CausesValidation="True" 
                        CommandName="Insert" 
                        Text="Submit Request" />
                </div>
                   
            
            </td>
            
        </InsertItemTemplate>
        
        <EmptyDataTemplate>
            
           No Data
            
            
        
        </EmptyDataTemplate>
    </asp:FormView>
<asp:LinqDataSource ID="LinqDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableInsert="True" 
        EnableUpdate="false" TableName="lead_transfers">
    </asp:LinqDataSource>
</div>

</asp:Content>


<%@ Page Title="" Language="C#" MasterPageFile="~/QuoteLeftNavMasterPage.master" AutoEventWireup="true" CodeFile="new_lead.aspx.cs" Inherits="new_lead" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentPlaceHolder" Runat="Server">

<h1>Capture New Lead</h1>






    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ASPNETDBConnectionString %>" 

        InsertCommand="INSERT INTO [clients] ([description], [contact_name_1], [contact_name_2], [address], [contact_info], [extra_notes], [status], [linked_client], [next_quote_contact_action], [next_quote_workflow_action], [next_project_contact_action], [next_project_workflow_action]) VALUES (@description, @contact_name_1, @contact_name_2, @address, @contact_info, @extra_notes, @status, @linked_client, @next_quote_contact_action, @next_quote_workflow_action, @next_project_contact_action, @next_project_workflow_action)" 
       
        >
        <DeleteParameters>
            <asp:Parameter Name="client_id" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="description" Type="String" />
            <asp:Parameter Name="contact_name_1" Type="String" />
            <asp:Parameter Name="contact_name_2" Type="String" />
            <asp:Parameter Name="address" Type="String" />
            <asp:Parameter Name="contact_info" Type="String" />
            <asp:Parameter Name="extra_notes" Type="String" />
            <asp:Parameter Name="status" Type="Int32" />
            <asp:Parameter Name="linked_client" Type="Int32" />
            <asp:Parameter Name="next_quote_contact_action" Type="String" />
            <asp:Parameter Name="next_quote_workflow_action" Type="String" />
            <asp:Parameter Name="next_project_contact_action" Type="String" />
            <asp:Parameter Name="next_project_workflow_action" Type="String" />
            <asp:Parameter Name="client_id" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="description" Type="String" />
            <asp:Parameter Name="contact_name_1" Type="String" />
            <asp:Parameter Name="contact_name_2" Type="String" />
            <asp:Parameter Name="address" Type="String" />
            <asp:Parameter Name="contact_info" Type="String" />
            <asp:Parameter Name="extra_notes" Type="String" />
            <asp:Parameter Name="status" Type="Int32" />
            <asp:Parameter Name="linked_client" Type="Int32" />
            <asp:Parameter Name="next_quote_contact_action" Type="String" />
            <asp:Parameter Name="next_quote_workflow_action" Type="String" />
            <asp:Parameter Name="next_project_contact_action" Type="String" />
            <asp:Parameter Name="next_project_workflow_action" Type="String" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:ListView ID="ListView1" runat="server" DataKeyNames="client_id" 
        DataSourceID="SqlDataSource1" InsertItemPosition="LastItem">
        
        <EmptyDataTemplate>
            <span>No data was returned.</span>
        </EmptyDataTemplate>
        <InsertItemTemplate>
            <span style="">description:
            <asp:TextBox ID="descriptionTextBox" runat="server" 
                Text='<%# Bind("description") %>' />
            <br />
            contact_name_1:
            <asp:TextBox ID="contact_name_1TextBox" runat="server" 
                Text='<%# Bind("contact_name_1") %>' />
            <br />
            contact_name_2:
            <asp:TextBox ID="contact_name_2TextBox" runat="server" 
                Text='<%# Bind("contact_name_2") %>' />
            <br />
            address:
            <asp:TextBox ID="addressTextBox" runat="server" Text='<%# Bind("address") %>' />
            <br />
            contact_info:
            <asp:TextBox ID="contact_infoTextBox" runat="server" 
                Text='<%# Bind("contact_info") %>' />
            <br />
            extra_notes:
            <asp:TextBox ID="extra_notesTextBox" runat="server" 
                Text='<%# Bind("extra_notes") %>' />
            <br />
            status:
            <asp:TextBox ID="statusTextBox" runat="server" Text='<%# Bind("status") %>' />
            <br />
            linked_client:
            <asp:TextBox ID="linked_clientTextBox" runat="server" 
                Text='<%# Bind("linked_client") %>' />
            <br />
            
            <asp:TextBox Visible=false ID="next_quote_contact_actionTextBox" runat="server" 
                Text='<%# Bind("next_quote_contact_action") %>' />
            <br />
            
            <asp:TextBox Visible=false ID="next_quote_workflow_actionTextBox" runat="server" 
                Text='<%# Bind("next_quote_workflow_action") %>' />
            <br />
            
            <asp:TextBox Visible=false ID="next_project_contact_actionTextBox" runat="server" 
                Text='<%# Bind("next_project_contact_action") %>' />
            <br />
            
            <asp:TextBox Visible=false ID="next_project_workflow_actionTextBox" runat="server" 
                Text='<%# Bind("next_project_workflow_action") %>' />
            <br />
            <asp:Button ID="InsertButton" runat="server" CommandName="Insert" 
                Text="Insert" />
            <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                Text="Clear" />
            <br />
            <br />
            </span>
        </InsertItemTemplate>
        <LayoutTemplate>
            <div ID="itemPlaceholderContainer" runat="server" 
                style="font-family: Verdana, Arial, Helvetica, sans-serif;">
                <span ID="itemPlaceholder" runat="server" />
            </div>
            <div style="text-align: center;background-color: #CCCCCC;font-family: Verdana, Arial, Helvetica, sans-serif;color: #000000;">
            </div>
        </LayoutTemplate>
            </asp:ListView>

    </asp:Content>


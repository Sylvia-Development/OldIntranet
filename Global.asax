<%@ Application Language="C#" %>



<script runat="server">

    
    
    void Application_Start(object sender, EventArgs e) 
    {
        sendEmail("Application_Start", "");
        
        

    }
    
    void Application_Init(object sender, EventArgs e) 
    {
        sendEmail("Application_Init", "");
        

    }
    
    void Application_End(object sender, EventArgs e) 
    {
        //  Code that runs on application shutdown

    }
        
    void Application_Error(object sender, EventArgs e) 
    {
        Exception ex = Server.GetLastError().GetBaseException();
        sendEmail("Application_Error", ex.Message + " " + ex.StackTrace);
        //Response.Redirect("\\error.aspx");
        

    }

    void Session_Start(object sender, EventArgs e) 
    {
        sendEmail("Session_Start", "");
        

    }

    void Session_End(object sender, EventArgs e) 
    {
        // Code that runs when a session ends. 
        // Note: The Session_End event is raised only when the sessionstate mode
        // is set to InProc in the Web.config file. If session mode is set to StateServer 
        // or SQLServer, the event is not raised.

    }

    void sendEmail(String subject, String message)
    {
        try
        {
            System.Web.Mail.MailMessage mail = new System.Web.Mail.MailMessage();
            mail.To = "graham@blu-line.co.za";
            mail.From = "asp@blu-line.co.za";
            mail.Subject = subject;
            mail.Body = System.DateTime.Now.ToString() +" - Username " +Session["username"]+ " \n "+message;
            System.Web.Mail.SmtpMail.SmtpServer = "smtp.afrihost.co.za";
            //System.Web.Mail.SmtpMail.Send(mail); 
            
        }
        catch { 
            
        
        }
        
    }
       
</script>

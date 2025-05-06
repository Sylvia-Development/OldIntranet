using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class emailTest : System.Web.UI.Page
{
    
    
    protected void Page_Load(object sender, EventArgs e)
    {
        
        
    }

    public void sendMail(Object sender, CommandEventArgs e)
    {
        EmailSender emailSender = new EmailSender();
        //emailSender.setToAddresses("graham@blu-line.co.za");
        emailSender.setSubject("Intranet Mail Test");
        emailSender.setBody("This is the body of the email frm live server");

        emailSender.sendEmail();
        
        

    }
}

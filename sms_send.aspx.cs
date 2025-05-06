using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net.Mail;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class sms_send : System.Web.UI.Page
{
    IntranetDataDataContext db = null;
   

    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Page_Init(object sender, EventArgs e)
    {
        db = new IntranetDataDataContext();
    }



    protected void SmsTemplatesDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {
        int pDepartmentId = -1;
        try
        {
            pDepartmentId = Int32.Parse(Page.Request.QueryString["pDepartmentId"]);
        }
        catch (Exception ex) { }


        var templates = from t in db.sms_templates
                        where t.dept_id == pDepartmentId
                        orderby t.display_order
                        select t;



       
        

        e.Result = templates;
    }

    protected void getClientNumbers(Object sender, EventArgs e)
    {
        TextBox box = (TextBox)sender;

        int pClientId = -1;
        try
        {
            pClientId = Int32.Parse(Page.Request.QueryString["pClientId"]);
        }
        catch (Exception ex) { }


        String result = (from c in db.clients
                     where c.client_id == pClientId
                     select c.sms_numbers).Single();




        box.Text = result;

        


       

    }

    protected void Send(Object sender, CommandEventArgs e)
    {

        if (Page.IsValid)
        {


            String numbers = Request.Form["LoginView2$numbers"];
            String message = Request.Form["LoginView2$messageTextBox"];
            int pClientId = -1;
            int pDeptId = -1;
            try
            {
                pClientId = Int32.Parse(Page.Request.QueryString["pClientId"]);
                pDeptId = Int32.Parse(Page.Request.QueryString["pDepartmentId"]);
            }
            catch (Exception ex) { }

            String userName = "graham@blu-line.co.za";
            String password = "karendex1";
            String smsStatus = "";


            String SendURL = "http://www.winsms.co.za/api/batchmessage.asp?user=" + userName + "&password=" + password + "&message=" + message + "&Numbers=" + numbers;


            try
            {


                System.Net.WebClient client = new System.Net.WebClient();
                String reply = client.DownloadString(SendURL);

                if (isSmsSentOk(reply))
                    smsStatus = "Sms was sent successfully";
                else
                    smsStatus = " Sms FAIL:" + reply;
            }
            catch (Exception ex)
            {
                smsStatus = " Sms FAIL:" + ex.Message;
            }

            SmsLogger logger = new SmsLogger();
            logger.logSms(pDeptId, pClientId, User.Identity.Name, message, numbers, smsStatus);
            Response.Redirect("sms_status.aspx?pStatus=" + smsStatus);

        }
       

    }


    protected void validate_smsmessage(object source, ServerValidateEventArgs args)
    {

        String inputMessage = args.Value;
        CustomValidator validator = (CustomValidator)source;

        if (inputMessage == null || inputMessage.Length <= 0)
        {
            args.IsValid = false;
            if (!args.IsValid)
                validator.ErrorMessage = "Message cannot be blank";
            return;
        }

        try
        {
            int i = inputMessage.IndexOf("[");
            int j = inputMessage.IndexOf("]");
            if (i > -1 || j > -1)
            {

                args.IsValid = false;
                validator.ErrorMessage = "Message still contains [ or ]";
            }
         }
        catch (ArgumentNullException ex)
        {
           

        }

    }
    protected void validate_smsnumbers(object source, ServerValidateEventArgs args)
    {



        String inputNumbers = args.Value;

        CustomValidator validator = (CustomValidator)source;

        args.IsValid = true;

        if (inputNumbers == null || inputNumbers.Length <= 0)
        {
            args.IsValid = false;
            if (!args.IsValid)
                validator.ErrorMessage = "Sms Numbers cannot be blank";
            return;
        }


        //chaeck if numbers are delimetered
        try
        {
            int i = inputNumbers.IndexOf(";");
            if (i == -1)
                throw new ArgumentNullException();
        }
        catch (ArgumentNullException ex)
        {
            // if there is no index of ; then the number should be a single 10 digit cell number
            args.IsValid = isValidCellNo(inputNumbers);
            if (!args.IsValid)
                validator.ErrorMessage = "Not a valid 10 digit cell no, can only be separated by ;";
            return;

        }
        // if you are here then it means that its a deliminated string so it must end with a ;

        if (!inputNumbers.EndsWith(";"))
        {
            args.IsValid = false;
            validator.ErrorMessage = "List of numbers must end with a ;";
            return;
        }

        string[] numbers = inputNumbers.Split(';');
        foreach (string number in numbers)
        {
            if (number.Length <= 0)
                return;

            if (!isValidCellNo(number))
            {
                args.IsValid = false;
                if (!args.IsValid)
                    validator.ErrorMessage = "Not a valid 10 digit cell no";
                break;
            }



        }

    }

    private bool isValidCellNo(String pCellNo)
    {


        if (pCellNo == null || pCellNo.Length <= 0)
            return false;



        if (pCellNo.Length == 10)
        {
            try
            {

                double.Parse(pCellNo);
                return true;

            }

            catch (Exception ex)
            {

                return false;

            }

        }

        else
        {

            return false;

        }




    }
  

    private bool isSmsSentOk(String pReply)
    {
        

        bool result = false;

        if((pReply != null && pReply.Length >0) 
            && (!pReply.Contains("NOCREDITS") 
            && !pReply.Contains("FAIL")
            && !pReply.Contains("BADDEST")
            && !pReply.Contains("ACCOUNTLOCKED")
            && !pReply.Contains("INVALID")))
        {

            result = true;
        }





        return result;
    }



}

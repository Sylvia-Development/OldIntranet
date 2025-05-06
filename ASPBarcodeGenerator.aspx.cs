using System;
using System.Web;
using System.Drawing;

namespace ASPDataMatrixGenerator
{
	/// <summary>
	/// Summary description for Class1.
	/// </summary>
	public class GenerateBarcode : System.Web.UI.Page
	{
		private Barcodes.Barcode.BarcodeWebControl	BarcodeWebControl1;

		public GenerateBarcode()
		{
			BarcodeWebControl1 = new Barcodes.Barcode.BarcodeWebControl();
		}

		private bool GetBoolParam( string sParam, bool bDefault )
		{
			if( sParam != null && sParam != "" )
			{
				return (sParam.Equals("y") || sParam.Equals("yes") || sParam.Equals("1"));
			}
			return bDefault;
		}

		private GraphicsUnit GetFontGraphicsUnit( string sParam )
		{
			if( sParam == "point" )
				return GraphicsUnit.Point;
			else if( sParam == "pixel" )
				return GraphicsUnit.Pixel;
			else if( sParam == "millimeter" )
				return GraphicsUnit.Millimeter;
			else if( sParam == "inch" )
				return GraphicsUnit.Inch;
			else if( sParam == "document" )
				return GraphicsUnit.Document;
			else if( sParam == "display" )
				return GraphicsUnit.Display;
			else if( sParam == "world" )
				return GraphicsUnit.World;
			return GraphicsUnit.Point;
		}

		private void Page_Load(object sender, System.EventArgs e)
		{
			//set width and height
			int width=250, height=100;
			if( Request.Params.Get("w") != null && Request.Params.Get("w") != "" )
				width = Convert.ToInt32( Request.Params.Get("w") );
			if( Request.Params.Get("h") != null && Request.Params.Get("h") != "" )
				height = Convert.ToInt32( Request.Params.Get("h") );

			//set the BarText
			if( Request.Params.Get("text") != null && Request.Params.Get("text") != "" )
				BarcodeWebControl1.BarText = Request.Params.Get("text");

			//set the BarType
			if( Request.Params.Get("bt") != null && Request.Params.Get("bt") != "" )
				BarcodeWebControl1.BarType = (Barcodes.Barcode.BarcodeTypes)Convert.ToInt32(Request.Params.Get("bt"));

			//set the Orientation
			if( Request.Params.Get("angle") != null && Request.Params.Get("angle") != "" )
				BarcodeWebControl1.Orientation = (Barcodes.Barcode.Orientations)Convert.ToInt32(Request.Params.Get("angle"));

			//set the BarAlign
			if( Request.Params.Get("balign") != null && Request.Params.Get("balign") != "" )
				BarcodeWebControl1.BarAlign = (Barcodes.Barcode.BarAlignment)Convert.ToInt32(Request.Params.Get("balign"));

			//set the CalcCheck
			BarcodeWebControl1.CalcCheck = GetBoolParam( Request.Params.Get("ccheck"), true );

			//set the Code128CharSet
			if( Request.Params.Get("c128cs") != null && Request.Params.Get("c128cs") != "" )
				BarcodeWebControl1.Code128CharSet = (Barcodes.Barcode.Code128CharSets)Convert.ToInt32(Request.Params.Get("c128cs"));

			//set the BackColor
			if( Request.Params.Get("bcolor") != null && Request.Params.Get("bcolor") != "" )
			{
				uint clr = (0xFF000000 | (uint)Convert.ToInt32(Request.Params.Get("bcolor"), 16));
				BarcodeWebControl1.BackColor = System.Drawing.Color.FromArgb( (int)clr );
			}

			//set the ForeColor
			if( Request.Params.Get("fcolor") != null && Request.Params.Get("fcolor") != "" )
			{
				uint clr = (0xFF000000 | (uint)Convert.ToInt32(Request.Params.Get("fcolor"), 16));
				BarcodeWebControl1.ForeColor = System.Drawing.Color.FromArgb( (int)clr );
			}

			//set the TextColor
			if( Request.Params.Get("tcolor") != null && Request.Params.Get("tcolor") != "" )
			{
				uint clr = (0xFF000000 | (uint)Convert.ToInt32(Request.Params.Get("tcolor"), 16));
				BarcodeWebControl1.TextColor = System.Drawing.Color.FromArgb( (int)clr );
			}

			//set the TextAlign
			BarcodeWebControl1.TextAlign = (Barcodes.Barcode.TextAlignment)Convert.ToInt32(Request.Params.Get("talign"));

			//set the ShowCheck
			BarcodeWebControl1.ShowCheck = GetBoolParam( Request.Params.Get("scheck"), true );

			//set the ShowGuard
			BarcodeWebControl1.ShowGuard = GetBoolParam( Request.Params.Get("sguard"), true );

			//set the ShowStSt
			BarcodeWebControl1.ShowStSt = GetBoolParam( Request.Params.Get("sstst"), true );

			//set the ShowText
			BarcodeWebControl1.ShowText = GetBoolParam( Request.Params.Get("stext"), true );

			//set the TextBottomTop
			BarcodeWebControl1.TextBottomTop = GetBoolParam( Request.Params.Get("tbt"), true );

			//set the TxtFullIndents
			BarcodeWebControl1.TxtFullIndents = GetBoolParam( Request.Params.Get("tfi"), false );

			//set the ShowQuietZone
			BarcodeWebControl1.ShowQuietZone = GetBoolParam( Request.Params.Get("quiet"), true );

			//set the NonPrintingToTxt
			BarcodeWebControl1.NonPrintingToTxt = GetBoolParam( Request.Params.Get("np2txt"), true );

			//set the JPEGQuality
			if( Request.Params.Get("qjpeg") != null && Request.Params.Get("qjpeg") != "" )
				BarcodeWebControl1.JPEGQuality = Convert.ToInt32(Request.Params.Get("qjpeg"));

			//set the BarWidthReduction
			if( Request.Params.Get("bwrdn") != null && Request.Params.Get("bwrdn") != "" )
				BarcodeWebControl1.BarWidthReduction = Convert.ToInt32(Request.Params.Get("bwrdn"));

			//set the Wide2NarrowRatio
			if( Request.Params.Get("w2nr") != null && Request.Params.Get("w2nr") != "" )
				BarcodeWebControl1.Wide2NarrowRatio = Convert.ToInt32(Request.Params.Get("w2nr"))/(double)100;

			//set the font
			string fName = "Arial";
			FontStyle fs = 0;
			if( GetBoolParam(Request.Params.Get("fbold"), false) ) fs |= FontStyle.Bold;
			if( GetBoolParam(Request.Params.Get("fitalic"), false) ) fs |= FontStyle.Italic;
			if( GetBoolParam(Request.Params.Get("fstrikeout"), false) ) fs |= FontStyle.Strikeout;
			if( GetBoolParam(Request.Params.Get("funderline"), false) ) fs |= FontStyle.Underline;
			if( Request.Params.Get("fname") != null && Request.Params.Get("fname") != "" )
			{
				fName = Request.Params.Get( "fname" );
			}
			int fSize = 12;
			if( Request.Params.Get("fsize") != null && Request.Params.Get("fsize") != "" )
				fSize = Convert.ToInt32(Request.Params.Get("fsize"));
			//create the font
			Font f = new Font( fName, fSize, fs, GetFontGraphicsUnit("funit"), 1, false );
			BarcodeWebControl1.TextFont = f;

			//set the image format
			Response.ContentType = "image/gif";
			System.Drawing.Imaging.ImageFormat fmt = System.Drawing.Imaging.ImageFormat.Gif;
			if( Request.Params.Get("img") != null && Request.Params.Get("img") != "" )
			{
				string imgStr = Request.Params.Get("img").ToLower();
				if( imgStr.Equals("jpg") || imgStr.Equals("jpeg") )
				{
					Response.ContentType = "image/jpeg";
					fmt = System.Drawing.Imaging.ImageFormat.Jpeg;
				}
			}

			Barcodes.Barcode.ErrorCodes err = BarcodeWebControl1.WriteToBinaryStream(Response.OutputStream, width, height, fmt);
			if( err != Barcodes.Barcode.ErrorCodes.EC_OK )
			{
				throw new System.ApplicationException( "Barcode ASP.NET. Error WriteToBinaryStream" );
			}
		}

		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
			//
			// CODEGEN: This call is required by the ASP.NET Web Form Designer.
			//
			InitializeComponent();
			base.OnInit(e);
		}
		
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{    
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion
	}
}

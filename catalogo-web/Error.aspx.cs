using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace catalogo_web
{
    public partial class Error : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["ErrorMensaje"] != null)
                {
                    lblError.Text = Session["ErrorMensaje"].ToString();
                    Session.Remove("ErrorMensaje");
                }
                else
                {
                    lblError.Text = "⚠️ Ha ocurrido un error inesperado.";
                }
            }
        }

    }
}
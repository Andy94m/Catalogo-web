using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dominio;
using Negocio;

namespace catalogo_web
{
    public partial class Master : System.Web.UI.MasterPage
    {
        public bool UsuarioLogeado { get; private set; }
        public bool EsAdmin { get; private set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            Usuario usuario = (Usuario)Session["usuario"];
            UsuarioLogeado = usuario != null;
            EsAdmin = usuario != null && usuario.Admin == true;

            if (IsPostBack && hfTheme.Value != "")
                Session["theme"] = hfTheme.Value;

            string tema = Session["theme"] != null ? Session["theme"].ToString() : "dark";
            Page.Header.Controls.Add(new LiteralControl($"<script>document.documentElement.setAttribute('data-bs-theme', '{tema}');</script>"));

            if (UsuarioLogeado)
            {
                lblNombre.Text = usuario.Nombre;
                lblApellido.Text = usuario.Apellido;
                lblEmail.Text = usuario.Email;
                //Debug.WriteLine(usuario.Id);
            }
        }

        protected void btnSalir_Click(object sender, EventArgs e)
        {
            Session.Clear(); // Limpia todos los datos de sesión
            Session.Abandon(); // Finaliza la sesión actual
            Response.Redirect("Default.aspx", false); // Redirige al inicio
        }
    }
}
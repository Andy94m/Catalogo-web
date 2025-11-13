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
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack && hfTheme.Value != "")
            {
                Session["theme"] = hfTheme.Value;
            }

            string tema = Session["theme"] != null ? Session["theme"].ToString() : "dark";
            Page.Header.Controls.Add(new LiteralControl($"<script>document.documentElement.setAttribute('data-bs-theme', '{tema}');</script>"));

            if (UsuarioLogeado)
            {
                var usuario = (Usuario)Session["usuario"];
                lblNombre.Text = usuario.Nombre;
                lblApellido.Text = usuario.Apellido;
                lblEmail.Text = usuario.Email;
                //Debug.WriteLine(usuario.Nombre);
                //Debug.WriteLine(usuario.Apellido);
                //Debug.WriteLine(usuario.Email);
                //Debug.WriteLine(usuario.Admin);
                //Debug.WriteLine(usuario.Id);
                //Debug.WriteLine(usuario.UrlImagenPerfil);
                //Debug.WriteLine(usuario.Pass);
            }
        }

        public bool UsuarioLogeado
        {
            get
            {
                return (Session["usuario"] != null);
            }
        }

        protected void btnSalir_Click(object sender, EventArgs e)
        {
            Session.Clear(); // Limpia todos los datos de sesión
            Session.Abandon(); // Finaliza la sesión actual
            Response.Redirect("Default.aspx", false); // Redirige al inicio

            // Mostrar alerta antes de redirigir
            string script = @"mostrarAlerta('Hasta la próxima 👋 ¡Sesión cerrada correctamente!', 'info');
                            setTimeout(function() {window.location.href = 'Default.aspx';}, 2000);";

            ScriptManager.RegisterStartupScript(this, GetType(), "logoutAlerta", script, true);
        }
    }
}
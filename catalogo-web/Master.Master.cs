using System;
using System.Collections.Generic;
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
            if (UsuarioLogeado)
            {
                var usuario = (Usuario)Session["usuario"];
                lblNombre.Text = usuario.Nombre;
                lblApellido.Text = usuario.Apellido;
                lblEmail.Text = usuario.Email;
            }
        }

        public bool UsuarioLogeado
        {
            get
            {
                return (Session["usuario"] != null);
            }
        }
    }
}
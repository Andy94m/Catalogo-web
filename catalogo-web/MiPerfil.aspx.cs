using Dominio;
using Negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace catalogo_web
{
    public partial class MiPerfil : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            Usuario user = new Usuario();
            user = (Usuario)Session["usuario"];
            UserNegocio negocio = new UserNegocio();
            try
            {
                user.Nombre = txtNombre.Text;
                user.Apellido = txtApellido.Text;
                user.Email = txtEmail.Text;
                user.UrlImagenPerfil = txtUrlImagenPerfil.Text;
                negocio.actualizar(user);
                Session["usuario"] = user;

                ScriptManager.RegisterStartupScript(this, GetType(),
                    "mostrarAlerta", "mostrarAlerta('Perfil actualizado correctamente.', 'success');", true);
            }
            catch (Exception ex)
            {
                throw ex;
            }

            return;
        }
    }
}
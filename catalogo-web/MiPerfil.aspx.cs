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
            if (!IsPostBack)
            {
                // Verifica si hay sesión activa
                Usuario usuario = (Usuario)Session["usuario"];

                if (usuario == null)
                {
                    Response.Redirect("Login.aspx");
                    return;
                }

                // Si hay usuario, continúa con la carga del perfil
                cargarDatosPerfil(usuario);
            }
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

        private void cargarDatosPerfil(Usuario usuario)
        {
            // Asignar los datos del usuario a los controles del formulario
            txtEmail.Text = usuario.Email;
            txtNombre.Text = usuario.Nombre;
            txtApellido.Text = usuario.Apellido;
            txtUrlImagenPerfil.Text = usuario.UrlImagenPerfil;

            // Mostrar imagen si tiene una URL válida
            if (!string.IsNullOrWhiteSpace(usuario.UrlImagenPerfil))
                imgNuevoPerfil.ImageUrl = usuario.UrlImagenPerfil;
            else
                imgNuevoPerfil.ImageUrl = "https://www.palomacornejo.com/wp-content/uploads/2021/08/no-image.jpg";
        }
    }
}
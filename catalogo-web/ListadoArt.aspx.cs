using Dominio;
using Negocio;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace catalogo_web
{
    public partial class ListadoArt : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Verifica si hay sesión y si el usuario es admin
                Usuario usuario = (Usuario)Session["usuario"];

                if (usuario == null || !usuario.Admin)
                {
                    Session["ErrorMensaje"] = "⛔ Acceso restringido: esta sección es solo para administradores.";
                    Response.Redirect("Error.aspx");
                    return;
                }

                cargarGrillasAdmin();
                cargarDropDownList();
            }
        }


        private void cargarGrillasAdmin()
        {
            ArticuloNegocio negocio = new ArticuloNegocio();
            gvArticulos.DataSource = negocio.listarConSP(); // Artículos activos
            gvArticulos.DataBind();

            gvPapelera.DataSource = negocio.listarExcluidos(); // Papelera
            gvPapelera.DataBind();
        }


        protected void gvArticulos_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int index = Convert.ToInt32(e.CommandArgument);
            int id = Convert.ToInt32(gvArticulos.DataKeys[index].Value);
            ArticuloNegocio negocio = new ArticuloNegocio();

            if (e.CommandName == "Editar")
            {
                Articulo articulo = negocio.buscarId(id);

                txtId.Value = articulo.Id.ToString();
                txtNombre.Text = articulo.Nombre;
                txtCodigo.Text = articulo.Cod;
                ddlTipo.SelectedValue = articulo.Tipo.Id.ToString();
                ddlMarca.SelectedValue = articulo.Compania.Id.ToString();
                txtDescripcion.Text = articulo.Descripcion;
                txtPrecio.Text = articulo.Precio.ToString("N2");
                txtUrlImagen.Text = articulo.UrlImagen;
                imgNuevoPerfil.ImageUrl = string.IsNullOrEmpty(articulo.UrlImagen)
                    ? "https://www.palomacornejo.com/wp-content/uploads/2021/08/no-image.jpg"
                    : articulo.UrlImagen;

                ScriptManager.RegisterStartupScript(this, GetType(), "abrirModal",
                    $"var modal = new bootstrap.Modal(document.getElementById('{modalDetalle.ClientID}')); modal.show();", true);
            }
            else if (e.CommandName == "Eliminar")
            {
                negocio.eliminarLogico(id);
                cargarGrillasAdmin();
            }
        }


        protected void gvPapelera_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Restaurar")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                int id = Convert.ToInt32(gvPapelera.DataKeys[index].Value);

                ArticuloNegocio negocio = new ArticuloNegocio();
                negocio.restaurarEliminado(id);

                cargarGrillasAdmin();
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            divAlerta.Visible = false;
            divExito.Visible = false;

            if (string.IsNullOrWhiteSpace(txtNombre.Text) ||
                string.IsNullOrWhiteSpace(txtCodigo.Text) ||
                string.IsNullOrWhiteSpace(txtPrecio.Text) ||
                !int.TryParse(ddlTipo.SelectedValue, out int idTipo) ||
                !int.TryParse(ddlMarca.SelectedValue, out int idMarca))
            {
                divAlerta.Visible = true;
                litAlerta.Text = "⚠️ Por favor completá todos los campos correctamente.";
                ScriptManager.RegisterStartupScript(this, GetType(), "mantenerModalAbierto", $@"
                    var modal = new bootstrap.Modal(document.getElementById('{modalDetalle.ClientID}'));
                    modal.show();
                ", true);

                return;

            }

            try
            {
                ArticuloNegocio negocio = new ArticuloNegocio();
                Articulo actualizado = new Articulo
                {
                    Id = int.Parse(txtId.Value),
                    Nombre = txtNombre.Text,
                    Cod = txtCodigo.Text,
                    Descripcion = txtDescripcion.Text,
                    Precio = decimal.Parse(txtPrecio.Text),
                    UrlImagen = txtUrlImagen.Text,
                    Tipo = new Categorias { Id = idTipo },
                    Compania = new Marcas { Id = idMarca }
                };

                if (actualizado.Id == 0)
                    negocio.agregarConSP(actualizado);
                else
                    negocio.modificarConSP(actualizado);

                cargarGrillasAdmin();

                divExito.Visible = true;
                litExito.Text = "✅ Artículo guardado correctamente.";

                // ✅ Cierra el modal después de 1 segundo
                ScriptManager.RegisterStartupScript(this, GetType(), "cerrarModalConDelay", $@"
            setTimeout(function() {{
                var modal = bootstrap.Modal.getInstance(document.getElementById('{modalDetalle.ClientID}'));
                modal.hide();
            }}, 1000);
        ", true);
            }
            catch (Exception ex)
            {
                divAlerta.Visible = true;
                litAlerta.Text = "❌ Error al guardar: " + ex.Message;
            }
        }



        private void cargarDropDownList()
        {
            MarcasNegocio marcasNegocio = new MarcasNegocio();
            List<Marcas> listaMarcas = marcasNegocio.listar();
            ddlMarca.DataSource = listaMarcas;
            ddlMarca.DataTextField = "Descripcion";
            ddlMarca.DataValueField = "Id";
            ddlMarca.DataBind();

            CategoriasNegocio categoriasNegocio = new CategoriasNegocio();
            List<Categorias> listaCategorias = categoriasNegocio.listar();
            ddlTipo.DataSource = listaCategorias;
            ddlTipo.DataTextField = "Descripcion";
            ddlTipo.DataValueField = "Id";
            ddlTipo.DataBind();
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            ArticuloNegocio negocio = new ArticuloNegocio();
            gvArticulos.DataSource = negocio.buscarPorNombre(txtBuscarNombre.Text);
            gvArticulos.DataBind();
        }

        protected void btnFiltrar_Click(object sender, EventArgs e)
        {
            string columna = ddlColumna.SelectedValue;
            string criterio = ddlCriterio.SelectedValue;
            string filtro = txtFiltro.Text;

            ArticuloNegocio negocio = new ArticuloNegocio();
            gvArticulos.DataSource = negocio.filtrar(columna, criterio, filtro, "");
            gvArticulos.DataBind();
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            txtId.Value = "0";
            txtNombre.Text = "";
            txtCodigo.Text = "";
            txtDescripcion.Text = "";
            txtPrecio.Text = "";
            txtUrlImagen.Text = "";
            imgNuevoPerfil.ImageUrl = "https://www.palomacornejo.com/wp-content/uploads/2021/08/no-image.jpg";

            ScriptManager.RegisterStartupScript(this, GetType(), "abrirModal",
                $"var modal = new bootstrap.Modal(document.getElementById('{modalDetalle.ClientID}')); modal.show();", true);
        }
    }
}
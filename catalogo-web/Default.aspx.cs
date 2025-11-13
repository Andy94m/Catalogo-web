using Dominio;
using Negocio;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Security.Cryptography.X509Certificates;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace catalogo_web
{
    public partial class Default : System.Web.UI.Page
    {
        public List<Articulo> ListaArticulos { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ArticuloNegocio negocio = new ArticuloNegocio();
                ListaArticulos = negocio.listarConSP();

                // Aplicar orden inicial
                string orden = ddlOrden.SelectedValue;
                if (orden == "asc")
                    ListaArticulos = ListaArticulos.OrderBy(a => a.Precio).ToList();
                else if (orden == "desc")
                    ListaArticulos = ListaArticulos.OrderByDescending(a => a.Precio).ToList();

                repRepetidor.DataSource = ListaArticulos;
                repRepetidor.DataBind();

                cargarDropDownList();
            }

            cargarCheckboxMarcas();
            cargarCheckboxTipos();
        }

        protected void repRepetidor_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            Articulo aux = new Articulo();
            ArticuloNegocio negocio = new ArticuloNegocio();
            Usuario usuario = (Usuario)Session["usuario"];
            bool esAdmin = usuario != null && usuario.Admin == true;
            cargarDropDownList();

            if (e.CommandName == "VerDetalle")
            {
                int id = int.Parse(e.CommandArgument.ToString());
                ViewState["IdArticulo"] = id;
                aux = negocio.buscarId(id);

                //Debug.WriteLine("ID del artículo seleccionado: " + id);
                //Debug.WriteLine("Nombre: " + aux.Nombre);
                //Debug.WriteLine("Marca: " + aux.Tipo.Descripcion);

                txtNombre.Text = aux.Nombre;
                txtCodigo.Text = aux.Cod;
                ddlTipo.SelectedValue = aux.Tipo.Id.ToString();
                ddlMarca.SelectedValue = aux.Compania.Id.ToString();
                txtDescripcion.Text = aux.Descripcion;
                txtPrecio.Text = aux.Precio.ToString("N2");
                txtUrlImagen.Text = aux.UrlImagen;

                imgNuevoPerfil.ImageUrl = string.IsNullOrEmpty(aux.UrlImagen)
                    ? "https://www.palomacornejo.com/wp-content/uploads/2021/08/no-image.jpg"
                    : aux.UrlImagen;

                txtNombre.Enabled = esAdmin;
                txtCodigo.Enabled = esAdmin;
                ddlTipo.Enabled = esAdmin;
                ddlMarca.Enabled = esAdmin;
                txtDescripcion.Enabled = esAdmin;
                txtPrecio.Enabled = esAdmin;
                txtUrlImagen.Enabled = esAdmin;
                btnGuardar.Visible = esAdmin;

                imgNuevoPerfil.ImageUrl = string.IsNullOrEmpty(aux.UrlImagen) ? "https://www.palomacornejo.com/wp-content/uploads/2021/08/no-image.jpg" : aux.UrlImagen;

                ScriptManager.RegisterStartupScript(this, GetType(), "abrirModal", $"var modal = new bootstrap.Modal(document.getElementById('{modalDetalle.ClientID}')); modal.show();", true);
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                ArticuloNegocio negocio = new ArticuloNegocio();
                Articulo actualizado = new Articulo();

                actualizado.Id = (int)ViewState["IdArticulo"];

                //Debug.WriteLine("Id del modal: " + actualizado.Id);
                actualizado.Nombre = txtNombre.Text;
                actualizado.Cod = txtCodigo.Text;
                actualizado.Descripcion = txtDescripcion.Text;
                actualizado.Precio = decimal.Parse(txtPrecio.Text);
                actualizado.UrlImagen = txtUrlImagen.Text;

                actualizado.Tipo = new Categorias { Id = int.Parse(ddlTipo.SelectedValue) };
                actualizado.Compania = new Marcas { Id = int.Parse(ddlMarca.SelectedValue) };

                negocio.modificarConSP(actualizado);

                ScriptManager.RegisterStartupScript(this, GetType(), "cerrarModal",
                    $"var modal = bootstrap.Modal.getInstance(document.getElementById('{modalDetalle.ClientID}')); modal.hide();", true);
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

        private void cargarCheckboxMarcas()
        {
            MarcasNegocio negocio = new MarcasNegocio();
            List<Marcas> marcas = negocio.listar();

            foreach (Marcas marca in marcas)
            {
                CheckBox chk = new CheckBox();
                chk.ID = "chkMarca_" + marca.Id;
                chk.Text = marca.Descripcion;

                // Envolvemos en un div con Bootstrap
                Panel wrapper = new Panel();
                wrapper.CssClass = "form-check";

                wrapper.Controls.Add(chk);
                phMarcas.Controls.Add(wrapper);
            }
        }

        private void cargarCheckboxTipos()
        {
            CategoriasNegocio negocio = new CategoriasNegocio();
            List<Categorias> tipos = negocio.listar();

            foreach (Categorias tipo in tipos)
            {
                CheckBox chk = new CheckBox();
                chk.ID = "chkTipo_" + tipo.Id;
                chk.Text = tipo.Descripcion;

                Panel wrapper = new Panel();
                wrapper.CssClass = "form-check";

                wrapper.Controls.Add(chk);
                phTipos.Controls.Add(wrapper);
            }
        }

        protected void btnAplicarFiltros_Click(object sender, EventArgs e)
        {
            List<int> marcasSeleccionadas = obtenerMarcasSeleccionadas();
            List<int> tiposSeleccionados = obtenerTiposSeleccionados();

            ArticuloNegocio negocio = new ArticuloNegocio();
            List<Articulo> filtrados = negocio.filtrarPorMarcasYTipos(marcasSeleccionadas, tiposSeleccionados);

            // Aplicar orden actual
            string orden = ddlOrden.SelectedValue;
            if (orden == "asc")
                filtrados = filtrados.OrderBy(a => a.Precio).ToList();
            else if (orden == "desc")
                filtrados = filtrados.OrderByDescending(a => a.Precio).ToList();

            repRepetidor.DataSource = filtrados;
            repRepetidor.DataBind();
        }


        protected void btnLimpiarFiltros_Click(object sender, EventArgs e)
        {
            // Desmarcar todos los checkboxes
            foreach (Control ctrl in phMarcas.Controls)
            {
                if (ctrl is Panel panel)
                {
                    foreach (Control subCtrl in panel.Controls)
                    {
                        if (subCtrl is CheckBox chk)
                            chk.Checked = false;
                    }
                }
            }

            // Volver a mostrar todos los artículos
            ArticuloNegocio negocio = new ArticuloNegocio();
            List<Articulo> todos = negocio.listarConSP();

            repRepetidor.DataSource = todos;
            repRepetidor.DataBind();
        }

        protected void ddlOrden_SelectedIndexChanged(object sender, EventArgs e)
        {
            List<int> marcasSeleccionadas = obtenerMarcasSeleccionadas();
            List<int> tiposSeleccionados = obtenerTiposSeleccionados();

            ArticuloNegocio negocio = new ArticuloNegocio();
            List<Articulo> lista = negocio.filtrarPorMarcasYTipos(marcasSeleccionadas, tiposSeleccionados);

            string orden = ddlOrden.SelectedValue;
            if (orden == "asc")
                lista = lista.OrderBy(a => a.Precio).ToList();
            else if (orden == "desc")
                lista = lista.OrderByDescending(a => a.Precio).ToList();

            repRepetidor.DataSource = lista;
            repRepetidor.DataBind();
        }

        private List<int> obtenerMarcasSeleccionadas()
        {
            List<int> marcas = new List<int>();
            foreach (Control ctrl in phMarcas.Controls)
            {
                if (ctrl is Panel panel)
                {
                    foreach (Control subCtrl in panel.Controls)
                    {
                        if (subCtrl is CheckBox chk && chk.Checked)
                        {
                            string idStr = chk.ID.Replace("chkMarca_", "");
                            if (int.TryParse(idStr, out int id))
                                marcas.Add(id);
                        }
                    }
                }
            }
            return marcas;
        }

        private List<int> obtenerTiposSeleccionados()
        {
            List<int> tipos = new List<int>();
            foreach (Control ctrl in phTipos.Controls)
            {
                if (ctrl is Panel panel)
                {
                    foreach (Control subCtrl in panel.Controls)
                    {
                        if (subCtrl is CheckBox chk && chk.Checked)
                        {
                            string idStr = chk.ID.Replace("chkTipo_", "");
                            if (int.TryParse(idStr, out int id))
                                tipos.Add(id);
                        }
                    }
                }
            }
            return tipos;
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            string textoBusqueda = TextBox1.Text.Trim();

            ArticuloNegocio negocio = new ArticuloNegocio();
            List<Articulo> resultados = negocio.buscarPorNombre(textoBusqueda);

            // Aplicar orden actual
            string orden = ddlOrden.SelectedValue;
            if (orden == "asc")
                resultados = resultados.OrderBy(a => a.Precio).ToList();
            else if (orden == "desc")
                resultados = resultados.OrderByDescending(a => a.Precio).ToList();

            repRepetidor.DataSource = resultados;
            repRepetidor.DataBind();
        }
    }
}
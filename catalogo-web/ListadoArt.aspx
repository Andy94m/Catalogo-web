<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="ListadoArt.aspx.cs" Inherits="catalogo_web.ListadoArt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" />
    <%--<h1>LISTADO ARTICULOSSSS WOOO</h1>--%>

    <!-- Encabezado y barra de acciones -->
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h4 class="mb-0">Panel de control de artículos</h4>

        <div class="d-flex gap-2">
            <!-- 🔍 Búsqueda por nombre -->
            <asp:TextBox ID="txtBuscarNombre" runat="server" CssClass="form-control" placeholder="Buscar por nombre..." />
            <asp:Button ID="btnBuscar" runat="server" Text="Buscar" CssClass="btn btn-outline-primary" OnClick="btnBuscar_Click" />

            <!-- ➕ Botón Agregar -->
            <asp:Button ID="btnAgregar" runat="server" Text="Agregar" CssClass="btn btn-success" OnClick="btnAgregar_Click" />
        </div>
    </div>

    <!-- 🎯 Filtros avanzados -->
    <div class="row mb-4">
        <div class="col-md-3">
            <asp:DropDownList ID="ddlColumna" runat="server" CssClass="form-select">
                <asp:ListItem Text="Nombre" Value="Nombre" />
                <asp:ListItem Text="Código" Value="Codigo" />
                <asp:ListItem Text="Marca" Value="Marca" />
                <asp:ListItem Text="Categoria" Value="Categoria" />
                <asp:ListItem Text="Descripción" Value="Descripcion" />
                <asp:ListItem Text="Precio" Value="Precio" />
            </asp:DropDownList>
        </div>
        <div class="col-md-3">
            <asp:DropDownList ID="ddlCriterio" runat="server" CssClass="form-select">
                <asp:ListItem Text="Contiene" Value="Contiene" />
                <asp:ListItem Text="Comienza con" Value="Comienza con" />
                <asp:ListItem Text="Termina con" Value="Termina con" />
                <asp:ListItem Text="Mayor a" Value="Mayor a" />
                <asp:ListItem Text="Menor a" Value="Menor a" />
                <asp:ListItem Text="Igual a" Value="Igual a" />
            </asp:DropDownList>
        </div>
        <div class="col-md-4">
            <asp:TextBox ID="txtFiltro" runat="server" CssClass="form-control" placeholder="Ingrese filtro..." />
        </div>
        <div class="col-md-2">
            <asp:Button ID="btnFiltrar" runat="server" Text="Filtrar" CssClass="btn btn-outline-secondary w-100" OnClick="btnFiltrar_Click" />
        </div>
    </div>

    <!-- Pestañas Bootstrap -->
    <ul class="nav nav-tabs mb-3" id="panelAdminTabs" role="tablist">
        <li class="nav-item" role="presentation">
            <button class="nav-link active" id="tab-articulos" data-bs-toggle="tab" data-bs-target="#panel-articulos" type="button" role="tab">Artículos activos</button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link" id="tab-papelera" data-bs-toggle="tab" data-bs-target="#panel-papelera" type="button" role="tab">Papelera de reciclaje</button>
        </li>
    </ul>

    <div class="tab-content" id="panelAdminContent">
        <!-- 🟢 Artículos activos -->
        <div class="tab-pane fade show active" id="panel-articulos" role="tabpanel">
            <div class="table-responsive">
                <asp:GridView ID="gvArticulos" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-striped table-sm"
                    OnRowCommand="gvArticulos_RowCommand" DataKeyNames="Id">
                    <Columns>
                        <asp:BoundField DataField="Id" HeaderText="ID">
                            <ItemStyle Width="50px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Cod" HeaderText="Código">
                            <ItemStyle Width="100px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Nombre" HeaderText="Nombre">
                            <ItemStyle Width="150px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Descripcion" HeaderText="Descripción">
                            <ItemStyle Width="250px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Compania.Descripcion" HeaderText="Marca">
                            <ItemStyle Width="120px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Tipo.Descripcion" HeaderText="Tipo">
                            <ItemStyle Width="120px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Precio" HeaderText="Precio" DataFormatString="{0:C}">
                            <ItemStyle Width="100px" />
                        </asp:BoundField>
                        <%--<asp:BoundField DataField="UrlImagen" HeaderText="Imagen">
                            <ItemStyle Width="200px" />
                        </asp:BoundField>--%>

                        <asp:ButtonField ButtonType="Button" CommandName="Eliminar" Text="🗑 Eliminar">
                            <ItemStyle Width="100px" />
                        </asp:ButtonField>
                        <asp:ButtonField ButtonType="Button" CommandName="Editar" Text="✏ Editar">
                            <ItemStyle Width="100px" />
                        </asp:ButtonField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>

        <!-- 🗑 Papelera -->
        <div class="tab-pane fade" id="panel-papelera" role="tabpanel">
            <div class="table-responsive">
                <asp:GridView ID="gvPapelera" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-sm"
                    OnRowCommand="gvPapelera_RowCommand" DataKeyNames="Id">
                    <Columns>
                        <asp:BoundField DataField="Id" HeaderText="ID">
                            <ItemStyle Width="50px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Cod" HeaderText="Código">
                            <ItemStyle Width="100px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Nombre" HeaderText="Nombre">
                            <ItemStyle Width="150px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Descripcion" HeaderText="Descripción">
                            <ItemStyle Width="250px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Compania.Descripcion" HeaderText="Marca">
                            <ItemStyle Width="120px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Tipo.Descripcion" HeaderText="Tipo">
                            <ItemStyle Width="120px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Precio" HeaderText="Precio" DataFormatString="{0:C}">
                            <ItemStyle Width="100px" />
                        </asp:BoundField>

                        <asp:ButtonField ButtonType="Button" CommandName="Restaurar" Text="♻ Restaurar">
                            <ItemStyle Width="100px" />
                        </asp:ButtonField>
                        <asp:ButtonField ButtonType="Button" CommandName="Editar" Text="✏ Editar">
                            <ItemStyle Width="100px" />
                        </asp:ButtonField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>


    <!-- Modal -->
    <div class="modal fade" id="modalDetalle" runat="server" tabindex="-1" aria-labelledby="modalDetalleLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content bg-body text-body">
                <div class="modal-body">
                    <!-- ✅ Paneles de alerta dentro del cuerpo del modal -->
                    <div runat="server" id="divAlerta" visible="false" class="alert alert-danger mb-3">
                        <asp:Literal ID="litAlerta" runat="server" />
                    </div>

                    <div runat="server" id="divExito" visible="false" class="alert alert-success mb-3">
                        <asp:Literal ID="litExito" runat="server" />
                    </div>


                    <asp:HiddenField ID="txtId" runat="server" />

                    <div class="row">
                        <div class="col-md-7">
                            <div class="mb-3">
                                <label for="txtNombre">Nombre</label>
                                <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" />
                            </div>
                            <div class="mb-3">
                                <label for="txtCodigo">Código</label>
                                <asp:TextBox ID="txtCodigo" runat="server" CssClass="form-control" />
                            </div>
                            <div class="mb-3">
                                <label for="ddlTipo">Tipo</label>
                                <asp:DropDownList ID="ddlTipo" runat="server" CssClass="form-control" />
                            </div>
                            <div class="mb-3">
                                <label for="ddlMarca">Marca</label>
                                <asp:DropDownList ID="ddlMarca" runat="server" CssClass="form-control" />
                            </div>
                            <div class="mb-3">
                                <label for="txtPrecio">Precio</label>
                                <asp:TextBox ID="txtPrecio" runat="server" CssClass="form-control" />
                            </div>
                            <div class="mb-3">
                                <label for="txtDescripcion">Descripción</label>
                                <asp:TextBox ID="txtDescripcion" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4" />
                            </div>
                            <asp:Label ID="lblAviso" runat="server" CssClass="text-muted" />
                        </div>

                        <div class="col-md-5 text-center">
                            <label class="form-label">Imagen del artículo</label>
                            <asp:TextBox ID="txtUrlImagen" runat="server" CssClass="form-control mb-3" />
                            <asp:Image ID="imgNuevoPerfil" runat="server"
                                ImageUrl="https://www.palomacornejo.com/wp-content/uploads/2021/08/no-image.jpg"
                                CssClass="img-fluid rounded border mb-3"
                                Width="200px" />
                        </div>
                    </div>
                </div>

                <div class="modal-footer">
                    <asp:Button ID="btnGuardar" runat="server"
                        CssClass="btn btn-success"
                        Text="Guardar cambios"
                        OnClick="btnGuardar_Click" />
                    <button type="button" class="btn btn-outline-danger" data-bs-dismiss="modal">Cerrar</button>
                </div>
            </div>
        </div>
    </div>

</asp:Content>

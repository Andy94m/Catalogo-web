<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="MiPerfil.aspx.cs" Inherits="catalogo_web.MiPerfil" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Content/Estilos-Default.css" rel="stylesheet" />
    <%--<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>--%>

    <script>
        function validar() {
            const txtApellido = document.getElementById("txtApellido");
            const txtNombre = document.getElementById("txtNombre");

            let valido = true;

            if (txtNombre.value.trim() === "") {
                txtNombre.classList.add("is-invalid");
                txtNombre.classList.remove("is-valid");
                valido = false;
            } else {
                txtNombre.classList.remove("is-invalid");
                txtNombre.classList.add("is-valid");
            }

            if (txtApellido.value.trim() === "") {
                txtApellido.classList.add("is-invalid");
                txtApellido.classList.remove("is-valid");
                valido = false;
            } else {
                txtApellido.classList.remove("is-invalid");
                txtApellido.classList.add("is-valid");
            }
            return valido;
        }

        function mostrarAlerta(mensaje, tipo = "success") {
            const alertPlaceholder = document.getElementById("liveAlertPlaceholder");
            const wrapper = document.createElement("div");
            wrapper.innerHTML = `
            <div class="alert alert-${tipo} alert-dismissible fade show" role="alert">
                ${mensaje}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>`;
            alertPlaceholder.innerHTML = ""; // Limpia alertas anteriores
            alertPlaceholder.append(wrapper);
        }

    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-md-8 perfil-card">
                <h2 class="text-center mb-4">Mi Perfil</h2>
                <div class="row">
                    <!-- Datos personales -->
                    <div class="col-md-7">
                        <div class="mb-3">
                            <label class="form-label">Email</label>
                            <asp:TextBox runat="server" CssClass="form-control" ID="txtEmail" />
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Nombre</label>
                            <asp:TextBox runat="server" CssClass="form-control" ClientIDMode="Static" ID="txtNombre" />
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Apellido</label>
                            <asp:TextBox ID="txtApellido" ClientIDMode="Static" runat="server" CssClass="form-control" MaxLength="20" />
                        </div>
                    </div>

                    <!-- Imagen de perfil -->
                    <div class="col-md-5 text-center">
                        <label class="form-label">URL Imagen:</label>
                        <asp:TextBox ID="txtUrlImagenPerfil" runat="server" CssClass="form-control mb-3" />
                        <%--<input type="file" id="txtImagen" runat="server" class="form-control mb-3" />--%>
                        <asp:Image ID="imgNuevoPerfil" ImageUrl="https://www.palomacornejo.com/wp-content/uploads/2021/08/no-image.jpg"
                            runat="server" CssClass="perfil-img mb-3" />
                    </div>
                </div>

                <!-- Botones -->
                <div class="text-center mt-4">
                    <div id="liveAlertPlaceholder"></div>
                    <asp:Button Text="Guardar" CssClass="btn btn-outline-primary me-2" OnClientClick="return validar()" OnClick="btnGuardar_Click" ID="btnGuardar" runat="server" />
                    <a href="/" class="btn btn-outline-secondary">Regresar</a>
                </div>
            </div>
        </div>
    </div>
</asp:Content>


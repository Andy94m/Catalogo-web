<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="catalogo_web.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Content/estilos-default.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>
        <hr />
        <h1>INVENTARIO</h1>
        <hr />
    </div>

    <div class="row row-cols-1 row-cols-md-3 g-4">
        <asp:Repeater runat="server" ID="repRepetidor">
            <ItemTemplate>
                <div class="col">
                    <div class="card-producto">
                        <div class="imagen">
                            <img src="<%#Eval("UrlImagen") %>" alt="Cartera negra">
                        </div>
                        <div class="contenido">
                            <div class="titulo"><%#Eval("Nombre") %></div>
                            <div class="vendedor"><%#Eval("Descripcion") %></div>
                            <div>
                                <span class="precio">$<%#Eval("Precio") %></span>
                            </div>
                            <%--<div class="descuento"><%# Eval("Tipo") + " / " + Eval("Compania") %></div>
                            <div class="descuento">COD: <%#Eval("Cod") %></div>--%>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</asp:Content>

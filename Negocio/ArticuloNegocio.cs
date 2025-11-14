using System;
using System.Collections;
using System.Collections.Generic;
using System.Data.Common;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;
using Dominio;
using System.Diagnostics;

namespace Negocio
{
    public class ArticuloNegocio
    {

        public List<Articulo> listarConSP()
        {
            List<Articulo> lista = new List<Articulo>();
            AccesoDatos datos = new AccesoDatos();

            if (datos != null)
                Debug.WriteLine("AccesoDatos no es nulo");
            else
                Debug.WriteLine("AccesoDatos es nulo");

            try
            {
                datos.setearProcedimiento("storedListar");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Articulo aux = new Articulo();
                    aux.Id = (int)datos.Lector["Id"];
                    aux.Cod = (string)datos.Lector["Codigo"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Descripcion = (string)datos.Lector["Descripcion"];
                    aux.UrlImagen = (string)datos.Lector["ImagenUrl"];
                    aux.Precio = (decimal)datos.Lector["Precio"];


                    //Debug.WriteLine(aux.Cod.ToString());

                    if (!(datos.Lector["ImagenUrl"] is DBNull))
                        aux.UrlImagen = (string)datos.Lector["ImagenUrl"];

                    aux.Compania = new Marcas();
                    aux.Compania.Id = (int)datos.Lector["IdMarca"];
                    aux.Compania.Descripcion = (string)datos.Lector["DescMarca"];

                    aux.Tipo = new Categorias();
                    aux.Tipo.Id = (int)datos.Lector["IdCategoria"];
                    aux.Tipo.Descripcion = (string)datos.Lector["DescCategoria"];

                    lista.Add(aux);
                }

                return lista;
            }
            catch (Exception ex)
            {
                //Debug.WriteLine("Error: " + ex.Message);
                //Debug.WriteLine("StackTrace: " + ex.StackTrace);
                throw;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        private Articulo auxFila(SqlDataReader lector)
        {
            Articulo aux = new Articulo
            {
                Id = (int)lector["Id"],
                Cod = (string)lector["Codigo"],
                Nombre = (string)lector["Nombre"],
                Descripcion = (string)lector["Descripcion"],
                Compania = new Marcas
                {
                    Id = (int)lector["IdMarca"],
                    Descripcion = (string)lector["DescMarca"]
                },
                Tipo = new Categorias
                {
                    Id = (int)lector["IdCategoria"],
                    Descripcion = (string)lector["DescCategoria"]
                },
                Precio = (decimal)lector["Precio"]
            };

            if (!(lector["ImagenUrl"] is DBNull))
                aux.UrlImagen = (string)lector["ImagenUrl"];

            return aux;
        }

        public List<Articulo> listarExcluidos()
        {
            List<Articulo> lista = new List<Articulo>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("select A.Id, Codigo, Nombre, A.Descripcion, M.Descripcion DescMarca, C.Descripcion DescCategoria, ImagenUrl, A.IdMarca, A.IdCategoria, Precio from ARTICULOS A, MARCAS M, CATEGORIAS C where A.IdMarca = M.Id and  A.IdCategoria= C.ID and Nombre is not null and Codigo LIKE '#%'");
                datos.ejecutarLectura();
                while (datos.Lector.Read())
                    lista.Add(auxFila(datos.Lector));

                return lista;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public void agregarConSP(Articulo artic)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearProcedimiento("storedAltaArticulo");
                datos.setearParametro("@Codigo", artic.Cod);
                datos.setearParametro("@Nombre", artic.Nombre);
                datos.setearParametro("@Descripcion", artic.Descripcion);
                datos.setearParametro("@IdMarca", artic.Compania.Id);
                datos.setearParametro("@IdCategoria", artic.Tipo.Id);
                datos.setearParametro("@ImagenUrl", artic.UrlImagen);
                datos.setearParametro("@Precio", artic.Precio);
                datos.ejecutarAccion();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
                //Console.WriteLine($"Consulta generada: insert into DISCOS (Titulo, FechaLanzamiento, CantidadCanciones) values ('{nuevo.Nombre}', '{nuevo.Cod}', {nuevo.Descripcion})");
            }
        }


        public void modificarConSP(Articulo artic)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearProcedimiento("storedModificar");
                datos.setearParametro("@Id", artic.Id);
                datos.setearParametro("@Codigo", artic.Cod);
                datos.setearParametro("@Nombre", artic.Nombre);
                datos.setearParametro("@Descripcion", artic.Descripcion);
                Debug.WriteLine("IdMarca en modificarConSP: " + artic.Compania.Id);
                Debug.WriteLine("IdMarca: " + artic.Compania.Id);
                Debug.WriteLine("IdCategoria: " + artic.Tipo.Id);

                datos.setearParametro("@IdMarca", artic.Compania.Id);
                datos.setearParametro("@IdCategoria", artic.Tipo.Id);
                datos.setearParametro("@ImagenUrl", artic.UrlImagen);
                datos.setearParametro("@Precio", artic.Precio);
                datos.ejecutarAccion();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public void eliminarLogico(int id)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("update ARTICULOS set Codigo = '#' + Codigo where Id = @Id");
                datos.setearParametro("@Id", id);
                datos.ejecutarAccion();
            }
            catch (Exception ex)
            {
                throw;
            }
        }

        public void restaurarEliminado(int id)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("update ARTICULOS set Codigo = REPLACE(Codigo, '#', '') where Codigo LIKE '#%' AND Id = @Id");
                datos.setearParametro("@Id", id);
                datos.ejecutarAccion();
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }


        public List<Articulo> filtrar(string columna, string criterio, string filtro, string codigo)
        {
            List<Articulo> lista = new List<Articulo>();
            AccesoDatos datos = new AccesoDatos();
            Console.WriteLine("Dentro de metodo filtrar");
            try
            {
                string consulta = "select A.Id, Codigo, Nombre, A.Descripcion, M.Descripcion DescMarca, C.Descripcion DescCategoria, ImagenUrl, A.IdMarca, A.IdCategoria, Precio from ARTICULOS A, MARCAS M, CATEGORIAS C where A.IdMarca = M.Id and  A.IdCategoria = C.Id and Nombre is not null and Codigo IS NOT NULL and Codigo NOT LIKE '#%' AND ";

                if (columna == "Nombre" || columna == "Codigo" || columna == "Marca" || columna == "Categoria" || columna == "Descripcion")
                {
                    if (columna == "Marca")
                    {
                        columna = "M.Descripcion";
                    }
                    else if (columna == "Categoria")
                    {
                        columna = "C.Descripcion";
                    }

                    if (criterio == "Comienza con")
                        consulta += columna + " like '" + filtro + "%'";
                    else if (criterio == "Termina con")
                        consulta += columna + " like '%" + filtro + "'";
                    else
                        consulta += columna + " like '%" + filtro + "%'";

                    Console.WriteLine(consulta);
                }
                else if (columna == "Precio")
                {
                    if (criterio == "Mayor a")
                        consulta += "Precio > " + filtro;
                    else if (criterio == "Menor a")
                        consulta += "Precio < " + filtro;
                    else
                        consulta += "Precio = " + filtro;
                }

                Console.WriteLine("SQL " + consulta);
                datos.setearConsulta(consulta);
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                    lista.Add(auxFila(datos.Lector));

                return lista;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public Articulo buscarId(int id)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("select A.Id, Codigo, Nombre, A.Descripcion, M.Descripcion DescMarca, C.Descripcion DescCategoria, ImagenUrl, A.IdMarca, A.IdCategoria, Precio from ARTICULOS A, MARCAS M, CATEGORIAS C where A.IdMarca = M.Id and  A.IdCategoria= C.ID and Nombre is not null and Codigo NOT LIKE '#%' and A.Id = @Id");
                datos.setearParametro("@Id", id);
                datos.ejecutarLectura();
                if (datos.Lector.Read())
                {
                    return auxFila(datos.Lector);
                }
                else
                {
                    return null;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<Articulo> filtrarPorMarcasYTipos(List<int> idsMarcas, List<int> idsTipos)
        {
            List<Articulo> lista = new List<Articulo>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                List<string> condiciones = new List<string>();

                if (idsMarcas.Count > 0)
                {
                    string marcas = string.Join(",", idsMarcas.Select((id, i) => "@m" + i));
                    condiciones.Add("A.IdMarca IN (" + marcas + ")");
                }

                if (idsTipos.Count > 0)
                {
                    string tipos = string.Join(",", idsTipos.Select((id, i) => "@t" + i));
                    condiciones.Add("A.IdCategoria IN (" + tipos + ")");
                }

                string where = condiciones.Count > 0 ? "WHERE " + string.Join(" AND ", condiciones) : "";

                string consulta = $@"
            SELECT A.Id, Codigo, Nombre, A.Descripcion, M.Descripcion DescMarca, C.Descripcion DescCategoria,
                   ImagenUrl, A.IdMarca, A.IdCategoria, Precio
            FROM ARTICULOS A
            INNER JOIN MARCAS M ON A.IdMarca = M.Id
            INNER JOIN CATEGORIAS C ON A.IdCategoria = C.Id
            {where}
              AND Nombre IS NOT NULL
              AND Codigo IS NOT NULL
              AND Codigo NOT LIKE '#%'";

                datos.setearConsulta(consulta);

                for (int i = 0; i < idsMarcas.Count; i++)
                    datos.setearParametro("@m" + i, idsMarcas[i]);

                for (int i = 0; i < idsTipos.Count; i++)
                    datos.setearParametro("@t" + i, idsTipos[i]);

                datos.ejecutarLectura();

                while (datos.Lector.Read())
                    lista.Add(auxFila(datos.Lector));

                return lista;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public List<Articulo> buscarPorNombre(string nombre)
        {
            List<Articulo> lista = new List<Articulo>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                string consulta = @"
            SELECT A.Id, Codigo, Nombre, A.Descripcion, M.Descripcion DescMarca, C.Descripcion DescCategoria,
                   ImagenUrl, A.IdMarca, A.IdCategoria, Precio
            FROM ARTICULOS A
            INNER JOIN MARCAS M ON A.IdMarca = M.Id
            INNER JOIN CATEGORIAS C ON A.IdCategoria = C.Id
            WHERE LOWER(A.Nombre) LIKE LOWER(@nombre)
              AND A.Nombre IS NOT NULL
              AND A.Codigo IS NOT NULL
              AND A.Codigo NOT LIKE '#%'";

                datos.setearConsulta(consulta);
                datos.setearParametro("@nombre", "%" + nombre.ToLower() + "%");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                    lista.Add(auxFila(datos.Lector));

                return lista;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

    }
}

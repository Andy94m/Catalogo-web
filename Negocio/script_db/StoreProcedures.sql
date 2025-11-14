--agregar usuario
USE [CATALOGO_WEB_DB]
GO

/****** Object:  StoredProcedure [dbo].[spAgregarUsuario]    Script Date: 14/11/2025 00:53:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spAgregarUsuario]
    @Nombre VARCHAR(50),
    @Apellido VARCHAR(50),
    @Email VARCHAR(100),
    @Pass VARCHAR(20),
    @Admin BIT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO USERS (nombre, apellido, email, pass, admin)
    VALUES (@Nombre, @Apellido, @Email, @Pass, @Admin);

    SELECT SCOPE_IDENTITY() AS Id;
END
GO

--validar usuario
USE [CATALOGO_WEB_DB]
GO

/****** Object:  StoredProcedure [dbo].[spValidarUsuario]    Script Date: 14/11/2025 00:54:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spValidarUsuario]
@Email varchar(50),
@Password varchar(100)
as
begin
	SELECT id, email, pass, nombre, apellido, UrlImagenPerfil, admin
	FROM USERS 
	WHERE email = @Email AND pass = @Password
END
GO


--alta articulo
USE [CATALOGO_WEB_DB]
GO

/****** Object:  StoredProcedure [dbo].[storedAltaArticulo]    Script Date: 14/11/2025 00:54:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[storedAltaArticulo]
@Codigo varchar (10),
@Nombre varchar(100),
@Descripcion varchar(100),
@IdMarca int,
@IdCategoria int,
@ImagenUrl varchar(300),
@Precio money
as
insert into ARTICULOS (Codigo, Nombre, Descripcion, IdMarca, IdCategoria, ImagenUrl, Precio) 
values (@Codigo, @Nombre, @Descripcion, @IdMarca, @IdCategoria, @ImagenUrl, @Precio)
GO


--listar
USE [CATALOGO_WEB_DB]
GO

/****** Object:  StoredProcedure [dbo].[storedListar]    Script Date: 14/11/2025 00:54:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[storedListar] as
SELECT  A.Id, Codigo, Nombre, 
A.Descripcion, M.Descripcion DescMarca, 
C.Descripcion DescCategoria,
ImagenUrl, 
A.IdMarca, 
A.IdCategoria, 
Precio 
from ARTICULOS A, MARCAS M, CATEGORIAS C 
where A.IdMarca = M.Id 
and  A.IdCategoria= C.ID 
and Nombre is not null 
and Codigo NOT LIKE '#%'
GO


--modificar
USE [CATALOGO_WEB_DB]
GO

/****** Object:  StoredProcedure [dbo].[storedModificar]    Script Date: 14/11/2025 00:54:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[storedModificar]
@Id int,
@Codigo varchar(10),
@Nombre varchar(100),
@Descripcion varchar(100),
@IdMarca int,
@IdCategoria int,
@ImagenUrl varchar(300),
@Precio money
as
update ARTICULOS 
set 
Codigo = @Codigo,
Nombre = @Nombre,
Descripcion = @Descripcion,
IdMarca = @IdMarca,
IdCategoria = @IdCategoria,
ImagenUrl = @ImagenUrl, 
Precio = @Precio 
where Id = @Id
GO


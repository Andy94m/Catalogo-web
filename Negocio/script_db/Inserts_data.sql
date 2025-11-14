USE [CATALOGO_WEB_DB]
GO
/****** Object:  Table [dbo].[ARTICULOS]    Script Date: 14/11/2025 01:05:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARTICULOS](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Codigo] [varchar](50) NULL,
	[Nombre] [varchar](50) NULL,
	[Descripcion] [varchar](150) NULL,
	[IdMarca] [int] NULL,
	[IdCategoria] [int] NULL,
	[ImagenUrl] [varchar](1000) NULL,
	[Precio] [money] NULL,
 CONSTRAINT [PK_ARTICULOS] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CATEGORIAS]    Script Date: 14/11/2025 01:05:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CATEGORIAS](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](50) NULL,
 CONSTRAINT [PK_CATEGORIAS] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FAVORITOS]    Script Date: 14/11/2025 01:05:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FAVORITOS](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdUser] [int] NOT NULL,
	[IdArticulo] [int] NOT NULL,
 CONSTRAINT [PK_Favoritos] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MARCAS]    Script Date: 14/11/2025 01:05:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MARCAS](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](50) NULL,
 CONSTRAINT [PK_MARCAS] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[USERS]    Script Date: 14/11/2025 01:05:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[USERS](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[email] [varchar](100) NOT NULL,
	[pass] [varchar](20) NOT NULL,
	[nombre] [varchar](50) NULL,
	[apellido] [varchar](50) NULL,
	[urlImagenPerfil] [varchar](500) NULL,
	[admin] [bit] NOT NULL,
 CONSTRAINT [PK_USERS] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[ARTICULOS] ON 
GO
INSERT [dbo].[ARTICULOS] ([Id], [Codigo], [Nombre], [Descripcion], [IdMarca], [IdCategoria], [ImagenUrl], [Precio]) VALUES (1, N'S0111112', N'Galaxy S10112', N'Una canoa cara edit02 admin administrador 05', 4, 4, N'https://images.samsung.com/is/image/samsung/assets/ar/p6_gro2/p6_initial_mktpd/smartphones/galaxy-s10/specs/galaxy-s10-plus_specs_design_colors_prism_black.jpg?$163_346_PNG$', 90.0000)
GO
INSERT [dbo].[ARTICULOS] ([Id], [Codigo], [Nombre], [Descripcion], [IdMarca], [IdCategoria], [ImagenUrl], [Precio]) VALUES (2, N'M03', N'Moto G Play 7ma Gen', N'Ya siete de estos?', 5, 1, N'https://www.motorola.cl/arquivos/moto-g7-play-img-product.png?v=636862863804700000', 15699.0000)
GO
INSERT [dbo].[ARTICULOS] ([Id], [Codigo], [Nombre], [Descripcion], [IdMarca], [IdCategoria], [ImagenUrl], [Precio]) VALUES (3, N'S99', N'Play 4', N'Ya no se cuantas versiones hay', 3, 3, N'sin_imagen_para_que_de_error....muejeje', 35000.0000)
GO
INSERT [dbo].[ARTICULOS] ([Id], [Codigo], [Nombre], [Descripcion], [IdMarca], [IdCategoria], [ImagenUrl], [Precio]) VALUES (4, N'S56', N'Bravia 55', N'Alta tele', 3, 2, N'https://intercompras.com/product_thumb_keepratio_2.php?img=images/product/SONY_KDL-55W950A.jpg&w=650&h=450', 49500.0000)
GO
INSERT [dbo].[ARTICULOS] ([Id], [Codigo], [Nombre], [Descripcion], [IdMarca], [IdCategoria], [ImagenUrl], [Precio]) VALUES (5, N'A23', N'Apple TV', N'lindo loro', 2, 3, N'https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/rfb-apple-tv-4k?wid=1144&hei=1144&fmt=jpeg&qlt=80&.v=1513897159574', 7850.0000)
GO
INSERT [dbo].[ARTICULOS] ([Id], [Codigo], [Nombre], [Descripcion], [IdMarca], [IdCategoria], [ImagenUrl], [Precio]) VALUES (6, N'S02', N'Samsung Galaxy A54', N'Celular con pantalla Super AMOLED 120Hz', 1, 1, N'https://images.samsung.com/is/image/samsung/p6pim/ar/sm-a546ezkearo/gallery/ar-galaxy-a54-5g-sm-a546-sm-a546ezkearo-534192225', 289999.0000)
GO
INSERT [dbo].[ARTICULOS] ([Id], [Codigo], [Nombre], [Descripcion], [IdMarca], [IdCategoria], [ImagenUrl], [Precio]) VALUES (7, N'A01', N'iPhone 13', N'Smartphone Apple con chip A15 Bionic', 2, 1, N'https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/iphone-13-model-unselect-gallery-1-202207?wid=5120&hei=2880&fmt=jpeg&qlt=80&.v=1654893618126', 799999.0000)
GO
INSERT [dbo].[ARTICULOS] ([Id], [Codigo], [Nombre], [Descripcion], [IdMarca], [IdCategoria], [ImagenUrl], [Precio]) VALUES (8, N'S57', N'Sony Bravia XR 65"', N'Televisor 4K HDR con Google TV', 3, 2, N'https://www.sony.com/image/sonyview/65xr65a80k.jpg', 649999.0000)
GO
INSERT [dbo].[ARTICULOS] ([Id], [Codigo], [Nombre], [Descripcion], [IdMarca], [IdCategoria], [ImagenUrl], [Precio]) VALUES (9, N'H01', N'Huawei P30 Pro', N'Cámara Leica y zoom óptico 5x', 4, 1, N'https://consumer.huawei.com/content/dam/huawei-cbg-site/common/mkt/pdp/phones/p30-pro/img/kv-phone.png', 199999.0000)
GO
INSERT [dbo].[ARTICULOS] ([Id], [Codigo], [Nombre], [Descripcion], [IdMarca], [IdCategoria], [ImagenUrl], [Precio]) VALUES (10, N'M04', N'Motorola Edge 30', N'Pantalla OLED 144Hz y Snapdragon 778G+', 5, 1, N'https://motorolaus.vtexassets.com/arquivos/ids/158728-800-auto?v=638104304012000000&width=800&height=auto&aspect=true', 239999.0000)
GO
INSERT [dbo].[ARTICULOS] ([Id], [Codigo], [Nombre], [Descripcion], [IdMarca], [IdCategoria], [ImagenUrl], [Precio]) VALUES (11, N'S88', N'Sony WH-1000XM5', N'Auriculares inalámbricos con cancelación de ruido', 3, 4, N'https://www.sony.com/image/sonyview/wh1000xm5-black.jpg', 189999.0000)
GO
INSERT [dbo].[ARTICULOS] ([Id], [Codigo], [Nombre], [Descripcion], [IdMarca], [IdCategoria], [ImagenUrl], [Precio]) VALUES (12, N'A11', N'Apple AirPods Pro 2da Gen', N'Auriculares con cancelación activa y estuche MagSafe', 2, 4, N'https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/MQD83?wid=2000&hei=2000&fmt=jpeg&qlt=80&.v=1660803972361', 139999.0000)
GO
INSERT [dbo].[ARTICULOS] ([Id], [Codigo], [Nombre], [Descripcion], [IdMarca], [IdCategoria], [ImagenUrl], [Precio]) VALUES (13, N'H02', N'Huawei FreeBuds 5i', N'Auriculares TWS con ANC', 4, 4, N'https://consumer.huawei.com/content/dam/huawei-cbg-site/common/mkt/pdp/audio/freebuds-5i/images/freebuds-5i-kv.png', 59999.0000)
GO
INSERT [dbo].[ARTICULOS] ([Id], [Codigo], [Nombre], [Descripcion], [IdMarca], [IdCategoria], [ImagenUrl], [Precio]) VALUES (14, N'M05', N'Moto G73 5G', N'Celular con 8GB RAM y 256GB de almacenamiento', 5, 1, N'https://motorolaus.vtexassets.com/arquivos/ids/158729-800-auto?v=638104304012000000&width=800&height=auto&aspect=true', 189999.0000)
GO
INSERT [dbo].[ARTICULOS] ([Id], [Codigo], [Nombre], [Descripcion], [IdMarca], [IdCategoria], [ImagenUrl], [Precio]) VALUES (15, N'S03', N'Samsung QLED Q60C 50"', N'Televisor 4K Smart TV con Quantum Dot', 1, 2, N'https://images.samsung.com/is/image/samsung/p6pim/ar/qn50q60cagczb/gallery/ar-qled-q60c-qn50q60cagczb-535312792', 429999.0000)
GO
INSERT [dbo].[ARTICULOS] ([Id], [Codigo], [Nombre], [Descripcion], [IdMarca], [IdCategoria], [ImagenUrl], [Precio]) VALUES (16, N'A24', N'Apple TV 4K (3ra Gen)', N'Streaming en 4K HDR con Siri Remote', 2, 3, N'https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/apple-tv-4k-select-202210?wid=2000&hei=2000&fmt=jpeg&qlt=80&.v=1664896363201', 99999.0000)
GO
INSERT [dbo].[ARTICULOS] ([Id], [Codigo], [Nombre], [Descripcion], [IdMarca], [IdCategoria], [ImagenUrl], [Precio]) VALUES (17, N'S98', N'Sony PS5 Digital Edition', N'Consola de videojuegos sin lector de discos', 3, 3, N'https://www.sony.com/image/sonyview/ps5-digital.jpg', 499999.0000)
GO
INSERT [dbo].[ARTICULOS] ([Id], [Codigo], [Nombre], [Descripcion], [IdMarca], [IdCategoria], [ImagenUrl], [Precio]) VALUES (18, N'H03', N'Huawei Vision S 65"', N'Smart TV con cámara magnética y HarmonyOS', 4, 2, N'https://consumer.huawei.com/content/dam/huawei-cbg-site/common/mkt/pdp/tv/vision-s/images/vision-s-kv.png', 399999.0000)
GO
INSERT [dbo].[ARTICULOS] ([Id], [Codigo], [Nombre], [Descripcion], [IdMarca], [IdCategoria], [ImagenUrl], [Precio]) VALUES (19, N'M06', N'Motorola VerveBuds 120', N'Auriculares Bluetooth resistentes al agua', 5, 4, N'https://motorolaus.vtexassets.com/arquivos/ids/158730-800-auto?v=638104304012000000&width=800&height=auto&aspect=true', 29999.0000)
GO
INSERT [dbo].[ARTICULOS] ([Id], [Codigo], [Nombre], [Descripcion], [IdMarca], [IdCategoria], [ImagenUrl], [Precio]) VALUES (20, N'S04', N'Samsung Galaxy Buds2 Pro', N'Auriculares con audio Hi-Fi y ANC', 1, 4, N'https://images.samsung.com/is/image/samsung/p6pim/ar/galaxy-buds2-pro-r510/gallery/ar-galaxy-buds2-pro-r510-sm-r510nzkearo-533711382', 119999.0000)
GO
INSERT [dbo].[ARTICULOS] ([Id], [Codigo], [Nombre], [Descripcion], [IdMarca], [IdCategoria], [ImagenUrl], [Precio]) VALUES (21, N'S05', N'Samsung Galaxy S23 Ultra', N'Celular con cámara de 200MP y S-Pen', 1, 1, N'https://images.samsung.com/is/image/samsung/p6pim/ar/sm-s918bzkearo/gallery/ar-galaxy-s23-ultra-sm-s918-534312-ar-gallery-1', 849999.0000)
GO
INSERT [dbo].[ARTICULOS] ([Id], [Codigo], [Nombre], [Descripcion], [IdMarca], [IdCategoria], [ImagenUrl], [Precio]) VALUES (22, N'A02', N'iPhone 15 Pro Max', N'Titanio, chip A17 Pro, cámara 5x', 2, 1, N'https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/iphone-15-pro-max-finish-select-202309?wid=5120&hei=2880&fmt=jpeg&qlt=80&.v=1692912930429', 999999.0000)
GO
INSERT [dbo].[ARTICULOS] ([Id], [Codigo], [Nombre], [Descripcion], [IdMarca], [IdCategoria], [ImagenUrl], [Precio]) VALUES (23, N'S58', N'Sony Bravia X90K 75"', N'Televisor 4K con Full Array LED', 3, 2, N'https://www.sony.com/image/sonyview/x90k-75inch.jpg', 799999.0000)
GO
INSERT [dbo].[ARTICULOS] ([Id], [Codigo], [Nombre], [Descripcion], [IdMarca], [IdCategoria], [ImagenUrl], [Precio]) VALUES (24, N'H04', N'Huawei Mate 50 Pro', N'Celular con XMAGE y pantalla curva', 4, 1, N'https://consumer.huawei.com/content/dam/huawei-cbg-site/common/mkt/pdp/phones/mate50-pro/images/mate50-pro-kv.png', 699999.0000)
GO
INSERT [dbo].[ARTICULOS] ([Id], [Codigo], [Nombre], [Descripcion], [IdMarca], [IdCategoria], [ImagenUrl], [Precio]) VALUES (25, N'M07', N'Motorola Razr 40 Ultra', N'Celular plegable con pantalla externa OLED', 5, 1, N'https://motorolaus.vtexassets.com/arquivos/ids/158731-800-auto?v=638104304012000000&width=800&height=auto&aspect=true', 749999.0000)
GO
INSERT [dbo].[ARTICULOS] ([Id], [Codigo], [Nombre], [Descripcion], [IdMarca], [IdCategoria], [ImagenUrl], [Precio]) VALUES (26, N'S89', N'Sony WH-CH720N', N'Auriculares con cancelación de ruido y Bluetooth', 3, 4, N'https://www.sony.com/image/sonyview/whch720n-black.jpg', 89999.0000)
GO
INSERT [dbo].[ARTICULOS] ([Id], [Codigo], [Nombre], [Descripcion], [IdMarca], [IdCategoria], [ImagenUrl], [Precio]) VALUES (27, N'A12', N'Apple HomePod Mini', N'Altavoz inteligente con Siri', 2, 4, N'https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/homepod-mini-select-202010?wid=2000&hei=2000&fmt=jpeg&qlt=80&.v=1601833131000', 49999.0000)
GO
INSERT [dbo].[ARTICULOS] ([Id], [Codigo], [Nombre], [Descripcion], [IdMarca], [IdCategoria], [ImagenUrl], [Precio]) VALUES (28, N'H05', N'Huawei Sound Joy', N'Altavoz portátil con Devialet y batería de 26h', 4, 4, N'https://consumer.huawei.com/content/dam/huawei-cbg-site/common/mkt/pdp/audio/sound-joy/images/sound-joy-kv.png', 59999.0000)
GO
INSERT [dbo].[ARTICULOS] ([Id], [Codigo], [Nombre], [Descripcion], [IdMarca], [IdCategoria], [ImagenUrl], [Precio]) VALUES (29, N'M08', N'Moto G100', N'Celular con Snapdragon 870 y Ready For', 5, 1, N'https://motorolaus.vtexassets.com/arquivos/ids/158732-800-auto?v=638104304012000000&width=800&height=auto&aspect=true', 289999.0000)
GO
INSERT [dbo].[ARTICULOS] ([Id], [Codigo], [Nombre], [Descripcion], [IdMarca], [IdCategoria], [ImagenUrl], [Precio]) VALUES (30, N'S06', N'Samsung Neo QLED QN90C 65"', N'Televisor 4K con Mini LED y HDR10+', 1, 2, N'https://images.samsung.com/is/image/samsung/p6pim/ar/qn65qn90cagczb/gallery/ar-qled-qn90c-qn65qn90cagczb-535312792', 699999.0000)
GO
INSERT [dbo].[ARTICULOS] ([Id], [Codigo], [Nombre], [Descripcion], [IdMarca], [IdCategoria], [ImagenUrl], [Precio]) VALUES (31, N'A25', N'Apple TV 4K Wi-Fi + Ethernet', N'Streaming 4K con más conectividad', 2, 3, N'https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/apple-tv-4k-select-202210?wid=2000&hei=2000&fmt=jpeg&qlt=80&.v=1664896363201', 109999.0000)
GO
INSERT [dbo].[ARTICULOS] ([Id], [Codigo], [Nombre], [Descripcion], [IdMarca], [IdCategoria], [ImagenUrl], [Precio]) VALUES (32, N'S100', N'Sony PS5 Slim', N'Consola de videojuegos más compacta', 3, 3, N'https://www.sony.com/image/sonyview/ps5-slim.jpg', 529999.0000)
GO
INSERT [dbo].[ARTICULOS] ([Id], [Codigo], [Nombre], [Descripcion], [IdMarca], [IdCategoria], [ImagenUrl], [Precio]) VALUES (33, N'H06', N'Huawei Vision S 75"', N'Smart TV con cámara y HarmonyOS', 4, 2, N'https://consumer.huawei.com/content/dam/huawei-cbg-site/common/mkt/pdp/tv/vision-s/images/vision-s-kv.png', 499999.0000)
GO
INSERT [dbo].[ARTICULOS] ([Id], [Codigo], [Nombre], [Descripcion], [IdMarca], [IdCategoria], [ImagenUrl], [Precio]) VALUES (34, N'M09', N'Motorola Moto Buds 600 ANC', N'Auriculares con cancelación activa y carga inalámbrica', 5, 4, N'https://motorolaus.vtexassets.com/arquivos/ids/158733-800-auto?v=638104304012000000&width=800&height=auto&aspect=true', 49999.0000)
GO
INSERT [dbo].[ARTICULOS] ([Id], [Codigo], [Nombre], [Descripcion], [IdMarca], [IdCategoria], [ImagenUrl], [Precio]) VALUES (35, N'S07', N'Samsung Galaxy Buds FE', N'Auriculares con diseño ergonómico y ANC', 1, 4, N'https://images.samsung.com/is/image/samsung/p6pim/ar/galaxy-buds-fe-r400/gallery/ar-galaxy-buds-fe-r400-sm-r400nzkearo-537711382', 69999.0000)
GO
INSERT [dbo].[ARTICULOS] ([Id], [Codigo], [Nombre], [Descripcion], [IdMarca], [IdCategoria], [ImagenUrl], [Precio]) VALUES (36, N'A03', N'iPhone SE (3ra Gen)', N'Celular compacto con chip A15 Bionic', 2, 1, N'https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/iphone-se-finish-select-202207?wid=5120&hei=2880&fmt=jpeg&qlt=80&.v=1654893618126', 299999.0000)
GO
INSERT [dbo].[ARTICULOS] ([Id], [Codigo], [Nombre], [Descripcion], [IdMarca], [IdCategoria], [ImagenUrl], [Precio]) VALUES (37, N'S59', N'Sony Bravia A80K 55"', N'Televisor OLED con Dolby Vision', 3, 2, N'https://www.sony.com/image/sonyview/a80k-55inch.jpg', 599999.0000)
GO
INSERT [dbo].[ARTICULOS] ([Id], [Codigo], [Nombre], [Descripcion], [IdMarca], [IdCategoria], [ImagenUrl], [Precio]) VALUES (38, N'H07', N'Huawei Nova 11 Pro', N'Celular con cámara frontal dual y carga rápida', 4, 1, N'https://consumer.huawei.com/content/dam/huawei-cbg-site/common/mkt/pdp/phones/nova11-pro/images/nova11-pro-kv.png', 349999.0000)
GO
INSERT [dbo].[ARTICULOS] ([Id], [Codigo], [Nombre], [Descripcion], [IdMarca], [IdCategoria], [ImagenUrl], [Precio]) VALUES (39, N'M10', N'Motorola Edge 40 Neo', N'Celular con pantalla pOLED y carga rápida 68W', 5, 1, N'https://motorolaus.vtexassets.com/arquivos/ids/158734-800-auto?v=638104304012000000&width=800&height=auto&aspect=true', 319999.0000)
GO
INSERT [dbo].[ARTICULOS] ([Id], [Codigo], [Nombre], [Descripcion], [IdMarca], [IdCategoria], [ImagenUrl], [Precio]) VALUES (40, N'cod', N'prueba', N'holaaaa prueba', 1, 1, N'imgendeprueba.com', 400000.0000)
GO
INSERT [dbo].[ARTICULOS] ([Id], [Codigo], [Nombre], [Descripcion], [IdMarca], [IdCategoria], [ImagenUrl], [Precio]) VALUES (41, N'#adasd', N'prueba2', N'hola prueba2', 1, 1, N'', 123232.0000)
GO
INSERT [dbo].[ARTICULOS] ([Id], [Codigo], [Nombre], [Descripcion], [IdMarca], [IdCategoria], [ImagenUrl], [Precio]) VALUES (42, N'#aaaarpeuab', N'Poke123?', N'asdasd', 5, 3, N'', 49500.0000)
GO
SET IDENTITY_INSERT [dbo].[ARTICULOS] OFF
GO
SET IDENTITY_INSERT [dbo].[CATEGORIAS] ON 
GO
INSERT [dbo].[CATEGORIAS] ([Id], [Descripcion]) VALUES (1, N'Celulares')
GO
INSERT [dbo].[CATEGORIAS] ([Id], [Descripcion]) VALUES (2, N'Televisores')
GO
INSERT [dbo].[CATEGORIAS] ([Id], [Descripcion]) VALUES (3, N'Media')
GO
INSERT [dbo].[CATEGORIAS] ([Id], [Descripcion]) VALUES (4, N'Audio')
GO
SET IDENTITY_INSERT [dbo].[CATEGORIAS] OFF
GO
SET IDENTITY_INSERT [dbo].[MARCAS] ON 
GO
INSERT [dbo].[MARCAS] ([Id], [Descripcion]) VALUES (1, N'Samsung')
GO
INSERT [dbo].[MARCAS] ([Id], [Descripcion]) VALUES (2, N'Apple')
GO
INSERT [dbo].[MARCAS] ([Id], [Descripcion]) VALUES (3, N'Sony')
GO
INSERT [dbo].[MARCAS] ([Id], [Descripcion]) VALUES (4, N'Huawei')
GO
INSERT [dbo].[MARCAS] ([Id], [Descripcion]) VALUES (5, N'Motorola')
GO
SET IDENTITY_INSERT [dbo].[MARCAS] OFF
GO
SET IDENTITY_INSERT [dbo].[USERS] ON 
GO
INSERT [dbo].[USERS] ([Id], [email], [pass], [nombre], [apellido], [urlImagenPerfil], [admin]) VALUES (1, N'admin@admin.com', N'admin', N'administrador', N'jefe de admin', N'', 1)
GO
INSERT [dbo].[USERS] ([Id], [email], [pass], [nombre], [apellido], [urlImagenPerfil], [admin]) VALUES (2, N'user@user.com', N'user', N'usuarioPrueba', N'Anonimo', N'', 0)
GO
INSERT [dbo].[USERS] ([Id], [email], [pass], [nombre], [apellido], [urlImagenPerfil], [admin]) VALUES (3, N'm.andresmontes@gmail.com', N'adolfo', N'Andrés', N'Montes', NULL, 0)
GO
SET IDENTITY_INSERT [dbo].[USERS] OFF
GO
ALTER TABLE [dbo].[USERS] ADD  DEFAULT ((0)) FOR [admin]
GO
ALTER TABLE [dbo].[ARTICULOS]  WITH CHECK ADD  CONSTRAINT [FK_Articulos_Categoria] FOREIGN KEY([IdCategoria])
REFERENCES [dbo].[CATEGORIAS] ([Id])
GO
ALTER TABLE [dbo].[ARTICULOS] CHECK CONSTRAINT [FK_Articulos_Categoria]
GO
ALTER TABLE [dbo].[ARTICULOS]  WITH CHECK ADD  CONSTRAINT [FK_Articulos_Marcas] FOREIGN KEY([IdMarca])
REFERENCES [dbo].[MARCAS] ([Id])
GO
ALTER TABLE [dbo].[ARTICULOS] CHECK CONSTRAINT [FK_Articulos_Marcas]
GO
ALTER TABLE [dbo].[FAVORITOS]  WITH CHECK ADD  CONSTRAINT [FK_Favoritos_Articulos] FOREIGN KEY([IdArticulo])
REFERENCES [dbo].[ARTICULOS] ([Id])
GO
ALTER TABLE [dbo].[FAVORITOS] CHECK CONSTRAINT [FK_Favoritos_Articulos]
GO
ALTER TABLE [dbo].[FAVORITOS]  WITH CHECK ADD  CONSTRAINT [FK_Favoritos_User] FOREIGN KEY([IdUser])
REFERENCES [dbo].[USERS] ([Id])
GO
ALTER TABLE [dbo].[FAVORITOS] CHECK CONSTRAINT [FK_Favoritos_User]
GO

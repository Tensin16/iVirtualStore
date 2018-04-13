--
--TABLA: DIRECCION FACTURACION
--

CREATE TABLE DIRECCION_FAC(
	DIRECCION_FAC_ID NUMBER(5,0)		NOT NULL,
	CALLE 				VARCHAR2(30)	NOT NULL,
	NUM_INTERIOR NUMBER(4,0),
	NUM_EXTERIOR 		NUMBER(4,0)		NOT NULL,
	COLONIA 			VARCHAR2(30)	NOT NULL,
	CP NUMBER(5,0)		NOT NULL,
	MUNICIPIO VARCHAR2(30)	NOT NULL,
	ESTADO VARCHAR2(30)	NOT NULL,
	CONSTRAINT DIRECCION_FAC_ID_PK PRIMARY KEY(DIRECCION_FAC_ID)
);

--
--TABLA: DIRECCION ENTREGA
--

CREATE TABLE DIRECCION_ENT(
	DIRECCION_ENT_ID NUMBER(5,0)		NOT NULL,
	CALLE VARCHAR2(30)	NOT NULL,
	NUM_INTERIOR NUMBER(4,0),
	NUM_EXTERIOR NUMBER(4,0)		NOT NULL,
	COLONIA VARCHAR2(30)	NOT NULL,
	CP NUMBER(5,0)		NOT NULL,
	MUNICIPIO VARCHAR2(30)	NOT NULL,
	ESTADO VARCHAR2(30)	NOT NULL,
	CONSTRAINT DIRECCION_ENT_ID_PK PRIMARY KEY(DIRECCION_ENT_ID)
);

-- 
-- TABLE: CLIENTE 
--

	CREATE TABLE CLIENTE(
	   CLIENTE_ID 		NUMBER(5,0)			NOT NULL,
	   DIRECCION_FAC_ID    NUMBER(5, 0)     NOT NULL,
	   DIRECCION_ENT_ID    NUMBER(5, 0)     NOT NULL,
	   NOMBRE 			VARCHAR2(50)		NOT NULL,
	   APELLIDO_PAT 	VARCHAR2(50)		NOT NULL,
	   APELLIDO_MAT VARCHAR2(50)		NOT NULL,
	   USUARIO 			VARCHAR2(20)		NOT NULL,
	   PASSWD 			VARCHAR2(10)		NOT NULL,
	   RFC 				VARCHAR2(10),
	   CORREO_ELEC 		VARCHAR2(30)		NOT NULL,
	   NUMERO 			NUMBER(10,0)		NOT NULL,
	   CONSTRAINT PK_CL PRIMARY KEY (CLIENTE_ID),
	   CONSTRAINT FK_D_FAC FOREIGN KEY (DIRECCION_FAC_ID)
	   REFERENCES DIRECCION_FAC(DIRECCION_FAC_ID),
	   CONSTRAINT FK_D_ENT FOREIGN KEY (DIRECCION_ENT_ID)
	   REFERENCES DIRECCION_ENT(DIRECCION_ENT_ID),
	   CONSTRAINT RFC_UQ UNIQUE (RFC)
	)
	;

--
-- TABLA: TARJETA DE CREDITO
--
CREATE TABLE TARJETA_CREDITO(
	BANCO VARCHAR2(30)	NOT NULL,
	TITULAR VARCHAR2(30)	NOT NULL,
	NUM_TARJETA NUMBER(10,0) NOT NULL,
	TIPO_TARJETA VARCHAR(30) NOT NULL,
	MES_VENC DATE NOT NULL,
	ANIO_VENC DATE NOT NULL,
	CLIENTE_ID NUMBER(5,0)	NOT NULL,
	CONSTRAINT CLIENTE_ID_FK FOREIGN KEY(CLIENTE_ID)
	REFERENCES CLIENTE(CLIENTE_ID),
	CONSTRAINT NUM_TARJETA_UQ UNIQUE (NUM_TARJETA),
	CONSTRAINT TIPO_TARJETA_CHK CHECK(TIPO_TARJETA IN('AMEX', 'VISA', 'MASTER CARD'))
)
;

--
--TABLA: TRANSFERENCIA BANCARIA
--

CREATE TABLE TRANSFERENCIA(
	BANCO VARCHAR2(30)	NOT NULL,
	TITULAR VARCHAR2(30)	NOT NULL,
	CLABE NUMBER(10,0)	NOT NULL,
	CLIENTE_ID NUMBER(5,0)	NOT NULL,
	CONSTRAINT CLIENTE_ID_FK2 FOREIGN KEY(CLIENTE_ID)
	REFERENCES CLIENTE(CLIENTE_ID)
);

--
--TABLA SEGUIMIENTO
--


CREATE TABLE SEGUIMIENTO(
	SEGUIMIENTO_ID 	NUMBER(5,0)		NOT NULL,
	LUGAR 	VARCHAR2(30) 	NOT NULL,
	FECHA_LLEGADA DATE 		NOT NULL,
	HORA_LLEGADA DATE 		NOT NULL,
	ESCALA NUMBER(2,0)		NOT NULL,
	CONSTRAINT SEGUIMIENTO_ID_PK PRIMARY KEY(SEGUIMIENTO_ID)
)
;

CREATE TABLE ESCALA(
	ESCALA_ID NUMBER(2,0) NOT NULL,
	CATEGORIA VARCHAR2(50) NOT NULL,
	CONSTRAINT ESCALA_ID_PK PRIMARY KEY(ESCALA_ID)
);

--
--TABLA TIPO PRODUCTO
--
CREATE TABLE TIPO_PRODUCTO(
    TIPO_PRODUCTO_ID NUMBER(1,0)   NOT NULL,
   	CATEGORIA VARCHAR2(20) NOT NULL,
   	CONSTRAINT TIPO_PRODUCTO_ID_PK PRIMARY KEY (TIPO_PRODUCTO_ID)
);
--
--TABLA PRODUCTO
--
CREATE TABLE PRODUCTO(
    FOLIO_PRODUCTO    NUMBER(13,0)    NOT NULL,
    TIPO_PRODUCTO_ID  NUMBER(1,0)    NOT NULL,
    PRECIO            NUMBER(5,2)    NOT NULL,
    TMP_DRCION_PRECIO NUMBER(5,0)    NOT NULL,
    COP_VENDIDAS      NUMBER(5,0)    NOT NULL,
    COP_EXISTENCIA    NUMBER(5,0)    NOT NULL,
    COP_DEFECTUOSAS   NUMBER(5,0)    NOT NULL,
    LOTE              NUMBER(5,0)    NOT NULL,
    URL               VARCHAR2(100)  NOT NULL,
    VECES_VISTO       NUMBER(5,0)    NOT NULL,
    CONSTRAINT PK_FOLIO_PRODUCTO PRIMARY KEY (FOLIO_PRODUCTO),
    CONSTRAINT U_PRODUCTO UNIQUE (URL),
    CONSTRAINT FK_TIPO_PRODUCTO_ID FOREIGN KEY (TIPO_PRODUCTO_ID)
    REFERENCES TIPO_PRODUCTO(TIPO_PRODUCTO_ID)
);

--
--TABLA PELICULA
--
CREATE TABLE PELICULA(
    FOLIO_PRODUCTO  NUMBER(13,0)    NOT NULL,
    NOMBRE       VARCHAR2(25)   NOT NULL,
    GENERO       VARCHAR2(20)   NOT NULL,
    DURACION_MIN NUMBER(3,0)    NOT NULL,
    CLASIF VARCHAR2(1)	NOT NULL,
    FORMATO VARCHAR2(10) NOT NULL,
    CONSTRAINT CLASIF_CHK CHECK(CLASIF IN('A', 'B', 'C')),
    CONSTRAINT FORMATO_CHK CHECK(FORMATO IN ('BLU-RAY', 'HD DVD', 'DVD')),
   	CONSTRAINT FOLIO_PRODUCTO_FK1 FOREIGN KEY (FOLIO_PRODUCTO)
   	REFERENCES PRODUCTO(FOLIO_PRODUCTO)
);
--
--TABLA ALBUM
--
CREATE TABLE ALBUM(
    FOLIO_PRODUCTO  NUMBER(13,0)    NOT NULL,
    ARTISTA       VARCHAR2(25)   NOT NULL,
    N_ALBUM       VARCHAR2(25)   NOT NULL,
    ANIO_CREACION DATE           NOT NULL,
    DURACION      NUMBER(3,0)    NOT NULL,
   CONSTRAINT FOLIO_PRODUCTO_FK2 FOREIGN KEY (FOLIO_PRODUCTO)
   	REFERENCES PRODUCTO(FOLIO_PRODUCTO)
);
--
--TABLA VIDEOJUEGO
--
CREATE TABLE VIDEO_JUEGO(
    FOLIO_PRODUCTO  NUMBER(13,0)    NOT NULL,
    NOMBRE         VARCHAR2(25)   NOT NULL,
    T_CONSOLA      VARCHAR2(20)   NOT NULL,
    DESCRIP_INST   VARCHAR2(200)  NOT NULL,
   CONSTRAINT FOLIO_PRODUCTO_FK3 FOREIGN KEY (FOLIO_PRODUCTO)
   	REFERENCES PRODUCTO(FOLIO_PRODUCTO)
);





CREATE TABLE TIPO_ENTREGA(
	TIPO_ENTREGA_ID NUMBER(1,0) NOT NULL,
	CATEGORIA VARCHAR2(20)	NOT NULL,
	CONSTRAINT TIPO_ENTREGA_ID_PK PRIMARY KEY (TIPO_ENTREGA_ID)
);

--
--TABLA ORDEN COMPRA
--	
CREATE TABLE ORDEN_COMPRA(
    FOLIO_COMPRA        NUMBER(10,0)  NOT NULL,
    CLIENTE_ID NUMBER(5,0)  NOT NULL,
    TIPO_ENTREGA_ID        NUMBER(1,0)  NOT NULL,
    CONSTRAINT PK_FOLIO_COMPRA PRIMARY KEY (FOLIO_COMPRA),
    CONSTRAINT CLIENTE_ID_FK5 FOREIGN KEY (CLIENTE_ID)
    REFERENCES CLIENTE(CLIENTE_ID),
    CONSTRAINT TIPO_ENTREGA_ID_FK FOREIGN KEY (TIPO_ENTREGA_ID)
    REFERENCES TIPO_ENTREGA(TIPO_ENTREGA_ID)
);

CREATE TABLE LISTA_PRODUCTO(
	LISTA_PROD_ID NUMBER (2,0) NOT NULL,
	FOLIO_COMPRA NUMBER(10,0) NOT NULL,
	FOLIO_PRODUCTO NUMBER(13,0)	NOT NULL,
    PRECIO_PROD NUMBER(7,2) NOT NULL,
    CANTIDAD_PROD NUMBER (3,0) NOT NULL,
    PRECIO_TOTAL AS (PRECIO_PROD * CANTIDAD_PROD) VIRTUAL,
    CONSTRAINT FOLIO_COMPRA_FK4 FOREIGN KEY(FOLIO_COMPRA)
    REFERENCES ORDEN_COMPRA(FOLIO_COMPRA),
    CONSTRAINT FOLIO_PRODUCTO_FK4 FOREIGN KEY(FOLIO_PRODUCTO)
    REFERENCES PRODUCTO(FOLIO_PRODUCTO)
);

--
--TABLA FACTURA
--
CREATE TABLE FACTURA(
    FACTURA_ID    NUMBER(5,0)   NOT NULL,
    FOLIO_COMPRA  NUMBER(10,0)   NOT NULL,
    FORMA_PAGO_ID VARCHAR2(20)  NOT NULL,
    IVA           NUMBER(4,2)   NOT NULL,
    CONSTRAINT PK_FACTURA_ID PRIMARY KEY (FACTURA_ID),
    CONSTRAINT FK2_FOLIO_COMPRA FOREIGN KEY (FOLIO_COMPRA)
    REFERENCES ORDEN_COMPRA(FOLIO_COMPRA)
);

--
--TABLA EMPRESA
--

CREATE TABLE EMPRESA(
	CLAVE_EMPRESA NUMBER(5,0)		NOT NULL,
	EMPRESA VARCHAR2(50)	NOT NULL,
	ZONA CHAR(1)			NOT NULL,
	CONSTRAINT CLAVE_EMPRESA_PK PRIMARY KEY(CLAVE_EMPRESA),
	CONSTRAINT ZONA_CHK CHECK(ZONA IN ('A', 'B', 'C', 'D', 'E'))		
)
;	

--
--TABLA PAQUETE
--

CREATE TABLE PAQUETE(
	PAQUETE_ID NUMBER(5,0) 	NOT NULL,
	SEGUIMIENTO_ID NUMBER(5,0)		NOT NULL,
	FACTURA_ID NUMBER(5,0)		NOT NULL,
	EMPRESA_CLAVE NUMBER(5,0)		NOT NULL,
	FECHA_ENVIO DATE DEFAULT SYSDATE,
	CONSTRAINT PAQUETE_ID_PK PRIMARY KEY (PAQUETE_ID),
	CONSTRAINT SEGUIMIENTO_ID_FK FOREIGN KEY (SEGUIMIENTO_ID)
	REFERENCES SEGUIMIENTO(SEGUIMIENTO_ID),
	CONSTRAINT FACTURA_ID_FK FOREIGN KEY (FACTURA_ID)
	REFERENCES FACTURA(FACTURA_ID),
	CONSTRAINT EMPRESA_CLAVE FOREIGN KEY (EMPRESA_CLAVE)
	REFERENCES EMPRESA(CLAVE_EMPRESA )
);


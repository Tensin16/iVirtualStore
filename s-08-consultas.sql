--1
SELECT P.PAQUETE_ID, P.FECHA_ENVIO, S.FECHA_LLEGADA, S.LUGAR, S.ESCALA, E.EMPRESA
FROM PAQUETE P 
JOIN EMPRESA E ON E.CLAVE_EMPRESA = P.EMPRESA_CLAVE
JOIN SEGUIMIENTO S ON S.SEGUIMIENTO_ID = P.SEGUIMIENTO_ID
WHERE E.ZONA = 'A';

--6
SELECT C.CLIENTE_ID, C.NOMBRE, C.APELLIDO_PAT, C.USUARIO, C.CORREO_ELEC, T.TIPO_TARJETA, T.NUM_TARJETA
FROM CLIENTE C 
INNER JOIN TARJETA_CREDITO T ON T.CLIENTE_ID = C.CLIENTE_ID
WHERE T.TIPO_TARJETA = 'AMEX';

--8
SELECT V.NOMBRE,T.CATEGORIA, P.COP_EXISTENCIA, P.VECES_VISTO, P.PRECIO
FROM VIDEO_JUEGO V
JOIN PRODUCTO P ON V.FOLIO_PRODUCTO = P.FOLIO_PRODUCTO
JOIN LISTA_PRODUCTO L ON L.FOLIO_PRODUCTO = P.FOLIO_PRODUCTO
JOIN ORDEN_COMPRA O ON O.FOLIO_COMPRA = L.FOLIO_COMPRA
JOIN TIPO_ENTREGA T ON T.TIPO_ENTREGA_ID = O.TIPO_ENTREGA_ID
WHERE O.TIPO_ENTREGA_ID = 2;

--9
SELECT C.NOMBRE, C.APELLIDO_MAT, A.N_ALBUM, A.ARTISTA
FROM CLIENTE C 
INNER JOIN ORDEN_COMPRA O ON O.CLIENTE_ID = C.CLIENTE_ID
INNER JOIN LISTA_PRODUCTO L ON L.FOLIO_COMPRA = O.FOLIO_COMPRA
INNER JOIN PRODUCTO P ON P.FOLIO_PRODUCTO = L.FOLIO_PRODUCTO
INNER JOIN ALBUM A ON A.FOLIO_PRODUCTO = P.FOLIO_PRODUCTO
WHERE C.CLIENTE_ID <11 AND C.CLIENTE_ID >7;
--10
SELECT P.NOMBRE, P.GENERO, P.CLASIF, I.COP_EXISTENCIA, I.PRECIO
FROM PELICULA P 
INNER JOIN PRODUCTO I ON I.FOLIO_PRODUCTO = P.FOLIO_PRODUCTO
WHERE P.CLASIF = 'A';

--11
SELECT C.APELLIDO_PAT, A.NOMBRE
FROM CLIENTE C 
INNER JOIN ORDEN_COMPRA O ON O.CLIENTE_ID = C.CLIENTE_ID
INNER JOIN LISTA_PRODUCTO L ON L.FOLIO_COMPRA = O.FOLIO_COMPRA
INNER JOIN PRODUCTO P ON P.FOLIO_PRODUCTO = L.FOLIO_PRODUCTO
INNER JOIN VIDEO_JUEGO A ON A.FOLIO_PRODUCTO = P.FOLIO_PRODUCTO
WHERE C.CLIENTE_ID > 11 and C.CLIENTE_ID <=14;





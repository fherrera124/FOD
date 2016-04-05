{
* Una cadena de restaurantes posee un archivo de productos que tiene a
* la venta. De cada producto se registra: código de producto,
* descripción, stock actual y stock mínimo. Diariamente el depósito debe
* efectuar envíos a cada uno de los tres restaurantes que se encuentran
* en la ciudad. Para esto, cada restaurante envía un archivo con los
* pedidos de productos. Cada pedido contiene: código de producto y
* cantidad pedida. Se pide realizar el proceso de actualización del
* archivo maestro con los tres archivos detalle, obteniendo un informe
* de aquellos productos que quedaron debajo del stock mínimo y de
* aquellos pedidos que no pudieron satisfacerse totalmente por falta de
* elementos informando la diferencia que no pudo ser enviada a cada
* restaurante.
* NOTA 1: Todos los archivos están ordenados por código de producto y el
* archivo maestro debe recorrerse sólo una vez y en forma simultánea con
* los detalle.
* NOTA 2: En los archivos detalle puede no aparecer algún producto.
* Puede aparecer el mismo producto en distintos detalles y en cada
* detalle el mismo producto aparece sólo una vez.
}

program p2e3;

type
	stg = string[30];

regmae = record
	cod: stg;
	descripcion: stg;
	stock: integer;
	stock_min: integer;
end;

regdet = record
	cod: stg;
	cant: integer;
end;

maestro = file of regmae;
detalle = file of regdet;

procedure leer(var archivo:detalle; var regd:alum_materias);
begin
	if (not eof(archivo)) then
		read (archivo,regd)
	else
		regd.cod:= valoralto;
end;

var
	det1,det2,det3: detalle; // semi globales

procedure minimo(var r1,r2,r3,min:regdet);
begin
	if (r1.cod<=r2.cod) and (r1.cod<=r3.cod) then begin
		min:= r1;
		leer(det1,r1);
	end
	else if (r2.cod<=r3.cod) then begin
		min:= r2;
		leer(det2,r2)
	else begin
		min:= r3;
		leer(det3,r3);
	end;
end;

var
	mae: maestro;
	det: detalle;
	regd: regdet;

begin
	leer();
end.

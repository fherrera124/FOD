{
* Una empresa posee un archivo con información de las ventas realizadas
* por diferentes promotores, de cada uno de ellos se conoce: código de
* promotor, nombre y monto de venta. La información del archivo se
* encuentra ordenada por código de promotor y cada promotor puede
* aparecer más de una vez en el archivo de venta.
*
* Realice un procedimiento que reciba el archivo anteriormente descripto
* y lo compacte, esto es, generar un nuevo archivo donde cada promotor
* aparezca una única vez con sus ventas totales.
*
* NOTA: No se conoce a priori la cantidad de promotores y el archivo
* debe recorrerse una única vez.
}

program p1e1;

	const valoralto = 'zzz';

	type stg = string[30];

	vendedor = record
		cod_promotor : stg;
		nom_promotor : stg;
		monto_venta : real;
	end;
	
	ventas = record
		cod_promotor: stg;
		total_ventas: real;
	end;

	detalle = file of vendedor;
	maestro = file of ventas;

var
	regm: ventas;
	regd: vendedor;
	mae: maestro;
	det: detalle;

procedure leer(var archivo:detalle; var regd:vendedor);
begin
	if (not eof(archivo)) then
		read (archivo,regd)
	else
		regd.cod_promotor:= valoralto;
end;

begin

	assign (mae, 'maestro');
	assign (det, 'detalle');
	rewrite (mae);
	reset(det);
	leer (det, regd);
	while (regd.cod_promotor <> valoralto) do
	begin
		writeln ('pri while');
		regm.cod_promotor:= regd.cod_promotor;
		regm.total_ventas:= 0;
		//writeln(regm.cod_promotor);
		writeln(regd.cod_promotor); {error: el campo es todo el archivo}
		readln;
		write('---------');
		while (regm.cod_promotor = regd.cod_promotor) do
		begin
			writeln ('seg while');
			regm.total_ventas:= regm.total_ventas + regd.monto_venta;
			leer (det, regd);
		end;
		write(mae,regm);
	end;
	close (det);
	close (mae);
	writeln ('ok');
end.


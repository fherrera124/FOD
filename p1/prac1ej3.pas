{
	* Realizar un programa que utilizando el archivo de números enteros
	* no ordenados creados en el ejercicio 1, liste su contenido en pantalla.
	* El nombre del archivo a procesar debe ser proporcionado por el usuario.
}

program prac1ej3;

type
	archivo = file of Integer;

procedure recorrido(var arc_logico:archivo); {esta bien q arc_logico sea pasado x ref?}
var
	nro: Integer;
begin
	reset(arc_logico); {archivo ya creado, para operar debe abrirse como de lect/escr}
	while not eof(arc_logico) do begin
		read(arc_logico,num);
		writeln(num);
	end;
	close(arc_logico);
end;

var
	arc_logico: archivo;
	arc_fisico: String[12];

begin
	write('Ingrese el nombre del archivo');
	readln(arc_fisico);
	assign(arc_logico,arc_fisico);
	recorrido(arc_logico);
end.

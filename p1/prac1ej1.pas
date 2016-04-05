{
	* Realizar un algoritmo que cree e incorpore datos a un archivo de
	* números enteros no ordenados. Los números son ingresados desde teclado.
	* El nombre del archivo debe ser proporcionado por el usuario.
	* La carga finaliza cuando se ingrese el número 0 (cero), que no debe
	* incorporarse al archivo.
}

program prac1ej1;

type
	archivo = file of Integer; {definición del tipo de dato para el archivo}

var
	arc_logico: archivo; {variable que define el nombre lógico del archivo}
	nro: Integer; {para obtener la información de teclado}
	arc_fisico: String[12]; {para obtener el nombre físico del archivo}

begin
	write('Ingrese el nombre del archivo');
	readln(arc_fisico);
	assign(arc_logico,arc_fisico);
	rewrite(arc_logico); {se crea el archivo}
	read(nro);
	while (nro <> 0) do begin
		write(arc_logico,nro);
		read(nro);
	end;
	close(arc_logico); {se cierra el archivo}
end.

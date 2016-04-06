{
	* Realizar un algoritmo que utilizando el archivo de números enteros
	* no ordenados creados en el ejercicio 1, y recorriéndolo una única
	* vez, informe por pantalla cuántos de los números son pares y cuántos
	* impares. 
	* El nombre del archivo a procesar debe ser proporcionado por el usuario.
}

program prac1ej2;

type
	archivo = file of Integer;

procedure recorrido(var arc_logico:archivo; var pars,imps:Integer); {esta bien q arc_logico sea pasado x ref?}
var
	nro: Integer;
begin
	reset(arc_logico); {archivo ya creado, para operar debe abrirse como de lect/escr}
	while not eof(arc_logico) do begin
		read(arc_logico,num);
		if (num mod 2 = 0) then
			pars:= pars+1
		else
			imps:= imps+1;
	end;
	close(arc_logico);
end;

var
	arc_logico: archivo; {variable que define el nombre lógico del archivo}
	arc_fisico: String[12]; {utilizada para obtener el nombre físico del archivo}
	pars,imps: Integer;

begin
	pars:= 0;
	imps:= 0;
	write('Ingrese el nombre del archivo');
	readln(arc_fisico);
	assign(arc_logico,arc_fisico);
	recorrido(arc_logico,pars,imps);
	write('Hay ',pars,' numeros pares y ',imps,' numeros impares.');
end.

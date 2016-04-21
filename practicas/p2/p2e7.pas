{
* Una empresa de colectivos opera en varias zonas, en cada una de las
* cuales maneja varias líneas, cada línea cuenta con varios coches y
* cada coche trabajó varios días del mes.
* Se dispone de un conjunto de registros con la siguiente información:
* ▪ nroZona
* ▪ nroLinea
* ▪ nroCoche
* ▪ dia (día del mes)
* ▪ recDia (recaudación diaria del coche)
* Los datos están ordenados por nroZona, nroLinea y luego por nroCoche
* de forma tal que todos los registros correspondientes a las líneas de
* una misma zona estan agrupados. Luego, los coches de una misma línea
* se encuentran agrupados y todas las recaudaciones diarias de un mismo
* coche están agrupadas también. Finaliza con un registro con nroZona =
* -1, nroLinea = -1, nroCoche = -1, dia = -1, recDia = -1.
* Se pide:
* a. Por cada coche: disponibilidad y recaudación mensual.
* b. Por cada línea: recaudación promedio de sus coches.
* c. Por cada zona: línea de mayor recaudación.
* d. Recaudación total de la empresa y zona que tiene más líneas
* trabajando.
}

{
* Notas mías:
* ▪ Considero el caso más simple en el que c/ num de coche y linea son
*   únicos e irrepetibles.
* ▪ Recaudación mensual, basicamente toda la recaudación del coche que
*   figure en el archivo.
* ▪ El campo día no lo uso, seguro tiene que ver algo con la
*   disponibilidad que pide el inciso a. PENDIENTE.
* ▪ Chequeo sólo el primer campo (nroZona) que sea distinto a -1.
}

program p2e7;

type
	regmae = record
		nroZona: integer;
		nroLinea: integer;
		nroCoche: integer;
		dia: integer;
		recDia: real;
	end;

	maestro = file of regmae;

procedure leer(var mae:maestro; var reg:regmae);
begin
	if not(eof(mae)) then
		read(mae,reg)
	else begin
		reg.nroZona:= -1; //único que chequeo
		reg.nroLinea:= -1;
		reg.nroCoche:= -1;
		reg.dia:= -1;
		reg.recDia:= -1;
	end;
end;

var
	mae: maestro;
	reg: regmae;
	nroZona, nroLinea, nroCoche,linMayorRec,cantLineas, cantCoches,
	maxCantLineas, zonaMaxCantLineas: integer;
	totalEmp, recLinea, recCoche, recProm, maxLinea: real;

begin
	assign(mae,'mae_p2e7');
	reset(mae);
	leer(mae,reg);
	totalEmp:= 0;
	maxCantLineas:= -1;
	while (reg.nroZona <> -1) do begin
		writeln('Zona: ', reg.nroZona);
		maxLinea:= -1;
		cantLineas:= 0; //relacionada con maxCantLineas de + arriba
		nroZona:= reg.nroZona;
		while (nroZona=reg.nroZona) do begin
			writeln('Línea: ',reg.nroLinea);
			recLinea:= 0; //relacionada con maxLinea de + arriba
			cantCoches:= 0;
			nroLinea:= reg.nroLinea;
			while (nroLinea=reg.nroLinea) do begin
				writeln('Coche: ', reg.nroCoche);
				recCoche:= 0;
				nroCoche:= reg.nroCoche;
				while (nroCoche=reg.nroCoche) do begin
					recCoche:= recCoche + reg.recDia;
					leer(mae,reg);
				end;
				{cambio de coche:
				-Print recaudacion y disponibilidad del coche anterior,
				-sumarla a la recaudacion total de la linea.
				-Incrementar cant de coches de linea actual.}
				//writeln('Disponibilidad:'); PENDIENTE
				writeln('Recaudación: ', recCoche);
				recLinea:= recLinea + recCoche;
				cantCoches:= cantCoches + 1;
			end;
			{cambio de linea:
			-Sumar recaudacion de la linea al total de empresa.
			-actualizar linea de zona actual con mayor recaudacion hasta
			 el momento.
			-Incrementar cant de lineas de zona actual.
			-Print recaud. promedio de los coches de linea anterior}
			totalEmp:= totalEmp + recLinea;
			if (maxLinea<recLinea) then begin
				maxLinea:= recLinea;
				linMayorRec:= nroLinea;
			end;
			cantLineas:= cantLineas + 1;
			recProm:= recLinea/cantCoches; 
			writeln('Recaudación promedio de los coches: ', recProm);
		end;
		{cambio de zona:
		-Actualizar zona con mayor cant de líneas hasta el momento.
		-Imprimir la linea con mayor recaudacion de la zona anterior}
		if (maxCantLineas<cantLineas) then begin
			maxCantLineas:= cantLineas;
			zonaMaxCantLineas:= nroZona;
		end;
		writeln('Linea con mayor recaudación de zona ',nroZona,': ',linMayorRec);
	end;
	{fin de archivo:
	-Recaudación total de empresa.
	-Print zona con mayor cant de líneas.}
	writeln('Total Empresa: ',totalEmp);
	writeln('Zona con mayor num de líneas: ',zonaMaxCantLineas);
end.

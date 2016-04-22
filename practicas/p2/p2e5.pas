{
* Se cuenta con un archivo con información de las ventas de una empresa
* a sus clientes y se necesita obtener las ventas por cliente, mes por
* mes, con el total por año, otro por cliente y uno de las ventas
* totales. El formato está especificado de la siguiente forma:
* ▪ cliente,año,mes,día,venta
* Para poder hacer el reporte como se solicita, el archivo debe estar
* ordenado en primer lugar por cliente, luego por año y luego por mes.
}

{
* Notas mías:
* DUDA: yo imprimo monto de venta de c/ mes, usando un acumulador de mes
* ¿Estará bien así mi enfoque? PREGUNTAR.
}

program p2e5;

const
	valoralto = 'zzz';

type
	stg2 = string[2];

	stg30 = string[30];

	regmae = record
		cli: stg30;
		year: stg2;
		month: stg2;
		day: stg2;
		sale: real;
	end;

	maestro = file of regmae;

procedure leer(var A:maestro; var R:regmae);
begin
	if not(eof(A)) then
		read(A,R)
	else
		R.cli:= valoralto;
end;

var
	mae: maestro;
	reg: regmae;
	cli: stg30;
	year, month: stg2;
	totalSales, clientSales, yearSales, monthSales: real;

begin
	assign(mae,'mae_p2e5');
	reset(mae);
	leer(mae,reg);
	writeln('Empresa.');
	totalSales:= 0;
	while (reg.cli <> valoralto) do begin
		cli:= reg.cli;
		writeln('Cliente: ', cli);
		clientSales:= 0;
		while (cli=reg.cli) do begin
			year:= reg.year;
			writeln('Año: ', year);
			yearSales:= 0;
			while (year=reg.year) and (cli=reg.cli) do begin
				month:= reg.month;
				writeln('Mes: ', month);
				monthSales:= 0;
				while (year=reg.year) and (cli=reg.cli) and (month=reg.month) do begin
					monthSales:= monthSales + reg.sale;
					leer(mae,reg);
				end;
				writeln('Total ventas en el mes: ', monthSales);
				yearSales:= yearSales + monthSales;
			end;
			writeln('Total ventas en el año: ', yearSales);
			clientSales:= clientSales + yearSales;
		end;
		writeln('Total ventas al cliente: ', clientSales);
		totalSales:= totalSales + clientSales;
	end;
	writeln('Total ventas de la empresa: ', totalSales);
end.

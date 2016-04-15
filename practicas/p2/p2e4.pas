{
* El encargado de ventas de un negocio de productos de limpieza desea
* administrar el stock de los productos que vende. Para ello, genera un
* archivo maestro donde figuran todos los productos que comercializa.
* De cada producto se maneja la siguiente información: código de
* producto, nombre comercial, precio de venta, stock actual y stock
* mínimo. Diariamente se genera un archivo detalle donde se registran
* todas las ventas de productos realizadas. De cada venta se registra:
* código de producto y cantidad de unidades vendidas. Se pide realizar
* un programa con opciones para:
* a. Crear el archivo maestro a partir de un archivo de texto llamado
* “productos.txt”.
* b. Listar el contenido del archivo maestro en un archivo de texto
* llamado “reporte.txt”, listando de a un producto por línea.
* c. Crear un archivo detalle de ventas a partir de en un archivo de
* texto llamado “ventas.txt”.
* d. Listar en pantalla el contenido del archivo detalle de ventas.
* e. Actualizar el archivo maestro con el archivo detalle, sabiendo que:
*   -Ambos archivos están ordenados por código de producto.
*   -Cada registro del maestro puede ser actualizado por 0, 1 ó más
*    registros del archivo detalle.
*   -El archivo detalle sólo contiene registros que están en el archivo
*    maestro.
* f. Listar en un archivo de texto llamado “stock_minimo.txt” aquellos
* productos cuyo stock actual esté por debajo del stock mínimo permitido
* .
}

program p2e4;

Uses CRT;

const valoralto = 'zzz';

type
	stg = string[30];

regmae = record
	cod: stg;
	nom: stg;
	prec: integer;
	stk: integer;
	stk_min: integer;
end;

regdet = record
	cod: stg;
	vend: integer;
end;

maestro = file of regmae;
detalle = file of regdet;

{ Importa un archivo de texto a un archivo binario }
procedure importar_productostxt (VAR mae: maestro; VAR T: text);
var
	reg: regmae;
begin
	rewrite(mae);
	reset(T);
	while not(EOF(T)) do begin
		readln(T, reg.nom);
		readln(T, reg.prec);
		readln(T, reg.stk);
		readln(T, reg.stk_min);
		write(mae, reg);
	end;
	close(mae);
	close(T);
end;

{ Importa un archivo de texto a un archivo binario }
procedure importar_ventastxt (VAR det: detalle; VAR T: text);
var
	reg: regdet;
begin
	rewrite(det);
	reset(T);
	while not(EOF(T)) do begin
		readln(T, reg.cod);
		writeln('ok');
		readln(T, reg.vend);
		write(det, reg);
	end;
	close(det);
	close(T);
end;

{ Exporta un archivo binario a un archivo de texto }
procedure exportar_maestro(VAR mae: maestro; VAR T: text);
var
	reg: regmae;
begin
	reset(mae);
	rewrite(T);
	while not(EOF(mae)) do begin
		read(mae, reg);
		writeln(T, reg.nom);
		writeln(T, reg.prec);
		writeln(T, reg.stk);
		writeln(T, reg.stk_min);
	end;
	close(mae);
	close(T);
end;

procedure imprimir_ventas(VAR det: detalle); //x ref aunque no se modifique
var
	reg: regdet;
begin
	reset(det);
	while not(EOF(det)) do begin
		read(det, reg);
		writeln(reg.cod);
		writeln(reg.vend);
	end;
	close(det);
end;

procedure act_maestro(var mae: maestro; var det: detalle);
var
	regm: regmae;
	regd: regdet;
begin
	reset(mae);
	reset(det);
	while not(EOF(det)) do begin
		read(mae, regm);
		read(det, regd);
		while (regd.cod <> regm.cod) do
			read(det, regd);
		while (regd.cod = regm.cod) do begin
			regm.stk:= regm.stk - regd.vend;
			read(det,regd);
		end;
		seek (mae, filepos(mae)-1);
		write(mae,regm);
	end;
	close(det);
	close(mae);
end;

var
	mae: maestro;
	det: detalle;
	t: text;
	opc: byte;

begin
	WriteLn('LOCAL PROD DE LIMPIEZA');
	WriteLn;
	WriteLn('a. Crear archivo binario maestro'); //Importa productos.txt
	writeln('b. Exportar maestro a archivo txt'); //exporta maestro a reporte.txt
	WriteLn('c. Crear archivo binario detalle'); //Importa ventas.txt
	writeln('d. Imprimir detalle');
	writeln('e. Actualizar archivo maestro');
	WriteLn('0. Salir');
	Window(1,10,80,22);
	repeat
		writeln('Ingrese opcion: ');
        ReadLn(opc);
        case opc of 
			1: begin
                writeln;
                writeln('Se creará el archivo binario maestro');
                assign(mae, 'mae_p2e4');
                assign(t, 'productos.txt');
                writeln('Importando alumnos.txt...');
                importar_productostxt(mae, t);
            end;
            2: begin
                writeln;
                writeln('Se creará el archivo de texto reporte.txt');
                assign(mae, 'mae_p2e4');
                assign(t, 'reporte.txt');
                writeln('Exportando a reporte.txt...');
                exportar_maestro(mae, t);
            end;
            3: begin
                writeln;
                writeln('Se creará el archivo binario detalle');
                assign(det, 'det1_p2e4');
                assign(t, 'ventas.txt');
                writeln('Importando detalle.txt...');
                importar_ventastxt(det, t);
            end;
            4: begin
                writeln('Se listará en pantalla contenido del archivo detalle de ventas.');
                assign(det, 'det1_p2e4');
                imprimir_ventas(det);
                
            end;
            5: begin
				writeln;
                writeln('Se actualizará el archivo binario maestro');
				assign(mae,'mae_p2e4');
				assign(det,'det1_p2e4');
				act_maestro(mae,det);
			end;
        end;
        ClrScr;
     until
        opc=0;
end.

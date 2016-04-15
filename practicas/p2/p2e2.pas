{
* Se dispone de un archivo con información de los alumnos de la Facultad
* de Informática. El archivo contiene, para cada alumno, el código de
* alumno, apellido, nombre, la cantidad de materias cursadas aprobadas
* sin final y la cantidad de materias con final aprobado. Además, se
* tiene un archivo detalle con el código de alumno e información
* correspondiente a una materia (esta información indica si aprobó la
* cursada o aprobó el final).
* Todos los archivos están ordenados por código de alumno y en el
* archivo detalle puede haber 0, 1 ó más registros por cada alumno del
* archivo maestro. Se pide realizar un programa con opciones para:
* a. Crear el archivo maestro a partir de un archivo de texto llamado
* “alumnos.txt”.
* b. Crear el archivo detalle a partir de un archivo de texto llamado
* “detalle.txt”.
* c. Listar el contenido del archivo maestro en un archivo de texto
* llamado “reporteAlumnos.txt”.
* d. Listar el contenido del archivo detalle en un archivo de texto
* llamado “reporteDetalle.txt”.
* e. Actualizar el archivo maestro de la siguiente manera:
* i. Si aprobó el final se incrementa en uno la cantidad de materias con
* final aprobado.
* ii. Si aprobó la cursada se incrementa en uno la cantidad de materias
* aprobadas sin final.
* f. Listar en un archivo de texto los alumnos que tengan más de cuatro
* materias cursadas sin aprobar. Deben listarse todos los campos.
* NOTA: Para la actualización del inciso e) los archivos deben
* recorrerse sólo una vez.
* }

program p2e2;

Uses CRT;

	const valoralto = 'zzz';

	type stg = string[30];
	
	alum_gral = record
		cod : stg;
		apel : stg;
		nom : stg;
		aprobs_no_final : integer;
		aprobs_si_final : integer;
	end;
	
	alum_materias = record
		cod : stg;
		materia: stg;
		aprob_con_final: byte; // 1 aprobado con final, 0 sin final
	end;
	
	maestro = file of alum_gral;
	detalle = file of alum_materias;

procedure leer(var archivo:detalle; var regd:alum_materias);
begin
	if (not eof(archivo)) then
		read (archivo,regd)
	else
		regd.cod:= valoralto;
end;

{ Importa un archivo de texto a un archivo binario }
procedure importar_alumnostxt (VAR mae: maestro; VAR T: text);
var
	reg: alum_gral;
begin
	rewrite(mae);
	reset(T);
	while not(EOF(T)) do begin
		readln(T, reg.cod);
		writeln('ok');
		readln(T, reg.apel);
		readln(T, reg.nom);
		readln(T, reg.aprobs_no_final);
		readln(T, reg.aprobs_si_final);
		write(mae, reg);
	end;
	close(mae);
	close(T);
end;

{ Importa un archivo de texto a un archivo binario }
procedure importar_detalletxt (VAR det: detalle; VAR T: text);
var
	reg: alum_materias;
begin
	rewrite(det);
	reset(T);
	while not(EOF(T)) do begin
		readln(T, reg.cod);
		readln(T, reg.materia);
		readln(T, reg.aprob_con_final);
		write(det, reg);
	end;
	close(det);
	close(T);
end;

{ Exporta un archivo binario a un archivo de texto }
procedure exportar_maestro (VAR mae:maestro; VAR T: text);
var
	reg: alum_gral;
begin
	reset(mae);
	rewrite(T);
	while not(EOF(mae)) do begin
		read(mae, reg);
		writeln(T, reg.cod);
		writeln(T, reg.apel);
		writeln(T, reg.nom);
		writeln(T, reg.aprobs_no_final);
		writeln(T, reg.aprobs_si_final);
	end;
	close(mae);
	close(T);
end;

{ Exporta un archivo binario a un archivo de texto }
procedure exportar_detalle (VAR det:detalle; VAR T: text);
var
	reg: alum_materias;
begin
	reset(det);
	rewrite(T);
	while not(EOF(det)) do begin
		read(det, reg);
		writeln(T, reg.cod, reg.materia,reg.aprob_con_final);
	end;
	close(det);
	close(T);
end;

var
	opc: Byte;
	mae: maestro;
	det: detalle;
	t: text;

begin
	WriteLn('ALUMNOS');
	WriteLn;
	WriteLn('1. Crear archivo binario maestro'); //Importa alumnos.txt
	WriteLn('2. Crear archivo binario detalle'); //Importa detalle.txt
	writeln('3. Exportar maestro a archivo txt'); //exporta maestro a reporteAlumnos.txt
	writeln('4. Exportar detalle a archivo txt'); //exporta detalle a reporteDetalle.txt
	writeln('5. Actualizar archivo maestro');
	//writeln();
	//writeln();
	WriteLn('0. Salir');
	Window(1,10,80,22);
	repeat
		writeln('Ingrese opcion: ');
        ReadLn(opc);
        case opc of 
			1: begin
                writeln;
                writeln('Se creará el archivo binario maestro');
                assign(mae, 'maestro');
                assign(t, 'alumnos.txt');
                writeln('Importando alumnos.txt...');
                importar_alumnostxt(mae, t);
            end;
            2: begin
                writeln;
                writeln('Se creará el archivo binario detalle');
                assign(det, 'detalle');
                assign(t, 'detalle.txt');
                writeln('Importando detalle.txt...');
                importar_detalletxt(det, t);
            end;
            3: begin
                writeln;
                writeln('Se creará el archivo de texto reporteAlumnos.txt');
                assign(mae, 'maestro');
                assign(t, 'reporteAlumnos.txt');
                writeln('Exportando a reporteAlumnos.txt...');
                exportar_maestro(mae, t);
            end;
            4: begin
                writeln;
                writeln('Se creará el archivo de texto reporteDetalle.txt');
                assign(det, 'detalle');
                assign(t, 'reporteDetalle.txt');
                writeln('Exportando a reporteDetalle.txt...');
                exportar_detalle(det, t);
            end;
            //5: pendiente
        end;
        ClrScr;
     until
        opc=0;
end.

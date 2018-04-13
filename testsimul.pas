program test;
uses
	simul;

var
	a : integer;
	name : string;
	ayyy : listSimulasi;
begin
	readln(a);
	readln(name);
	
	pSimtoArr(a, name, ayyy); // baca
	
	lihatStatistik(a, ayyy); //write layar
	
	writeln('disini gua set energi jadi 15');
	ayyy.list[a].energi := 15; //test ngoprek
	lihatStatistik(a, ayyy); //write layar
	
	pArrToSim(a, name, ayyy); //save file
end.
program test;
uses
	simul,
	typeuniverse;

var
	a : filesimul;
	name : string;
	ayyy : listSimulasi;
	stop : boolean;
	x : char;
begin
	
	stop:=false;
	repeat
		writeln('stop? y/n');
		readln(x);
		if x = 'y' then 
			stop:=true
		else
			fSIm2var(a, name, ayyy);
	until stop;
end.

unit istirahat;

interface
uses typeuniverse;
procedure istirahat (var daftarsimulasi: tabSimulasi;  N: integer; var n-istirahat: integer = 0);

implementation
procedure istirahat (var daftarsimulasi: tabSimulasi; N: integer; var n-istirahat: integer = 0);

begin
		if (daftarsimulasi.tab[N].energi => 10) or (n-istirahat >= 6) then
	begin
		writeln('Anda tidak dapat beristirahat lagi, telah mencapai batas maksimum!');
	end else
		begin
			daftarsimulasi.tab[N].energi := daftarsimulasi.tab[N].energi + 1;
			if (daftarsimulasi.tab[N].energi > 10) then
				daftarsimulasi.tab[N].energi := 10

			n-istirahat := n-istirahat + 1;
		end;
end;
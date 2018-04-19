unit F10;

interface
uses typeuniverse;
procedure istirahat (var daftarsimulasi: listSimulasi;  N: integer; var nistirahat: integer);

implementation
procedure istirahat (var daftarsimulasi: listSimulasi; N: integer; var nistirahat: integer);

begin
		if (daftarsimulasi.list[N].energi >= 10) or (nistirahat >= 6) then
	begin
		writeln('Anda tidak dapat beristirahat lagi, telah mencapai batas maksimum!');
	end else
		begin
			daftarsimulasi.list[N].energi := daftarsimulasi.list[N].energi + 1;
			if (daftarsimulasi.list[N].energi > 10) then
				daftarsimulasi.list[N].energi := 10;

			nistirahat := nistirahat + 1;
			writeln('Istirahat sukses');
		end;
end;
end.

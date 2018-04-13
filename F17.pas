unit F17;

interface
	uses typeuniverse;
	procedure upgradeInventori (var imax : integer);
	
implementation
	
	procedure upgradeInventori (var imax : integer);
	begin
		imax := imax + 25; {KETIKA DIUPGRADE MAKA INVENTORI MAKS BERTAMBAH 25}
		writeln('Inventori berhasil diupgrade');
	end;
end.

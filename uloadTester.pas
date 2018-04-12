program uloadTester;

uses uload, typeuniverse, sysutils;

var
	bahanmentah : tabmentah;
	bahanolahan : tabolahan;
	i : integer;

begin
	LoadBahanMentah(bahanmentah);
	for i:=1 to 3 do
	begin
		writeln (bahanmentah.tab[i].nama);
		writeln (bahanmentah.tab[i].harga);
		writeln (bahanmentah.tab[i].kadaluarsa);
	end;
	
	LoadBahanOlahan (bahanolahan);
	for i:=1 to 2 do
	begin
		writeln (bahanolahan.tab[i].nama);
		writeln (bahanolahan.tab[i].harga);
		writeln (bahanolahan.tab[i].komposisi[1].nama);
		writeln (bahanolahan.tab[i].komposisi[2].nama);
	end;
end.
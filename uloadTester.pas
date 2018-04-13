program uloadTester;

uses uload, typeuniverse, sysutils;

var
	{bahanmentah : tabmentah;}
	bahanolahan : tabolahan;
	i,j : integer;

begin
	{LoadBahanMentah(bahanmentah);
	for i:=1 to 3 do
	begin
		writeln (bahanmentah.tab[i].nama);
		writeln (bahanmentah.tab[i].harga);
		writeln (bahanmentah.tab[i].kadaluarsa);
	end;}
	writeln ();
	LoadBahanOlahan (bahanolahan);
	for i:=1 to 4 do
	begin
		writeln (bahanolahan.tab[i].nama);
		writeln (bahanolahan.tab[i].harga);
		for j:=1 to bahanolahan.tab[i].n do
		begin
			writeln (bahanolahan.tab[i].komposisi[j].nama);
		end;
	end;
end.
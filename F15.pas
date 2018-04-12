unit F15;

interface
	uses typeuniverse;
	procedure cariResep (a : tabResep);

implementation

	procedure cariResep (a :tabResep);
	var
		x : resep;
		i, j : integer;
		cek : boolean;
		
	begin
		writeln('Cari resep:');
		readln(x.nama);
		i :=1;
		cek := false;
		while (i<=a.neff) and not(cek) do
		begin
			if (a.tab[i].nama = x.nama) then cek:= true
			else i:=i+1
		end;
		
		if not(cek) then writeln('Resep tidak tersedia')
		else
		begin
			writeln(a.tab[i].nama);
			for j:=1 to (a.tab[i].n) do
			begin
				writeln(a.tab[i].bahan[j].nama);
			end;
			writeln(a.tab[i].harga);
		end;
	end;
end.

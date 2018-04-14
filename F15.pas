unit F15;

interface
	uses typeuniverse;
	procedure cariResep (a : tabResep);

implementation

	procedure cariResep (a :tabResep);
	var
		x : resep;
		i, j, k : integer;
		cek : boolean;
		
	begin
		writeln('Cari resep:'); {INPUT RESEP}
		readln(x.nama);
		i :=1;
		cek := false;
		while (i<=a.neff) and not(cek) do {VALIDASI INPUT}
		begin
			if (a.tab[i].nama = x.nama) then cek:= true
			else i:=i+1
		end;
		
		if not(cek) then writeln('Resep tidak tersedia') {INPUT TIDAK TERDAPAT DI RESEP}
		else {INPUT DITEMUKAN}
		begin
			writeln('Nama resep:');
			writeln(a.tab[i].nama);
			writeln('Bahan-bahan:');
			for j:=1 to (a.tab[i].nmentah) do
			begin
				writeln(a.tab[i].partmentah[j].nama);
			end;
			for k:=1 to (a.tab[i].nolahan) do
			begin
				writeln(a.tab[i].partolahan[k].nama);
			end;
			writeln('Harga resep:');
			writeln(a.tab[i].harga);
		end;
	end;
end.

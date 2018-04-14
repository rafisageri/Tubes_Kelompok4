unit ulisting;

interface
	uses sysutils, typeuniverse;
	type arrString = array [1..100] of string;
	procedure lihatInventoriM (x : tabInventoriM);
	procedure lihatInventoriO (x : tabInventoriO);
	procedure lihatInventori (x1 : tabInventoriM ; x2 : tabInventoriO);
	procedure lihatResep (x : tabResep);
	procedure urutString (var s1, s2 : string);
	function isUrut (s1, s2 : string): boolean;
	
implementation	
	procedure urutString (var s1, s2 : string); 
	{I.S string s1 dan s2 terdefinisi dan tidak kosong, bisa sudah terurut atau belum terurut. Contoh : s1='bulan', s2='anak'
	 F.S s1 dan s2 terurut berdasarkan abjad. Contoh : s1 = 'anak', s2 = 'bulan'}
	var {KAMUS LOKAL urutString}
		temp1, temp2, temp : string;
		i : integer;
		stop : boolean;
	{ALGORITMA urutString}
	begin
		temp1 := UpperCase (s1);
		temp2 := UpperCase (s2);
		i := 1;
		stop := False;
		repeat {Skema standar iterate-stop}
			if (ord(temp1[i]) < ord(temp2[i])) then {Ord () mengembalikan integer yang ekivalen dengan ordinal dari suatu char. Ordnya lebih kecil berarti char tersebut ada di urutan lebih dulu di alfabet}
			begin
				stop := True;
			end else if (ord(temp1[i]) = ord(temp2[i])) then
			begin
				i := i + 1;
			end else {(ord(temp1[i]) > ord(temp2[i]) }
			begin 
				temp := s1; {Tukar s1 dengan s2}
				s1 := s2; 
				s2 := temp;
			end;
		until ((stop) or (i>=length(s1)) or (i>=length(s2)));
		if (length(s1) > length(s2)) then {Misalkan stringnya halo sama halobandung. Asumsinya halo mau ditulis duluan daripada halobandung}
		begin
			temp := s1; {Tukar s1 dengan s2}
			s1 := s2; 
			s2 := temp;
		end;
	end;
	
	function isUrut (s1, s2 : string): boolean;
	{I.S string s1 dan s2 terdefinisi dan tidak kosong, bisa sudah terurut atau belum terurut. Contoh : s1='bulan', s2='anak'
	 F.S fungsi mengembalikan true jika s1 dan s2 sudah terurut. Contoh : s1 = 'anak', s2 = 'bulan'}
	 
	var {KAMUS LOKAL isUrut}
		check1, check2 : string;
	{ALGORITMA isUrut}
	begin
		check1 := s1;
		check2 := s2;
		urutString (check1, check2);
		if ((s1=check1) and (s2=check2)) then
		begin
			isUrut := True;
		end else begin {(s1<>check1) and (s2<>check2)}
			isUrut := False;
		end;
	end;
	
	procedure lihatResep (x : tabResep);
	var {KAMUS LOKAL lihatResep}
		i, j : integer; {counter traversal}
	{ALGORITMA lihatResep}
	begin
		if (tabResep.neff < 1) then
		begin
			writeln ('Daftar resep kosong !');
		end else if (tabResep.neff = 1) then
		begin
			{Menampilkan daftar resep ke layar}
			writeln (tabResep.tab[1].nama);
			for i:=1 to tabResep.tab[1].nmentah do
			begin
				writeln (tabResep.tab[1].partmentah[i].nama);
			end;
			for i:=1 to tabResep.tab[1].nolahan do
			begin
				writeln (tabResep.tab[1].partolahan[i].nama);
			end;
		end else begin {tabResep.neff > 1}
			{Ada kemungkinan daftar resep belum terurut, maka akan dilakukan sorting dengan metode insertion sort}
			for i:=2 to tabResep.neff do
			begin
				j:= i-1;
				while ((not(isUrut(tabResep.tab[j].nama, tabResep.tab[i].nama))) and (j>=1)) do
				begin
					urutString(tabResep.tab[j].nama, tabResep.tab[i].nama);
					j:=j-1;
				end;
				{isUrut bernilai True yang berarti string sudah menemukan posisi yang tepat atau string diletakkan di posisi pertama}
			end;
			{Menampilkan daftar resep ke layar}
			for i:=1 to tabResep.neff do
			begin
				writeln (tabResep.tab[i].nama);
				for j:=1 to tabResep.tab[i].nmentah do
				begin
					writeln (tabResep.tab[i].partmentah[j].nama);
				end;
				for j:=1 to tabResep.tab[i].nolahan do
				begin
					writeln (tabResep.tab[i].partolahan[j].nama);
				end;
			end;		
		end;
	end;
	
	procedure lihatInventoriM (x : tabInventoriM);
	{KAMUS LOKAL lihatInventoriM}
	var
		i, j : integer; {counter traversal}
	{ALGORITMA lihatInventoriM}
	begin
		if (tabInventoriM.neff < 1) then
		begin
			writeln ('Inventori bahan mentah kosong !');
		end else if (tabInventoriM.neff = 1) then
		begin
			{Menampilkan daftar bahan mentah di inventori ke layar}
			writeln (tabInventoriM.tab[1].nama);
		end else begin {tabInventoriM.neff > 1}
			{Ada kemungkinan daftar bahan mentah di inventori belum terurut, maka akan dilakukan sorting dengan metode insertion sort}
			for i:=2 to tabInventoriM.neff do
			begin
				j:= i-1;
				while ((not(isUrut(tabInventoriM.tab[j].nama, tabInventoriM.tab[i].nama))) and (j>=1)) do
				begin
					urutString(tabInventoriM.tab[j].nama, tabInventoriM.tab[i].nama);
					j:=j-1;
				end;
				{isUrut bernilai True yang berarti string sudah menemukan posisi yang tepat atau string diletakkan di posisi pertama}
			end;
			{Menampilkan daftar bahan mentah di inventori ke layar}
			for i:=1 to tabInventoriM.neff do
			begin
				writeln (tabInventoriM.tab[i].nama);
			end;		
		end;
	end;
	
	procedure lihatInventoriO (x : tabInventoriO);
	{KAMUS LOKAL lihatInventoriO}
	var
		i, j : integer; {counter traversal}
	{ALGORITMA lihatInventoriO}
	begin
		if (tabInventoriO.neff < 1) then
		begin
			writeln ('Inventori bahan olahan kosong !');
		end else if (tabInventoriO.neff = 1) then
		begin
			{Menampilkan daftar bahan mentah di inventori ke layar}
			writeln (tabInventoriO.tab[1].nama);
		end else begin {tabInventoriO.neff > 1}
			{Ada kemungkinan daftar bahan olahan di inventori belum terurut, maka akan dilakukan sorting dengan metode insertion sort}
			for i:=2 to tabInventoriO.neff do
			begin
				j:= i-1;
				while ((not(isUrut(tabInventoriO.tab[j].nama, tabInventoriO.tab[i].nama))) and (j>=1)) do
				begin
					urutString(tabInventoriO.tab[j].nama, tabInventoriO.tab[i].nama);
					j:=j-1;
				end;
				{isUrut bernilai True yang berarti string sudah menemukan posisi yang tepat atau string diletakkan di posisi pertama}
			end;
			{Menampilkan daftar bahan olahan di inventori ke layar}
			for i:=1 to tabInventoriO.neff do
			begin
				writeln (tabInventoriO.tab[i].nama);
			end;		
		end;
	end;
	
	procedure lihatInventori (x1 : tabInventoriM ; x2: tabInventoriO);
	{ALGORITMA lihatInventori}
	begin
		writeln ('Daftar bahan mentah : ');
		lihatInventoriM (x1);
		writeln ();
		writeln ('Daftar bahan olahan : ');
		lihatInventoriO (x2);
	end;
end.
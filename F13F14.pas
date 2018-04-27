unit F13F14;

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
		i, lmin : integer;
		stop : boolean;
	{ALGORITMA urutString}
	begin
		temp1 := UpperCase (s1);
		temp2 := UpperCase (s2);
		i := 1;
		stop := False;
		
		if length(s1) < length(s2) then
		begin
			lmin := length(s1);
		end
		else //if length(s1) >= length(s2) then
		begin
			lmin := length(s2);
		end;
		
		//cek kasus s2 = s1 + '<...>'
		if (copy(s1, 1, lmin) = copy(s2, 1, lmin)) and (length(s1)>lmin) then
		//contoh: s1= satuuuuuu, s2= satu, akan dihasilkan s1= satu, s2= satuuuuuu
		begin
			temp := s1;
			s1 :=s2;
			s2 :=temp;
		end
		//(copy(s1, 1, lmin) = copy(s2, 1, lmin)) and length(s2)>lmin sudah terpenuhi
		else if (copy(s1, 1, lmin) <> copy(s2, 1, lmin)) then
		begin
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
					stop := True;
				end;
			until ((stop) or (i>=length(s1)) or (i>=length(s2)));
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
	{I.S. Daftar bahan resep terdefinisi dalam array
	 F.S. Daftar bahan resep ditampilkan di layar}
	var {KAMUS LOKAL lihatResep}
		i, j : integer; {counter traversal}
	{ALGORITMA lihatResep}
	begin
		if (x.neff < 1) then
		begin
			writeln ('Daftar resep kosong !');
		end else if (x.neff = 1) then
		begin
			{Menampilkan daftar resep ke layar}
			writeln (x.tab[1].nama);
			for i:=1 to x.tab[1].nmentah do
			begin
				writeln (x.tab[1].partmentah[i].nama);
			end;
			for i:=1 to x.tab[1].nolahan do
			begin
				writeln (x.tab[1].partolahan[i].nama);
			end;
		end else begin {tabResep.neff > 1}
			{Ada kemungkinan daftar resep belum terurut, maka akan dilakukan sorting dengan metode insertion sort}
			for i:=2 to x.neff do
			begin
				j:= i-1;
				while ((not(isUrut(x.tab[j].nama, x.tab[i].nama))) and (j>=1)) do
				begin
					urutString(x.tab[j].nama, x.tab[i].nama);
					j:=j-1;
				end;
				{isUrut bernilai True yang berarti string sudah menemukan posisi yang tepat atau string diletakkan di posisi pertama}
			end;
			{Menampilkan daftar resep ke layar}
			for i:=1 to x.neff do
			begin
				writeln (x.tab[i].nama);
				for j:=1 to x.tab[i].nmentah do
				begin
					writeln (x.tab[i].partmentah[j].nama);
				end;
				for j:=1 to x.tab[i].nolahan do
				begin
					writeln (x.tab[i].partolahan[j].nama);
				end;
			end;		
		end;
	end;
	
	procedure lihatInventoriM (x : tabInventoriM);
	{I.S. Daftar inventori bahan mentah terdefinisi dalam array
	 F.S. Daftar inventori bahan mentah ditampilkan di layar}
	{KAMUS LOKAL lihatInventoriM}
	var
		i, j : integer; {counter traversal}
		temp1, temp2 : string;
	{ALGORITMA lihatInventoriM}
	begin
		if (x.neff < 1) then
		begin
			writeln ('Inventori bahan mentah kosong !');
		end else if (x.neff = 1) then
		begin
			{Menampilkan daftar bahan mentah di inventori ke layar}
			writeln (x.tab[1].nama);
		end else begin {tabInventoriM.neff > 1}
			{Ada kemungkinan daftar bahan mentah di inventori belum terurut, maka akan dilakukan sorting dengan metode insertion sort}
			for i:=2 to x.neff do
			begin
				temp1 := x.tab[i].nama;
				j:= i-1;
				while ((not(isUrut(x.tab[j].nama, temp1))) and (j>=1)) do
				begin
					temp2:= x.tab[j].nama;
					x.tab[j].nama := temp1;
					x.tab[j+1].nama := temp2;
					j:=j-1;
				end;
				{isUrut bernilai True yang berarti string sudah menemukan posisi yang tepat atau string diletakkan di posisi pertama}
			end;
			{Menampilkan daftar bahan mentah di inventori ke layar}
			for i:=1 to x.neff do
			begin
				writeln (x.tab[i].nama);
			end;		
		end;
	end;
	
	procedure lihatInventoriO (x : tabInventoriO);
	{I.S. Daftar inventori bahan olahan terdefinisi dalam array
	 F.S. Daftar inventori bahan olahan ditampilkan di layar}
	{KAMUS LOKAL lihatInventoriO}
	var
		i, j : integer; {counter traversal}
		temp1, temp2 : string;
	{ALGORITMA lihatInventoriO}
	begin
		if (x.neff < 1) then
		begin
			writeln ('Inventori bahan olahan kosong !');
		end else if (x.neff = 1) then
		begin
			{Menampilkan daftar bahan mentah di inventori ke layar}
			writeln (x.tab[1].nama);
		end else begin {x.neff > 1}
			{Ada kemungkinan daftar bahan olahan di inventori belum terurut, maka akan dilakukan sorting dengan metode insertion sort}
			for i:=2 to x.neff do
			begin
				temp1 := x.tab[i].nama;
				j:= i-1;
				while ((not(isUrut(x.tab[j].nama, temp1))) and (j>=1)) do
				begin
					temp2 := x.tab[j].nama;
					x.tab[j].nama := temp1;
					x.tab[j+1].nama := temp2;
					j:=j-1;
				end;
				{isUrut bernilai True yang berarti string sudah menemukan posisi yang tepat atau string diletakkan di posisi pertama}
			end;
			{Menampilkan daftar bahan olahan di inventori ke layar}
			for i:=1 to x.neff do
			begin
				writeln (x.tab[i].nama);
			end;		
		end;
	end;
	
	procedure lihatInventori (x1 : tabInventoriM ; x2: tabInventoriO);
	{I.S. Daftar inventori bahan mentah dan bahan olahan terdefinisi dalam array
	 F.S. Daftar inventori bahan mentah dan bahan olahan ditampilkan di layar}
	{ALGORITMA lihatInventori}
	begin
		writeln ('Daftar bahan mentah : ');
		lihatInventoriM (x1);
		writeln ();
		writeln ('Daftar bahan olahan : ');
		lihatInventoriO (x2);
	end;
end.

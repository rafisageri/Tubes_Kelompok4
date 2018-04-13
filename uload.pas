unit uload; {Unit yang berisi semua procedure untuk load berbagai tipe data dari file eksternal yang formatnya terdefinisi}
	

interface
	Uses sysutils, typeuniverse;
	procedure LoadBahanMentah (var bahanMentah : tabmentah); {Membaca file eksternal yang bernama 'bahanmentah.txt' terus dimasukkin ke tipe bentukan mentah}
	procedure LoadBahanOlahan (var bahanOlahan : tabolahan); {Membaca file eksternal yang bernama 'bahanolahan.txt' terus dimasukkin ke tipe bentukan olahan}
		
implementation
	
procedure LoadBahanMentah (var bahanMentah : tabmentah); {Membaca file eksternal yang bernama 'bahanmentah.txt' terus dimasukkin ke tipe bentukan mentah}

var {KAMUS LOKAL LoadBahanMentah}
	guardMark 		: integer; {Menandakan posisi karakter guard dalam string}
	i 				: integer; {counter traversal}
	j				: integer; {Menandakan jumlah bahan mentah dalam file eksternal}
	temp			: array [1..100] of char;  {Menyimpan data pada file eksternal secara sementara}
	tempHarga		: array [1..100] of char;  {Menyimpan data harga bahan dalam bentuk string sebelum di-convert ke integer}
	tempKadaluarsa	: array [1..100] of char;  {Menyimpan data jumlah bahan dalam bentuk string sebelum di-convert ke integer}
	inf				: textfile;
	
begin {ALGORITMA UTAMA LoadBahanMentah}
	assign (inf, 'bahanmentah.txt');
	reset (inf);
	j := 1;
	while (not(EOF(inf))) do
	begin		
		readln (inf, temp);
		{Membaca nama bahan mentah yang bertipe string}
		guardMark := pos ('|', temp);
		for i := 1 to (guardMark-2) do
		begin
			bahanMentah.tab[j].nama[i] := temp[i];
		end;
		{Membaca harga bahan mentah yang bertipe integer}
		temp := copy (temp,guardMark+2, length(temp) - guardMark - 2);
		guardMark := pos ('|', temp);
		for i :=1 to (guardMark-2) do
		begin
			tempHarga[i] := temp[i]
		end;
		bahanMentah.tab[j].harga := StrToInt (tempHarga);
		{Membaca durasi kadaluarsa bahan mentah yang bertipe integer}
		temp := copy (temp,guardMark+2, length(temp) - guardMark - 2);
		for i :=1 to (length(temp)) do
		begin
			tempKadaluarsa[i] := temp[i]
		end;
		bahanMentah.tab[j].Kadaluarsa := StrToInt (tempKadaluarsa);
		
		j := j + 1;
	end;
	close (inf);
end;


procedure LoadBahanOlahan (var bahanOlahan : tabolahan); {Membaca file eksternal yang bernama 'bahanolahan.txt' terus dimasukkin ke tipe bentukan olahan}

var {KAMUS LOKAL LoadBahanOlahan}
	guardMark 		: integer; {Menandakan posisi karakter guard dalam string}
	i,k 			: integer; {counter traversal}
	j				: integer; {Menandakan jumlah bahan mentah dalam file eksternal}
	temp			: array [1..100] of char;  {Menyimpan data pada file eksternal secara sementara, bersifat serbaguna}
	tempHargaJual	: array [1..100] of char;  {Menyimpan data harga bahan dalam bentuk string sebelum di-convert ke integer}
	tempN			: array [1..100] of char;  {Menyimpan data jumlah bahan dalam bentuk string sebelum di-convert ke integer}
	inf				: textfile;
	
begin {ALGORITMA UTAMA LoadBahanOlahan}
	assign (inf, 'bahanolahan.txt');
	reset (inf);
	j := 1;
	while (not(EOF(inf))) do
	begin		
		readln (inf, temp);
		writeln ('ini temp awal ', temp);
		{Membaca nama bahan olahan yang bertipe string}
		guardMark := pos ('|', temp);
		for i := 1 to (guardMark-2) do
		begin
			bahanOlahan.tab[j].nama[i] := temp[i];
		end;
		{Membaca harga jual bahan olahan yang bertipe integer}
		temp := copy (temp,guardMark+2, length(temp));
		writeln ('ini temp pas baca harga jual ', temp);
		guardMark := pos ('|', temp);
		for i :=1 to (guardMark-2) do
		begin
			tempHargaJual[i] := temp[i]
		end;
		writeln ('ini tempHargaJual ', tempHargaJual);
		bahanOlahan.tab[j].harga := StrToInt (tempHargaJual);
		{Membaca jumlah komposisi bahan yang bertipe integer}
		temp := copy (temp,guardMark+2, length(temp));
		writeln ('ini temp pas baca jumlah komposisi bahan ', temp);
		guardMark := pos ('|', temp);
			tempN := temp[1];
		writeln ('Ini tempN ' ,tempN);
		bahanOlahan.tab[j].N := StrToInt (tempN);
		{Membaca komposisi bahan mentah yang menyusun bahan olahan yang bertipe string}
		if (bahanOlahan.tab[j].N = 1) then
		begin	
			temp := copy (temp,guardMark+2, length(temp));
			writeln ('ini temp pas baca komposisi bahan ', temp);
			for i :=1 to (length(temp)) do
			begin
				bahanOlahan.tab[j].komposisi[1].nama[i] := temp[i];
			end;
		end else {bahanOlahan.tab[j].N > 1} begin
			for k:=1 to bahanOlahan.tab[j].N-1 do
			begin
				temp := copy (temp,guardMark+2, length(temp));
				writeln ('ini temp pas baca komposisi bahan ', temp);
				guardMark := pos ('|', temp);
				for i :=1 to (guardMark-2) do
				begin
					bahanOlahan.tab[j].komposisi[k].nama[i] := temp[i];
				end;
			end;
			temp := copy (temp,guardMark+2, length(temp));
			writeln ('ini temp pas baca komposisi bahan ', temp);
			for i :=1 to (length(temp)) do
			begin
				bahanOlahan.tab[j].komposisi[bahanOlahan.tab[j].N].nama[i] := temp[i];
			end;
		end;
		
		j := j + 1;
	end;
	close (inf);
end;

end.
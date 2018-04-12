unit uload; {Unit yang berisi semua procedure untuk load berbagai tipe data dari file eksternal yang formatnya terdefinisi}

Uses sysutils;

procedure LoadBahanMentah (inf : textfile); {Membaca file eksternal yang bernama 'bahanmentah.txt' terus dimasukkin ke tipe bentukan mentah}

var {KAMUS LOKAL LoadBahanMentah}
	guardMark 	: integer; {Menandakan posisi karakter guard dalam string}
	i 			: integer;
	j			: integer; {Menandakan jumlah bahan mentah dalam file eksternal}
	bahanMentah	: array [1..100] of mentah;
	temp		: array [1..100] of char;  {Menyimpan data pada file eksternal secara sementara}
	tempHarga	: array [1..100] of char;  {Menyimpan data harga bahan dalam bentuk string sebelum di-convert ke integer}
	tempJumlah	: array [1..100] of char;  {Menyimpan data jumlah bahan dalam bentuk string sebelum di-convert ke integer}
	
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
			bahanMentah[j].nama[i] := temp[i];
		end;
		{Membaca harga bahan mentah yang bertipe integer}
		temp := copy (temp,guardMark+2, length(temp) - guardMark - 2);
		guardMark := pos ('|', temp);
		for i :=1 to (guardMark-2) do
		begin
			tempHarga[i] := temp[i]
		end;
		bahanMentah[j].harga := StrToInt (tempHarga);
		{Membaca jumlah bahan mentah yang bertipe integer}
		temp := copy (temp,guardMark+2, length(temp) - guardMark - 2);
		for i :=1 to (length(temp)) do
		begin
			tempJumlah[i] := temp[i]
		end;
		bahanMentah[j].jumlah := StrToInt (tempJumlah);
		
		j := j + 1;
	end;
	close (inf);
end.


procedure LoadBahanOlahan (inf : textfile); {Membaca file eksternal yang bernama 'bahanolahan.txt' terus dimasukkin ke tipe bentukan olahan}

var {KAMUS LOKAL LoadBahanOlahan}
	guardMark 	: integer; {Menandakan posisi karakter guard dalam string}
	i 			: integer;
	j			: integer; {Menandakan jumlah bahan mentah dalam file eksternal}
	bahanOlahan	: array [1..100] of olahan;
	temp			: array [1..100] of char;  {Menyimpan data pada file eksternal secara sementara, bersifat serbaguna}
	tempHargaJual	: array [1..100] of char;  {Menyimpan data harga bahan dalam bentuk string sebelum di-convert ke integer}
	tempJumlah		: array [1..100] of char;  {Menyimpan data jumlah bahan dalam bentuk string sebelum di-convert ke integer}
	tempN			: integer; {Menyimpan data jumlah komposisi bahan mentah dalam bentuk integer sebelum di-convert ke integer}
	tempKomposisi	: array [1..100] of mentah;
	
begin {ALGORITMA UTAMA LoadBahanOlahan}
	assign (inf, 'bahanolahan.txt');
	reset (inf);
	j := 1;
	while (not(EOF(inf))) do
	begin		
		readln (inf, temp);
		{Membaca nama bahan olahan yang bertipe string}
		guardMark := pos ('|', temp);
		for i := 1 to (guardMark-2) do
		begin
			bahanOlahan[j].nama[i] := temp[i];
		end;
		{Membaca harga jual bahan olahan yang bertipe integer}
		temp := copy (temp,guardMark+2, length(temp) - guardMark - 2);
		guardMark := pos ('|', temp);
		for i :=1 to (guardMark-2) do
		begin
			tempHargaJual[i] := temp[i]
		end;
		bahanOlahan[j].hargaJual := StrToInt (tempHargaJual);
		{Membaca jumlah komposisi bahan yang bertipe integer}
		temp := copy (temp,guardMark+2, length(temp) - guardMark - 2);
		guardMark := pos ('|', temp);
		for i :=1 to (guardMark-2) do
		begin
			tempJumlah[i] := temp[i]
		end;
		bahanBahan[j].jumlah := StrToInt (tempJumlah);
		
		j := j + 1;
	end;
	close (inf);
end.


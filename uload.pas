unit uload; {Unit yang berisi semua procedure untuk load berbagai tipe data dari file eksternal yang formatnya terdefinisi}
	

interface
	Uses sysutils, typeuniverse;
	procedure LoadBahanMentah (var bahanMentah : tabmentah); {Membaca file eksternal yang bernama 'bahanmentah.txt' terus dimasukkin ke tipe bentukan mentah}
	procedure LoadBahanOlahan (var bahanOlahan : tabolahan); {Membaca file eksternal yang bernama 'bahanolahan.txt' terus dimasukkin ke tipe bentukan olahan}
	procedure LoadInventoriBahanMentah (tabmentah : tabInventoriM); {Membaca file eksternal yang bernama 'InventoriBahanMentah.txt' terus dimasukkin ke tipe bentukan mentah}
	procedure LoadInventoriBahanOlahan (tabolahan : tabInventoriO); {Membaca file eksternal yang bernama 'Inventoribahanolahan.txt' terus dimasukkin ke tipe bentukan olahan}
	procedure LoadResep (var bahanResep : tabResep); {Membaca file eksternal yang bernama 'resep.txt' terus dimasukkin ke tipe bentukan resep}

	
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
		i	 			: integer; {counter traversal}
		j				: integer; {Menandakan jumlah bahan mentah dalam file eksternal}
		temp			: string;  {Menyimpan data pada file eksternal secara sementara, bersifat serbaguna}
		inf				: textfile;
		lTemp			: integer;	{Menandakan panjang temp}
	begin {ALGORITMA UTAMA LoadBahanOlahan}
		assign (inf, 'bahanolahan.txt');
		reset (inf);
		j := 0;
		while (not(EOF(inf))) do
		begin
			j := j+1;
			
			{Membaca nama bahan olahan yang bertipe string}
			readln(inf, temp);
			write('ini temp awal ', temp);
			lTemp := length(temp);
			guardMark := pos ('|', temp);
			bahanOlahan.tab[j].nama := copy(temp, 1, guardMark-2);
					
			{Membaca harga jual bahan olahan yang bertipe integer}
			temp := copy (temp,guardMark+2, lTemp);
			writeln('ini temp pas baca harga jual ', temp);
			lTemp := length(temp);
			guardMark := pos ('|', temp);
			bahanOlahan.tab[j].harga := StrToInt( copy(temp, 1, guardMark-2) );
			
			writeln ('ini tempHargaJual ', bahanOlahan.tab[j].harga);
		
			{Membaca jumlah komposisi bahan mentah dengan asumsi nilai pada file eksternal bisa salah.
			Sehingga jumlah komposisi bahan mentah ditentukan dengan menghitung nama-nama bahan mentah penyusun yang ada pada file}
		 
			temp := copy (temp,guardMark+2, lTemp);			//format temp saat ini nama | nama | ... | nama
			writeln('temp saat ini: ', temp);				//akan dijadikan nama | nama | ... | nama |
			temp:= temp + ' |';								//format temp saat ini nama | nama | ... | nama |
		
			//asumsi bahanOlahan.tab[j].N inkonklusif
			lTemp := length(temp);
			i:=0;
		
			while lTemp <>0 do //temp tidak kosong
			begin
				i:=i+1;
				guardMark := pos ('|', temp);
				bahanOlahan.tab[j].komposisi[i].nama := copy(temp, 1, guardMark-2);
				writeln('nama terekam :', bahanOlahan.tab[j].komposisi[i].nama);
				temp := copy (temp,guardMark+2, lTemp); {Jika guardMark+2 lebih dari ltemp, maka copy () akan mengembalikan string kosong}
				lTemp := length(temp);
			end;
			bahanOlahan.tab[j].N := i;
			//end of process
		end;
		bahanOlahan.neff := j;
		close (inf);
	end;

procedure LoadInventoriBahanMentah (tabmentah : tabInventoriM); {Membaca file eksternal yang bernama 'InventoriBahanMentah.txt' terus dimasukkin ke tipe bentukan mentah}

	var {KAMUS LOKAL InventoriBahanMentah}
		guardMark 	: integer; {Menandakan posisi karakter guard dalam string}
		slashMark 	: integer; {Menandakan posisi karakter slash dalam string}
		j			: integer; {Menandakan jumlah inventori bahan mentah dalam file eksternal} 
		temp		: array [1..100] of char;  {Menyimpan data  dalam bentuk string sebelum di-convert ke integer}
		inf 		: textfile;
	
	
	begin {ALGORITMA UTAMA InventoriBahanMentah}
		assign (inf, 'inventoribahanmentah.txt');
		reset (inf);
		j := 0;
		while (not(EOF(inf))) do
		begin
			j := j + 1;
			readln (inf, temp);
			{Membaca nama inventori bahan mentah yang bertipe string}
			guardMark := pos ('|', temp);
			tabmentah.tab[j].nama := copy (temp, 1, guardMark-2);
		
			{Membaca Hari beli yang bertipe integer}
			temp := copy (temp,guardMark+2, length(temp));
			slashMark := pos ('/', temp);
			tabmentah.tab[j].tglbeli.hari := StrToInt ( copy (temp, 1, slashMark-1) );
		
			{Membaca Bulan beli yang bertipe integer}
			temp := copy (temp,slashmark+1, length(temp));
			slashMark := pos ('/', temp);
			tabmentah.tab[j].tglbeli.bulan := StrToInt (copy (temp, 1, slashMark-1));
		
			{Membaca Tahun beli yang bertipe integer}
			temp := copy (temp,slashmark + 1, length(temp));
			guardMark := pos ('|', temp);
			tabmentah.tab[j].tglbeli.tahun := StrToInt (copy (temp, 1, guardMark-2));
			
			{Membaca Jumlah bahan mentah yang bertipe integer}
			temp := copy (temp,guardMark+2, length(temp));
			tabmentah.tab[j].jumlah := StrToInt (copy (temp, 1, length(temp)));
		end;
		close (inf);
	end;

procedure LoadInventoriBahanOlahan (tabolahan : tabInventoriO); {Membaca file eksternal yang bernama 'Inventoribahanolahan.txt' terus dimasukkin ke tipe bentukan olahan}

	var {KAMUS LOKAL LoadInventoriBahanOlahan}
		guardMark 	: integer; {Menandakan posisi karakter guard dalam string}
		slashMark 	: integer; {Menandakan posisi karakter slash dalam string}
		j			: integer; {Menandakan jumlah bahan mentah dalam file eksternal}
		temp		: array [1..100] of char;  {Menyimpan data  dalam bentuk string sebelum di-convert ke integer}
		inf			: textfile;
	
	
	begin {ALGORITMA UTAMA LoadInventoriBahanOlahan}
		assign (inf, 'inventoribahanolahan.txt');
		reset (inf);
		j := 0;
		while (not(EOF(inf))) do
		begin
			j := j + 1;
			readln (inf, temp);
			{Membaca nama inventori bahan mentah yang bertipe string}
			guardMark := pos ('|', temp);
			tabolahan.tab[j].nama := copy (temp, 1, guardMark-2);
		
			{Membaca Hari beli yang bertipe integer}
			temp := copy (temp,guardMark+2, length(temp));
			slashMark := pos ('/', temp);
			tabolahan.tab[j].tglbuat.hari := StrToInt ( copy (temp, 1, slashMark-1) );
		
			{Membaca Bulan beli yang bertipe integer}
			temp := copy (temp,slashmark+1, length(temp));
			slashMark := pos ('/', temp);
			tabolahan.tab[j].tglbuat.bulan := StrToInt (copy (temp, 1, slashMark-1));
			
			{Membaca Tahun beli yang bertipe integer}
			temp := copy (temp,slashmark + 1, length(temp));
			guardMark := pos ('|', temp);
			tabolahan.tab[j].tglbuat.tahun := StrToInt (copy (temp, 1, guardMark-2));
		
			{Membaca Jumlah bahan mentah yang bertipe integer}
			temp := copy (temp,guardMark+2, length(temp));
			tabolahan.tab[j].jumlah := StrToInt (copy (temp, 1, length(temp)));
		end;
		close (inf);
	end;

procedure LoadResep (var bahanResep : tabResep); {Membaca file eksternal yang bernama 'resep.txt' terus dimasukkin ke tipe bentukan resep}

	var {KAMUS LOKAL LoadResep}
		guardMark 		: integer; {Menandakan posisi karakter guard dalam string}
		i	 			: integer; {counter traversal}
		j				: integer; {Menandakan jumlah bahan mentah dalam file eksternal}
		temp			: string;  {Menyimpan data pada file eksternal secara sementara, bersifat serbaguna}
		inf				: textfile;
		lTemp			: integer;	{Menandakan panjang temp}
	begin {ALGORITMA UTAMA LoadResep}
		assign (inf, 'resep.txt');
		reset (inf);
		j := 0;
		while (not(EOF(inf))) do
		begin
			j := j+1;
			
			{Membaca nama resep yang bertipe string}
			readln(inf, temp);
			write('ini temp awal ', temp);
			lTemp := length(temp);
			guardMark := pos ('|', temp);
			bahanResep.tab[j].nama := copy(temp, 1, guardMark-2);
					
			{Membaca harga jual resep yang bertipe integer}
			temp := copy (temp,guardMark+2, lTemp);
			writeln('ini temp pas baca harga jual ', temp);
			lTemp := length(temp);
			guardMark := pos ('|', temp);
			bahanResep.tab[j].harga := StrToInt( copy(temp, 1, guardMark-2) );
			
			writeln ('ini tempHargaJual ', bahanResep.tab[j].harga);
		
			{Membaca jumlah komposisi bahan mentah dengan asumsi nilai pada file eksternal bisa salah.
			Sehingga jumlah komposisi bahan mentah ditentukan dengan menghitung nama-nama bahan mentah penyusun yang ada pada file}
		 
			temp := copy (temp,guardMark+2, lTemp);			//format temp saat ini nama | nama | ... | nama
			writeln('temp saat ini: ', temp);				//akan dijadikan nama | nama | ... | nama |
			temp:= temp + ' |';								//format temp saat ini nama | nama | ... | nama |
		
			//asumsi bahanResep.tab[j].N inkonklusif
			lTemp := length(temp);
			i:=0;
		
			while lTemp <>0 do //temp tidak kosong
			begin
				i:=i+1;
				guardMark := pos ('|', temp);
				bahanResep.tab[j].komposisi[i].nama := copy(temp, 1, guardMark-2);
				writeln('nama terekam :', bahanResep.tab[j].komposisi[i].nama);
				temp := copy (temp,guardMark+2, lTemp); {Jika guardMark+2 lebih dari ltemp, maka copy () akan mengembalikan string kosong}
				lTemp := length(temp);
			end;
			bahanResep.tab[j].N := i;
			//end of process
		end;
		bahanResep.neff := j;
		close (inf);
	end;
end.

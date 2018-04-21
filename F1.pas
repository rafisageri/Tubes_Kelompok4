unit F1; {Unit yang berisi semua procedure untuk load berbagai tipe data dari file eksternal yang formatnya terdefinisi}
	
interface
	Uses sysutils, typeuniverse, F8;
	function cekBahanMentah (bahan : string; daftarBahan : tabmentah): integer;
	function cekBahanOlahan (bahan : string; daftarBahan : tabolahan): integer;
	procedure LoadBahanMentah (var bahanMentah : tabmentah); {Membaca file eksternal yang bernama 'bahanmentah.txt' terus dimasukkin ke tipe bentukan mentah}
	procedure LoadBahanOlahan (var bahanOlahan : tabolahan); {Membaca file eksternal yang bernama 'bahanolahan.txt' terus dimasukkin ke tipe bentukan olahan}
	procedure LoadInventoriMentah (nfile: integer; nama:string; var listMentah:listInventoriM);{Membaca file eksternal yang bernama 'nama' terus dimasukkin ke tipe bentukan mentah. Format 'nama': 'inventoribahanmentah[nfile].txt'}
	procedure LoadInventoriOlahan (nfile: integer; nama:string; var listOlahan:listInventoriO);{Membaca file eksternal yang bernama 'nama' terus dimasukkin ke tipe bentukan olahan. Format 'nama': 'inventoribahanolahan[nfile].txt'}
	procedure LoadResep (var bahanResep : tabResep; daftarMentah : tabmentah; daftarOlahan : tabolahan); {Membaca file eksternal yang bernama 'resep.txt' terus dimasukkin ke tipe bentukan resep}
	procedure LoadFileSimulasi (nfile: integer; nama:string; var arr: listSimulasi);
	
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
		writeln ('> File bahan mentah berhasil di-load');
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
			lTemp := length(temp);
			guardMark := pos ('|', temp);
			bahanOlahan.tab[j].nama := copy(temp, 1, guardMark-2);
					
			{Membaca harga jual bahan olahan yang bertipe integer}
			temp := copy (temp,guardMark+2, lTemp);
			lTemp := length(temp);
			guardMark := pos ('|', temp);
			bahanOlahan.tab[j].harga := StrToInt( copy(temp, 1, guardMark-2) );
		
			{Membaca jumlah komposisi bahan olahan dengan asumsi nilai pada file eksternal bisa salah.
			Sehingga jumlah komposisi bahan olahan ditentukan dengan menghitung nama-nama bahan mentah penyusun yang ada pada file}
			temp := copy (temp,guardMark+2, lTemp);
			guardMark := pos ('|', temp);
			lTemp := length(temp);
			
			temp := copy (temp,guardMark+2, lTemp);			//format temp saat ini nama | nama | ... | nama
			temp:= temp + ' |';					//format temp saat ini nama | nama | ... | nama |
		
			//asumsi bahanOlahan.tab[j].N inkonklusif
			lTemp := length(temp);
			i:=0;
		
			while lTemp <>0 do //temp tidak kosong
			begin
				i:=i+1;
				guardMark := pos ('|', temp);
				bahanOlahan.tab[j].komposisi[i].nama := copy(temp, 1, guardMark-2);
				temp := copy (temp,guardMark+2, lTemp); {Jika guardMark+2 lebih dari ltemp, maka copy () akan mengembalikan string kosong}
				lTemp := length(temp);
			end;
			bahanOlahan.tab[j].N := i;
			//end of process
		end;
		bahanOlahan.neff := j;
		close (inf);
		writeln ('> File bahan olahan berhasil di-load');
	end;

procedure LoadInventoriMentah (nfile: integer; nama:string; var listMentah:listInventoriM);{Membaca file eksternal yang bernama 'nama' terus dimasukkin ke tipe bentukan mentah. Format 'nama': 'inventoribahanmentah[nfile].txt'}

	var {KAMUS LOKAL InventoriBahanMentah}
		guardMark 	: integer; {Menandakan posisi karakter guard dalam string}
		slashMark 	: integer; {Menandakan posisi karakter slash dalam string}
		j			: integer; {Menandakan jumlah inventori bahan mentah dalam file eksternal} 
		temp		: array [1..100] of char;  {Menyimpan data  dalam bentuk string sebelum di-convert ke integer}
		inf 		: textfile;
	
	
	begin {ALGORITMA UTAMA InventoriBahanMentah}
		assign (inf, nama);
		reset (inf);
		j := 0;
		while (not(EOF(inf))) do
		begin
			j := j + 1;
			readln (inf, temp);
			{Membaca nama inventori bahan mentah yang bertipe string}
			guardMark := pos ('|', temp);
			listMentah.list[nfile].tab[j].nama := copy (temp, 1, guardMark-2);
		
			{Membaca Hari beli yang bertipe integer}
			temp := copy (temp,guardMark+2, length(temp));
			slashMark := pos ('/', temp);
			listMentah.list[nfile].tab[j].tglbeli.hari := StrToInt ( copy (temp, 1, slashMark-1) );
		
			{Membaca Bulan beli yang bertipe integer}
			temp := copy (temp,slashmark+1, length(temp));
			slashMark := pos ('/', temp);
			listMentah.list[nfile].tab[j].tglbeli.bulan := StrToInt (copy (temp, 1, slashMark-1));
		
			{Membaca Tahun beli yang bertipe integer}
			temp := copy (temp,slashmark + 1, length(temp));
			guardMark := pos ('|', temp);
			listMentah.list[nfile].tab[j].tglbeli.tahun := StrToInt (copy (temp, 1, guardMark-2));
			
			{Membaca Jumlah bahan mentah yang bertipe integer}
			temp := copy (temp,guardMark+2, length(temp));
			listMentah.list[nfile].tab[j].jumlah := StrToInt (copy (temp, 1, length(temp)));
		end;
		close (inf);
		writeln ('> File inventori bahan mentah berhasil di-load');
	end;

procedure LoadInventoriOlahan (nfile: integer; nama:string; var listOlahan:listInventoriO);{Membaca file eksternal yang bernama 'nama' terus dimasukkin ke tipe bentukan olahan. Format 'nama': 'inventoribahanolahan[nfile].txt'}

	var {KAMUS LOKAL LoadInventoriOlahan}
		guardMark 	: integer; {Menandakan posisi karakter guard dalam string}
		slashMark 	: integer; {Menandakan posisi karakter slash dalam string}
		j			: integer; {Menandakan jumlah bahan mentah dalam file eksternal}
		temp		: array [1..100] of char;  {Menyimpan data  dalam bentuk string sebelum di-convert ke integer}
		inf			: textfile;
	
	
	begin {ALGORITMA UTAMA LoadInventoriOlahan}
		assign (inf, nama);
		reset (inf);
		j := 0;
		while (not(EOF(inf))) do
		begin
			j := j + 1;
			readln (inf, temp);
			{Membaca nama inventori bahan mentah yang bertipe string}
			guardMark := pos ('|', temp);
			listOlahan.list[nfile].tab[j].nama := copy (temp, 1, guardMark-2);
		
			{Membaca Hari beli yang bertipe integer}
			temp := copy (temp,guardMark+2, length(temp));
			slashMark := pos ('/', temp);
			listOlahan.list[nfile].tab[j].tglbuat.hari := StrToInt ( copy (temp, 1, slashMark-1) );
		
			{Membaca Bulan beli yang bertipe integer}
			temp := copy (temp,slashmark+1, length(temp));
			slashMark := pos ('/', temp);
			listOlahan.list[nfile].tab[j].tglbuat.bulan := StrToInt (copy (temp, 1, slashMark-1));
			
			{Membaca Tahun beli yang bertipe integer}
			temp := copy (temp,slashmark + 1, length(temp));
			guardMark := pos ('|', temp);
			listOlahan.list[nfile].tab[j].tglbuat.tahun := StrToInt (copy (temp, 1, guardMark-2));
		
			{Membaca Jumlah bahan mentah yang bertipe integer}
			temp := copy (temp,guardMark+2, length(temp));
			listOlahan.list[nfile].tab[j].jumlah := StrToInt (copy (temp, 1, length(temp)));
		end;
		close (inf);
		writeln ('> File bahan olahan berhasil di-load');
	end;
	
function cekBahanMentah (bahan : string; daftarBahan : tabmentah): integer;
{I.S. Nama bahan mentah yang akan dicari dan daftar bahan mentahnya terdefinisi
 F.S. Fungsi akan mengembalikan nomor indeks posisi bahan mentah pada daftar bahan mentah 
 dan mengembalikan -1 jika nama bahan mentah tidak ditemukan pada daftar bahan mentah}
	var {KAMUS LOKAL cariBahanMentah}
		stop : boolean;
		i : integer;
	begin {ALGORITMA cariBahanMentah}
		stop := False;
		i := 1;
		while ( (i<=daftarBahan.neff) and (stop=False) ) do
		begin
			if (bahan = daftarBahan.tab[i].nama) then 
			begin
				stop := True;
			end;
			i := i + 1;
		end;
		{Jika looping berhenti bukan karena stop bernilai True, berarti bahan tidak ditemukan. 
		 Sehingga fungsi akan mengembalikan nilai -1}
		if (stop) then
			cekBahanMentah := i
		else
			cekBahanMentah := -1;
	end;

function cekBahanOlahan (bahan : string; daftarBahan : tabolahan): integer;
{I.S. Nama bahan olahan yang akan dicari dan daftar bahan olahannya terdefinisi
 F.S. Fungsi akan mengembalikan nomor indeks posisi bahan olahan pada daftar bahan olahan 
 dan mengembalikan -1 jika nama bahan olahan tidak ditemukan pada daftar bahan olahan}
	var {KAMUS LOKAL cariBahanOlahan}
		stop : boolean;
		i : integer;
	begin {ALGORITMA cariBahanOlahan}
		stop := False;
		i := 1;
		while ( (i<=daftarBahan.neff) and (stop=False) ) do
		begin
			if (bahan = daftarBahan.tab[i].nama) then 
			begin
				stop := True;
			end;
			i := i + 1;
		end;
		{Jika looping berhenti bukan karena stop bernilai True, berarti bahan tidak ditemukan. 
		 Sehingga fungsi akan mengembalikan nilai -1}
		if (stop) then
			cekBahanOlahan := i
		else
			cekBahanOlahan := -1;
	end;
	
procedure LoadResep (var bahanResep : tabResep; daftarMentah : tabmentah; daftarOlahan : tabolahan); {Membaca file eksternal yang bernama 'resep.txt' terus dimasukkin ke tipe bentukan resep}

	var {KAMUS LOKAL LoadResep}
		guardMark 		: integer; {Menandakan posisi karakter guard dalam string}
		nmentah,nolahan	: integer; {counter traversal}
		j				: integer; {Menandakan jumlah bahan mentah dalam file eksternal}
		temp			: string;  {Menyimpan data pada file eksternal secara sementara, bersifat serbaguna}
		inf				: textfile;
		lTemp			: integer;	{Menandakan panjang temp}
		p,q				: integer;
		tempS			: string;
		
	begin {ALGORITMA UTAMA LoadResep}
		assign (inf, 'resep.txt');
		reset (inf);
		j := 0;
		while (not(EOF(inf))) do
		begin
			j := j+1;
			
			{Membaca nama resep yang bertipe string}
			readln(inf, temp);
			lTemp := length(temp);
			guardMark := pos ('|', temp);
			bahanResep.tab[j].nama := copy(temp, 1, guardMark-2);
					
			{Membaca harga jual resep yang bertipe integer}
			temp := copy (temp,guardMark+2, lTemp);
			lTemp := length(temp);
			guardMark := pos ('|', temp);
			bahanResep.tab[j].harga := StrToInt( copy(temp, 1, guardMark-2) );
			
			{Membaca jumlah bahan-bahan penyusun resep dengan asumsi nilai pada file eksternal bisa salah.
			Sehingga jumlah bahan-bahan penyusun resep ditentukan dengan menghitung nama-nama bahan penyusun resep yang ada pada file}
			temp := copy (temp,guardMark+2, lTemp);
			guardMark := pos ('|', temp);
			lTemp := length(temp);
			
			temp := copy (temp,guardMark+2, lTemp);			//format temp saat ini nama | nama | ... | nama
			temp:= temp + ' |';					//format temp saat ini nama | nama | ... | nama |
		
			//asumsi bahanResep.tab[j].N inkonklusif
			lTemp := length(temp);
			nmentah:=0;
			nolahan:=0;
			while lTemp <>0 do //temp tidak kosong
			begin
				guardMark := pos ('|', temp);
				tempS := copy(temp, 1, guardMark-2);
				p := CekBahanMentah (tempS, daftarMentah);
				q := CekBahanOlahan (tempS, daftarOlahan); 
				if ((p=-1) and (q=-1)) then
				begin
					writeln ('File resep baris ke ', j, ' memiliki bahan penyusun yang tidak terdefinisi');
				end else if (p=-1) then
				begin
					nolahan := nolahan + 1;
					bahanResep.tab[j].partolahan[nolahan].nama := tempS;
				end else if (q=-1) then
				begin
					nmentah := nmentah + 1;
					bahanResep.tab[j].partmentah[nmentah].nama := tempS;
				end else 
				begin
					writeln ('File resep baris ke ', j, ' memiliki bahan penyusun yang tidak terdefinisi');
				end;
				temp := copy (temp,guardMark+2, lTemp); {Jika guardMark+2 lebih dari ltemp, maka copy () akan mengembalikan string kosong}
				lTemp := length(temp);
			end;
			bahanResep.tab[j].nmentah := nmentah;
			bahanResep.tab[j].nolahan := nolahan;
			//end of process
		end;
		bahanResep.neff := j;
		close (inf);
		writeln ('> File resep berhasil di-load');
	end;
	
procedure LoadFileSimulasi (nfile: integer; nama:string; var arr: listSimulasi);
	//I.S. terdapat textfile yang akan diassign ke inf.
	//F.S. arr terisi
	var {KAMUS LOKAL LoadFileSimulasi}
		inf : textfile;
		tempTgl, temp : string;
		guardmark, l, slashmark, lTgl : integer;
		tt, bb, hh : word;
	begin {ALGORITMA LoadFileSimulasi}
		assign(inf, nama);
		reset(inf);
		{format isi data:
		nomor | hari hidup | energi | kapasitas inv. maks | Total Bahan Mentah Dibeli |
		Total Bahan Olahan Dibuat | Total Bahan Olahan Dijual | Total Resep Dijual |
		Total Pemasukan | Total Pengeluaran | Total Pendapatan}
		 
		while not(eof(inf)) do
		begin
			
			read(inf, temp);											//baca isi file ke variabel temp: string
			l:= length(temp);
			guardmark := pos ('|' , temp);								//indeks dimana karakter '|' ditemukan
			arr.list[nfile].nomor := StrToInt( copy(temp, 1, (guardmark-2)) ); 		//assign nomor
			

			temp := copy (temp, guardmark+2, l); 						//truncate temp
			l := l - guardmark - 1;										//panjang baru
			guardmark := pos ('|' , temp);								//indeks dimana karakter '|' ditemukan
			tempTgl := copy(temp, 1, guardmark-2);
			//format tempTgl hari/bulan/tahun
			
			////////////////////////////////////////////////////////////////////////////
			lTgl := length(tempTgl);
			slashmark := pos ('/', tempTgl);
			arr.list[nfile].awalsim.hari := StrToInt(copy(tempTgl, 1, slashmark-1));
			tempTgl := copy(tempTgl, slashmark+1, lTgl);
			
			lTgl := lTgl-slashmark;
			slashmark := pos ('/', tempTgl);
			arr.list[nfile].awalsim.bulan := StrToInt(copy(tempTgl, 1, slashmark-1));
			arr.list[nfile].awalsim.tahun := StrToInt(copy(tempTgl, slashmark+1, lTgl));
			////////////////////////////////////////////////////////////////////////////
			
			temp := copy (temp, guardmark+2, l); 						//truncate temp
			l := l - guardmark - 1;										//panjang baru
			guardmark := pos ('|' , temp);								//indeks dimana karakter '|' ditemukan
			arr.list[nfile].totalhari := StrToInt( copy(temp, 1, (guardmark-2)) ); //assign totalhari
			
			if arr.list[nfile].totalhari = 0 then
			begin
				DeCodeDate (Date,tt,bb,hh);
				
				arr.list[nfile].awalsim.hari := hh;		//assign awalsim
				arr.list[nfile].awalsim.bulan := bb;
				arr.list[nfile].awalsim.tahun := tt;
				
				arr.list[nfile].energi := 10;
				arr.list[nfile].kapasitas := 25;
				arr.list[nfile].totalmentahbeli := 0;
				arr.list[nfile].totalbahanbuat := 0;
				arr.list[nfile].totalbahanjual := 0;
				arr.list[nfile].totalresepjual := 0;
				arr.list[nfile].pemasukan := 5000000;//modal
				arr.list[nfile].pengeluaran := 0;
				arr.list[nfile].uang := 5000000;//modal
			end
			else
			begin
				temp := copy (temp, guardmark+2, l); 						//truncate temp
				l := l - guardmark - 1;										//panjang baru
				guardmark := pos ('|' , temp);								//indeks dimana karakter '|' ditemukan
				arr.list[nfile].energi := StrToInt( copy(temp, 1, (guardmark-2)) );		//assign energi
			
				temp := copy (temp, guardmark+2, l); 						//truncate temp
				l := l - guardmark - 1;										//panjang baru
				guardmark := pos ('|' , temp);								//indeks dimana karakter '|' ditemukan
				arr.list[nfile].kapasitas := StrToInt( copy(temp, 1, (guardmark-2)) );	//assign kapasitas
				
				temp := copy (temp, guardmark+2, l); 						//truncate temp
				l := l - guardmark - 1;										//panjang baru
				guardmark := pos ('|' , temp);								//indeks dimana karakter '|' ditemukan
				arr.list[nfile].totalmentahbeli := StrToInt( copy(temp, 1, (guardmark-2)) );	//assign totalmentahbeli
			
				temp := copy (temp, guardmark+2, l); 						//truncate temp
				l := l - guardmark - 1;										//panjang baru
				guardmark := pos ('|' , temp);								//indeks dimana karakter '|' ditemukan
				arr.list[nfile].totalbahanbuat := StrToInt( copy(temp, 1, (guardmark-2)) );	//assign totalbahanbuat
			
				temp := copy (temp, guardmark+2, l); 						//truncate temp
				l := l - guardmark - 1;										//panjang baru
				guardmark := pos ('|' , temp);								//indeks dimana karakter '|' ditemukan
				arr.list[nfile].totalbahanjual := StrToInt( copy(temp, 1, (guardmark-2)) );	//assign totalbahanjual
			
				temp := copy (temp, guardmark+2, l); 						//truncate temp
				l := l - guardmark - 1;										//panjang baru
				guardmark := pos ('|' , temp);								//indeks dimana karakter '|' ditemukan
				arr.list[nfile].totalresepjual := StrToInt( copy(temp, 1, (guardmark-2)) );	//assign totalresepjual
			
				temp := copy (temp, guardmark+2, l); 						//truncate temp
				l := l - guardmark - 1;										//panjang baru
				guardmark := pos ('|' , temp);								//indeks dimana karakter '|' ditemukan
				arr.list[nfile].pemasukan := StrToInt( copy(temp, 1, (guardmark-2)) );	//assign pemasukan
			
				temp := copy (temp, guardmark+2, l); 						//truncate temp
				l := l - guardmark - 1;										//panjang baru
				guardmark := pos ('|' , temp);								//indeks dimana karakter '|' ditemukan
				arr.list[nfile].pengeluaran := StrToInt( copy(temp, 1, (guardmark-2)) );	//assign pengeluaran
			
				arr.list[nfile].uang := arr.list[nfile].pemasukan - arr.list[nfile].pengeluaran; //assign uang
			end;
		end;
	
		close(inf);
		writeln ('> File simulasi berhasil di-load');
	end;
end.

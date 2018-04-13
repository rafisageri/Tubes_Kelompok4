unit simul;
//buat tipe data simulasi

interface
	uses
		typeuniverse,
		sysutils;
	type
		simulasi = record
			nomor			: integer;
			awalsim			: tanggal;
			totalhari		: integer;
			energi			: integer;
			kapasitas		: integer;
			totalmentahbeli	: integer;
			totalbahanbuat	: integer;
			totalbahanjual	: integer;
			totalresepjual	: integer;
			pemasukan		: integer;
			pengeluaran		: integer;
			uang			: integer;
		end;		
		listSimulasi = record
			list	: array [1..10] of simulasi;
			neff	: integer;
		end;
		fileSimul = textfile;
	
	procedure pSimToArr(nfile: integer; nama:string; var arr: listSimulasi);
	//I.S. terdapat textfile yang akan diassign ke inf.
	//F.S. arr terisi
	procedure pArrToSim(nfile: integer; nama:string; arr: listSimulasi);
	//I.S. arr terdefinisi
	//F.S. textfile inf terdefinisi
	procedure lihatStatistik(nfile:integer; arr: listSimulasi);
	//I.S. nfile, arr terdefinisi
	//menampilkan isi arr
	
implementation
	procedure pSimToArr(nfile: integer; nama:string; var arr: listSimulasi);
	var
		inf : fileSimul;
		tempTgl, temp : string;
		guardmark, l, slashmark, lTgl : integer;
		tt, bb, hh : word;
	begin
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
				arr.list[nfile].pemasukan := 0;
				arr.list[nfile].pengeluaran := 0;
				arr.list[nfile].uang := 0;
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
	end;

	procedure pArrToSim(nfile: integer; nama:string; arr: listSimulasi);
	//I.S. arr terdefinisi
	//F.S. textfile inf terdefinisi
	var
		inf:fileSimul;
		temp, dateStr : string;
	begin

		assign(inf, nama);
		rewrite(inf);
		dateStr:= IntToStr(arr.list[nfile].awalsim.hari) + '/' + IntToStr(arr.list[nfile].awalsim.bulan) +'/' + IntToStr(arr.list[nfile].awalsim.tahun);
		
		
		{format isi data:
		nomor | tgl mulai |hari hidup | energi | kapasitas inv. maks | Total Bahan Mentah Dibeli |
		Total Bahan Olahan Dibuat | Total Bahan Olahan Dijual | Total Resep Dijual |
		Total Pemasukan | Total Pengeluaran | Total Pendapatan}
		temp := IntToStr(arr.list[nfile].nomor);
		temp := temp + ' | ' + dateStr;
		temp := temp + ' | ' + IntToStr(arr.list[nfile].totalhari);
		temp := temp + ' | ' + IntToStr(arr.list[nfile].energi);
		temp := temp + ' | ' + IntToStr(arr.list[nfile].kapasitas);
		temp := temp + ' | ' + IntToStr(arr.list[nfile].totalmentahbeli);
		temp := temp + ' | ' + IntToStr(arr.list[nfile].totalbahanbuat);
		temp := temp + ' | ' + IntToStr(arr.list[nfile].totalbahanjual);
		temp := temp + ' | ' + IntToStr(arr.list[nfile].totalresepjual);
		temp := temp + ' | ' + IntToStr(arr.list[nfile].pemasukan);
		temp := temp + ' | ' + IntToStr(arr.list[nfile].pengeluaran);
		temp := temp + ' | ' + IntToStr(arr.list[nfile].uang);
		writeln(temp);
		write(inf, temp);
		close(inf);
	end;
	
	procedure lihatStatistik(nfile:integer; arr: listSimulasi);
	begin
		writeln('Nomor simulasi: ', arr.list[nfile].nomor);
		writeln('Tanggal awal simulasi (DD/MM/YYYY): ', arr.list[nfile].awalsim.hari, '/', arr.list[nfile].awalsim.bulan, '/', arr.list[nfile].awalsim.tahun);
		writeln('Jumlah hari hidup: ', arr.list[nfile].totalhari);
		writeln('Jumlah energi: ', arr.list[nfile].energi);
		writeln('Kapasitas maksimum inventori: ', arr.list[nfile].kapasitas);
		writeln('Total bahan mentah dibeli: ', arr.list[nfile].totalmentahbeli);
		writeln('Total bahan olahan dibuat: ', arr.list[nfile].totalbahanbuat);
		writeln('Total bahan olahan dijual: ', arr.list[nfile].totalbahanjual);
		writeln('Total resep dijual: ', arr.list[nfile].totalresepjual);
		writeln('Total pemasukan: ', arr.list[nfile].pemasukan);
		writeln('Total pengeluaran: ', arr.list[nfile].pengeluaran);
		writeln('Total uang: ', arr.list[nfile].uang);
		
	end;
	
end.
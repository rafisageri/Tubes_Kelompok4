unit simul;

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
	procedure fSim2var(var inf:fileSimul; var nama:string; var arr: listSimulasi);
	
implementation
	procedure fSim2var(var inf:fileSimul; var nama:string; var arr: listSimulasi);
	var
		temp: string;
		guardmark, l, nfile: integer;
	begin
		nfile:=0;
		 readln(nama);
		 assign(inf, nama);
		 reset(inf);
		 
		 {format isi data:
		 nomor | hari hidup | energi | kapasitas inv. maks | Total Bahan Mentah Dibeli |
		 Total Bahan Olahan Dibuat | Total Bahan Olahan Dijual | Total Resep Dijual |
		 Total Pemasukan | Total Pengeluaran | Total Pendapatan}
		 
		 while not(eof(inf)) do
		 begin
			nfile:=nfile+1;
		 
			read(inf, temp);											//baca isi file ke variabel temp: string
			l:= length(temp);
			guardmark := pos ('|' , temp);								//indeks dimana karakter '|' ditemukan
			arr.list[nfile].nomor := StrToInt( copy(temp, 1, (guardmark-2)) ); 		//assign nomor
			
			temp := copy (temp, guardmark+2, l); 						//truncate temp
			l := l- guardmark+2;										//panjang baru
			guardmark := pos ('|' , temp);								//indeks dimana karakter '|' ditemukan
			//arr.list	//assign awalsim
			
			temp := copy (temp, guardmark+2, l); 						//truncate temp
			l := l- guardmark+2;										//panjang baru
			guardmark := pos ('|' , temp);								//indeks dimana karakter '|' ditemukan
			arr.list[nfile].totalhari := StrToInt( copy(temp, 1, (guardmark-2)) ); //assign totalhari
			
			temp := copy (temp, guardmark+2, l); 						//truncate temp
			l := l- guardmark+2;										//panjang baru
			guardmark := pos ('|' , temp);								//indeks dimana karakter '|' ditemukan
			arr.list[nfile].energi := StrToInt( copy(temp, 1, (guardmark-2)) );		//assign energi
			
			temp := copy (temp, guardmark+2, l); 						//truncate temp
			l := l- guardmark+2;										//panjang baru
			guardmark := pos ('|' , temp);								//indeks dimana karakter '|' ditemukan
			arr.list[nfile].kapasitas := StrToInt( copy(temp, 1, (guardmark-2)) );	//assign kapasitas
			
			temp := copy (temp, guardmark+2, l); 						//truncate temp
			l := l- guardmark+2;										//panjang baru
			guardmark := pos ('|' , temp);								//indeks dimana karakter '|' ditemukan
			arr.list[nfile].totalmentahbeli := StrToInt( copy(temp, 1, (guardmark-2)) );	//assign totalmentahbeli
			
			temp := copy (temp, guardmark+2, l); 						//truncate temp
			l := l- guardmark+2;										//panjang baru
			guardmark := pos ('|' , temp);								//indeks dimana karakter '|' ditemukan
			arr.list[nfile].totalbahanbuat := StrToInt( copy(temp, 1, (guardmark-2)) );	//assign totalbahanbuat
			
			temp := copy (temp, guardmark+2, l); 						//truncate temp
			l := l- guardmark+2;										//panjang baru
			guardmark := pos ('|' , temp);								//indeks dimana karakter '|' ditemukan
			arr.list[nfile].totalbahanjual := StrToInt( copy(temp, 1, (guardmark-2)) );	//assign totalbahanjual
			
			temp := copy (temp, guardmark+2, l); 						//truncate temp
			l := l- guardmark+2;										//panjang baru
			guardmark := pos ('|' , temp);								//indeks dimana karakter '|' ditemukan
			arr.list[nfile].totalresepjual := StrToInt( copy(temp, 1, (guardmark-2)) );	//assign totalresepjual
			writeln(arr.list[nfile].totalresepjual);
			
			temp := copy (temp, guardmark+2, l); 						//truncate temp
			l := l- guardmark+2;										//panjang baru
			guardmark := pos ('|' , temp);								//indeks dimana karakter '|' ditemukan
			arr.list[nfile].pemasukan := StrToInt( copy(temp, 1, (guardmark-2)) );	//assign pemasukan
			
			temp := copy (temp, guardmark+2, l); 						//truncate temp
			l := l- guardmark+2;										//panjang baru
			guardmark := pos ('|' , temp);								//indeks dimana karakter '|' ditemukan
			arr.list[nfile].pengeluaran := StrToInt( copy(temp, 1, (guardmark-2)) );	//assign pengeluaran
			
			temp := copy (temp, guardmark+2, l); 						//truncate temp
			l := l- guardmark+2;										//panjang baru
			arr.list[nfile].uang := StrToInt(temp);									//assign uang
		 end;
		 
		 close(inf);
	end;
end.
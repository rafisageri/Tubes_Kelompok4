unit F2;

interface
	uses sysutils, typeuniverse;
	procedure SaveFileSimulasi (nfile: integer; nama:string; arr: listSimulasi);
	procedure SaveInventoriMentah (nfile : integer; nama : string; arr : listInventoriM);
	procedure SaveInventoriOlahan (nfile : integer; nama : string; arr : listInventoriO);
	procedure SaveResep (resep : tabResep);
	procedure SaveBahanOlahan (olahan : tabolahan);
	
implementation
procedure SaveFileSimulasi (nfile: integer; nama:string; arr: listSimulasi);
	//I.S. arr terdefinisi
	//F.S. textfile inf terdefinisi
	var {KAMUS LOKAL SaveFileSimulasi}
		inf:textfile;
		temp, dateStr : string;
	begin {ALGORITMA SaveFileSimulasi}
		assign(inf, nama);
		rewrite(inf);
		dateStr:= IntToStr(arr.list[nfile].awalsim.hari) + '/' + IntToStr(arr.list[nfile].awalsim.bulan) +'/' + IntToStr(arr.list[nfile].awalsim.tahun);
		{format isi data: 
		 Nomor Simulasi | Tanggal | Jumlah Hari Hidup | Jumlah Energi | Kapasitas Maksimum Inventori | 
		 Total Bahan Mentah Dibeli | Total Bahan Olahan Dibuat | Total Bahan Olahan Dijual | Total Resep Dijual | 
		 Total Pemasukan | Total Pengeluaran | Total Pendapatan }
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
		write(inf, temp);
		close(inf);
		writeln ('>File simulasi berhasil tersimpan');
	end;
	
procedure SaveInventoriMentah (nfile : integer; nama : string; arr : listInventoriM);
	{I.S. Inventori bahan mentah saat ini terdefinisi
	 F.S. File eksternal berisi data inventori bahan mentah saat ini}
	var {KAMUS LOKAL SaveInventoriMentah}
		inf : textfile;
		temp, dateStr : string;
		i : integer;
	begin {ALGORITMA SaveInventoriOlahan}
		assign (inf, nama);
		rewrite (inf);
		{format isi data: Nama Bahan Mentah | Tanggal Beli | Jumlah }
		for i :=1 to arr.list[nfile].neff do
		begin
			dateStr := IntToStr(arr.list[nfile].tab[i].tglbeli.hari) + '/' + IntToStr(arr.list[nfile].tab[i].tglbeli.bulan) +'/' + IntToStr(arr.list[nfile].tab[i].tglbeli.tahun);
			temp := arr.list[nfile].tab[i].nama + ' | ' + dateStr + ' | ' + IntToStr(arr.list[nfile].tab[i].jumlah);
			writeln (inf, temp);
		end;
		close (inf);
		writeln ('>File inventori bahan mentah berhasil tersimpan');
	end;
	
procedure SaveInventoriOlahan (nfile : integer; nama : string; arr : listInventoriO);
	{I.S. Inventori bahan olahan saat ini terdefinisi
	 F.S. File eksternal berisi data inventori bahan olahan saat ini}
	var {KAMUS LOKAL SaveInventoriOlahan}
		inf : textfile;
		temp, dateStr : string;
		i : integer;
	begin {ALGORITMA SaveInventoriOlahan}
		assign (inf, nama);
		rewrite (inf);
		{format isi data: Nama Bahan Olahan | Tanggal Buat | Jumlah }
		for i :=1 to arr.list[nfile].neff do
		begin
			dateStr := IntToStr(arr.list[nfile].tab[i].tglbuat.hari) + '/' + IntToStr(arr.list[nfile].tab[i].tglbuat.bulan) +'/' + IntToStr(arr.list[nfile].tab[i].tglbuat.tahun);
			temp := arr.list[nfile].tab[i].nama + ' | ' + dateStr + ' | ' + IntToStr(arr.list[nfile].tab[i].jumlah) + IntToStr(arr.list[nfile].tab[i].harga);
			writeln (inf, temp);
		end;
		close (inf);
		writeln ('>File inventori bahan olahan berhasil tersimpan');
	end;
	
procedure SaveResep (resep : tabResep);
	{I.S. Tabel data resep saat ini terdefinisi
	 F.S. File eksternal 'resep.txt' berisi data resep saat ini}
	 var {KAMUS LOKAL SaveResep}
		inf : textfile;
		temp : string;
		i,j : integer;
	begin {ALGORITMA SaveResep}
		assign (inf, 'daftarresep.txt');
		rewrite (inf);
		{format isi data: Nama Resep | Harga Jual | N | Bahan-1 | Bahan-2 | Bahan-3 | … | Bahan-N }
		for i:= 1 to resep.neff do
		begin
			temp := resep.tab[i].nama + ' | ' + IntToStr(resep.tab[i].harga);
			{Menulis bahan-bahan mentah penyusun resep}
			temp := temp + ' | ' + IntToStr(resep.tab[i].nmentah);
			for j:=1 to resep.tab[i].nmentah do
			begin
				temp := temp + ' | ' + resep.tab[i].partmentah[j].nama;
			end;
			{Menulis bahan-bahan olahan penyusun resep}
			temp := temp + ' | ' + IntToStr(resep.tab[i].nolahan);
			for j:=1 to resep.tab[i].nolahan do
			begin
				temp := temp + ' | ' + resep.tab[i].partmentah[j].nama;
			end;
			writeln (inf, temp);
		end;
		close (inf);
		writeln ('>File resep berhasil tersimpan');
	end;
	
procedure SaveBahanOlahan (olahan : tabolahan);
	{I.S. Tabel bahan olahan saat ini terdefinisi
	 F.S. File eksternal 'daftarolahan.txt' berisi tabel bahan olahan saat ini}
	var {KAMUS LOKAL SaveBahanOlahan}
		inf : textfile;
		temp : string;
		i,j : integer;
	begin {ALGORITMA SaveBahanOlahan}
		assign (inf, 'daftarolahan.txt');
		rewrite (inf);
		{format isi data: Nama Bahan Olahan | Harga Jual | N | Bahan-1 | Bahan-2 | Bahan-3 | … | Bahan-N }
		for i:=1 to olahan.neff do
		begin
			temp := olahan.tab[i].nama + ' | ' + IntToStr (olahan.tab[i].harga) + ' | ' + IntToStr (olahan.tab[i].n);
			{Menulis bahan-bahan mentah penyusun bahan olahan}
			for j:=1 to olahan.tab[i].n do
			begin
				temp := temp + ' | ' + olahan.tab[i].komposisi[j].nama;
			end;
			writeln (inf, temp);
		end;
		close(inf);
		writeln ('>File bahan olahan berhasil tersimpan');
	end;
end.
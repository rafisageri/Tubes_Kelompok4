unit F11;

interface
uses typeuniverse, uload, sysutils, penanggalan;
function cariKadaluarsa (bahan : string; daftarMentah : tabmentah): integer;
function isKadaluarsaM (i : integer; daftarmentah : tabMentah; inventoriM : listInventoriM; sim : listSimulasi; nfile : integer): boolean;
function isKadaluarsaO (i : integer; daftarolahan : tabOlahan; inventoriO : listInventoriO; sim : listSimulasi; nfile : integer): boolean;
procedure buangKadaluarsa (sim : listSimulasi; InventoriM : listInventoriM; mentah : tabmentah; InventoriO : listInventoriO; olahan : tabolahan; nfile : integer);
procedure tidur (var simulasi : listSimulasi; var BTidur : boolean; nfile : integer);

implementation
function cariKadaluarsa (bahan : string; daftarMentah : tabmentah): integer;
	{I.S. Daftar bahan mentah dan nama bahan mentah dari inventori yang akan dicari durasi kadaluarsanya terdefinisi
	 F.S. Fungsi menghasilkan durasi kadaluarsa dari bahan mentah di inventori}
	var {KAMUS LOKAL cariKadaluarsa}
	i: integer;
	{ALGORITMA cariKadaluarsa}
	begin
		for i:=1 to daftarMentah.Neff do
		begin
			if (bahan = daftarMentah.tab[i].nama) then
			begin
				cariKadaluarsa := daftarMentah.tab[i].kadaluarsa;
			end;
		end;
	end;

function isKadaluarsaM (i : integer; daftarmentah : tabMentah; inventoriM : listInventoriM; sim : listSimulasi; nfile : integer): boolean;
	{I.S. Indeks bahan mentah di array inventori yang akan diperkisa, daftar bahan mentah, daftar inventori bahan mentah, dan file simulasi terdefinisi
	 F.S. Fungsi memberikan nilai True jika bahan mentah sudah kadaluarsa}
	var {KAMUS LOKAL isKadaluarsaM}
		tglKadaluarsa : tanggal; {variabel temporary}
		j : integer; {counter traversal}
	{ALGORITMA isKadaluarsaM}
	begin
		{Mencari tanggal kadaluarsa dari bahan mentah}
		tglKadaluarsa.hari := inventoriM.list[nfile].tab[i].tglbeli.hari;
		tglKadaluarsa.bulan := inventoriM.list[nfile].tab[i].tglbeli.bulan;
		tglKadaluarsa.tahun := inventoriM.list[nfile].tab[i].tglbeli.tahun;
		for j:=1 to cariKadaluarsa(inventoriM.list[nfile].tab[i].nama, daftarmentah) do
		begin
			gantiHari (tglKadaluarsa);
		end;
		{Proyeksi tanggal kadaluarsa dari bahan mentah sudah tersimpan}
		if (tglKadaluarsa.tahun > sim.list[nfile].awalsim.tahun) then
		begin 
			isKadaluarsaM := True;
		end else {tglKadaluarsa.tahun <= sim.list[nfile].awalsim.tahun} 
		begin
			if (tglKadaluarsa.bulan > sim.list[nfile].awalsim.bulan) then
			begin
				isKadaluarsaM := True;
			end else {tglKadaluarsa.bulan <= sim.list[nfile].awalsim.bulan}
			begin
				if (tglKadaluarsa.hari > sim.list[nfile].awalsim.hari) then
				begin
					isKadaluarsaM := True;
				end else {tglKadaluarsa.hari <= sim.list[nfile].awalsim.hari}
				begin 
					isKadaluarsaM := False;
				end;
			end;
		end;
	end;
	
function isKadaluarsaO (i : integer; daftarolahan : tabOlahan; inventoriO : listInventoriO; sim : listSimulasi; nfile : integer): boolean;
	{I.S. Indeks bahan olahan di array inventori yang akan diperkisa, daftar bahan olahan, daftar inventori bahan olahan, dan file simulasi terdefinisi
	 F.S. Fungsi memberikan nilai True jika bahan olahan sudah kadaluarsa}
	var {KAMUS LOKAL isKadaluarsaO}
		tglKadaluarsa : tanggal; {variabel temporary}
		j : integer; {counter traversal}
	{ALGORITMA isKadaluarsaO}
	begin
		{Mencari tanggal kadaluarsa dari bahan olahan}
		tglKadaluarsa.hari := inventoriO.list[nfile].tab[i].tglbuat.hari;
		tglKadaluarsa.bulan := inventoriO.list[nfile].tab[i].tglbuat.bulan;
		tglKadaluarsa.tahun := inventoriO.list[nfile].tab[i].tglbuat.tahun;
		for j:=1 to 3 do
		begin
			gantiHari (tglKadaluarsa);
		end;
		{Proyeksi tanggal kadaluarsa dari bahan olahan sudah tersimpan}
		if (tglKadaluarsa.tahun > sim.list[nfile].awalsim.tahun) then
		begin 
			isKadaluarsaO := True;
		end else {tglKadaluarsa.tahun <= sim.list[nfile].awalsim.tahun} 
		begin
			if (tglKadaluarsa.bulan > sim.list[nfile].awalsim.bulan) then
			begin
				isKadaluarsaO := True;
			end else {tglKadaluarsa.bulan <= sim.list[nfile].awalsim.bulan}
			begin
				if (tglKadaluarsa.hari > sim.list[nfile].awalsim.hari) then
				begin
					isKadaluarsaO := True;
				end else {tglKadaluarsa.hari <= sim.list[nfile].awalsim.hari}
				begin 
					isKadaluarsaO := False;
				end;
			end;
		end;
	end;
	

procedure buangKadaluarsa (sim : listSimulasi; InventoriM : listInventoriM; mentah : tabmentah; InventoriO : listInventoriO; olahan : tabolahan; nfile : integer);
	{I.S. List inventori bahan mentah, list inventori bahan olahan terdefinisi
	 F.S. Semua bahan mentah dan bahan olahan di inventori yang sudah jatuh kadaluarsa pada tanggal hari ini dihapus dari inventori}
	var {KAMUS LOKAL buangKadaluarsa} 
		i,j,k : integer;
		dateStr, temp, namaFile : string;
		inf : textfile;
	{ALGORITMA buangKadaluarsa}
	begin
		{Menghapus bahan mentah kadaluarsa dari inventori}
		for i:=1 to InventoriM.neff do
		begin
			if (isKadaluarsaM(i, mentah, InventoriM,sim,nfile)) then
			begin
				{Menghapus inventori ke-i kemudian menggeser inventori yang lain dengan cara memanipulasi file eksternal}
				namaFile := 'inventorimentah' + IntToStr(nfile) + '.txt';
				assign (inf, namaFile);
				rewrite (inf);
				for j := 1 to i-1 do
				begin
					dateStr := IntToStr(InventoriM.list[nfile].tab[j].tglbeli.hari) + '/' + IntToStr(InventoriM.list[nfile].tab[j].tglbeli.bulan) +'/' + IntToStr(InventoriM.list[nfile].tab[j].tglbeli.tahun);
					temp := InventoriM.list[nfile].tab[j].nama + ' | ' + dateStr + ' | ' + IntToStr(InventoriM.list[nfile].tab[j].jumlah);
					writeln (inf, temp);
				end;
				
				for j := i + 1 to InventoriM.neff do
				begin
					k := j -1;
					dateStr := IntToStr(InventoriM.list[nfile].tab[k].tglbeli.hari) + '/' + IntToStr(InventoriM.list[nfile].tab[k].tglbeli.bulan) +'/' + IntToStr(InventoriM.list[nfile].tab[k].tglbeli.tahun);
					temp := InventoriM.list[nfile].tab[k].nama + ' | ' + dateStr + ' | ' + IntToStr(InventoriM.list[nfile].tab[k].jumlah);
					writeln (inf, temp);
				end;
				close (inf);
				LoadInventoriBahanMentah (InventoriM.list[nfile]);
			end;
		end;
		
		{Menghapus bahan olahan kadaluarsa dari inventori}
		for i:=1 to InventoriO.neff do
		begin
			if (isKadaluarsaO(i, olahan, InventoriO,sim,nfile)) then
			begin
				{Menghapus inventori ke-i kemudian menggeser inventori yang lain dengan cara memanipulasi file eksternal}
				namaFile := 'inventoriolahan' + IntToStr(nfile) + '.txt';
				assign (inf, namaFile);
				rewrite (inf);
				for j := 1 to i-1 do
				begin
					dateStr := IntToStr(InventoriO.list[nfile].tab[j].tglbuat.hari) + '/' + IntToStr(InventoriO.list[nfile].tab[j].tglbuat.bulan) +'/' + IntToStr(InventoriO.list[nfile].tab[j].tglbuat.tahun);
					temp := InventoriO.list[nfile].tab[j].nama + ' | ' + dateStr + ' | ' + IntToStr(InventoriO.list[nfile].tab[j].jumlah);
					writeln (inf, temp);
				end;
				
				for j := i + 1 to InventoriO.neff do
				begin
					k := j -1;
					dateStr := IntToStr(InventoriO.list[nfile].tab[k].tglbuat.hari) + '/' + IntToStr(InventoriO.list[nfile].tab[k].tglbuat.bulan) +'/' + IntToStr(InventoriO.list[nfile].tab[k].tglbuat.tahun);
					temp := InventoriO.list[nfile].tab[k].nama + ' | ' + dateStr + ' | ' + IntToStr(InventoriO.list[nfile].tab[k].jumlah);
					writeln (inf, temp);
				end;
				close (inf);
				LoadInventoriBahanOlahan (InventoriO.list[nfile]);
			end;
		end;
	end;
	
procedure tidur (var simulasi : listSimulasi; var BTidur : boolean; nfile : integer);
	{I.S. Data simulasi nomor <nfile> terdefinisi
	 F.S. Energi ter-reset menjadi 10, barang-barang kadaluarsa dihapus dari inventori, markTidur bernilai True}
	 
	{ALGORITMA tidur}
	begin
		if (BTidur) then
		begin
			writeln ('Anda tidak dapat melakukan aksi tidur saat ini');
		end else {markTidur bernilai False}
		begin
			simulasi.list[nfile].energi := 10;
			writeln('Anda telah tidur dan tubuh Anda telah kembali fit, yeay!');
			simulasi.list[nfile].awalsim.hari := simulasi.list[nfile].awalsim.hari + 1;
			writeln('Hari ke-', simulasi.list[nfile].awalsim.hari);
		end;
	end;
end.
unit F11;

interface
uses typeuniverse;
procedure tidur(var Sim: tabSimulasi; N: integer; var bTidur: boolean; var eoDay: boolean);

implementation
procedure tidur(var Sim: tabSimulasi; var bTidur: boolean; N: integer; var eoDay: boolean);
	begin
	if (eoDay) then
		begin
		Sim.tabSimulasi[N].energi := 10;
		Sim.tabSimulasi[N].awalsim.hari := Sim.tabSimulasi[N].awalsim.ri + 1;
		writeln('Anda telah tidur dan Energi Anda telah dipulihkan!');
		writeln('Hari ke-', Sim.tabSimulasi[N].awalsim.hari);
		eoDay := false;
		bTidur := false;
		end else if (bTidur) then 
			begin
			Sim.tabSimulasi[N].energi := 10;
			Sim.tabSimulasi[N].awalsim.hari := Sim.tabSimulasi[N].awalsim.hari + 1;
			writeln('Anda telah tidur dan Energi Anda telah dipulihkan!');
			writeln('Hari ke-', Sim.tabSimulasi[N].awalsim.hari);
			eoDay := false;
			bTidur := false;
			end else writeln('Anda tidak dapat tidur karena Anda belum melakukan apapun');
		
//variabel 'boleh-tidur' blm terdefinisi
//

function cariKadaluarsa(Barang: string; daftarMentah: tabMentah) : integer
var
	i: integer;
begin
	for i:=1 to daftarMentah.Neff do
	begin
		if (Barang = daftarMentah.mentah[i].nama) then
		begin
			cariKadaluarsa := daftarMentah.mentah[i].kadaluarsa;
		end;
	end;
end;

procedure buang(var invenMentah: tabInventoriM; var invenOlahan: tabInventoriO; Sim: tabSimulasi; N: integer; daftarMentah: tabMentah);
var
	Nkad: integer; //banyak barang yg sudah kadaluarsa
	i: integer;
	TempM: inventoriM; //variabel sementara untuk bahan mentah
	TempO: inventoriO; //variabel sementara untuk bahan olahan
begin
	Nkad:= 0;
	for i:=1 to invenMentah.Neff do
	begin	
		////////////////////////////////////////////////////////////////////////////
		//CEK INI
		
		//Mengolah bahan mentah
		if (Sim.simulasi[N].awalsim.tanggal.hari >= InvenMentah.InventoriM[i].tglbeli.hari + cariKadaluarsa(invenMentah.inventoriM[i].nama, daftarMentah)) then
		begin
			TempM.nama := invenMentah.inventoriM[i].nama;
			TempM.tglbeli.hari := invenMentah.inventoriM[i].tglbeli.hari;
			TempM.tglbeli.bulan := invenMentah.inventoriM[i].tglbeli.bulan;
			TempM.tglbeli.tahun := invenMentah.inventoriM[i].tglbeli.tahun;
			TempM.jumlah := invenMentah.inventoriM[i].jumlah;

			invenMentah.inventoriM[i].nama := invenMentah.inventoriM[invenMentah.Neff-Nkad].nama;
			invenMentah.inventoriM[i].tglbeli.hari := invenMentah.inventoriM[invenMentah.Neff-Nkad].tglbeli.hari;
			invenMentah.inventoriM[i].tglbeli.bulan := invenMentah.inventoriM[invenMentah.Neff-Nkad].tglbeli.bulan;
			invenMentah.inventoriM[i].tglbeli.tahun := invenMentah.inventoriM[invenMentah.Neff-Nkad].tglbeli.tahun;
			invenMentah.inventoriM[i].jumlah := invenMentah.inventoriM[invenMentah.Neff-Nkad].jumlah;

			invenMentah.inventoriM[invenMentah.Neff-Nkad].nama := TempM.nama;
			invenMentah.inventoriM[invenMentah.Neff-Nkad].tglbeli.hari := TempM.tglbeli.hari;
			invenMentah.inventoriM[invenMentah.Neff-Nkad].tglbeli.bulan := TempM.tglbeli.bulan;
			invenMentah.inventoriM[invenMentah.Neff-Nkad].tglbeli.tahun := TempM.tglbeli.tahun;
			invenMentah.inventoriM[invenMentah.Neff-Nkad].jumlah := TempM.jumlah;

			Nkad := Nkad + 1;			
		end;
	end;

	invenMentah.Neff := invenMentah.Neff - Nkad;

	//menginisialisasi kembali jumlah kadaluarsa
	//mengolah bahan olahan
	Nkad:= 0;
	for i:=1 to invenOlahan.Neff do
	begin
		if (Sim.simulasi[N].awalsim.tanggal.hari >= InvenOlahan.InventoriO[i].tglbeli.hari + 3) then
		begin
			TempO.nama := invenOlahan.inventoriO[i].nama;
			TempO.tglbeli.hari := invenOlahan.inventoriO[i].tglbeli.hari;
			TempO.tglbeli.bulan := invenOlahan.inventoriO[i].tglbeli.bulan;
			TempO.tglbeli.tahun := invenOlahan.inventoriO[i].tglbeli.tahun;
			TempO.jumlah := invenOlahan.inventoriO[i].jumlah;

			invenOlahan.inventoriO[i].nama := invenOlahan.inventoriO[invenOlahan.Neff-Nkad].nama;
			invenOlahan.inventoriO[i].tglbeli.hari := invenOlahan.inventoriO[invenOlahan.Neff-Nkad].tglbeli.hari;
			invenOlahan.inventoriO[i].tglbeli.bulan := invenOlahan.inventoriO[invenOlahan.Neff-Nkad].tglbeli.bulan;
			invenOlahan.inventoriO[i].tglbeli.tahun := invenOlahan.inventoriO[invenOlahan.Neff-Nkad].tglbeli.tahun;
			invenOlahan.inventoriO[i].jumlah := invenOlahan.inventoriO[invenOlahan.Neff-Nkad].jumlah;

			invenOlahan.inventoriO[invenOlahan.Neff-Nkad].nama := TempO.nama;
			invenOlahan.inventoriO[invenOlahan.Neff-Nkad].tglbeli.hari := TempO.tglbeli.hari;
			invenOlahan.inventoriO[invenOlahan.Neff-Nkad].tglbeli.bulan := TempO.tglbeli.bulan;
			invenOlahan.inventoriO[invenOlahan.Neff-Nkad].tglbeli.tahun := TempO.tglbeli.tahun;
			invenOlahan.inventoriO[invenOlahan.Neff-Nkad].jumlah := TempO.jumlah;

			Nkad := Nkad + 1;			
		end;
	end;

	invenOlahan.Neff := invenOlahan.Neff - Nkad;
end;

unit tidur;

interface
uses typeuniverse;
procedure tidur(var simulasi: tabSimulasi; N: integer; aktivitas: boolean = false);

implementation
procedure tidur( var simulasi: tabSimulasi; var B-tidur: boolean; N: integer; aktivitas: boolean = false);
	begin
		simulasi.tabSimulasi[N].energi := 10;
		writeln('Anda telah tidur dan tubuh Anda telah kembali fit, yeay!');
		simulasi.tabSimulasi[N].awalsim.hari := simulasi.tabSimulasi[N].awalsim.hari + 1;
		writeln('Hari ke-', simulasi.tabSimulasi[N].awalsim.hari);
//B-tidur blm diimplementasi

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

procedure buang(var invenMentah: tabInventoriM; var invenOlahan: tabInventoriO; simulasi: tabSimulasi; N: integer; daftarMentah: tabMentah);
var
	Nkad: integer;
	i: integer;
	Temp: inventoriM;
begin
	Nkad:= 0;
	for i:=1 to invenMentah.Neff do
	begin
		if (simulasi.simulasi[N].awalsim.tanggal.hari >= InvenMentah.InventoriM[i].tglbeli.hari + cariKadaluarsa(invenMentah.inventoriM[i].nama, daftarMentah)) then
		begin
			Temp.nama := invenMentah.inventoriM[i].nama;
			Temp.tglbeli.hari := invenMentah.inventoriM[i].tglbeli.hari;
			Temp.tglbeli.bulan := invenMentah.inventoriM[i].tglbeli.bulan;
			Temp.tglbeli.tahun := invenMentah.inventoriM[i].tglbeli.tahun;
			Temp.jumlah := invenMentah.inventoriM[i].jumlah;

			invenMentah.inventoriM[i].nama := invenMentah.inventoriM[invenMentah.Neff-Nkad].nama;
			invenMentah.inventoriM[i].tglbeli.hari := invenMentah.inventoriM[invenMentah.Neff-Nkad].tglbeli.hari;
			invenMentah.inventoriM[i].tglbeli.bulan := invenMentah.inventoriM[invenMentah.Neff-Nkad].tglbeli.bulan;
			invenMentah.inventoriM[i].tglbeli.tahun := invenMentah.inventoriM[invenMentah.Neff-Nkad].tglbeli.tahun;
			invenMentah.inventoriM[i].jumlah := invenMentah.inventoriM[invenMentah.Neff-Nkad].jumlah;

			invenMentah.inventoriM[invenMentah.Neff-Nkad].nama := Temp.nama;
			invenMentah.inventoriM[invenMentah.Neff-Nkad].tglbeli.hari := Temp.tglbeli.hari;
			invenMentah.inventoriM[invenMentah.Neff-Nkad].tglbeli.bulan := Temp.tglbeli.bulan;
			invenMentah.inventoriM[invenMentah.Neff-Nkad].tglbeli.tahun := Temp.tglbeli.tahun;
			invenMentah.inventoriM[invenMentah.Neff-Nkad].jumlah := Temp.jumlah;

			Nkad := Nkad + 1;			
		end;
	end;

	invenMentah.Neff := invenMentah.Neff - Nkad;

	Nkad:= 0;
	for i:=1 to invenOlahan.Neff do
	begin
		if (simulasi.simulasi[N].awalsim.tanggal.hari >= InvenOlahan.InventoriO[i].tglbeli.hari + 3) then
		begin
			Temp.nama := invenOlahan.inventoriO[i].nama;
			Temp.tglbeli.hari := invenOlahan.inventoriO[i].tglbeli.hari;
			Temp.tglbeli.bulan := invenOlahan.inventoriO[i].tglbeli.bulan;
			Temp.tglbeli.tahun := invenOlahan.inventoriO[i].tglbeli.tahun;
			Temp.jumlah := invenOlahan.inventoriO[i].jumlah;

			invenOlahan.inventoriO[i].nama := invenOlahan.inventoriO[invenOlahan.Neff-Nkad].nama;
			invenOlahan.inventoriO[i].tglbeli.hari := invenOlahan.inventoriO[invenOlahan.Neff-Nkad].tglbeli.hari;
			invenOlahan.inventoriO[i].tglbeli.bulan := invenOlahan.inventoriO[invenOlahan.Neff-Nkad].tglbeli.bulan;
			invenOlahan.inventoriO[i].tglbeli.tahun := invenOlahan.inventoriO[invenOlahan.Neff-Nkad].tglbeli.tahun;
			invenOlahan.inventoriO[i].jumlah := invenOlahan.inventoriO[invenOlahan.Neff-Nkad].jumlah;

			invenOlahan.inventoriO[invenOlahan.Neff-Nkad].nama := Temp.nama;
			invenOlahan.inventoriO[invenOlahan.Neff-Nkad].tglbeli.hari := Temp.tglbeli.hari;
			invenOlahan.inventoriO[invenOlahan.Neff-Nkad].tglbeli.bulan := Temp.tglbeli.bulan;
			invenOlahan.inventoriO[invenOlahan.Neff-Nkad].tglbeli.tahun := Temp.tglbeli.tahun;
			invenOlahan.inventoriO[invenOlahan.Neff-Nkad].jumlah := Temp.jumlah;

			Nkad := Nkad + 1;			
		end;
	end;

	invenOlahan.Neff := invenOlahan.Neff - Nkad;
end;
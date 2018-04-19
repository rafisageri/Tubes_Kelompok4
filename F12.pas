unit F12;
//buat tipe data simulasi

interface
	uses
		typeuniverse,
		sysutils;
	procedure lihatStatistik(nfile:integer; arr: listSimulasi);
	//I.S. nfile, arr terdefinisi
	//menampilkan isi arr
	
implementation
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

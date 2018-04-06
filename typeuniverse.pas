unit typeuniverse;

interface

const
	//program utama
	arrMin = 1;
	arrMax = 100;
	
	//[nama modul] - [pemilik modul]
	//(tambah konstanta disini)
type
	//program utama
	tanggal = record
		hari	: integer;
		bulan	: integer;
		tahun	: integer;
	end;
	
	mentah = record
		nama		: string;
		harga		: integer;
		kadaluarsa	: integer;
	end;
	
	tabMentah = record
		tab		: array [arrMin..arrMax] of mentah;
		neff	: integer;
	end;
	
	olahan = record
		nama		: string;
		hargajual	: integer;
		n			: integer;
		bahan		: array[arrMin..n] of mentah;
	end;
	
	tabOlahan = record
		tab		: array [arrMin..arrMax] of olahan;
		neff	: integer;
	end;
	
	inventoriM = record
		nama	: string;
		tglbeli	: tanggal;
		jumlah	: integer;
	end;
	
	tabInventoriM = record
		tab		: array [arrMin..arrMax] of inventoriM;
		neff	: integer;
	end;
	
	inventoriO = record
		nama	: string;
		tglbuat	: tanggal;
		jumlah	: integer;
	end;
	
	tabInventoriO = record
		tab		: array [arrMin..arrMax] of inventoriO;
		neff	: integer;
	end;
	
	resep = record
		nama	: string;
		harga	: integer;
		n		: integer;
		bahan	: array [arrMin..n] of mentah;
	end;
	
	tabResep = record
		tab		: array [arrMin..arrMax] of resep;
		neff	: integer;
	end;
	
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
	
	tabSimulasi = record
		tab		: array [arrMin..arrMax] of simulasi;
		neff	: integer;
	end;
	
	//[nama modul] - [pemilik modul]
	//(tambah tipe disini)
	
implementation

end.

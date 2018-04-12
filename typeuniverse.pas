unit typeuniverse;

interface

const
	arrMin = 1;
	arrMax = 100;
	
type
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
		harga		: integer;
		n			: integer;
		komposisi	: array [arrMin..arrMax] of mentah;
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
		ntot	: integer;
	end;
	
	inventoriO = record
		nama	: string;
		tglbuat	: tanggal;
		jumlah	: integer;
	end;
	
	tabInventoriO = record
		tab		: array [arrMin..arrMax] of inventoriO;
		neff	: integer;
		ntot	: integer;
	end;
	
	resep = record
		nama	: string;
		harga	: integer;
		n		: integer;
		bahan	: array [arrMin..arrMax] of mentah;
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
	
implementation

end.

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
	
	////////////////////////////////
	//tipe untuk file bahan mentah//
	mentah = record
		nama		: array [arrMin..arrMax] of char;
		harga		: integer;
		kadaluarsa	: integer;
	end;
	
	tabMentah = record
		tab	: array [arrMin..arrMax] of mentah;
		neff	: integer;
	end;
	
	////////////////////////////////
	//tipe untuk file bahan olahan//
	olahan = record
		nama		: array [arrMin..arrMax] of char;
		harga		: integer;
		n		: integer;
		komposisi	: array [arrMin..arrMax] of mentah;
	end;
	
	tabOlahan = record
		tab	: array [arrMin..arrMax] of olahan;
		neff	: integer;
	end;
	
	//////////////////////////////////////////
	//tipe untuk file inventori bahan mentah//
	inventoriM = record
		nama	: array [arrMin..arrMax] of char;
		tglbeli	: tanggal;
		jumlah	: integer;
	end;
	
	tabInventoriM = record
		tab	: array [arrMin..arrMax] of inventoriM;
		neff	: integer;
		ntot	: integer;
	end;
	
	listInventoriM = record
		list	: array [1..10] of tabInventoriM;
		neff	: integer;
	end; 	
	////////////////////////////////////
	//tipe untuk file inventori olahan//
	inventoriO = record
		nama	: array [arrMin..arrMax] of char;
		tglbuat	: tanggal;
		jumlah	: integer;
		harga   : integer; 
	end;
	
	tabInventoriO = record
		tab	: array [arrMin..arrMax] of inventoriO;
		neff	: integer;
		ntot	: integer;
	end;
	
	listInventoriO = record
		list	: array [1..10] of tabInventoriO;
		neff	: integer;
	end;	
	////////////////////////////////
	//tipe untuk file daftar resep//
	resep = record
		nama		: array [arrMin..arrMax] of char;
		harga		: integer;
		nmentah		: integer;
		partmentah	: array [arrMin..arrMax] of mentah;
		nolahan         : integer; 
		partolahan     	: array [arrMin..arrMax] of olahan;
	end;
	
	tabResep = record
		tab	: array [arrMin..arrMax] of resep;
		neff	: integer;
	end;
	
	////////////////////////////////////
	//tipe untuk file daftar informasi//
	simulasi = record
		nomor			: integer;
		awalsim			: tanggal;
		totalhari		: integer;
		energi			: integer;
		kapasitas		: integer;
		totalmentahbeli		: integer;
		totalbahanbuat		: integer;
		totalbahanjual		: integer;
		totalresepjual		: integer;
		pemasukan		: integer;
		pengeluaran		: integer;
		uang			: integer;
	end;
	
	listSimulasi = record
		list	: array [1..10] of simulasi;
		neff	: integer;
	end;
	
implementation

end.

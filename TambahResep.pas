unit TambahResep; 

interface 
  
  uses TypeUniverse;
			 
  Procedure InputDataResep(var NamaResep : string; var MentahResep : Mresep; var OlahanResep : Oresep; var HargaResep : integer); 
  
  Function IsResepAda(ResepJadi : tabresep; NamaResep : string) : boolean; 
  
  Function IsBahanPembentukCukup(MentahResep : Mresep; OlahanResep : Oresep) : boolean; 
  
  Function IsBahanMentahAda(MentahResep : Mresep; BahanMentah : TabMentah) : boolean; 
  
  Function IsBahanOlahanAda(OlahanResep : Oresep; BahanOlahan : TabOlahan) : boolean; 
  
  Function IsHargaValid(HargaResep : integer; MentahResep : Mresep; OlahanResep : Oresep; BahanMentah : TabMentah; BahanOlahan : TabOlahan) : boolean;   
  
  Procedure KurangiEnergi(var Energi : integer); 
  
  Procedure InputResepBaru(NamaResep : string; MentahResep : Mresep; OlahanResep : Oresep; HargaResep : integer; var ResepJadi : tabresep);
  
  Procedure TambahResepBaru(BahanMentah : TabMentah; BahanOlahan : TabOlahan; var ResepJadi : tabresep; var Energi : integer);
  
implementation

  Procedure InputDataResep(var NamaResep : string; var MentahResep : Mresep; var OlahanResep : Oresep; var HargaResep : integer);
  //Prosedur untuk menerima masukan nama, harga dan bahan2 yang dibutuhkan untuk membuat resep
  
  var //Kamus lokal
  i : integer; 
  found : boolean; 
  
  begin //Algoritma 
  
  write('Nama Resep : ');
  readln(NamaResep); 
  
  i := 1;
  found := false;
  writeln('Bahan Mentah : ','ketik "-" pada layar untuk berhenti memasukan bahan mentah');
  while (not(found)) do begin //nanti akan ada batas masukan i, tergantung bahan maksimal
    readln(MentahResep.bahan[i]); 
	  if (MentahResep.bahan[i] = '-') then begin  
	    found := true; 
	  end else 
	    found := false; 
  end; 
  
  MentahResep.neff := i - 1; 
  
  i := 1;
  found := false;
  writeln('Bahan Olahan : ','ketik "-" pada layar untuk berhenti memasukan bahan mentah');
  while (not(found)) do begin //nanti akan ada batas masukan i, tergantung bahan maksimal
    readln(OlahanResep.bahan[i]); 
	  if (OlahanResep.bahan[i] = '-') then begin  
	    found := true; 
	  end else 
	    found := false; 
  end; 
  
  OlahanResep.neff := i - 1;
  
  write('Harga : ');
  readln(HargaResep); 
  
  end;
  
  Function IsResepAda(ResepJadi : tabresep; NamaResep : string) : boolean; 
  //fungsi untuk mengecek apakah resep sudah ada atau belum
  
  var //Kamus lokal
  Found : boolean;
  i : integer; 
  
  begin //Algoritma 
  found := False;
  
  for i := 1 to ResepJadi.neff do begin 
	if (NamaResep = ResepJadi.tab[i].nama) then begin 
		found := true; 
	end else 
		found := false; 
  end; 
  
  IsResepAda := found; 
  end;
  
  Function IsBahanPembentukCukup(MentahResep : Mresep; OlahanResep : Oresep) : boolean; 
  //Fungsi untuk mengecek apakah bahan mentah dan olahan pembentuk resep cukup 
  var //Kamus lokal 
  found : boolean; 
  
  begin //Algoritma
  found := false; 
	if (MentahResep.neff + OlahanResep.neff >= 2) then begin 
		found := true; 
	end else 
		found := false; 
 
  IsBahanPembentukCukup := found; 
  end; 
  
  Function IsBahanMentahAda(MentahResep : Mresep; BahanMentah : TabMentah) : boolean; 
  //Fungsi untuk mengecek apakah bahan mentah pembentuk ada atau tidak 
  var //Kamus utama  
  j , k : integer; 
  found : boolean; 
  
  begin //Algoritma 
  found := true; 
  j := 1; 

     while (j <= MentahResep.neff) or (found) do begin 
       found := false; 
       k := 1; 
         while (k <= BahanMentah.neff) or (not(found)) do begin 
            if (MentahResep.bahan[j] = BahanMentah.tab[k].nama) then begin 
              found := true;
            end else begin 
              found := false; 
              k := k + 1; 
			end; 
         end; 
      j := j + 1; 
     end;
	 IsBahanMentahAda := found;
  end; 	 
  
  Function IsBahanOlahanAda(OlahanResep : Oresep; BahanOlahan : TabOlahan) : boolean; 
  //Fungsi untuk mengecek apakah bahan mentah pembentuk ada atau tidak 
  var //Kamus utama  
  j , k : integer; 
  found : boolean; 
  
  begin //Algoritma 
  found := true;
  j := 1; 

     while (j <= OlahanResep.neff) or (found) do begin 
       found := false; 
       k := 1; 
         while (k <= BahanOlahan.neff) or (not(found)) do begin 
            if (OlahanResep.bahan[j] = BahanOlahan.tab[k].nama) then begin 
              found := true;
            end else begin 
              found := false; 
              k := k + 1; 
			end; 
         end; 
      j := j + 1; 
     end;
  IsBahanOlahanAda := found;
  end;
  
  Function IsHargaValid(HargaResep : integer; MentahResep : Mresep; OlahanResep : Oresep; BahanMentah : TabMentah; BahanOlahan : TabOlahan) : boolean;   
  //Fungsi untuk menentukan apakah harga masukan pengguna valid 
  var
  j , k , sumharga : integer; 
  price : boolean;
  begin //Algoritma 
  sumharga := 0;
  j := 1; 

     while (j <= MentahResep.neff)  do begin 
       k := 1; 
         while (k <= BahanMentah.neff) do begin 
            if (MentahResep.bahan[j] = BahanMentah.tab[k].nama) then begin 
              sumharga := sumharga + BahanMentah.tab[k].harga;
			  k := k + 1;
            end else begin 
              k := k + 1; 
			end; 
         end; 
      j := j + 1; 
     end;

  j := 1; 

     while (j <= OlahanResep.neff) do begin 
       k := 1; 
         while (k <= BahanOlahan.neff) do begin 
            if (OlahanResep.bahan[j] = BahanOlahan.tab[k].nama) then begin 
              sumharga := sumharga + BahanOlahan.tab[k].harga;
			  k := k + 1; 
            end else begin 
              k := k + 1; 
			end; 
         end; 
      j := j + 1; 
     end;	 
	 
  price := true; 
  if (HargaResep < trunc(sumharga * 1.125) ) then begin 
		   price := false; 
		   writeln('Pembuatan resep gagal, harga tidak memenuhi syarat'); 
		 end else 
           price := true; 
  IsHargaValid := price;
  end; 
  
  Procedure KurangiEnergi(var Energi : integer); 
  //Prosedur untuk mengurangi energi saat melakukan satu kegiatan 
  begin //Algoritma 
  
  Energi := Energi - 1; 
  
  end; 

  Procedure InputResepBaru(NamaResep : string; MentahResep : Mresep; OlahanResep : Oresep; HargaResep : integer; var ResepJadi : tabresep);
  //Prosedur untuk menyimpan resep yang sudah divalidasi pada daftar resep 
  
  var //Kamus lokal 
  i : integer; 
  
  begin //Algoritma 
  
  ResepJadi.neff := ResepJadi.neff + 1; 
  ResepJadi.tab[ResepJadi.neff].nama := NamaResep; 
  ResepJadi.tab[ResepJadi.neff].harga := hargaResep;
  ResepJadi.tab[ResepJadi.neff].nmentah := MentahResep.neff;
  ResepJadi.tab[ResepJadi.neff].nolahan := OlahanResep.neff; 
  
  for i := 1 to MentahResep.neff do begin 
    ResepJadi.tab[ResepJadi.neff].partmentah[i].nama := MentahResep.bahan[i];
  end; 
  
  for i := 1 to OlahanResep.neff do begin 
    ResepJadi.tab[ResepJadi.neff].partolahan[i].nama := Olahanresep.bahan[i];  
  end; 
  
  end; 
  
  Procedure TambahResepBaru(BahanMentah : TabMentah; BahanOlahan : TabOlahan; var ResepJadi : tabresep; var Energi : integer);
  //Prosedur keseluruhan untuk membuat resep baru 
  
  var //Kamus Lokal
  NamaResep : string; 
  MentahResep : Mresep; 
  OlahanResep : Oresep;
  HargaResep : integer;
  ResepValid : boolean; 
  begin //Algoritma
  
  InputDataResep(NamaResep, MentahResep, OlahanResep, HargaResep); 
  
  ResepValid := IsResepAda(ResepJadi, NamaResep);  
  if (not(ResepValid)) then begin 
	writeln('Pembuatan resep gagal, resep sudah ada');
  end else begin 
	ResepValid := IsBahanPembentukCukup(MentahResep, OlahanResep);
    if (not(ResepValid)) then begin 
		writeln('Pembuatan resep gagal, jumlah pembentuk resep kurang');
	end else begin 
		ResepValid := IsBahanMentahAda(MentahResep, BahanMentah); 
		if (not(ResepValid)) then begin 
			writeln('Pembuatan resep gagal, bahan mentah tidak ditemukan'); 
		end else begin 
		    ResepValid := IsBahanOlahanAda(OlahanResep, BahanOlahan); 
			if (not(ResepValid)) then begin 
				Writeln('Pembuatan resep gagal, bahan olahan tidak ditemukan');
			end else begin 
				ResepValid := IsHargaValid(HargaResep,  MentahResep, OlahanResep, BahanMentah, BahanOlahan); 
				if (not(ResepValid)) then begin 
					writeln('Pembuatan resep gagal, harga masukan tidak valid'); 
				end else begin 
					InputResepBaru(NamaResep , MentahResep , OlahanResep , HargaResep , ResepJadi);
					KurangiEnergi(Energi);
				end;
			end;
		end;
	end;
  end; 
  end;
				    
       
  
end. 
  
  
   
  
  
  
  
  
  
  
  
  
  
  
  
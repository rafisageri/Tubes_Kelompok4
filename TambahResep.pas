unit TambahResep; 

interface 
  
  uses TypeUniverse;
			 
  Procedure InputDataResep(var NamaResep : string; var MentahResep : Mresep; var OlahanResep : Oresep; var HargaResep : integer); 
  
  Procedure ValidasiResep(NamaResep : string; MentahResep : Mresep; OlahanResep : Oresep; HargaResep : integer; BahanMentah : TabMentah; BahanOlahan : TabOlahan; ResepJadi : tabresep; var ResepValid : boolean); 
  
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
  
  Procedure ValidasiResep(NamaResep : string; MentahResep : Mresep; OlahanResep : Oresep; HargaResep : integer; BahanMentah : TabMentah; BahanOlahan : TabOlahan; ResepJadi : tabresep; var ResepValid : boolean); 
  //Prosedur untuk memvalidasi apakah resep yang di input sudah tersedia, bahan mentah dan bahan olahan tersedia, dan harga yang ditentukan memenuhi syarat harga resep
  
  var //Kamus lokal
  i , j , k , sumharga : integer;
  found : boolean; 
  
  begin //Algoritma 
  
  i := 1; 
  found := true; 
  while (i < ResepJadi.neff) or (found) do begin 
     if (NamaResep = ResepJadi.tab[i].nama) then begin 
	   found := false; 
	 end else 
	   found := true; 
	   i := i + 1; 
  end; 
  
  sumharga := 0;
  if (not(found)) then begin 
    writeln('Pembuatan resep gagal, Nama Resep sudah ada'); 
  end else begin 
    if (MentahResep.neff + OlahanResep.neff < 2) then begin 
	writeln('Pembuatan resep gagal, bahan penyusun kurang');
	end else begin 
     j := 1; 

     while (j <= MentahResep.neff) or (found) do begin 
       found := false; 
       k := 1; 
         while (k <= BahanMentah.neff) or (not(found)) do begin 
            if (MentahResep.bahan[j] = BahanMentah.tab[k].nama) then begin 
              found := true;
			  sumharga := sumharga + BahanMentah.tab[k].harga;
            end else begin 
              found := false; 
              k := k + 1; 
			end; 
         end; 
      j := j + 1; 
     end;
     
     if (not(Found)) then begin 
       writeln('Pembuatan resep gagal, Bahan mentah tidak ditemukan'); 
     end else begin 
       j := 1; 
	   
	   while (j <= OlahanResep.neff) or (found) do begin 
         found := false; 
         k := 1; 
           while (k <= BahanOlahan.neff) or (not(found)) do begin 
              if (OlahanResep.bahan[j] = BahanOlahan.tab[k].nama) then begin 
                found := true;
				sumharga := sumharga + BahanOlahan.tab[k].harga; 
              end else begin 
                found := false; 
                k := k + 1; 
			  end; 
           end; 
        j := j + 1; 
       end; 	 
	   
	   if (not(found)) then begin 
	     writeln('Pembuatan resep gagal, bahan olahan tidak ditemukan'); 
	   end else begin 
	     if (HargaResep < trunc(sumharga * 1.125) ) then begin 
		   found := false; 
		   writeln('Pembuatan resep gagal, harga tidak memenuhi syarat'); 
		 end else 
           found := true; 
       end;
     end; 
    end; 
  end; 
  ResepValid := found; 
  
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
  
  ValidasiResep(NamaResep, MentahResep, OlahanResep, HargaResep, BahanMentah, BahanOlahan, ResepJadi, ResepValid); 
  
  if (ResepValid) then begin 
        KurangiEnergi(energi); 
        InputResepBaru(NamaResep, MentahResep, OlahanResep, HargaResep, ResepJadi); 
		Writeln('Pembuatan Resep Berhasil');     
  end;

  end;   
    
	    
  
end. 
  
  
   
  
  
  
  
  
  
  
  
  
  
  
  
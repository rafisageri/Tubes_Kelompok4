unit TambahResep; 

interface 
  
  uses TypeUniverse;
			 
  Procedure InputDataResep(var NamaResep : string; var MentahResep : Mresep; var OlahanResep : Oresep; var HargaResep : integer); 
  
  Function IsResepAda(ResepJadi : tabresep; NamaResep : string) : boolean; 
  
  Function IsBahanPembentukCukup(MentahResep : Mresep; OlahanResep : Oresep) : boolean; 
  
  Function IsBahanMentahAda(MentahResep : Mresep; BahanMentah : TabMentah) : boolean; 
  
  Function IsBahanOlahanAda(OlahanResep : Oresep; BahanOlahan : TabOlahan) : boolean; 
  
  Function IsHargaValid(HargaResep : integer; MentahResep : Mresep; OlahanResep : Oresep; BahanMentah : TabMentah; BahanOlahan : TabOlahan) : boolean;   
  
  Procedure InputResepBaru(NamaResep : string; MentahResep : Mresep; OlahanResep : Oresep; HargaResep : integer; var ResepJadi : tabresep);
  
  Procedure TambahResep(BahanMentah : TabMentah; BahanOlahan : TabOlahan; var ResepJadi : tabresep; var Energi : integer);
  
implementation

  Procedure InputDataResep(var NamaResep : string; var MentahResep : Mresep; var OlahanResep : Oresep; var HargaResep : integer);
  {I.S. Pengguna memasukan nama resep, bahan pembentuk, harga resep yang ingin dibuat }
  {F.S. Nama resep, bahan pembentuk, dan harga resep terdefinisi melalui input pengguna} 
  {prosedur untuk menerima masukan nama, bahan pembentuk, dan harga resep dari pengguna}
  
  var //Kamus lokal
  i : integer; 
  found : boolean; 
  
  begin //Algoritma 
  
  write('Nama Resep : ');
  readln(NamaResep); //Input nama resep
  
  i := 1;
  found := false;
  writeln('Bahan Mentah : ','ketik "-" pada layar untuk berhenti memasukan bahan mentah');
  while (not(found)) do begin //nanti akan ada batas masukan i, tergantung bahan maksimal
    readln(MentahResep.bahan[i]); 
 	  if (MentahResep.bahan[i] = '-') then begin  
	    found := true; 
	    end else //input selain "-"
	    found := false; 
  end; 
  
  MentahResep.neff := i - 1; //jumlah dari bahan mentah yang dibutuhkan
  
  i := 1;
  found := false;
  writeln('Bahan Olahan : ','ketik "-" pada layar untuk berhenti memasukan bahan mentah');
  while (not(found)) do begin //nanti akan ada batas masukan i, tergantung bahan maksimal
    readln(OlahanResep.bahan[i]); 
	  if (OlahanResep.bahan[i] = '-') then begin  
	    found := true; 
	  end else //masukkan selain "-"
	    found := false; 
  end; 
  
  OlahanResep.neff := i - 1; // jumlah dari bahan olahan yang dibutuhkan
  
  write('Harga : ');
  readln(HargaResep);//input harga resep 
  
  end;
  
  Function IsResepAda(ResepJadi : tabresep; NamaResep : string) : boolean; 
  {I.S. nama resep terdefinisi}
  {F.S. mengeluarkan nilai boolean true jika resep sudah ada dan false jika belum}
  {fungsi untuk menentukan apakahg nama resep yang dimasukan pengguna sudah ada atau belum}
  
  var //Kamus lokal
  Found : boolean;
  i : integer; 
  
  begin //Algoritma 
  found := False;
  
  for i := 1 to ResepJadi.neff do begin 
	if (NamaResep = ResepJadi.tab[i].nama) then begin 
		found := true; 
		end else //NamaResep tidak sama dengan nama resep pada daftar
		found := false; 
  end; 
  
  IsResepAda := found; 
  end;
  
  Function IsBahanPembentukCukup(MentahResep : Mresep; OlahanResep : Oresep) : boolean; 
  {I.S. jumlah bahan mentah olahan pembentuk resep terdefinisi}
  {F.S. mengeluarkan nilai true jika jumlah pembentuk resep >=2 dan false jika tidak}
  {fungsi untuk memvalidasi apakah jumlah bahan pembentuk resep cukup}
  var //Kamus lokal 
  found : boolean; 
  
  begin //Algoritma
  found := false; 
	if (MentahResep.neff + OlahanResep.neff >= 2) then begin 
		found := true; 
		end else //MentahResep.neff + OlahanResep.neff < 2
		found := false; 
 
  IsBahanPembentukCukup := found; 
  end; 
  
  Function IsBahanMentahAda(MentahResep : Mresep; BahanMentah : TabMentah) : boolean; 
  {I.S. bahan mentah pembentuk resep terdefinisi}
  {F.S. mengeluarkan nilai true jika bahan mentah pembentuk ada pada daftar bahan mentah}
  {fungsi untuk mevalidasi apakah bahan mentah yang diinput ada pada daftar bahan mentah}
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
	      end else begin //MentahResep.bahan[j] <> BahanMentah.tab[k].nama
              found := false; 
              k := k + 1; 
			end; 
         end; 
      j := j + 1; 
     end;
	 IsBahanMentahAda := found;
  end; 	 
  
  Function IsBahanOlahanAda(OlahanResep : Oresep; BahanOlahan : TabOlahan) : boolean;
  {I.S. Bahan olahan pembentuk resep terdefinisi}
  {F.S. mengeluarkan nilai true jika bahan olahan pembentuk resep ada pada daftar bahan olahan dan false jika tidak}
  {fungsi untuk memvalidasi apakah bahan olahan pembentuk resep ada pada daftar bahan olahan}
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
            end else begin //OlahanResep.bahan[j] <> BahanOlahan.tab[k].nama
              found := false; 
              k := k + 1; 
			end; 
         end; 
      j := j + 1; 
     end;
  IsBahanOlahanAda := found;
  end;
  
  Function IsHargaValid(HargaResep : integer; MentahResep : Mresep; OlahanResep : Oresep; BahanMentah : TabMentah; BahanOlahan : TabOlahan) : boolean;   
  {I.S. Harga resep terdefinisi}
  {F.S. mengeluarkan nilai true jika harga resep memenuhi persyaratan dan false jika tidak}
  {fungsi untuk memvalidasi apakah harga masukan pengguna sudah memenuhi persyaratan}
  var //Kamus lokal
  j , k , sumharga : integer; 
  price : boolean;
  begin //Algoritma 
  sumharga := 0;
  j := 1; 

     while (j <= MentahResep.neff)  do begin 
       k := 1; 
         while (k <= BahanMentah.neff) do begin 
            if (MentahResep.bahan[j] = BahanMentah.tab[k].nama) then begin 
              sumharga := sumharga + BahanMentah.tab[k].harga; //menyimpan total harga dari bahan mentah
			  k := k + 1;
            end else begin //MentahResep.bahan[j] <> BahanMentah.tab[k].nama
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
              sumharga := sumharga + BahanOlahan.tab[k].harga; //menjumlahkan total harga bahan mentah dengan bahan olahan
			  k := k + 1; 
            end else begin //OlahanResep.bahan[j] <> BahanOlahan.tab[k].nama
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

  Procedure InputResepBaru(NamaResep : string; MentahResep : Mresep; OlahanResep : Oresep; HargaResep : integer; var ResepJadi : tabresep);
  {I.S. Nama, bahan pembentuk, dan harga resep terdefinisi}
  {F.S. Nama, bahan pembentuk, dan harga resep disimpan pada data daftar resep}
  {program untuk memindahkan data nama, bahan pembentuk, dan harga resep dari variabel sementara ke tipe bentukan tabresep
  
  var //Kamus lokal 
  i : integer; 
  
  begin //Algoritma 
  
  ResepJadi.neff := ResepJadi.neff + 1; //mengubah jumlah resep yang ada
  ResepJadi.tab[ResepJadi.neff].nama := NamaResep; //memasukan data nama resep
  ResepJadi.tab[ResepJadi.neff].harga := hargaResep; //memasukan data harga resep
  ResepJadi.tab[ResepJadi.neff].nmentah := MentahResep.neff; //memasukan data jumlah bahan mentah 
  ResepJadi.tab[ResepJadi.neff].nolahan := OlahanResep.neff; //mrmasukan data jumlah bahan olahan 
  
  for i := 1 to MentahResep.neff do begin 
    ResepJadi.tab[ResepJadi.neff].partmentah[i].nama := MentahResep.bahan[i];//memasukan data bahan2 mentah yang dibutuhkan
  end; 
  
  for i := 1 to OlahanResep.neff do begin 
    ResepJadi.tab[ResepJadi.neff].partolahan[i].nama := Olahanresep.bahan[i];//memasukan data bahan2 olahan yang dibutuhkan
  end; 
  
  end; 
  
  Procedure TambahResep(BahanMentah : TabMentah; BahanOlahan : TabOlahan; var ResepJadi : tabresep; var Energi : integer);
  {I.S. menerima masukan nama, pembentuk, dan harga resep dari pengguna}
  {F.S. nama, pembentuk, harga resep ke daftar resep atau pembuatan resep gagal}
  {fungsi keseluruhan untuk membuat resep baru}
  var //Kamus Lokal
  NamaResep : string; 
  MentahResep : Mresep; 
  OlahanResep : Oresep;
  HargaResep : integer;
  ResepValid : boolean; 
  begin //Algoritma
  
  InputDataResep(NamaResep, MentahResep, OlahanResep, HargaResep); 
  
  ResepValid := IsResepAda(ResepJadi, NamaResep);  
  if (ResepValid) then begin 
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
				end;
			end;
		end;
	end;
  end; 
  end;
				    
       
  
end. 
  
  
   
  
  
  
  
  
  
  
  
  
  
  
  

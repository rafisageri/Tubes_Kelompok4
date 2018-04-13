unit JualResep;

interface 

uses TypeUniverse;

  Procedure CekResep(JualR : string; FoundResep : boolean; ResepJadi : tabresep);
  
  Procedure CekBahanMentah (JualR : string; JumlahJualR : integer; BahanMentah : ListInventoriM; FoundMentah : boolean; CountMentah : boolean; ResepJadi : tabresep; Nsim : integer);  

  Procedure CekBahanOlahan (JualR : string; JumlahJualR : integer; BahanOlahan : ListInventoriO; FoundOlahan : boolean; CountOlahan : boolean; ResepJadi : tabresep; Nsim : integer);  
 
  Procedure KurangiBahanMentah (JualR : string; JumlahJualR : integer; BahanMentah : ListInventoriM; ResepJadi : tabresep; Nsim : integer); 
  
  Procedure KurangiBahanOlahan (JualR : string; JumlahJualR : integer; BahanOlahan : ListInventoriO; ResepJadi : tabresep; Nsim : integer); 
  
  procedure CekEnergi(Energi : Integer; CountEnergi : boolean); //energi dan CountEnergi merupakan var pada program utama
  
  Procedure KurangiEnergi(Energi : integer); 
  
  Procedure TambahPendapatanResep(Pendapatan : integer; JumlahJualR : integer; ResepJadi : tabresep; Nsim : integer);
  
  Procedure MenjualResep(JualR : string; JumlahJualR : integer; BahanMentah : ListInventoriM; BahanOlahan : ListInventoriO; ResepJadi : tabresep; FoundResep : boolean; FoundMentah : boolean; FoundOlahan : boolean; CountMentah : boolean; CountOlahan : boolean; CountEnergi : boolean; Energi : integer; Pendapatan : integer; Nsim : integer); 
  

implementation 

  
  Procedure CekResep(JualR : string; FoundResep : boolean; ResepJadi : tabresep);
  //Prosedur untuk mengecek apakah resep yang mau dibuat ada pada daftar resep
  
  var //Kamus lokal
  i : integer; 
  
  begin //Algoritma
  
  FoundResep := False; 
  i := 1; 
  
  repeat 
    if (ResepJadi.tab[i].nama = JualR) then begin 
	   FoundResep := True; 
	end else
       i := i + 1; 
   until (FoundResep) or (i > ResepJadi.neff); 
   
  end; 
  
  
  Procedure CekBahanMentah (JualR : string; JumlahJualR : integer; BahanMentah : ListInventoriM; FoundMentah : boolean; CountMentah : boolean; ResepJadi : tabresep; Nsim : integer);  
  //Prosedur untuk mengecek apakah bahan mentah yang dibutuhkan ada di inventori dan mengecek apakah jumlah stoknya cukup 
  
  var //Kamus lokal 
  i , j , k , m , n : integer ;
  Found : boolean;
  
  begin // Algoritma 
  
  FoundMentah := false; 
  CountMentah := false; 
  i := 1;
  j := 1; 
  Found := False; 
  
  repeat 
    if (ResepJadi.tab[i].nama = JualR) then begin 
	   Found := True; 
	end else
       i := i + 1; 
   until (Found) //Karena sudah divalidasi, resep sudah dipastikan ada pada daftar resep. looping hanya bertujuan menentukan posisi resep pada array
   
   while (j <= ResepJadi.tab[i].nmentah) and (FoundMentah) do begin 
     FoundMentah := False;
	 k := 1; 
	   while (k <= BahanMentah.list[Nsim].neff) and (not(FoundMentah)) do begin
          if (ResepJadi.tab[i].partmentah[j].nama = BahanMentah.list[nsim].tab[k].nama) then begin 
             FoundMentah := True; 
          end else 
             FoundMentah := False; 
			 k := k + 1;
       end;
     j := j + 1; 	   
    end; 
  
   if (not(FoundMentah)) then begin 
     writeln ('Penjualan resep gagal, bahan mentah tidak mencukupi'); 
   end else begin 
     n := 1;
	 
	 while (n <= ResepJadi.tab[i].nmentah) and (countMentah) do begin 
 	   CountMentah := False; 
	   m := 1;
	     while (m <= BahanMentah.list[Nsim].neff) and (not(CountMentah)) do begin 
		   if (ResepJadi.tab[i].partMentah[n].nama = BahanMentah.list[nsim].tab[m].nama) then begin 
		      if (BahanMentah.list[Nsim].tab[m].jumlah >= JumlahJualR) then begin 
			    CountMentah := True; 
			  end else 
			    CountMentah := False; 
		   end else  
              CountMentah := False;
              m := m + 1; 			  
		 end; 
	   n := n + 1;	 
	 end; 
    end; 	 
   
  end;
   
 Procedure CekBahanOlahan (JualR : string; JumlahJualR : integer; BahanOlahan : ListInventoriO; FoundOlahan : boolean; CountOlahan : boolean; ResepJadi : tabresep; Nsim : integer);  
  //Prosedur untuk mengecek apakah bahan olahan yang dibutuhkan ada di inventori dan mengecek apakah jumlah stoknya cukup 
  
  var //Kamus lokal 
  i , j , k , m , n : integer ;
  Found : boolean;
  
  begin // Algoritma 
  
  FoundOlahan := false; 
  CountOlahan := false; 
  i := 1;
  j := 1; 
  Found := False; 
  
  repeat 
    if (ResepJadi.tab[i].nama = JualR) then begin 
	   Found := True; 
	end else
       i := i + 1; 
   until (Found) //Karena sudah divalidasi, resep sudah dipastikan ada pada daftar resep. looping hanya bertujuan menentukan posisi resep pada array
   
   while (j <= ResepJadi.tab[i].nolahan) and (FoundOlahan) do begin 
     FoundOlahan := False;
	 k := 1; 
	   while (k <= BahanOlahan.list[Nsim].neff) and (not(FoundOlahan)) do begin
          if (ResepJadi.tab[i].partolahan[j].nama = BahanOlahan.list[nsim].tab[k].nama) then begin 
             FoundOlahan := True; 
          end else 
             FoundOlahan := False;
             k := k + 1; 			 
       end; 
	 j := j + 1;   
    end; 
  
   if (not(FoundOlahan)) then begin 
     writeln ('Penjualan resep gagal, bahan olahan tidak mencukupi'); //output ini menunjukan bahan apa yang kurang. kelemahannya adalah bahan yang tidak mencukupi yang ditampilkan hanya yang ditemukan pertama 
   end else begin 
     n := 1;
	 
	 while (n <= ResepJadi.tab[i].nolahan) and (countOlahan) do begin 
 	   CountMentah := False; 
	   m := 1;
	     while (m <= BahanOlahan.list[Nsim].neff) and (not(CountOlahan)) do begin 
		   if (ResepJadi.tab[i].partOlahan[n].nama = BahanOlahan.list[nsim].tab[m].nama) then begin 
		      if (BahanOlahan.list[Nsim].tab[m].jumlah >= JumlahJualR) then begin 
			    CountOlahan := True; 
			  end else 
			    CountOlahan := False; 
		   end else  
              CountOlahan := False;
              m := m + 1;			  
		 end; 
	   n := n + 1; 	 
	 end; 
    end; 	 
    
   end; 
	

  Procedure KurangiBahanMentah (JualR : string; JumlahJualR : integer; BahanMentah : ListInventoriM; ResepJadi : tabresep; Nsim : integer); 
  //Prosedur untuk mengurangi bahan mentah dan olahan yang dibutuhkan untuk menjual resep pada invetori, tidak ada proses validasi karena sudah pada prosedur sebelumnya

  var //Kamus lokal
  
  i , j , k : integer; 
  found : boolean; 

  begin //Algoritma 
    Found := false; 
    i := 1; 
    
   repeat 
    if (ResepJadi.tab[i].nama = JualR) then begin 
	   Found := True; 
	end else
       i := i + 1; 
   until (Found) //Karena sudah divalidasi, resep sudah dipastikan ada pada daftar resep. looping hanya bertujuan menentukan posisi resep pada array
   
   j := 1; 
   
   while (j <= ResepJadi.tab[i].nmentah) do begin 
     Found := false; 
     k := 1;
       while (k <= BahanMentah.list[Nsim].neff) and (not(found)) do begin 	 
	     if (ResepJadi.tab[i].partmentah[j].nama = BahanMentah.list[Nsim].tab[k].nama) then begin 
		    BahanMentah.list[Nsim].tab[K].jumlah := BahanMentah.list[Nsim].tab[k].jumlah - JumlahJualR; 
			found := true; 
	     end else 
		    found := false;
            k := k + 1; 			
	   end; 
	 j := j + 1;    
   end; 	   
  
  end;     

 Procedure KurangiBahanOlahan (JualR : string; JumlahJualR : integer; BahanOlahan : ListInventoriO; ResepJadi : tabresep; Nsim : integer); 
  //Prosedur untuk mengurangi bahan mentah dan olahan yang dibutuhkan untuk menjual resep pada invetori, tidak ada proses validasi karena sudah pada prosedur sebelumnya

  var //Kamus lokal
  
  i , j , k : integer; 
  found : boolean; 

  begin //Algoritma 
    Found := false; 
    i := 1; 
    
   repeat 
    if (ResepJadi.tab[i].nama = JualR) then begin 
	   Found := True; 
	end else
       i := i + 1; 
   until (Found) //Karena sudah divalidasi, resep sudah dipastikan ada pada daftar resep. looping hanya bertujuan menentukan posisi resep pada array
   
   j := 1; 
   
   while (j <= ResepJadi.tab[i].nolahan) do begin 
     Found := false; 
     k := 1;
       while (k <= Bahanolahan.list[Nsim].neff) and (not(found)) do begin 	 
	     if (ResepJadi.tab[i].partolahan[j].nama = Bahanolahan.list[Nsim].tab[k].nama) then begin 
		    Bahanolahan.list[Nsim].tab[K].jumlah := BahanOlahan.list[Nsim].tab[k].jumlah - JumlahJualR; 
			found := true; 
	     end else 
		    found := false;
            k := k + 1; 			
	   end; 
	 j := j + 1;    
   end; 	   
  
  end;      
		   
 Procedure CekEnergi(Energi : integer; CountEnergi : boolean); 
  //Prosedur untuk mengecek apakah energi 
  
  begin //Algoritma
  
    if (Energi > 0) then begin 
       CountEnergi := True;
  	end else 
       CountEnergi := False;	
  
  end;
  
  
  Procedure KurangiEnergi(Energi : integer); 
  //Prosedur untuk mengurangi energi saat melakukan satu kegiatan 
  begin //Algoritma 
  
  Energi := Energi - 1; 
  
  end; 
  
 Procedure TambahPendapatanResep(Pendapatan : integer; JumlahJualR : integer; ResepJadi : tabresep; Nsim : integer);
 //Prosedur untuk menambahkan pendapatan setelah berhasil menjual resep 
 
 var //Kamus lokal 
 i := integer;
 found := boolean; 
 
 begin //Algoritma
  i := 1; 
  found := false;
  
  repeat 
    if (ResepJadi.tab[i].nama = JualR) then begin 
	   Found := True; 
	end else
       i := i + 1; 
   until (Found)
  
  Pendapatan := Pendapatan + ResepJadi.tab[i].harga * JumlahJualR;
  
  end;
   
  Procedure MenjualResep(JualR : string; JumlahJualR : integer; BahanMentah : ListInventoriM; BahanOlahan : ListInventoriO; ResepJadi : tabresep; FoundResep : boolean; FoundMentah : boolean; FoundOlahan : boolean; CountMentah : boolean; CountOlahan : boolean; CountEnergi : boolean; Energi : integer; Pendapatan : integer; Nsim : integer); 
  //Prosedur menjual resep secara utuh 
  
  Begin //Algoritma
  
  CekResep(JualR, FoundResep, ResepJadi); 
  
  if (not(FoundResep)) then begin 
     Writeln('Penjualan resep gagal, resep tidak ditemukan');
  end else begin 
     CekBahanMentah(JualR, JumlahJualR, BahanMentah, FoundMentah, CountMentah, ResepJadi, Nsim);
	 if (not(CountMentah)) then begin 
	    writeln('Penjualan gagal, bahan mentah tidak mencukupi');
	 end else begin 
        CekBahanOlahan(JualR, JumlahJualR, BahanOlahan, FoundOlahan, CountOlahan, ResepJadi,Nsim); 
        if (not(CountOlahan)) then begin 
           Writeln('Penjualan resep gagal, bahan olahan tidak mencukupi'); 
        end else begin 
           KurangiBahanMentah(JualR, JumlahJualR, BahanMentah, ResepJadi, Nsim);
           KurangiBahanOlahan(JualR, JumlahJualR, BahanOlahan, ResepJadi, Nsim); 
           CekEnergi(Energi, CountEnergi); 
              if (not(CountEnergi)) then begin 
                writeln('Energi tidak mencukupi'); 
              end else begin 
                KurangiEnergi(energi); 
                TambahPendapatanResep(Pendapatan, JumlahJualR, ResepJadi, Nsim); 
              end ;				
	     end;
     end;
  end;
  
  end; 
  
end.
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
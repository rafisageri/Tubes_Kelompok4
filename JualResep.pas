unit JualResep;

interface 

  uses TypeUniverse;
  
  Procedure CekResep(JualR : string; var FoundResep : boolean; ResepJadi : tabresep; var i : integer);
  
  Procedure CekBahanMentah (JualR : string; JumlahJualR : integer; BahanMentah : ListInventoriM; FoundMentah : boolean; var CountMentah : boolean; ResepJadi : tabresep; Nsim : integer; i : integer);  

  Procedure CekBahanOlahan (JualR : string; JumlahJualR : integer; BahanOlahan : ListInventoriO; FoundOlahan : boolean; var CountOlahan : boolean; ResepJadi : tabresep; Nsim : integer; i : integer);  
 
  Procedure KurangiBahanMentah (JualR : string; JumlahJualR : integer; BahanMentah : ListInventoriM; ResepJadi : tabresep; Nsim : integer; i : integer); 
  
  Procedure KurangiBahanOlahan (JualR : string; JumlahJualR : integer; BahanOlahan : ListInventoriO; ResepJadi : tabresep; Nsim : integer; i : integer); 
  
  procedure CekEnergi(Energi : Integer; var CountEnergi : boolean); //energi dan CountEnergi merupakan var pada program utama
  
  Procedure KurangiEnergi(var Energi : integer); 
  
  Procedure TambahPendapatanResep(var Pendapatan : integer; JumlahJualR : integer; ResepJadi : tabresep; Nsim : integer; i : integer);
  
  Procedure MenjualResep(JualR : string; JumlahJualR : integer; BahanMentah : ListInventoriM; BahanOlahan : ListInventoriO; ResepJadi : tabresep; FoundResep : boolean; FoundMentah : boolean; FoundOlahan : boolean; CountMentah : boolean; CountOlahan : boolean; CountEnergi : boolean; var Energi : integer; var Pendapatan : integer; Nsim : integer); 
  

implementation 
  
  Procedure CekResep(JualR : string; var FoundResep : boolean; ResepJadi : tabresep; var i : integer);
  //Prosedur untuk mengecek apakah resep yang mau dibuat ada pada daftar resep
  
  begin //Algoritma
  
  FoundResep := False;  
  
  repeat 
    if (ResepJadi.tab[i].nama = JualR) then begin 
	   FoundResep := True; 
	end else
       i := i + 1; 
   until (FoundResep) or (i > ResepJadi.neff); 
   
  end; 
  
  
  Procedure CekBahanMentah (JualR : string; JumlahJualR : integer; BahanMentah : ListInventoriM; FoundMentah : boolean; var CountMentah : boolean; ResepJadi : tabresep; Nsim : integer; i : integer);  
  //Prosedur untuk mengecek apakah bahan mentah yang dibutuhkan ada di inventori dan mengecek apakah jumlah stoknya cukup 
  
  var //Kamus lokal 
  j , k , m , n : integer ;
 
  
  begin // Algoritma 
  
  FoundMentah := false; 
  CountMentah := false; 
  j := 1;
  
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
   
 Procedure CekBahanOlahan (JualR : string; JumlahJualR : integer; BahanOlahan : ListInventoriO; FoundOlahan : boolean; var CountOlahan : boolean; ResepJadi : tabresep; Nsim : integer; i : integer);  
  //Prosedur untuk mengecek apakah bahan olahan yang dibutuhkan ada di inventori dan mengecek apakah jumlah stoknya cukup 
  
  var //Kamus lokal 
  j , k , m , n : integer ;
 
  
  begin // Algoritma 
  
  FoundOlahan := false; 
  CountOlahan := false; 
  j := 1; 
   
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
 	   CountOlahan := False; 
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
	

  Procedure KurangiBahanMentah (JualR : string; JumlahJualR : integer; BahanMentah : ListInventoriM; ResepJadi : tabresep; Nsim : integer; i : integer); 
  //Prosedur untuk mengurangi bahan mentah dan olahan yang dibutuhkan untuk menjual resep pada invetori, tidak ada proses validasi karena sudah pada prosedur sebelumnya

  var //Kamus lokal
  
  j , k : integer; 
  Found : boolean;
  begin //Algoritma 
   
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

 Procedure KurangiBahanOlahan (JualR : string; JumlahJualR : integer; BahanOlahan : ListInventoriO; ResepJadi : tabresep; Nsim : integer; i : integer); 
  //Prosedur untuk mengurangi bahan mentah dan olahan yang dibutuhkan untuk menjual resep pada invetori, tidak ada proses validasi karena sudah pada prosedur sebelumnya

  var //Kamus lokal
  
  j , k : integer; 
  Found : boolean;
  begin //Algoritma
  
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
		   
 Procedure CekEnergi(Energi : integer; var CountEnergi : boolean); 
  //Prosedur untuk mengecek apakah energi 
  
  begin //Algoritma
  
    if (Energi > 0) then begin 
       CountEnergi := True;
  	end else 
       CountEnergi := False;	
  
  end;
  
  
  Procedure KurangiEnergi(var Energi : integer); 
  //Prosedur untuk mengurangi energi saat melakukan satu kegiatan 
  begin //Algoritma 
  
  Energi := Energi - 1; 
  
  end; 
  
 Procedure TambahPendapatanResep(var Pendapatan : integer; JumlahJualR : integer; ResepJadi : tabresep; Nsim : integer; i : integer);
 //Prosedur untuk menambahkan pendapatan setelah berhasil menjual resep 

 begin //Algoritma
 
  Pendapatan := Pendapatan + ResepJadi.tab[i].harga * JumlahJualR;
  
  end;
   
  Procedure MenjualResep(JualR : string; JumlahJualR : integer; BahanMentah : ListInventoriM; BahanOlahan : ListInventoriO; ResepJadi : tabresep; FoundResep : boolean; FoundMentah : boolean; FoundOlahan : boolean; CountMentah : boolean; CountOlahan : boolean; CountEnergi : boolean; var Energi : integer; var Pendapatan : integer; Nsim : integer); 
  //Prosedur menjual resep secara utuh 
  
  var //Kamus Lokal
  i : integer;
  
  Begin //Algoritma
  
  Write('Masukan nama resep : '); 
  readln(JualR);
  
  write('Jumlah : ');
  readln(JumlahJualR);
  
  i := 1; 
  CekResep(JualR, FoundResep, ResepJadi, i); 
  
  if (not(FoundResep)) then begin 
     Writeln('Penjualan resep gagal, resep tidak ditemukan');
  end else begin 
     CekBahanMentah(JualR, JumlahJualR, BahanMentah, FoundMentah, CountMentah, ResepJadi, Nsim, i);
	 if (not(CountMentah)) then begin 
	    writeln('Penjualan gagal, bahan mentah tidak mencukupi');
	 end else begin 
        CekBahanOlahan(JualR, JumlahJualR, BahanOlahan, FoundOlahan, CountOlahan, ResepJadi,Nsim, i); 
        if (not(CountOlahan)) then begin 
           Writeln('Penjualan resep gagal, bahan olahan tidak mencukupi'); 
        end else begin 
           KurangiBahanMentah(JualR, JumlahJualR, BahanMentah, ResepJadi, Nsim, i);
           KurangiBahanOlahan(JualR, JumlahJualR, BahanOlahan, ResepJadi, Nsim, i); 
           CekEnergi(Energi, CountEnergi); 
              if (not(CountEnergi)) then begin 
                writeln('Energi tidak mencukupi'); 
              end else begin 
                KurangiEnergi(energi); 
                TambahPendapatanResep(Pendapatan, JumlahJualR, ResepJadi, Nsim, i); 
              end ;				
	     end;
     end;
  end;
  
  end; 
  
end.
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
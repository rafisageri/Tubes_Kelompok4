unit JualBahanOlahan; 

interface 
  
  procedure CariOlahan(JualO : String; Olahan : ListInventoriO; FoundOlahan : Boolean); //JualO dan FoundOlahan var pada program utama 
  
  procedure KurangiOlahan(JumlahJualO : integer; Olahan : ListInventirO; FoundOlahan : Boolean); //JumlahJualO, Olahan, dan Foundolahan var pada program utama 

  procedure CekEnergi(Energi : Integer; CountEnergi : boolean); //energi dan CountEnergi merupakan var pada program utama
  
  procedure KurangiEnergi(Energi : integer; FoundOlahan : boolean); //Energi dan Foundolahan merupakan var pada program utama 

  procedure TambahPendapatan(Pendapatan : integer; Olahan : ListInventoriO); //Pendapatan merupakan var pada program utama 
  
  Procedure JualOlahan(JualO : String;  FoundOlahan : Boolean; JumlahJualO : integer; Olahan : ListInventoriO; Energi : integer; Pendapatan : integer); 
  
implementation 

  procedure CariOlahan(JualO : String; Olahan : ListInventoriO; FoundBoolean : Boolean); 
  //Prosedur untuk mencari bahan olahan pada inventori, apakah bahan tersebut ada atau tidak pada inventori
  var //kamus lokal
  i : integer; 
  found : boolean; 
  
  Begin //algoritma
  
    FoundOlahan := False;
    i := 1 ;
    repeat 
       if (ListinventoriO.list[n].Tab[i].Nama = JualO) then begin //n adalah nomor simulasi 
	     foundOlahan := True 
	   end else 
	     i := i + 1;
     until (foundOlahan) or (i > ListInventoriO.list[n].neff) //looping akan berhenti juga bahan olahan masukan ada pada inventori atau saat tidak ditemukan sampai array ke neff
   end;
   
  Procedure KurangiOlahan(JumlahJualO : integer; Olahan : ListInventoriO; FoundOlahan : Boolean);
  //Prosedur untuk mengurangi jumlah bahan olahan pada inventori 
  
  var //kamus lokal
  i : integer 
  
  Begin //Algoritma
  
    CountOlahan := False;
	i := 1; 
    repeat 
	    if (ListinventoriO.list[n].Tab[i].Nama = JualO) then begin //n adalah nomor simulasi 
	       if (ListInventoriO.list[n].tab[i].jumlah > JumlahJualO) then begin 
		     ListInventoriO.list[n].tab[i].jumlah := ListInventoriO.list[n].tab[i].jumlah - JumlahJualO;
			 ListInventoriO.list[n].ntot := ListInventorio.list[n].ntot - JumlahJualO;
			 CountOlahan := True ;
		   end else Count := False; 
	   end else 
	     i := i + 1;
     until (foundOlahan) or (i > ListInventoriO.list[n].neff); //bahan olahan pada inventori akan berkurang jika stock mencukupi, jika tidak maka looping akan terus berjalan sampai array ke neff
  
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

  Procedure TambahPendapatan(Pendapatan : integer; Olahan : ListInventoriO; JumlahJualO : integer);
  //Menambahkan Pendapatan saat menjual sesuatu
  
  begin //Algoritma
  
  Pendapatan := Pendapatan + ListInventoriO.list[n].tab[i].harga * JumlahJualO;
  
  end;
  
  
  Procedure JualOlahan(JualO : String;  FoundOlahan : Boolean; JumlahJualO : integer; Olahan : ListInventoriO; Energi : integer; Pendapatan : integer);
  
  begin //Algoritma 
  
  Write('Jual Bahan Olahan');
  readln(JualO);
  
  write('Jumlah'); 
  readln(JumlahJualO);
  
  CariOlahan(JualO, Olahan, FoundOlahan); 
  
  if (not(FoundOlahan)) then begin
      Writeln('Penjualan gagal, bahan olahan tidak ditemukan'); 
  end else begin 
     KurangiOlahan(JumlahJualO, Olahan, CountOlahan); 
         if (ListInventoriO.list[n].tab[i].jumlah = 0) then begin 
            writeln('Penjualan gagal, bahan olahan tidak ditemukan'); 
         end else 
		 if (not(CountOlahan)) then begin 
            writeln('Penjualan gagal, bahan olahan di inventori tidak mencukupi');
         end else begin 
		     CekEnergi(Energi,CountEnergi);
			   if (not(CountEnergi)) then begin 
			      Writeln('Penjualan gagal, energi tidak mencukupi');
			   end else begin 
   			   
                  KurangiEnergi(energi);
                  TambahPendapatan(Pendapatan, Olahan, JumlahJualO); 
				  Writeln('Penjualan berhasil');
			   end;
 
        end; 
   end; 

   end;    
          
    
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
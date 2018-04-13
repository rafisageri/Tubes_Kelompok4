unit JualBahanOlahan; 

interface 

uses TypeUniverse;
 
  procedure CariOlahan(JualO : String; BahanOlahan : ListInventoriO; FoundOlahan : Boolean; Nsim : integer); //JualO dan FoundOlahan var pada program utama. Nsim menunjukan nomor simulasi 
  
  procedure KurangiOlahan(JumlahJualO : integer; BahanOlahan : ListInventirO; FoundOlahan : Boolean; Nsim : integer); //JumlahJualO, Olahan, dan Foundolahan var pada program utama 

  procedure CekEnergi(Energi : Integer; CountEnergi : boolean); //energi dan CountEnergi merupakan var pada program utama
  
  procedure KurangiEnergi(Energi : integer); //Energi dan Foundolahan merupakan var pada program utama 

  procedure TambahPendapatan(Pendapatan : integer; JumlahJualO : integer; BahanOlahan : ListInventoriO; Nsim : integer); //Pendapatan merupakan var pada program utama 
  
  Procedure MenjualOlahan(JualO : String;  FoundOlahan : Boolean; JumlahJualO : integer; BahanOlahan : ListInventoriO; Energi : integer; Pendapatan : integer; Nsim : integer); 
  
implementation 

  procedure CariOlahan(JualO : String; BahanOlahan : ListInventoriO; FoundBoolean : Boolean; Nsim : integer); 
  //Prosedur untuk mencari bahan olahan pada inventori, apakah bahan tersebut ada atau tidak pada inventori
  var //kamus lokal
  i : integer; 
  
  Begin //algoritma
  
    FoundOlahan := False;
    i := 1 ;
    repeat 
       if (BahanOlahan.list[Nsim].Tab[i].Nama = JualO) then begin //n adalah nomor simulasi 
	     foundOlahan := True 
	   end else 
	     i := i + 1;
     until (foundOlahan) or (i > BahanOlahan.list[Nsim].neff) //looping akan berhenti juga bahan olahan masukan ada pada inventori atau saat tidak ditemukan sampai array ke neff
   end;
   
  Procedure KurangiOlahan(JumlahJualO : integer; BahanOlahan : ListInventoriO; FoundOlahan : Boolean; Nsim :integer);
  //Prosedur untuk mengurangi jumlah bahan olahan pada inventori 
  
  var //kamus lokal
  i : integer 
  
  Begin //Algoritma
  
    CountOlahan := False;
	i := 1; 
    repeat 
	    if (BahanOlahan.list[Nsim].Tab[i].Nama = JualO) then begin //n adalah nomor simulasi 
	       if (BahanOlahan.list[Nsim].tab[i].jumlah > JumlahJualO) then begin 
		     BahanOlahan.list[Nsim].tab[i].jumlah := BahanOlahan.list[Nsim].tab[i].jumlah - JumlahJualO;
			 BahanOlahan.list[Nsim].ntot := BahanOlahan.list[Nsim].ntot - JumlahJualO;
			 CountOlahan := True ;
		   end else Count := False; 
	   end else 
	     i := i + 1;
     until (foundOlahan) or (i > BahanOlahan.list[Nsim].neff); //bahan olahan pada inventori akan berkurang jika stock mencukupi, jika tidak maka looping akan terus berjalan sampai array ke neff
  
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

  Procedure TambahPendapatanOlahan(Pendapatan : integer; JumlahJualO : integer; BahanOlahan : ListInventoriO; Nsim : integer);
  //Menambahkan Pendapatan saat menjual sesuatu
  
  var //Kamus lokal 
  
  i := integer; 
  found := boolean; 
  
  begin //Algoritma
  
  Found := False;
    i := 1 ;
    repeat 
       if (BahanOlahan.list[Nsim].Tab[i].Nama = JualO) then begin //n adalah nomor simulasi 
	     found := True 
	   end else 
	     i := i + 1;
     until (found)
  
  Pendapatan := Pendapatan + BahanOlahan.list[Nsim].tab[i].harga * JumlahJualO; //buat algoritma searching bahan olahan
  
  end;
  
  
  Procedure MenjualOlahan(JualO : String;  FoundOlahan : Boolean; JumlahJualO : integer; BahanOlahan : ListInventoriO; Energi : integer; Pendapatan : integer; Nsim : integer);
  
  begin //Algoritma 
  
  Write('Jual Bahan Olahan');
  readln(JualO);
  
  write('Jumlah'); 
  readln(JumlahJualO);
  
  CariOlahan(JualO, BahanOlahan, FoundOlahan; Nsim); 
  
  if (not(FoundOlahan)) then begin
      Writeln('Penjualan gagal, bahan olahan tidak ditemukan'); 
  end else begin 
     KurangiOlahan(JumlahJualO, BahanOlahan, CountOlahan, Nsim); 
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
                  TambahPendapatan(Pendapatan, BahanOlahan, JumlahJualO, Nsim); 
				  Writeln('Penjualan berhasil');
			   end;
 
        end; 
   end; 

   end;    
          
end.   
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
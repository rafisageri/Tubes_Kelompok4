unit F7; 

interface 
 
  uses TypeUniverse;
  
  procedure CariOlahan(JualO : String; BahanOlahan : ListInventoriO; var FoundOlahan : Boolean; Nsim : integer; var i : integer); 
  
  procedure KurangiOlahan(BahanOlahan : ListInventoriO; Nsim : integer; i : integer); 

  procedure KurangiEnergi(var Energi : integer);  

  procedure TambahPendapatanOlahan(var Pendapatan : integer; JumlahJualO : integer; BahanOlahan : ListInventoriO; Nsim : integer; i : integer); 
  
  Procedure JualOlahan(var BahanOlahan : ListInventoriO; var Energi : integer; var Pendapatan : integer; Nsim : integer);
  
implementation 

  procedure CariOlahan(JualO : String;  BahanOlahan : ListInventoriO; var FoundOlahan : Boolean; Nsim : integer; var i : integer); 
  //Prosedur untuk mencari bahan olahan pada inventori, apakah bahan tersebut ada atau tidak pada inventori

  Begin //algoritma
  
    FoundOlahan := False;
    
    repeat 
       if (BahanOlahan.list[Nsim].Tab[i].Nama = JualO) then begin //n adalah nomor simulasi 
	     foundOlahan := True 
	   end else 
	     i := i + 1;
     until (foundOlahan) or (i > BahanOlahan.list[Nsim].neff) //looping akan berhenti juga bahan olahan masukan ada pada inventori atau saat tidak ditemukan sampai array ke neff
   end;
   
  Procedure KurangiOlahan(BahanOlahan : ListInventoriO; Nsim : integer; i : integer);
  //Prosedur untuk mengurangi jumlah bahan olahan pada inventori 
  
  
  Begin //Algoritma
  
  BahanOlahan.list[Nsim].tab[i].jumlah := BahanOlahan.list[Nsim].tab[i].jumlah - 1;
	 BahanOlahan.list[Nsim].ntot := BahanOlahan.list[Nsim].ntot - 1;
			  
  end; 
  
  Procedure KurangiEnergi(var Energi : integer); 
  //Prosedur untuk mengurangi energi saat melakukan satu kegiatan 
  begin //Algoritma 
  
  Energi := Energi - 1; 
  
  end; 

  Procedure TambahPendapatanOlahan(var Pendapatan : integer; JumlahJualO : integer; BahanOlahan : ListInventoriO; Nsim : integer; i : integer);
  //Menambahkan Pendapatan saat menjual sesuatu
    
  begin //Algoritma
  
  Pendapatan := Pendapatan + BahanOlahan.list[Nsim].tab[i].harga * JumlahJualO; //buat algoritma searching bahan olahan
  
  end;
  
  
  Procedure JualOlahan(var BahanOlahan : ListInventoriO; var Energi : integer; var Pendapatan : integer; Nsim : integer);
  // Prosedur untuk menjual bahan olahan secara utuh 
  
  var // Kamus lokal
  i , JumlahJualO : integer;
  JualO : String; 
  FoundOlahan : Boolean; 
  begin //Algoritma 
  
  Write('>> Nama Bahan Olahan : ');
  readln(JualO);
  
  write('>> Jumlah : '); 
  readln(JumlahJualO);
  
  i := 1; 
  
  CariOlahan(JualO, BahanOlahan, FoundOlahan, Nsim, i); 
  
  if (not(FoundOlahan)) then begin
     Writeln('Penjualan gagal, bahan olahan tidak ditemukan'); 
  end else begin 
         KurangiOlahan(BahanOlahan, Nsim, i); 
         if (BahanOlahan.list[nsim].tab[i].jumlah = 0) then begin 
            writeln('Penjualan gagal, bahan olahan tidak ditemukan'); 
         end else begin		 	   
              KurangiEnergi(energi);
              TambahPendapatanOlahan(Pendapatan, JumlahJualO, BahanOlahan, Nsim, i); 
		      Writeln('Penjualan berhasil');
	       end;
 
         end; 
   

  end;    
          
end; 

end.   

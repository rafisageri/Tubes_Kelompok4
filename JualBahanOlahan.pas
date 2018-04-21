unit JualBahanOlahan; 

interface 
 
  uses TypeUniverse;
  
  procedure CariOlahan(JualO : String; BahanOlahan : ListInventoriO; var FoundOlahan : Boolean; Nsim : integer; var i : integer); 
  
  procedure KurangiOlahan(BahanOlahan : ListInventoriO; Nsim : integer; i : integer); 

  procedure KurangiEnergi(var Energi : integer); 

  procedure TambahPendapatanOlahan(var Pendapatan : integer; JumlahJualO : integer; BahanOlahan : ListInventoriO; Nsim : integer; i : integer); 
  
  Procedure JualOlahan(var BahanOlahan : ListInventoriO; var Energi : integer; var Pendapatan : integer; Nsim : integer);
  
implementation 

  procedure CariOlahan(JualO : String;  BahanOlahan : ListInventoriO; var FoundOlahan : Boolean; Nsim : integer; var i : integer); 
  {I.S. bahan olahan yang ingin dijual terdefinisi}
  {F.S. bahan ditemukan atau tidak pada inventori bahan olahan}
  {prosedur untuk mencari apakah suatu bahan olahan ada pada inventori sehingga bisa dijual}

  Begin //algoritma
  
    FoundOlahan := False;
    
    repeat 
       if (BahanOlahan.list[Nsim].Tab[i].Nama = JualO) then begin //nsim adalah nomor simulasi 
	     foundOlahan := True 
	   end else //BahanOlahan.list[nsim].tab[i].nama <> JualO
	     i := i + 1;
     until (foundOlahan) or (i > BahanOlahan.list[Nsim].neff) //looping akan berhenti jika bahan olahan masukan ada pada inventori atau saat tidak ditemukan sampai array ke neff
   end;
   
  Procedure KurangiOlahan(BahanOlahan : ListInventoriO; Nsim : integer; i : integer);
  {I.S. 
  
  
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
  FoundOlahan , CountOlahan : Boolean; 
  begin //Algoritma 
  
  Write('Nama Bahan Olahan : ');
  readln(JualO);
  
  write('Jumlah : '); 
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
		   if (not(CountOlahan)) then begin 
              writeln('Penjualan gagal, bahan olahan di inventori tidak mencukupi');
           end else begin  			   
              KurangiEnergi(energi);
              TambahPendapatanOlahan(Pendapatan, JumlahJualO, BahanOlahan, Nsim, i); 
		      Writeln('Penjualan berhasil');
	       end;
 
         end; 
   

  end;    
          
end; 

end.   
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  

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
  {I.S. bahan olahan yang ingin dijual terdefinisi}
  {F.S. bahan ditemukan atau tidak pada inventori bahan olahan}
  {prosedur untuk mencari apakah suatu bahan olahan ada pada inventori sehingga bisa dijual}

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
  {I.S. jumlah bahan olahan pada inventori terdefinisi (jika 0 maka tidak ada bahan olahan)}
  {F.S. jumlah bahan olahan berkurang 1 dan total inventori berkurang 1}
  {Prosedur untuk megurangi bahan olahan yang akan dijual}
  
  Begin //Algoritma
  
  BahanOlahan.list[Nsim].tab[i].jumlah := BahanOlahan.list[Nsim].tab[i].jumlah - 1;
	 BahanOlahan.list[Nsim].ntot := BahanOlahan.list[Nsim].ntot - 1;
			  
  end; 
  
  Procedure KurangiEnergi(var Energi : integer); 
  {I.S. jumlah energi terdefinisi}
  {F.S. jumlah energi berkurang 1}
  {prosedur untuk mengurangi energi setelah melakukan suatu aksi}
  begin //Algoritma 
  
  Energi := Energi - 1; 
  
  end; 

  Procedure TambahPendapatanOlahan(var Pendapatan : integer; JumlahJualO : integer; BahanOlahan : ListInventoriO; Nsim : integer; i : integer);
  {I.S. Jumlah pendapatan terdefinisi}
  {F.S. pendapatan bertambah}
  {prosedur untuk menambahkan pendapatan setelah menjual sesuatu}
    
  begin //Algoritma
  
  Pendapatan := Pendapatan + BahanOlahan.list[Nsim].tab[i].harga * JumlahJualO; //buat algoritma searching bahan olahan
  
  end;
  
  
  Procedure JualOlahan(var BahanOlahan : ListInventoriO; var Energi : integer; var Pendapatan : integer; Nsim : integer);
  {I.S. bahan olahan yang ingin dijual terdefinisi}
  {F.S. bahan olahan terjual atau gagal karena beberapa faktor}
  {keseluruhan prosedur untuk menjual suatu bahan olahan pada inventori}
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
          
end.

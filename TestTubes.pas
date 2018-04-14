Program testtubes; 

uses JualResep , JualBahanOlahan, TypeUniverse;

var 
  BahanMentah : ListInventoriM;
  BahanOlahan : ListInventoriO;
  ResepJadi : TabResep; 
  FoundResep, FoundMentah, FoundOlahan, CountMentah, CountOlahan, CountEnergi : Boolean;
  JualO , JualR : string; 
  JumlahJualO, JumlahJualR, Nsim, Energi, Pendapatan, a, b, c : integer; 
  
begin 

  countenergi := true;
  countolahan := true;
  countmentah := true;
  foundresep := true;
  foundmentah := true;
  foundolahan := true; 
  jualo := 'namabahanolahan';
  jumlahjualo := 0;
  jualr := 'namaresep';
  jumlahjualr := 0;
  nsim := 1; 
  energi := 3; 
  pendapatan := 0; 
  
  BahanMentah.list[1].neff := 3;
  BahanMentah.list[1].ntot := 30;
  BahanOlahan.list[1].neff := 3;
  BahanOlahan.list[1].ntot := 30; 
  
  writeln('masukan nama bahan mentah');
  for a := 1 to 3 do begin 
    readln(BahanMentah.list[1].tab[a].nama);
  end; 
  
  writeln('masukan nama bahan olahan');
  for a := 1 to 3 do begin 
    readln(BahanOlahan.list[1].tab[a].nama); 
  end;
  
  writeln('masukan daftar resep'); 
  for a := 1 to 3 do begin 
    readln(ResepJadi.tab[a].nama);   
  end;
  
  for a := 1 to 3 do begin 
    BahanMentah.list[1].tab[a].jumlah := 3;  
  end; 
  
  for a := 1 to 3 do begin 
    BahanOlahan.list[1].tab[a].jumlah := 2; 
  end;
  
  for a := 1 to 3 do begin  
    BahanOlahan.list[1].tab[a].harga := 1000; 
  end; 

  for a := 1 to 3 do begin 
    Resepjadi.tab[a].harga := 4000; 
  end; 
  
  for a := 1 to 3 do begin 
    ResepJadi.tab[a].nmentah := 2;
  end; 
  
  for a := 1 to 3 do begin 
    ResepJadi.tab[a].nolahan := 2; 
  end; 
  
  writeln('masukan daftar bahan mentah untuk resep');
  for a := 1 to 3 do begin 
    writeln('resep ' , a);
    for b := 1 to 2 do begin 
    readln(ResepJadi.tab[a].partmentah[b].nama); 
	end;
  end; 
  
  writeln('masukan daftar bahan olahan untuk resep');  
  for a := 1 to 3 do begin 
    writeln('resep ' , a);
    for b := 1 to 2 do begin 
    readln(ResepJadi.tab[a].partolahan[b].nama); 
	end;
  end; 
  

  
  writeln('test Jualolahan');
  writeln;
  
  MenjualOlahan(JualO , FoundOlahan  , JumlahJualO ,BahanOlahan, CountOlahan, CountEnergi , Energi, Pendapatan , Nsim ); 
  writeln;
  
  writeln('test Jualresep');
  
  MenjualResep(JualR , JumlahJualR, BahanMentah , BahanOlahan , ResepJadi , FoundResep , FoundMentah , FoundOlahan , CountMentah , CountOlahan , CountEnergi , Energi , Pendapatan, Nsim); 
  writeln('test selesai');
  writeln;
 

 end.
  
unit B4;

interface
	uses typeuniverse;
	procedure Restock (var a : tabInventoriM; var b : tabInventoriO; var imax : integer; s : listSimulasi; n : integer {simulasi ke berapa});
	
implementation
	
	procedure Restock (var a : tabInventoriM; var b : tabInventoriO; var imax : integer; s : listSimulasi; n : integer {simulasi ke berapa});
	begin
		if (a.ntot+b.ntot+9<= imax) then {KALAU INVENTORI MASIH CUKUP -> RESTOCK, KALAU ENGGA GAK AJDI}
		begin
			if (s.tab[n].totalhari = 3) or (s.tab[n].totalhari = 6) or (s.tab[n].totalhari = 9) then {SETIAP 3 HARI}
			begin
				a.tab[a.neff+1].nama := a.tab[1].nama;
				a.tab[a.neff+1].tglbeli.hari := 000; {KALAU RESTOCK MAKA TANGGALNYA JADI 000 UNTUK MEMBEDAKAN}
				a.tab[a.neff+1].jumlah := 3;
				a.tab[a.neff+2].nama := a.tab[2].nama;
				a.tab[a.neff+2].tglbeli.hari := 000;
				a.tab[a.neff+2].jumlah := 3;
				a.tab[a.neff+3].nama := a.tab[3].nama;
				a.tab[a.neff+3].tglbeli.hari := 000;
				a.tab[a.neff+3].jumlah := 3;
				a.neff := a.neff+3;
				a.ntot := a.ntot+9;
			end;
		end;
	end;
end.

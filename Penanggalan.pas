unit Penanggalan;
interface
	uses typeuniverse;
	procedure GantiHari(var hariini:tanggal);
	//I.S. hariini terdefinisi, F.S. hariini terdefinisi
	//Spek: mengganti hari menjadi keesokan hari
	//Asumsi tanggal real
	//Catatan: generator tanggal menggunakan tanggal real dari PC
	
implementation
	procedure GantiHari(var hariini:tanggal);
	begin
		if (hariini.hari=31) then
		begin
			if hariini.bulan = 12 then //Akhir tahun
			begin
				hariini.hari	:=1;
				hariini.bulan	:=1;
				hariini.tahun	:=hariini.tahun+1;
			end
			else //bukan akhir tahun
			begin
				hariini.hari	:=1;
				hariini.bulan	:=hariini.bulan+1;
			end;
		end
		else if (hariini.hari=30) and ((hariini.bulan=4) or (hariini.bulan=6) or (hariini.bulan=9) or (hariini.bulan=11)) then
		begin
				hariini.hari	:=1;
				hariini.bulan	:=hariini.bulan+1;
		end
		else if (hariini.hari=29) and (hariini.bulan=2) then //kabisat, februari
		begin
				hariini.hari	:=1;
				hariini.bulan	:=3; //Maret
		end
		else if (hariini.hari=28) and (hariini.bulan=2) then //februari
		begin
			if (hariini.tahun mod 4 = 0) and (hariini.tahun mod 100 <> 0) then //kabisat
			begin
				hariini.hari	:=29;
			end
			else // bukan kabisat
			begin
				hariini.hari	:=1;
				hariini.bulan	:=3; //Maret
			end;
		end
		else //bukan kemungkinan akhir bulan
		begin
			hariini.hari	:=hariini.hari+1;
		end;
	end;
end.
unit F6;

interface
	uses typeuniverse, sysutils;
	procedure olahBahan (O : tabOlahan; var a : tabInventoriM; var b : tabInventoriO; var e {energi} : integer);
	
implementation
	
	procedure olahBahan (o : tabOlahan; var a : tabInventoriM; var b : tabInventoriO; var e {energi} : integer);
	var
		x : olahan;
		i, n, u, z, p : integer;
		cek : boolean;
		ada : boolean;
		tt : TDateTime;
		dd,mm,yy : word;
		
	begin
		writeln('Buat olahan:'); {INPUT NAMA}
		readln(x.nama);
		writeln('Jumlah:'); {INPUT JUMLAH}
		readln(n);
		
		{CEK YANG MAU DIBUAT ADA DI OLAHAN GAK}
		i:=1;
		cek := false;
		while (i<=o.neff) and not(cek) do
		begin
			if (o.tab[i].nama = x.nama) then cek:= true
			else i:=i+1;
		end;
		
		if (not(cek)) then writeln('Pembuatan gagal, olahan tidak ada di daftar') {KALO GA ADA DI OLAHAN}
		else {KALO ADA DI OLAHAN}
		begin
			if (e<=0) then writeln('Pembuatan gagal, energi tidak mencukupi') {KALO ENERGI GA CUKUP}
			else {ENERGI CUKUP}
			begin
				u := 1;
				while (u<=o.tab[i].n) do {U= BANYAK BAHAN, EX: NASI GORENG, U=2, NASI, KECAP}
				begin
					p := n; {PENGGANTI N KALO ADA KASUS BAHAN PAS DIBELI GA CUKUP, MAKA KE PEMBELIAN BERIKUTNYA}
					z := 1;
					while (z<=a.neff) do {MENCARI BAHAN MENTAH DI INVENTORI MENTAH}
					begin
						ada := false;
						if (a.tab[z].nama=o.tab[i].komposisi[u].nama) or not(ada) then {KALO DAPET NAMANYA DI INVENTORI}
						begin
							if (a.tab[z].jumlah<=0) then {KASUS TERNYATA BAHAN PERTAMA DIBELI ABIS}
							z := z+1
							else
							begin
								if ((a.tab[z].jumlah-n)<0) then {KASUS TERNYATA PAS KETEMU GA CUKUP}
								begin
									p:= n- a.tab[z].jumlah;
									a.tab[z].jumlah := 0;
									z:= z+1;
								end
								else {KASUS LANGSUNG/PAS SETELAH KETEMU CUKUP}
								begin
									ada := true;
									a.tab[z].jumlah := (a.tab[z].jumlah-p);
								end;
							end; 
						end
						else
						z := z+1;
					end;
					if (ada = false) then {KASUS GA KETEMU SAMA SEKALI DI INVENTORI}
					begin
						u := 101;
						writeln('Bahan mentah tidak tersedia di inventori');
					end
					else u:= u+1; {BAHAN DAPET LANJUT}
				end;
				
				if (ada = true) then {UDAH BERES MAKA MASUKKIN KE ARRAY}
				begin
					e:= e-1;
					b.tab[b.neff+1].nama := x.nama;
					begin
						tt:=Date;
						DecodeDate(tt,yy,mm,dd);
						b.tab[b.neff+1].tglbuat.hari:= dd;
						b.tab[b.neff+1].tglbuat.hari:= mm;
						b.tab[b.neff+1].tglbuat.hari:= yy;
					end;
					b.tab[b.neff+1].jumlah := n;
					b.tab[b.neff+1].harga := o.tab[i].harga;
					b.neff := b.neff+1;
					b.ntot := b.ntot+n;
				end;
			end;
		end;
	end;
end.

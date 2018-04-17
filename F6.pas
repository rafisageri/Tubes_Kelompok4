unit F6;

interface
	uses typeuniverse, sysutils;
	procedure olahBahan (o : tabOlahan; var a : tabInventoriM; var b : tabInventoriO; var e {energi} : integer; tglNow: tanggal);
	
implementation
	
	procedure olahBahan (o : tabOlahan; var a : tabInventoriM; var b : tabInventoriO; var e {energi} : integer; tglNow: tanggal);
	var
		x : olahan;
		i, n, u, z, p, j, k, l : integer;
		cek : boolean;
		gada : boolean;
		beres : boolean;
		tt : TDateTime;
		dd,mm,yy : word;
		tabSum : array[1..100] of integer;
		sum : integer;
		
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
				j := 1; {VALIDASI JUMLAH SELURUH BAHAN MENCUKUPI ATAU TIDAK}
				for j:=1 to o.tab[i].n do
				begin
					sum := 0;
					k := 1;
					for k:=1 to a.neff do
					begin
						if (a.tab[k].nama = o.tab[i].komposisi[j].nama) then
						sum := sum + a.tab[k].jumlah;
					end;
					tabSum[j]:= sum;
				end;
				
				gada := false;
				l := 1;
				
				while (l<=o.tab[i].n) and not(gada) do {CEK BAHAN 1 PER SATU}
				begin
					if (tabSum[l]=0) then gada := true
					else l:=l+1
				end;
				
				if (gada= false) then {BAHAN ADA SEMUA}
				begin
					for u:=1 to o.tab[i].n do {U= BANYAK BAHAN, EX: NASI GORENG, U=2, NASI, KECAP}
					begin
						p := n; {PENGGANTI N KALO ADA KASUS BAHAN PAS DIBELI GA CUKUP, MAKA KE PEMBELIAN BERIKUTNYA}
						z := 1;
						beres := false;
						while (z<=a.neff) and not(beres) do {MENCARI BAHAN MENTAH DI INVENTORI MENTAH}
						begin
							if (a.tab[z].nama=o.tab[i].komposisi[u].nama) then {KALO DAPET NAMANYA DI INVENTORI}
							begin
								if (a.tab[z].jumlah<=0) then {KASUS TERNYATA BAHAN PERTAMA DIBELI ABIS}
								z := z+1
								else
								begin
									if ((a.tab[z].jumlah-n)<0) then {KASUS TERNYATA PAS KETEMU GA CUKUP}
									begin
										p:= n- a.tab[z].jumlah;
										a.ntot := a.ntot - a.tab[z].jumlah;
										a.tab[z].jumlah := 0;
										z:= z+1;
									end
									else {KASUS LANGSUNG/PAS SETELAH KETEMU CUKUP}
									begin
										a.tab[z].jumlah := (a.tab[z].jumlah-p);
										a.ntot := a.ntot - p;
										beres := true;
									end;
								end; 
							end
							else {MASIH MENCARI NAMA BAHAN DI TABEL}
							z := z+1;
						end;
					end;
				end
				else {gada = true}
				writeln('Jumlah bahan tidak mencukupi');
				
				if (gada = false) then {UDAH BERES MAKA MASUKKIN KE ARRAY}
				begin
					e:= e-1;
					b.tab[b.neff+1].nama := x.nama;
					begin
						tt:=Date;
						DecodeDate(tt,yy,mm,dd);
						b.tab[b.neff+1].tglbuat.hari:= tglNow.hari;
						b.tab[b.neff+1].tglbuat.hari:= tglNow.bulan;
						b.tab[b.neff+1].tglbuat.hari:= tglNow.tanggal;
					end;
					b.tab[b.neff+1].jumlah := n;
					b.tab[b.neff+1].harga := o.tab[i].harga;
					b.neff := b.neff+1;
					b.ntot := b.ntot+n;
					writeln('Pembuatan olahan berhasil');
				end;
			end;
		end;
	end;
end.

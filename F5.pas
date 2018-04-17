unit F5;

interface
	uses typeuniverse, sysutils;
	procedure beliBahan ( a : tabMentah; var b : tabInventoriM; var c : tabInventoriO; var u {uang} : integer; var e {energi} : integer; var imax {inventori maks} : integer; tglNow:tanggal);
	
implementation

	procedure beliBahan ( a : tabMentah; var b : tabInventoriM; var c : tabInventoriO; var u {uang} : integer; var e {energi} : integer; var imax {inventori maks} : integer; tglNow:tanggal);
	var
		x : mentah;
		n, i : integer;
		cek : boolean;
		tt : TDateTime;
		dd,mm,yy : word;
	begin
		writeln('Beli bahan:'); {INPUT NAMA}
		readln(x.nama);
		writeln('Jumlah:'); {INPUT JUMLAH}
		readln(n);
		
		i:=1;
		cek := false;
		while (i<=a.neff) and (cek=false) do {VALIDASI NAMA BAHAN}
		begin
			if (a.tab[i].nama = x.nama) then cek := true
			else
			i:=i+1;
		end;
		
		if (cek=false) then writeln('Pembelian gagal, bahan tidak dijual di supermarket') {BAHAN TIDAK TERSEDIA DI FILE}
		else {BAHAN DITEMUKAN}
		begin
			if (e<=0) then writeln('Pembelian gagal, energi tidak mencukupi') {ENERGI TIDAK CUKUP}
			else {ENERGI MENCUKUPI}
			begin
				if ((b.ntot+n+c.ntot) > imax) then writeln('Pembelian gagal, inventori tidak mencukupi') {INVENTORI PENUH}
				else {INVENTORI CUKUP}
				begin
					if (a.tab[i].harga*n > u) then writeln('Pembelian gagal, uang tidak mencukupi') {UANG TIDAK CUKUP}
					else {UANG CUKUP}
					begin
						e:= e-1;
						u:= u - (a.tab[i].harga*n );
						{INPUT KE INVENTORI}
						b.tab[b.neff+1].nama := x.nama;
						begin
							tt:=Date;
							DecodeDate(tt,yy,mm,dd);
							b.tab[b.neff+1].tglbeli.hari:= tglNow.hari;
							b.tab[b.neff+1].tglbeli.hari:= tglNow.bulan;
							b.tab[b.neff+1].tglbeli.hari:= tglNow.tahun;
						end;
						b.tab[b.neff+1].jumlah := n;
						b.neff := b.neff+1;
						b.ntot := b.ntot+n;
						writeln('Total harga: ', a.tab[i].harga*n);
						writeln('Pembelian berhasil');
					end;
				end;
			end;
		end;
	end;
end.
{Pada program awal cantumin energi, uang, imax, sama dideklarasi awal neff dan ntot = 0)
(Neff itu baris yang ada di tab, ntot itu jumlah total seluruh barang}

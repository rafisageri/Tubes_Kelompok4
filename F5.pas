unit F5;

interface
	uses typeuniverse, sysutils;
	procedure beliBahan ( a : tabMentah; var b : tabInventoriM; var c : tabInventoriO; var u {uang} : integer; var e {energi} : integer; var imax {inventori maks} : integer);
	
implementation

	procedure beliBahan ( a : tabMentah; var b : tabInventoriM; var c : tabInventoriO; var u {uang} : integer; var e {energi} : integer; var imax {inventori maks} : integer);
	var
		x : mentah;
		n, i : integer;
		cek : boolean;
		tt : TDateTime;
		dd,mm,yy : word;
	begin
		writeln('Beli bahan:');
		readln(x.nama);
		writeln('Jumlah:');
		readln(n);
		
		i:=1;
		cek := false;
		while (i<=a.neff) or not(cek) do
		begin
			if (a.tab[i].nama = x.nama) then cek := true
			else i:=i+1;
		end;
		
		if (not(cek)) then writeln('Pembelian gagal, bahan tidak dijual di supermarket')
		else
		begin
			if (e<=0) then writeln('Pembelian gagal, energi tidak mencukupi')
			else
			begin
				if ((b.ntot+n+c.ntot) > imax) then writeln('Pembelian gagal, inventori tidak mencukupi')
				else
				begin
					if (a.tab[i].harga*n > u) then writeln('Pembelian gagal, uang tidak mencukupi')
					else
					begin
						e:= e-1;
						u:= u - (a.tab[i].harga*n );
						b.tab[b.neff+1].nama := x.nama;
						begin
							tt:=Date;
							DecodeDate(tt,yy,mm,dd);
							b.tab[b.neff+1].tglbeli.hari:= dd;
							b.tab[b.neff+1].tglbeli.hari:= mm;
							b.tab[b.neff+1].tglbeli.hari:= yy;
						end;
						b.tab[b.neff+1].jumlah := n;
						b.neff := b.neff+1;
						b.ntot := b.ntot+n;
					end;
				end;
			end;
		end;
	end;
end.
{Pada program awal cantumin energi, uang, imax, sama dideklarasi awal neff dan ntot = 0)
(Neff itu baris yang ada di tab, ntot itu jumlah total seluruh barang}

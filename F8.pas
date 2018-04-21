unit F8;

interface 
  uses TypeUniverse , sysutils;
  function cariBahanMentah (bahan : string; daftarBahan : TabInventoriM): integer;
  function cariBahanOlahan (bahan : string; daftarBahan : TabInventoriO): integer;
  function cariIndeksResep (resep : string; daftarResep : tabResep): integer;
  function isBahanMentahValid (bahan : string; n : integer; daftarBahan : TabInventoriM): boolean;
  function isBahanOlahanValid (bahan : string; n : integer; daftarBahan : TabInventoriO): boolean;  
  procedure jualResep (daftarResep : tabresep; daftarBahanM : TabInventoriM; daftarBahanO : TabInventoriO; var pendapatan : longint; var energi : integer);

implementation 

function cariBahanMentah (bahan : string; daftarBahan : TabInventoriM): integer;
{I.S. Nama bahan mentah yang akan dicari dan daftar bahan mentahnya terdefinisi
 F.S. Fungsi akan mengembalikan nomor indeks posisi bahan mentah pada daftar bahan mentah 
 dan mengembalikan -1 jika nama bahan mentah tidak ditemukan pada daftar bahan mentah}
	var {KAMUS LOKAL cariBahanMentah}
		stop : boolean;
		i : integer;
	begin {ALGORITMA cariBahanMentah}
		stop := False;
		i := 1;
		while ( (i<=daftarBahan.neff) and (stop=False) ) do
		begin
			if (bahan = daftarBahan.tab[i].nama) then 
			begin
				stop := True;
			end;
			i := i + 1;
		end;
		{Jika looping berhenti bukan karena stop bernilai True, berarti bahan tidak ditemukan. 
		 Sehingga fungsi akan mengembalikan nilai -1}
		if (stop) then
			cariBahanMentah := i
		else
			cariBahanMentah := -1;
	end;

function cariBahanOlahan (bahan : string; daftarBahan : TabInventoriO): integer;
{I.S. Nama bahan olahan yang akan dicari dan daftar bahan olahannya terdefinisi
 F.S. Fungsi akan mengembalikan nomor indeks posisi bahan olahan pada daftar bahan olahan 
 dan mengembalikan -1 jika nama bahan olahan tidak ditemukan pada daftar bahan olahan}
	var {KAMUS LOKAL cariBahanOlahan}
		stop : boolean;
		i : integer;
	begin {ALGORITMA cariBahanOlahan}
		stop := False;
		i := 1;
		while ( (i<=daftarBahan.neff) and (stop=False) ) do
		begin
			if (bahan = daftarBahan.tab[i].nama) then 
			begin
				stop := True;
			end;
			i := i + 1;
		end;
		{Jika looping berhenti bukan karena stop bernilai True, berarti bahan tidak ditemukan. 
		 Sehingga fungsi akan mengembalikan nilai -1}
		if (stop) then
			cariBahanOlahan := i
		else
			cariBahanOlahan := -1;
	end;

function cariIndeksResep (resep : string; daftarResep : tabResep): integer;
{I.S. Nama resep yang akan dicari dan daftar resepnya terdefinisi
 F.S. Fungsi akan mengembalikan nomor indeks posisi bahan resep pada daftar resep 
 dan mengembalikan -1 jika nama resep tidak ditemukan pada daftar resep}
	var {KAMUS LOKAL cariIndeksResep}
		stop : boolean;
		i : integer;
	begin {ALGORITMA cariIndeksResep}
		stop := False;
		i := 1;
		while ( (i<=daftarResep.neff) and (stop=False) ) do
		begin
			if (resep = daftarResep.tab[i].nama) then 
			begin
				stop := True;
			end;
			i := i + 1;
		end;
		{Jika looping berhenti bukan karena stop bernilai True, berarti bahan tidak ditemukan. 
		 Sehingga fungsi akan mengembalikan nilai -1}
		if (stop) then
			cariIndeksResep := i
		else
			cariIndeksResep := -1;
	end;
	
function isBahanMentahValid (bahan : string; n : integer; daftarBahan : TabInventoriM): boolean;  
{I.S. Nama bahan mentah dan jumlahnya yang akan dijual terdefinisi, daftar bahan mentah juga terdefinisi
 F.S. Fungsi akan menghasilkan True jika nama bahan mentah ada di daftar bahan mentah dan jumlahnya mencukupi untuk dijual}
	var {KAMUS LOKAL isBahanMentahValid}
		i : integer;
	begin {ALGORITMA isBahanMentahValid}
		{Mengecek apakah nama bahan mentah ada di daftar bahan mentah yang terdefinisi}
		i := cariBahanMentah(bahan, daftarBahan);
		if (i = -1) then {cariBahanMentah() menghasilkan -1 jika bahan tidak ada di daftar bahan}
		begin
			isBahanMentahValid := False; {Berdasarkan definisi, fungsi langsung bernilai False}
		end else {i <> -1}
		begin
			{Mengecek apakah nama bahan mentah yang ingin dijual jumlahnya cukup}
			if (n <= daftarBahan.tab[i].jumlah) then 
			begin
				isBahanMentahValid := True;
			end else {jumlah bahan tidak mencukupi untuk dijual}
				isBahanMentahValid := False;
		end;
	end;
	
function isBahanOlahanValid (bahan : string; n : integer; daftarBahan : TabInventoriO): boolean;  
{I.S. Nama bahan olahan dan jumlahnya yang akan dijual terdefinisi, daftar bahan olahan juga terdefinisi
 F.S. Fungsi akan menghasilkan True jika nama bahan olahan ada di daftar bahan olahan dan jumlahnya mencukupi untuk dijual}
	var {KAMUS LOKAL isBahanOlahanValid}
		i : integer;
	begin {ALGORITMA isBahanOlahanValid}
		{Mengecek apakah nama bahan olahan ada di daftar bahan olahan yang terdefinisi}
		i := cariBahanOlahan(bahan, daftarBahan);
		if (i = -1) then {cariBahanOlahan() menghasilkan -1 jika bahan tidak ada di daftar bahan}
		begin
			isBahanOlahanValid := False; {Berdasarkan definisi, fungsi langsung bernilai False}
		end else {i <> -1}
		begin
			{Mengecek apakah nama bahan mentah yang ingin dijual jumlahnya cukup}
			if (n <= daftarBahan.tab[i].jumlah) then 
			begin
				isBahanOlahanValid := True;
			end else {jumlah bahan tidak mencukupi untuk dijual}
				isBahanOlahanValid := False;
		end;
	end;

procedure jualResep (daftarResep : tabresep; daftarBahanM : TabInventoriM; daftarBahanO : TabInventoriO; var pendapatan : longint; var energi : integer);
{I.S. Nama resep, daftar resep, daftar bahan mentah, daftar bahan olahan, dan pendapatan saat ini terdefinisi. Energi saat ini terdefinisi dan tervalidasi
 F.S. Jika resep yang akan dijual valid, maka bahan mentah dan bahan olahan di inventori berkurang, pendapatan bertambah, dan energi berurang}
	var {KAMUS LOKAL jualResep}
		i : integer;
		j, p, count : integer;
		bahan, resep : string;
	begin {ALGORITMA jualResep}
		writeln('>> Masukkan nama resep');
		readln(resep);
		i := cariIndeksResep (resep, daftarResep);
		if ( i = -1 ) then
		begin 
			writeln ('Nama resep tidak ada di daftar resep !');
		end else {Nama resep ada di daftar resep}
			count := 0;
			{Mengecek validitas bahan bahan mentah penyusun resep}
			for j:=1 to daftarResep.tab[i].nmentah do
			begin
				bahan := daftarResep.tab[i].partmentah[j].nama;
				if ( not(isBahanMentahValid(bahan,1,daftarBahanM)) ) then //Berdasarkan spesifikasi soal,
				begin											          //Diasumsikan n =1
					count := count + 1;
				end;
			end;
			if (count > 0) then
			begin
				writeln ('Bahan mentah yang diperlukan untuk membuat resep tidak ada di daftar bahan mentah atau jumlahnya tidak mencukupi');
			end else
			begin
				{Mengecek validitas bahan bahan olahan penyusun resep}
				for j:=1 to daftarResep.tab[i].nolahan do
				begin
					bahan := daftarResep.tab[i].partolahan[j].nama;
					if ( not(isBahanOlahanValid(bahan,1,daftarBahanO)) ) then //Berdasarkan spesifikasi soal,
					begin											          //Diasumsikan n =1
						count := count + 1;
					end;
				end;
				if (count > 0) then
				begin
					writeln ('Bahan olahan yang diperlukan untuk membuat resep tidak ada di daftar bahan olahan atau jumlahnya tidak mencukupi');
				end else
				begin
					{Nama resep, bahan mentah penyusun, dan bahan olahan penyusun sudah valid}
					
					{Mengurangi bahan mentah di inventori}
					for j:=1 to daftarResep.tab[i].nmentah do
					begin
						bahan := daftarResep.tab[i].partmentah[j].nama;
						p := cariBahanMentah(bahan, daftarBahanM);
						daftarBahanM.tab[p].jumlah := daftarBahanM.tab[p].jumlah - 1;
					end;

					{Mengurangi bahan olahan di inventori}
					for j:=1 to daftarResep.tab[i].nolahan do
					begin
						bahan := daftarResep.tab[i].partolahan[j].nama;
						p := cariBahanOlahan(bahan, daftarBahanO);
						daftarBahanO.tab[p].jumlah := daftarBahanO.tab[p].jumlah - 1;
					end;
					
					{Menambah pendapatan berdasarkan harga jual resep}
					pendapatan := pendapatan + daftarResep.tab[i].harga;
					
					writeln ('Resep ', resep, ' berhasil terjual. Pendapatan bertambah sebesar = ', daftarResep.tab[i].harga);
					writeln ('Uang sekarang = ', pendapatan);
					
					{Mengurangi energi sebesar 1, terdefinisi di spesifikasi soal}
					energi := energi - 1;
				end;
			end;
		end;			
end.

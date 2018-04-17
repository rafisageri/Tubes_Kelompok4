unit jualResep;

interface 
  uses TypeUniverse , sysutils;
  function cariBahanMentah (bahan : string; daftarBahan : TabInventoriM): integer;
  function cariBahanOlahan (bahan : string; daftarBahan : TabInventoriO): integer;
  function cariResep (resep : string; daftarResep : tabResep): integer;
  function isBahanMentahValid (bahan : string; n : integer; daftarBahan : TabInventoriM): boolean;
  function isBahanOlahanValid (bahan : string; n : integer; daftarBahan : TabInventoriO): boolean;  
  procedure jualResep(var BahanMentah : ListInventoriM; var BahanOlahan : ListInventoriO; ResepJadi : tabresep; var Energi : integer; var Pendapatan : integer; Nsim : integer); 

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

function cariResep (resep : string; daftarResep : tabResep): integer;
{I.S. Nama resep yang akan dicari dan daftar resepnya terdefinisi
 F.S. Fungsi akan mengembalikan nomor indeks posisi bahan resep pada daftar resep 
 dan mengembalikan -1 jika nama resep tidak ditemukan pada daftar resep}
	var {KAMUS LOKAL cariResep}
		stop : boolean;
		i : integer;
	begin {ALGORITMA cariResep}
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
			cariResep := i
		else
			cariResep := -1;
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
	end;

procedure jualResep (resep : string; daftarResep : tabresep; daftarBahanM : TabInventoriM; daftarBahanO : TabInventoriO);
	var {KAMUS LOKAL jualResep}
		i : integer;
		j, count : integer;
	begin {ALGORITMA jualResep}	
		i := cariResep (resep, daftarResep);
		if ( i = -1 ) then
		begin
			writeln ('Nama resep tidak ada di daftar resep !');
		end else {Nama resep ada di daftar resep}
			{Mengecek validitas bahan bahan mentah penyusun resep}
			
			for j:=1 to daftarResep.tab[i].nmentah do
			begin
				
			if (isBahanMentahValid (daftarResep.tab[i].
		end;
	end;
	
end.
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
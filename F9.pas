unit makan;

interface
uses typeuniverse;
procedure makan (var daftarsimulasi: tabSimulasi;  N: integer; var n-makan: integer = 0);

implementation
procedure makan(var daftarsimulasi: tabSimulasi; N: integer; var n-makan : integer = 0); //N menyatakan simulasi yang sedang digunakan

//Pada program utama, inisialisasikan n-makan = 0, setelah simulasi dimulai
//Xmakan juga bernilai 0 pada hari berikutnya (setelah tidur)

begin														
	if (daftarsimulasi.tab[N].energi => 10) or (n-makan >= 3) then
	begin
	writeln('Maaf, Anda tidak dapat makan lagi'); //tidak dapat makan karena energi sudah penuh atau sudah 3 kali makan
	end else 
		begin
			daftarsimulasi.tab[N].energi := daftarsimulasi.tab[N].energi + 3;
			if (daftarsimulasi.tab[N].energi > 10) then 
				daftarsimulasi.tab[N].energi := 10

			n-makan := n-makan + 1;
		end;
end;
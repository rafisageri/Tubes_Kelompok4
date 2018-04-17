unit F9;

interface
uses typeuniverse;
procedure makan (var daftarsimulasi: listSimulasi;  N: integer; var nmakan: integer);

implementation
procedure makan(var daftarsimulasi: listSimulasi; N: integer; var nmakan : integer); //N menyatakan simulasi yang sedang digunakan

//Pada program utama, inisialisasikan n-makan = 0, setelah simulasi dimulai
//Xmakan juga bernilai 0 pada hari berikutnya (setelah tidur)

begin				
	nmakan := 0;
	if (daftarsimulasi.list[N].energi >=10) or (nmakan >=3) then
	begin
	writeln('Maaf, Anda tidak dapat makan lagi'); //tidak dapat makan karena energi sudah penuh atau sudah 3 kali makan
	end else 
		begin
			daftarsimulasi.list[N].energi := daftarsimulasi.list[N].energi + 3;
			if (daftarsimulasi.list[N].energi > 10) then 
				daftarsimulasi.list[N].energi := 10;
			nmakan := nmakan + 1;
		end;
end;
end.

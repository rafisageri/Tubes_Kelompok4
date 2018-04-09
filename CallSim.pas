unit CallSim;

interface
	uses
		basic;
		kitchen;
		chef;
	procedure Call1(s: string; var eoD : boolean; var e: integer);
	
implementation

	
	procedure Call1(s: string;
					var e: integer;
					var eoD:boolean;
					var invMth: tabInventoriM;
					var invOlh: tabInventoriO;
					var inv: integer;
					...);
					
	{I.S. s, e, eoD, invMth, invOlh, inv, ... terdefinisi,
	F.S. panggil prosedur pada unit basic tergantung input s,
	bTidur:= True untuk beberapa prosedur.
	bTidur menunjukkan bahwa prosedur tidur dapat dipakai}
	
	begin
		write('> ');
		readln(s);
		
		if s='stopSimulasi' then //F4
		begin
			stopSimulasi(...);
		end
		else if s='beliBahan' then //F5
		begin
			beliBahan(...);
			bTidur:= True;
		end
		else if s='olahBahan' then //F6
		begin
			olahBahan(...);
			bTidur:= True;
		end
		else if s='jualOlahan' then //F7
		begin
			jualOlahan(...);
			bTidur:= True;
		end
		else if s='jualResep' then //F8
		begin
			jualResep(...);
			bTidur:= True;
		end
		else if s='makan' then //F9
		begin
			makan(nMakan, energi);
			bTidur:= True;
		end
		else if s='istirahat' then //F10
		begin
			istirahat(nIstirahat, energi);
			bTidur:= True;
		end
		else if s='tidur' then //F11
		begin
			tidur(bTidur, energi, eoD, invMth, invOlh);
		end
		else if s='lihatStatistik' then //F12
		begin
			lihatStatistik(...);
			bTidur:= True;
		end
		else if s='lihatInventori' then //F13
		begin
			lihatInventori(...);
		end
		else if s='lihatResep' then //F14
		begin
			stopSimulasi(...);
		end
		else if s='cariResep' then //F15
		begin
			cariResep(...);
		end
		else if s='tambahResep' then //F16
		begin
			tambahResep(...);
		end
		else if s='upgradeInventori' then //F17
		begin
			upgradeInventori(inv);
		end
		else //Input tidak valid. Program utama sudah mencakup loop validasi
		begin
			writeln('command salah');
		end;
	end;
end.

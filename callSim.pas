unit CallSim;

interface
	procedure Call0(s: string; var eoD : boolean; var e: integer);
	procedure Call1(s: string; var eoD : boolean; var e: integer);
	
implementation
	procedure Call0();
	begin
		write('>> ');
		readln(s);
		if s='exit' then //F2
		begin
			eoProg:=True;
		end
		else if s='startSimulasi' then //F3
		begin
			writeln('Simulasi berapa yang ingin dijalankan?');
			readln(simulN);
			writeln('> Start ', simulN);
			writeln('Mulai simulasi ', simulN);
			eoSim:=False;
		end
		else if s='lihatInventori' then //F13
		begin
			writeln('Inventori simulasi berapa yang ingin dilihat?');
			readln(simulN);
			writeln('Membaca Inventori simulasi ', simulN);
			lihatInventori(...);
		end
		else if s='lihatResep' then //F14
		begin
			lihatResep(...);
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
			writeln('Inventori simulasi berapa yang ingin di-upgrade?');
			readln(simulN);
			writeln('Meng-upgrade inventori simulasi ', simulN);
			upgradeInventori(...);
			writeln('Upgrade sukses.');
		end
		else //Input tidak valid. Program utama sudah mencakup loop validasi
		begin
			writeln('command salah');
		end;
	end;

	procedure Call1();
	begin
		write('>> ');
		readln(s);
		
		if s='stopSimulasi' then //F4
		begin
			eoSim:=True;
			writeln('Simulasi dihentikan');
			lihatStatistik(...);
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
			lihatResep(...);
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
unit CallSim;
	{list variabel sementara
	
	int simulN
	boo eoProg eoSim
	listSimulasi DftrSim
	tabResep DftrResep
	}
interface
	procedure Call0();
	procedure Call1();
	
implementation
	procedure Call0();
	begin
		write('>> ');
		readln(s);
		if s='exit' then //F2 //CLEAR
		begin
			eoProg:=True;
		end
		else if s='startSimulasi' then //F3 //CLEAR
		begin
			writeln('Simulasi berapa yang ingin dijalankan?');
			readln(simulN);
			writeln('> Start ', simulN);
			writeln('Mulai simulasi ', simulN);
			eoSim:=False;
		end
		else if s='lihatInventori' then //F13 //CLEAR //simul.pas //....
		begin
			writeln('Inventori simulasi berapa yang ingin dilihat?');
			readln(simulN);
			writeln('Membaca Inventori simulasi ', simulN);
			lihatInventori(simulN, DftrSim);
		end
		else if s='lihatResep' then //F14 //CLEAR //ulisting //... 
		begin
			lihatResep(DftrResep);
		end
		else if s='cariResep' then //F15 //.- //jualResep.pas
		begin
			cariResep(DftrResep);
		end
		else if s='tambahResep' then //F16 //.- //jualResep.pas
		begin
			tambahResep(...);
		end
		else if s='upgradeInventori' then //F17 //CLEAR //.-D
		begin
			writeln('Inventori simulasi berapa yang ingin di-upgrade?');
			readln(simulN);
			writeln('Meng-upgrade inventori simulasi ', simulN);
			upgradeInventori(DftrSim.list[simulN].kapasitas);
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
		
		if s='stopSimulasi' then //F4 //CLEAR //....
		begin
			eoSim:=True;
			writeln('Simulasi dihentikan');
			lihatStatistik(simulN, DftrSim);
		end
		else if s='beliBahan' then //F5bughari
		begin
			beliBahan(...);
			bTidur:= True;
		end
		else if s='olahBahan' then //F6bughari
		begin
			olahBahan(...);
			bTidur:= True;
		end
		else if s='jualOlahan' then //F7 //.- //jualBahanOlahan.pas
		begin
			jualOlahan(...);
			bTidur:= True;
		end
		else if s='jualResep' then //F8 //.- //jualResep.pas
		begin
			jualResep(...);
			bTidur:= True;
		end
		else if s='makan' then //F9 //.---
		begin
			makan(nMakan, energi);
			bTidur:= True;
		end
		else if s='istirahat' then //F10 .---
		begin
			istirahat(nIstirahat, energi);
			bTidur:= True;
		end
		else if s='tidur' then //F11 .---
		begin
			tidur(bTidur, energi, eoD, invMth, invOlh);
		end
		else if s='lihatStatistik' then //F12 ///CLEAR //.... /simul.pas
		begin
			lihatStatistik(simulN, DftrSim);
			bTidur:= True;
		end
		else if s='lihatInventori' then //F13 //CLEAR //simul.pas //....
		begin
			writeln('Inventori simulasi berapa yang ingin dilihat?');
			readln(simulN);
			writeln('Membaca Inventori simulasi ', simulN);
			lihatInventori(simulN, DftrSim);
		end
		else if s='lihatResep' then //F14 //CLEAR //ulisting //... 
		begin
			lihatResep(DftrResep);
		end
		else if s='cariResep' then //F15 //.- //jualResep.pas
		begin
			cariResep(DftrResep);
		end
		else if s='tambahResep' then //F16 //.- //jualResep.pas
		begin
			tambahResep(...);
		end
		else if s='upgradeInventori' then //F17 //CLEAR //.-D
		begin
			writeln('Inventori simulasi berapa yang ingin di-upgrade?');
			readln(simulN);
			writeln('Meng-upgrade inventori simulasi ', simulN);
			upgradeInventori(DftrSim.list[simulN].kapasitas);
		end
		else //Input tidak valid. Program utama sudah mencakup loop validasi
		begin
			writeln('command salah');
		end;
	end;
end.
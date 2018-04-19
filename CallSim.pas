unit CallSim;
	{list variabel sementara
	
	int simN
	boo eoDay eoSim eoProg
	listSimulasi DftrSim
	tabResep DftrResep
	tabMentah DftrMentah
	tabOlahan DftrOlahan
	listInventoriM invMentah
	listInventoriO invOlahan
	
	TglHariIni tanggal
	}
interface
	procedure Call0();
	procedure Call1();
	
implementation
	procedure Call0(var simN	: integer;
					var eoSim	: boolean;
					var eoProg	: boolean;
					var DftrSim : listSimulasi;
					var DftrResep	: tabResep;
					var DftrMentah	: tabMentah;
					var DftrOlahan	: tabOlahan);
	var
		s: string;
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
			readln(simN);
			writeln('> Start ', simN);
			writeln('Mulai simulasi ', simN);
			eoSim:=False;
		end
		else if s='lihatInventori' then //F13
		begin
			writeln('Inventori simulasi berapa yang ingin dilihat?');
			readln(simN);
			writeln('Membaca Inventori simulasi ', simN);
			lihatInventori(simN, DftrSim);
		end
		else if s='lihatResep' then //F14
		begin
			lihatResep(DftrResep);
		end
		else if s='cariResep' then //F15
		begin
			cariResep(DftrResep);
		end
		else if s='tambahResep' then //F16
		begin
			tambahResep(DftrMentah, DftrOlahan; DftrResep);
		end
		else if s='upgradeInventori' then //F17
		begin
			writeln('Inventori simulasi berapa yang ingin di-upgrade?');
			readln(simN);
			writeln('Meng-upgrade inventori simulasi ', simN);
			upgradeInventori(DftrSim.list[simN].kapasitas);
		end
		else //Input tidak valid. Program utama sudah mencakup loop validasi
		begin
			writeln('Command salah');
		end;
	end;

	procedure Call1(var simN	: integer;
					var nMakan	: integer;
					var nIstirahat : integer;
					var eoSim	: boolean;
					var eoDay	: boolean;
					var DftrSim : listSimulasi;
					var DftrResep	: tabResep;
					var DftrMentah	: tabMentah;
					var DftrOlahan	: tabOlahan
					var invMentah	: listInventoriM
					var invOlahan	: listInventoriO
					var TglHariIni	: tanggal);
	var
		E0, uang0: integer;
		s : string;
	begin
		write('>> ');
		readln(s);
		
		if s='stopSimulasi' then //F4
		begin
			eoSim:=True;
			writeln('Simulasi dihentikan');
			lihatStatistik(simN, DftrSim);
		end
		else if s='beliBahan' then //F5
		begin
			E0:=DftrSim.list[simN].energi
			uang0:=DftrSim.list[simN].uang
			
			beliBahan(DftrMentah, invMentah.list[simN], invOlahan.list[simN], DftrSim.list[simN].uang, DftrSim.list[simN].energi, DftrSim.list[simN].kapasitas, TglHariIni);
			
			if E0>DftrSim.list[simN].energi then
				bTidur:= True;
				//boleh tidur
				
			//pengeluaran nambah
			DftrSim.list[simN].pengeluaran := DftrSim.list[simN].pengeluaran + (E0 - DftrSim.list[simN].uang);
		end
		else if s='olahBahan' then //F6
		begin
			E0:=DftrSim.list[simN].energi
		
			olahBahan(DftrOlahan, invMentah.list[simN], invOlahan.list[simN], DftrSim.list[simN].energi, DftrSim.list[simN].kapasitas, TglHariIni);
			
			if E0>DftrSim.list[simN].energi then
				bTidur:= True;
				//boleh tidur
		end
		else if s='jualOlahan' then //F7 //ASSCLEAR
		begin
			E0:=DftrSim.list[simN].energi
			uang0:=DftrSim.list[simN].uang
		
			jualOlahan(invOlahan, DftrSim.list[simN].energi, DftrSim.list[simN].uang, simN);

			if E0>DftrSim.list[simN].energi then
				bTidur:= True;
				//boleh tidur

			//pemasukan nambah
			DftrSim.list[simN].pemasukan := DftrSim.list[simN].pemasukan + (DftrSim.list[simN].uang - E0);
		end
		else if s='jualResep' then //F8 //ASSCLEAR
		begin
			E0:=DftrSim.list[simN].energi
			uang0:=DftrSim.list[simN].uang
		
			jualResep (DftrResep, invMentah.list[simN],invOlahan.list[simN], DftrSim.list[simN].uang, DftrSim.list[simN].energi);
			if E0>DftrSim.list[simN].energi then
				bTidur:= True;
				//boleh tidur

			//pemasukan nambah
			DftrSim.list[simN].pemasukan := DftrSim.list[simN].pemasukan + (DftrSim.list[simN].uang -E0);
		end
		else if s='makan' then //F9
		begin
			E0 := daftarsimulasi.list[N].energi;
			
			makan(DftrSim, simN, nMakan);
			
			if E0<DftrSim.list[simN].energi then
				bTidur:= True;
				//boleh tidur
		end
		else if s='istirahat' then //F10
		begin
			E0 := daftarsimulasi.list[N].energi;
			
			istirahat(nIstirahat, energi);
			
			if E0<DftrSim.list[simN].energi then
				bTidur:= True;
				//boleh tidur
		end
		else if s='tidur' then //F11 //.--- //BUG DELETE
		begin
			//cekdulu bTidur
			if bTidur=true then //boleh tidur
			begin
				tidur(energi, eoDay, invMth, invOlh);
				bTidur:=false;
			end else //bTidur=false
			begin
				writeln('Anda belum dapat tidur, anda harus melakukan kegiatan lain');
			end;
		end
		else if s='lihatStatistik' then //F12
		begin
			lihatStatistik(simN, DftrSim);
			bTidur:= True;
		end
		else if s='lihatInventori' then //F13
		begin
			writeln('Inventori simulasi berapa yang ingin dilihat?');
			readln(simN);
			writeln('Membaca Inventori simulasi ', simN);
			lihatInventori(simN, DftrSim);
		end
		else if s='lihatResep' then //F14
		begin
			lihatResep(DftrResep);
		end
		else if s='cariResep' then //F15
		begin
			cariResep(DftrResep);
		end
		else if s='tambahResep' then //F16
		begin
			tambahResep(DftrMentah, DftrOlahan; DftrResep);
		end
		else if s='upgradeInventori' then //F17
		begin
			writeln('Inventori simulasi berapa yang ingin di-upgrade?');
			readln(simN);
			writeln('Meng-upgrade inventori simulasi ', simN);
			upgradeInventori(DftrSim.list[simN].kapasitas);
		end
		else //Input tidak valid. Program utama sudah mencakup loop validasi
		begin
			writeln('command salah');
		end;
	end;
end.
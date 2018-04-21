program main;
uses
	F1,
	F2,
	F12,
	typeuniverse,
	Penanggalan,
	CallSim;
var
	i, nMakan{jumlah makan dilakukan}, nIstirahat{jumlah istirahat dilakukan}, simN : integer{simulasi yg akan dijalankan};
	bTidur, eoDay, eoSim, eoProg : Boolean;
	
	TglHariIni	: tanggal;
	DftrResep	: tabResep;
	DftrMentah	: tabMentah;
	DftrOlahan	: tabOlahan;
	invMentah	: listInventoriM;
	invOlahan	: listInventoriO;
	DftrSim		: listSimulasi;
	
begin
	writeln('> load');
	//read data simulasi
	LoadFileSimulasi(1, 'simul1.txt', DftrSim);
	LoadFileSimulasi(2, 'simul2.txt', DftrSim);
	LoadFileSimulasi(3, 'simul3.txt', DftrSim);
	LoadFileSimulasi(4, 'simul4.txt', DftrSim);
	LoadFileSimulasi(5, 'simul5.txt', DftrSim);
	LoadFileSimulasi(6, 'simul6.txt', DftrSim);
	LoadFileSimulasi(7, 'simul7.txt', DftrSim);
	LoadFileSimulasi(8, 'simul8.txt', DftrSim);
	LoadFileSimulasi(9, 'simul9.txt', DftrSim);
	LoadFileSimulasi(10, 'simul10.txt', DftrSim);

	//read Inventori Bahan Mentah
	LoadInventoriBahanMentah(1, 'inventoribahanmentah1.txt', invMentah);
	LoadInventoriBahanMentah(2, 'inventoribahanmentah2.txt', invMentah);
	LoadInventoriBahanMentah(3, 'inventoribahanmentah3.txt', invMentah);
	LoadInventoriBahanMentah(4, 'inventoribahanmentah4.txt', invMentah);
	LoadInventoriBahanMentah(5, 'inventoribahanmentah5.txt', invMentah);
	LoadInventoriBahanMentah(6, 'inventoribahanmentah6.txt', invMentah);
	LoadInventoriBahanMentah(7, 'inventoribahanmentah7.txt', invMentah);
	LoadInventoriBahanMentah(8, 'inventoribahanmentah8.txt', invMentah);
	LoadInventoriBahanMentah(9, 'inventoribahanmentah9.txt', invMentah);
	LoadInventoriBahanMentah(10, 'inventoribahanmentah10.txt', invMentah);

	//read Inventori Bahan Olahan
	LoadInventoriBahanOlahan(1, 'inventoribahanolahan1.txt', invOlahan);
	LoadInventoriBahanOlahan(2, 'inventoribahanolahan2.txt', invOlahan);
	LoadInventoriBahanOlahan(3, 'inventoribahanolahan3.txt', invOlahan);
	LoadInventoriBahanOlahan(4, 'inventoribahanolahan4.txt', invOlahan);
	LoadInventoriBahanOlahan(5, 'inventoribahanolahan5.txt', invOlahan);
	LoadInventoriBahanOlahan(6, 'inventoribahanolahan6.txt', invOlahan);
	LoadInventoriBahanOlahan(7, 'inventoribahanolahan7.txt', invOlahan);
	LoadInventoriBahanOlahan(8, 'inventoribahanolahan8.txt', invOlahan);
	LoadInventoriBahanOlahan(9, 'inventoribahanolahan9.txt', invOlahan);
	LoadInventoriBahanOlahan(10, 'inventoribahanolahan10.txt', invOlahan);
	}
	//read Daftar Bahan Mentah di Supermarket
	LoadBahanMentah(DftrMentah);
	
	//read Daftar Bahan Olahan
	LoadBahanOlahan(DftrOlahan);
	
	//read Daftar Resep
	LoadResep(DftrResep, DftrMentah, DftrOlahan);
	
	repeat
		eoSim:=True; //belum tentu simulasi dijalankan
	

		//Uses callSim, preSimulasi action here
		Call0(simN, eoSim, eoProg, DftrSim, DftrResep, DftrMentah,DftrOlahan);
		
		//inisialisasi eoSim := false ada di Call0, startSimulasi
		if not(eoSim) then		//hari sebenernya ada di array
		begin
			TglHariIni:=DftrSim.list[simN].awalsim;
			
			if DftrSim.list[simN].totalhari >10 then
			begin
				writeln('Simulasi sudah melewati 10 hari');
				writeln('Simulasi tidak dapat dilanjutkan');
				lihatStatistik(simN, DftrSim);
				eoSim:=True;
			end
			else if (DftrSim.list[simN].totalhari>=1) and not(eoSim) then
			begin
				for i:=1 to DftrSim.list[simN].totalhari do
				GantiHari(TglHariIni);
			end;
			//if DftrSim.list[simN].totalhari =0, TglHariIni sudah siap pakai
		end;
		
		
		//dalam suatu simulasi
		while not(eoSim) and not(eoProg) do
		begin
			//awal hari, inisialisasi
			eoDay:= false;
			nIstirahat :=0;
			nMakan :=0;
			bTidur := false;
			
			//dalam suatu hari
			repeat 
				if DftrSim.list[simN].energi=0 then
				begin
					writeln('Energi habis, anda hanya dapat tidur');
					writeln('> Tidur');
					//tidur(bTidur, energi, eoDay, invMentah, invOlahan);
				end	
				else //energi <>0
				begin
					//Call1(simN, nMakan, nIstirahat, eoSim, eoDay, DftrSim, DftrResep, DftrMentah, DftrOlahan, invMentah, invOlahan,	TglHariIni	: tanggal); 
					//uses callSim, main action
				end;
			until eoDay or eoSim;
			
			if not(eoSim) then
			begin
				DftrSim.list[simN].totalhari:= DftrSim.list[simN].totalhari+1;
				GantiHari(TglHariIni);
			end;
			
		end; //eoSim
		
		//save disini, sekaligus implementasi F2-exit (save data)
		//walaupun simulasi tidak berjalan, data mungkin berubah
		
		//save data simulasi
		SaveFileSimulasi(1, 'simul1.txt', DftrSim);
		SaveFileSimulasi(2, 'simul2.txt', DftrSim);
		SaveFileSimulasi(3, 'simul3.txt', DftrSim);
		SaveFileSimulasi(4, 'simul4.txt', DftrSim);
		SaveFileSimulasi(5, 'simul5.txt', DftrSim);
		SaveFileSimulasi(6, 'simul6.txt', DftrSim);
		SaveFileSimulasi(7, 'simul7.txt', DftrSim);
		SaveFileSimulasi(8, 'simul8.txt', DftrSim);
		SaveFileSimulasi(9, 'simul9.txt', DftrSim);
		SaveFileSimulasi(10, 'simul10.txt', DftrSim);
		
		//save Inventori Bahan Mentah
		SaveInventoriMentah(1, 'inventoribahanmentah1.txt', invMentah);
		SaveInventoriMentah(2, 'inventoribahanmentah2.txt', invMentah);
		SaveInventoriMentah(3, 'inventoribahanmentah3.txt', invMentah);
		SaveInventoriMentah(4, 'inventoribahanmentah4.txt', invMentah);
		SaveInventoriMentah(5, 'inventoribahanmentah5.txt', invMentah);
		SaveInventoriMentah(6, 'inventoribahanmentah6.txt', invMentah);
		SaveInventoriMentah(7, 'inventoribahanmentah7.txt', invMentah);
		SaveInventoriMentah(8, 'inventoribahanmentah8.txt', invMentah);
		SaveInventoriMentah(9, 'inventoribahanmentah9.txt', invMentah);
		SaveInventoriMentah(10, 'inventoribahanmentah10.txt', invMentah);

		//save Inventori Bahan Olahan
		SaveInventoriOlahan(1, 'inventoribahanolahan1.txt', invOlahan);
		SaveInventoriOlahan(2, 'inventoribahanolahan2.txt', invOlahan);
		SaveInventoriOlahan(3, 'inventoribahanolahan3.txt', invOlahan);
		SaveInventoriOlahan(4, 'inventoribahanolahan4.txt', invOlahan);
		SaveInventoriOlahan(5, 'inventoribahanolahan5.txt', invOlahan);
		SaveInventoriOlahan(6, 'inventoribahanolahan6.txt', invOlahan);
		SaveInventoriOlahan(7, 'inventoribahanolahan7.txt', invOlahan);
		SaveInventoriOlahan(8, 'inventoribahanolahan8.txt', invOlahan);
		SaveInventoriOlahan(9, 'inventoribahanolahan9.txt', invOlahan);
		SaveInventoriOlahan(10, 'inventoribahanolahan10.txt', invOlahan);
		
		//save Daftar Bahan Olahan
		SaveBahanOlahan(DftrOlahan);
		//p.s.: is this really necessary?
		
		//save Daftar Resep
		SaveResep(DftrResep, DftrMentah, DftrOlahan);}
	until eoProg = True;
	
  
	//terminasi

end.

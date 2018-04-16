program main;
uses
	typeuniverse;
	CallSim;
var
	energi, hari, nMakan{jumlah kesempatan makan}, nIstirahat{jumlah kesempatan Istirahat}, nTidur {jumlah kesempatan tidur}, simN : integer{simulasi yg akan dijalankan};
	eoDay, eoSim, eoProg : Boolean;
	
	TglHariIni	: tanggal;
	DftrResep	: tabResep;
	DftrMentah	: tabMentah;
	DftrOlahan	: tabOlahan;
	invMentah	: listInventoriM;
	invOlahan	: listInventoriO;
	DftrSim		: listSimulasi;
	
begin
	writeln('> load');
	//read file ke array here
	pArrToSim(1, 'simul1.txt', DftrSim;
	pArrToSim(2, 'simul2.txt', DftrSim;
	pArrToSim(3, 'simul3.txt', DftrSim;
	pArrToSim(4, 'simul4.txt', DftrSim;
	pArrToSim(5, 'simul5.txt', DftrSim;
	pArrToSim(6, 'simul6.txt', DftrSim;
	pArrToSim(7, 'simul7.txt', DftrSim;
	pArrToSim(8, 'simul8.txt', DftrSim;
	pArrToSim(9, 'simul9.txt', DftrSim;
	pArrToSim(10, 'simul10.txt', DftrSim;
	

	
	repeat
		hari := 999 //inisialisasi sebelum assign nilai faktual dari array
		eoSim:=True; //belum tentu simulasi dijalankan
	
		//Call0 here
		//Uses callSim, preSimulasi action here
		Call0();
		
		//validasi hari
		//inisialisasi eoSim := false ada di Call0, startSimulasi
		if hari>=10 and not(eoSim) then		//hari sebenernya ada di array
		begin
			writeln('Simulasi sudah melewati 10 hari');
			writeln('Simulasi tidak dapat dilanjutkan');
			lihatStatistik(simN, DftrSim);
			eoSim:=True;
		end;
		
		//dalam suatu simulasi
		while not(eoSim) and not(eoProg) do
		begin
			eoDay:= false;
			nIstirahat :=6;
			nMakan :=3;
			bTidur := false;
			
			//dalam suatu hari
			repeat 
				if energi=0 then
				begin
					writeln('Energi habis, anda hanya dapat tidur');
					writeln('> Tidur');
					tidur(bTidur, energi, eoDay, invMentah, invOlahan);
				end	
				else //energi <>0
				begin
					Call1(); //uses callSim, main action
				end;
			until eoDay or eoSim;
			
			if not(eoSim) then
			begin
				hari:= hari+1; 
			end;
			
		end; //eoSim
		
		//save disini, sekaligus implementasi F2-exit (save data)
		//walaupun simulasi tidak berjalan, data mungkin berubah
		pArrToSim(1, 'simul1.txt', DftrSim;
		pArrToSim(2, 'simul2.txt', DftrSim;
		pArrToSim(3, 'simul3.txt', DftrSim;
		pArrToSim(4, 'simul4.txt', DftrSim;
		pArrToSim(5, 'simul5.txt', DftrSim;
		pArrToSim(6, 'simul6.txt', DftrSim;
		pArrToSim(7, 'simul7.txt', DftrSim;
		pArrToSim(8, 'simul8.txt', DftrSim;
		pArrToSim(9, 'simul9.txt', DftrSim;
		pArrToSim(10, 'simul10.txt', DftrSim;
	
		
	
	until eoprog = True;
	
  
	//terminasi

end.
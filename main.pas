program main;
uses
	typeuniverse;
	CallSim;
var
	NRG, hari, nMakan, nIstirahat, nTidur, simulN : integer;
	komando1 : string;
	eoDay,eoProg : Boolean;
	invMentah : tabInventoriM;
	invOlahan : tabInventoriO;
	DftrSim: listSimulasi;
	
begin
	//read file ke array here
	pSimToArr(1, simul1.txt, DftrSim);
	pSimToArr(2, simul2.txt, DftrSim);
	pSimToArr(3, simul3.txt, DftrSim);
	pSimToArr(4, simul4.txt, DftrSim);
	pSimToArr(5, simul5.txt, DftrSim);
	pSimToArr(6, simul6.txt, DftrSim);
	pSimToArr(7, simul7.txt, DftrSim);
	pSimToArr(8, simul8.txt, DftrSim);
	pSimToArr(9, simul9.txt, DftrSim);
	pSimToArr(10, simul10.txt, DftrSim);
	
	
	repeat
	//dalam suatu simulasi
	
		//Call0 here
		//Uses callSim, preSimulasi action here
		
		while hari<10 and not(eoprog) do
		//dalam suatu hari
		begin
			eoDay:= false;
			nIstirahat :=6;
			nMakan :=3;
			bTidur := false;
			
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
			until eoDay or eoProg;
			
			if not(eoProg) then
			begin
				hari:= hari+1; 
			end;
			
		end;
		
	until eoprog = True;
	
  
	//terminasi

end.

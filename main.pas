program main;
uses
	typeuniverse;
	CallSim;
var
	energi, hari, nMakan, nIstirahat, nTidur : integer;
	komando1 : string;
	eoDay,eoProg : Boolean;
	invMentah : tabInventoriM;
	invOlahan : tabInventoriO;
	
begin
	//read file ke array here
	//read file ke energi dan hari here
	
	
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

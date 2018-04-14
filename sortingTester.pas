program cobalagi;

uses typeuniverse, sysutils;

procedure urutString (var s1, s2 : string); 
	{I.S string s1 dan s2 terdefinisi dan tidak kosong, bisa sudah terurut atau belum terurut. Contoh : s1='bulan', s2='anak'
	 F.S s1 dan s2 terurut berdasarkan abjad. Contoh : s1 = 'anak', s2 = 'bulan'}
	var {KAMUS LOKAL urutString}
		temp1, temp2, temp : string;
		i, lmin : integer;
		stop : boolean;
	{ALGORITMA urutString}
	begin
		temp1 := UpperCase (s1);
		temp2 := UpperCase (s2);
		i := 1;
		stop := False;
		
		if length(s1) < length(s2) then
		begin
			lmin := length(s1);
		end
		else //if length(s1) >= length(s2) then
		begin
			lmin := length(s2);
		end;
		
		
		//cek kasus s2 = s1 + '<...>'
		if (copy(s1, 1, lmin) = copy(s2, 1, lmin)) and (length(s1)>lmin) then
		//ex: s1= satuuuuuu, s2= satu, prefered s1= satu, s2= satuuuuuu
		begin
			temp := s1;
			s1 :=s2;
			s2 :=temp;
		end
		//(copy(s1, 1, lmin) = copy(s2, 1, lmin)) and length(s2)>lmin sudah prefered
		else if (copy(s1, 1, lmin) <> copy(s2, 1, lmin)) then
		begin
			repeat {Skema standar iterate-stop}
				if (ord(temp1[i]) < ord(temp2[i])) then {Ord () mengembalikan integer yang ekivalen dengan ordinal dari suatu char. Ordnya lebih kecil berarti char tersebut ada di urutan lebih dulu di alfabet}
				begin
					writeln('3a');
					stop := True;
				end else if (ord(temp1[i]) = ord(temp2[i])) then
				begin
					i := i + 1;
				end else {(ord(temp1[i]) > ord(temp2[i]) }
				begin 
					temp := s1; {Tukar s1 dengan s2}
					s1 := s2; 
					s2 := temp;
					stop := True;
				end;
			until ((stop) or (i>=length(s1)) or (i>=length(s2)));
		end;
	end;

var
	s1,s2 : string;
	
begin
	readln (s1);
	writeln ('1');
	readln (s2);
	writeln('2');
	urutString (s1,s2);
	writeln ('3');
	writeln (s1);
	writeln (s2);
end.
unit F17;

interface
	uses typeuniverse;
	function upgradeInventori (imax : integer) : integer;
	
implementation
	
	function upgradeInventori (imax : integer) : integer;
	begin
		upgradeInventori := imax + 25;
	end;
end.

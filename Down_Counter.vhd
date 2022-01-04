-- Down Counter
library ieee;
use ieee.std_logic_1164.all;

entity Down_Counter is
port( CLK: in std_logic;
	  RST: in std_logic;
	  En: in std_logic;
	  Complete: out std_logic );
end Down_Counter;

architecture Counter_Behavior of Down_Counter is
begin
	process
	variable Count_temp: integer := 8;  --initial counter to 8 CLK
	begin
		wait until (rising_edge(CLK)); 
		if (RST='1') then
			Count_temp := 8;  --reset counter to 8 CLK
		elsif (RST='0' and En='1') then
			Count_temp := Count_temp -1 ;  -- count down
			Complete <= '0';
			if (Count_temp = 0) then
				Complete <= '1';
			end if;
		end if;	
	end process;
end Counter_Behavior;


-- Traffic_Light_FSM
library ieee;
use ieee.std_logic_1164.all;

entity Traffic_Light_FSM is
port( CLK: in std_logic;
	  Sensor: in std_logic;
	  Complete: in std_logic;
	  RST, En: out std_logic;
	  r_light: out std_logic;
	  g_light: out std_logic;
	  y_light: out std_logic );
end Traffic_Light_FSM;

architecture Traffic_Light_FSM_Behavior of Traffic_Light_FSM is
type FSM_States is (Green, Yellow_1, Red, Yellow_2);  --FSM state declare in order 
signal Current_State, Next_State: FSM_States;
begin  --FSM Two behavior
	process  -- Rising_edge_trigger
	begin
		wait until (rising_edge(CLK));
		Current_State <= Next_State;
	end process;
	
	process(Current_State, Sensor)  -- FSM Cycle 
	begin
		case Current_State is 
			when Green => 
				r_light <= '0';
				g_light <= '1';
				y_light <= '0';
				RST <= '1';
				En <= '0';
				if (Sensor = '1') then 
					Next_State <= Yellow_1;
				else 
					Next_State <= Green;
				end if;
				
			when Yellow_1 => 
				r_light <= '0';
				g_light <= '0';
				y_light <= '1';
				RST <= '0';
				En <= '0';
				Next_State <= Red;
			
			when Red => 
				r_light <= '1';
				g_light <= '0';
				y_light <= '0';
				RST <= '0';
				En <= '1';
				if (Complete = '1') then 
					Next_State <= Yellow_2;
				else 
					Next_State <= Red;
				end if;
				
			when Yellow_2 => 
				r_light <= '0';
				g_light <= '0';
				y_light <= '1';
				RST <= '0';
				En <= '0';
				Next_State <= Green;
		end case;
	end process;
end Traffic_Light_FSM_Behavior;


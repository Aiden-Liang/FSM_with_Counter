--FSM with Counter
library ieee;
use ieee.std_logic_1164.all;
use ieee.NUMERIC_BIT.all;
library Down_Counter;
use Down_Counter.all;
library Traffic_Light_FSM;
use Traffic_Light_FSM.all;

entity FSM_with_Counter is
port( CLK, Sensor: in std_logic;
	  Red_Light: out std_logic;
	  Green_Light: out std_logic;
	  Yellow_Light: out std_logic );
end FSM_with_Counter;
	  
architecture Structural_Model of FSM_with_Counter is
signal rst, en, complete: std_logic;
component Down_Counter
port( CLK: in std_logic;
	  RST: in std_logic;
	  En: in std_logic;
	  Complete: out std_logic );
end component;

component Traffic_Light_FSM
port( CLK: in std_logic;
	  Sensor: in std_logic;
	  Complete: in std_logic;
	  RST, En: out std_logic;
	  r_light: out std_logic;
	  g_light: out std_logic;
	  y_light: out std_logic );
end component;

begin

Counter: Down_Counter port map( CLK=>CLK, RST=>rst, En=>en, Complete=>complete );
FSM_Controller: Traffic_Light_FSM port map( CLK=>CLK, Sensor=>Sensor, Complete=>complete, RST=>rst, En=>en, r_light=>Red_Light, g_light=>Green_Light, y_light=>Yellow_Light );

end Structural_Model;


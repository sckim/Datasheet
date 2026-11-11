library IEEE;
use IEEE.std_logic_1164.all;

entity Ch15Ex1En is
	port (
		x: in STD_LOGIC;
		y: in STD_LOGIC;
		z: out STD_LOGIC
		);
end Ch15Ex1En;

architecture Ch15Ex1Arch of Ch15Ex1En is
begin
	z <= x xor y;
end Ch15Ex1Arch;

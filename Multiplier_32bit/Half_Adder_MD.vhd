library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Half_Adder_Ent is 
            port (
                 a : in std_logic;
                 b : in std_logic;
                 sum : out std_logic;
                 carry : out std_logic               
                  );
end entity;

architecture Half_Adder_Arch of Half_Adder_Ent is 
begin
  
  sum <= a xor b;
  carry <= a and b;
  
end architecture;
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Full_Adder_Ent is 
            port (
                 a : in std_logic;
                 b : in std_logic;
                 c : in std_logic;
                 sum : out std_logic;
                 carry : out std_logic               
                  );
end entity;

architecture Full_Adder_Arch of Full_Adder_Ent is 
begin
  
  sum <= (a xor b) xor c;
  carry <= (a and b) or (a and c) or (b and c) ;
  
end architecture;
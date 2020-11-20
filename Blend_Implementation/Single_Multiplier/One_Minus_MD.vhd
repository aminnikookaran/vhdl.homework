library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity One_Minus_MD_Ent is
  port (
    a : in std_logic_vector(8 downto 0);
    y : out std_logic_vector(8 downto 0)
  );
end entity;

architecture One_Minus_MD_Arch of One_Minus_MD_Ent is  
  begin
    
    y <= ('1' & X"00") when a = ('0' & X"00") else
         ('0' & X"00") when a(8) = '1' else (1 - a);
    
end architecture;
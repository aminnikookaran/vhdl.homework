library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Saturating_Adder_MD_Ent is
  port (
    a : in std_logic_vector(7 downto 0);
    b : in std_logic_vector(7 downto 0);
    y : out std_logic_vector(7 downto 0)
  );
end entity;

architecture Saturating_Adder_MD_Arch of Saturating_Adder_MD_Ent is
  
  signal sum : std_logic_vector(8 downto 0);
  
  begin
    
    sum <= ('0' & a) + ('0' & b);
    y <= X"FF" when sum(8) = '1' else sum(7 downto 0);
    
end architecture;
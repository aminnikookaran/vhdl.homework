library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Blend_Multiplier_MD_Ent is
  port (
    c : in std_logic_vector(7 downto 0);
    f : in std_logic_vector(8 downto 0);
    y : out std_logic_vector(7 downto 0)
  );
end entity;

architecture Blend_Multiplier_MD_Arch of Blend_Multiplier_MD_Ent is
  
  signal m : std_logic_vector(15 downto 0);
  
  begin
    
    y <= c when f(8) = '1' else m(15 downto 8);
    m <= c * f(7 downto 0);
    
end architecture;
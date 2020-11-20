library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Pipelined_Blend_Multiplier_MD_Ent is
  port (
    clk : in std_logic;
    c : in std_logic_vector(7 downto 0);
    f : in std_logic_vector(8 downto 0);
    y : out std_logic_vector(7 downto 0)
  );
end entity;

architecture Pipelined_Blend_Multiplier_MD_Arch of Pipelined_Blend_Multiplier_MD_Ent is
  
  signal m : std_logic_vector(15 downto 0);
  signal mc : std_logic_vector(7 downto 0);
  signal cq : std_logic_vector(7 downto 0);
  signal f8q : std_logic;
  
  begin
    
    y <= cq when f8q = '1' else mc;
    m <= c * f(7 downto 0);
    
    process (clk)
      begin
        if rising_edge (clk) then
          mc <= m(15 downto 8);
          cq <= c;
          f8q <= f(8);
        end if;
    end process;
    
end architecture;
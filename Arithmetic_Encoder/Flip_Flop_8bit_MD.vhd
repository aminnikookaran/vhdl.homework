library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Flip_Flop_8bit_MD_Ent is 
  port (
    iclk : in std_logic;
    idata : in std_logic_vector(7 downto 0);
    odata : out std_logic_vector(7 downto 0)
  );
end entity;

architecture Flip_Flop_8bit_MD_Arch of Flip_Flop_8bit_MD_Ent is
  begin
    
    process (iclk)
      begin
        if rising_edge(iclk) then
          odata <= idata;
        end if;
    end process;

end architecture;
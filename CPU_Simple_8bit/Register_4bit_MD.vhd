library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Register_4bit_MD_Ent is 
  port (
    iclk : in std_logic;
    irst : in std_logic;
    ice : in std_logic;
    idata : in std_logic_vector(3 downto 0);
    odata : out std_logic_vector(3 downto 0)
  );
end entity;

architecture Register_4bit_MD_Arch of Register_4bit_MD_Ent is
  begin
    
    process (iclk)
      begin
        if rising_edge(iclk) then
          if (irst = '1') then
            odata <= X"0";
          elsif (ice = '1')  then
            odata <= idata;
          end if;
        end if;
    end process;

end architecture;
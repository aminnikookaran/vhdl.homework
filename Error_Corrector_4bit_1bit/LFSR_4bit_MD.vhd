library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity LFSR_4bit_Ent is 
  port (
    iclk : in std_logic;
    odata : out std_logic_vector(3 downto 0)
  );
end entity;

architecture LFSR_4bit_Arch of LFSR_4bit_Ent is
  
  signal b : std_logic_vector(3 downto 0);
  
  begin
    
    process (iclk)
      begin
        if rising_edge(iclk) then
          if ((b > 0) or (b < 16)) then
          	 b(0) <= b(1);
          	 b(1) <= b(2);
          	 b(2) <= b(3);
          	 b(3) <= b(0) xor b(1);
          else
            b <= "0001";
          end if;
        end if;
    end process;
    
    odata <= b;
    
end architecture;
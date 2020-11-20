library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Parallel_to_Serial_Port_DP_Ent is 
  port (
    iclk : in std_logic;
    idata : in std_logic_vector(7 downto 0);
    il : in std_logic;
    odata : out std_logic
  );
end entity;

architecture Parallel_to_Serial_Port_DP_Arch of Parallel_to_Serial_Port_DP_Ent is
  
  signal reg : std_logic_vector(10 downto 0);

  begin
    
    odata <= reg(0);

    process (iclk)
      begin
        if rising_edge(iclk) then
          if (il = '1') then
            reg <= "11" & idata & '0';
          else
            reg <= '1' & reg(10 downto 1);
          end if;
        end if;
    end process;
            
end architecture;
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Serial_to_Parallel_Port_DP_Ent is 
  port (
    iclk : in std_logic;
    idata : in std_logic;
    ocbs : out std_logic_vector(2 downto 0);
    odata : out std_logic_vector(7 downto 0)
  );
end entity;

architecture Serial_to_Parallel_Port_DP_Arch of Serial_to_Parallel_Port_DP_Ent is
  
  signal reg : std_logic_vector(10 downto 0) ;

  begin
    
    ocbs <= reg(10 downto 9) & reg(0);
    odata <= reg(8 downto 1);
    
    process (iclk)
      begin
        if rising_edge(iclk) then
          reg(10) <= idata;
          reg(9 downto 0) <= reg(10 downto 1);
        end if;
    end process;
                
end architecture;
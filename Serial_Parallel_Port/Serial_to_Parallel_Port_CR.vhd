library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Serial_to_Parallel_Port_CR_Ent is 
  port (
    iclk : in std_logic;
    icbs : in std_logic_vector(2 downto 0);
    odv : out std_logic
  );
end entity;

architecture Serial_to_Parallel_Port_CR_Arch of Serial_to_Parallel_Port_CR_Ent is
  
  signal count : std_logic_vector(3 downto 0);
  
  begin
    
    odv <= '1' when (icbs = "110" and count = X"0") else '0';
        
    process (iclk)
      begin
        if rising_edge(iclk) then
          if (icbs = "110" and count = X"0") then
            count <= count + 1;
          elsif (count > X"0" and count < X"A") then
            count <= count + 1;
          else
            count <= X"0";
          end if;
        end if;
    end process;
            
end architecture;
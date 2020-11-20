library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Parallel_to_Serial_Port_CR_Ent is 
  port (
    iclk : in std_logic;
    idr : in std_logic;
    ol : out std_logic
  );
end entity;

architecture Parallel_to_Serial_Port_CR_Arch of Parallel_to_Serial_Port_CR_Ent is
  
  signal count : std_logic_vector(3 downto 0);
  
  begin
    
    ol <= '1' when (count = X"0" and idr = '1') else '0';

    process (iclk)
      begin
        if rising_edge(iclk) then
          if (count = X"0" and idr = '1') or (count > X"0" and count < X"A") then
            count <= count + 1;
          else
            count <= X"0";
          end if;
        end if;
    end process;
    
end architecture;
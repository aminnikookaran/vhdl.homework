library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Counter_11bit_Ent is 
  port (
    ien : in std_logic;
    irs : in std_logic;
    iclk : in std_logic;
    odata : out std_logic_vector(10 downto 0)
  );
end entity;

architecture Counter_11bit_Arch of Counter_11bit_Ent is
  
  signal t : std_logic_vector(10 downto 0) := std_logic_vector(to_unsigned(0,11));
  begin
  
  process (iclk,irs)
    begin
      if (irs = '1') then
 	    		t <= (others => '0');
     	elsif rising_edge(iclk) then
 	    		if (ien = '1') then
   			    t <= t + 1;
   		   end if;
   	  end if;
  end process;
  
  odata <= t;
  
end architecture;
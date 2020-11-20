library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity T_Flip_Flop_Ent is 
  port (
    iclk : in std_logic;
    ien : in std_logic;
    it : in std_logic;
    oq : out std_logic;
    oqnot : out std_logic
  );
end entity;

architecture T_Flip_Flop_Arch of T_Flip_Flop_Ent is
  begin
    process(iclk)
      variable data : std_logic;
      begin
        if rising_edge(iclk) then
          if ((it = '1') and (ien = '1')) then
            data := not data;
          end if;
        end if;
        oq <= data;
        oqnot <= not data;
    end process;
    
end architecture;
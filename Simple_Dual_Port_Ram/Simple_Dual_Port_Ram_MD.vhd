library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Simple_Dual_Port_Ram_1024x8bit_Ent is 
  port (
    iwA : in std_logic;
    iadrA : in std_logic_vector(9 downto 0);
    iclkA : in std_logic;
    idataA : in std_logic_vector(7 downto 0);
    
    irB : in std_logic;
    iadrB : in std_logic_vector(9 downto 0);
    iclkB : in std_logic;
    odataB : out std_logic_vector(7 downto 0)
  );
end entity;

architecture Simple_Dual_Port_Ram_1024x8bit_Arch of Simple_Dual_Port_Ram_1024x8bit_Ent is
  type Mem is array(0 to 1023) of std_logic_vector(7 downto 0);
  signal ram : mem;
  begin
    
    --write
    process(iclkA)
      begin
        if rising_edge(iclkA) then
          if (iwA = '1') then
            ram(conv_integer(iadrA)) <= idataA;
          end if;
        end if;
    end process;
  
    --read
    process(iclkB)
      begin
        if rising_edge(iclkB) then
          if (irB = '1') then
            odataB <= ram(conv_integer(iadrB));
          end if;
        end if;
    end process;

end architecture;
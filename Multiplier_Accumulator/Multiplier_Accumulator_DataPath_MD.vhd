library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Multiplier_Accumulator_DataPath_Ent is 
  port (
    iclk : in std_logic;
    irst : in std_logic;
    ice : in std_logic;
    imc : in std_logic_vector(1 downto 0);
    idataA : in std_logic_vector(7 downto 0);
    idataB : in std_logic_vector(7 downto 0);
    odata : out std_logic_vector(31 downto 0)
  );
end entity;

architecture Multiplier_Accumulator_DataPath_Arch of Multiplier_Accumulator_DataPath_Ent is
  
  signal multiply : std_logic_vector(15 downto 0) := X"0000";
  signal add : std_logic_vector(31 downto 0) := X"00000000";
  signal reg8 : std_logic_vector(7 downto 0) := X"00";
  signal reg32 : std_logic_vector(31 downto 0) := X"00000000";
  
  begin
    
    with imc select
      multiply <= (X"00" & idataA) when "01"|"11",
      			  (X"00" & reg8) when "10",
      			  (reg8 * idataA) when others;
    add <= multiply + reg32;
    
    process (iclk,irst)
      begin
        if (irst = '0') then
            reg8 <= X"00";
            reg32 <= X"00000000";
        elsif rising_edge(iclk) then
          if (ice = '1') then
            reg8 <= idataB;
            reg32 <= add;
          end if;
        end if;
    end process;
    
    odata <= reg32;

end architecture;
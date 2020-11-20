library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Serial_to_Parallel_Port_TB_Ent is
end entity ;

architecture Serial_to_Parallel_Port_TB_Arch of Serial_to_Parallel_Port_TB_Ent is

component Serial_to_Parallel_Port_TL_Ent is
  port(
    iclk : in std_logic;
    idata : in std_logic;
    odv : out std_logic;
    odata : out std_logic_vector(7 downto 0)
  );
end component ;

  signal iclk : std_logic := '0';
  signal idata : std_logic := '0';
  signal odv : std_logic;
  signal odata : std_logic_vector(7 downto 0);
  
begin
  
  S2P_TL : Serial_to_Parallel_Port_TL_Ent port map (
    iclk => iclk,
    idata => idata,
    odv => odv,
    odata => odata
  );
  
  iclk <= not iclk after 500 ns;
  idata <= '0',
           '1' after 155 us,
           '0' after 259 us,
           '0' after 363 us,
           '1' after 467 us,
           '0' after 571 us,
           '1' after 675 us,
           '0' after 779 us,
           '1' after 883 us;

end architecture ;
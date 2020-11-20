library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Parallel_to_Serial_Port_TB_Ent is
end entity ;

architecture Parallel_to_Serial_Port_TB_Arch of Parallel_to_Serial_Port_TB_Ent is

component Parallel_to_Serial_Port_TL_Ent is
  port(
    iclk : in std_logic;
    idata : in std_logic_vector(7 downto 0);
    idr : in std_logic;
    odata : out std_logic
  );
end component ;

  signal iclk : std_logic := '0';
  signal idata : std_logic_vector(7 downto 0) := X"00";
  signal idr : std_logic := '0';
  signal odata : std_logic;
  
begin
  
  P2S_TL : Parallel_to_Serial_Port_TL_Ent port map (
    iclk => iclk,
    idata => idata,
    idr => idr,
    odata => odata
  );
  
  iclk <= not iclk after 500 ns;
  idr <= '1' after 200 us;
  idata <= X"AA",
           X"55" after 210 us,
           X"15" after 314 us;

end architecture ;
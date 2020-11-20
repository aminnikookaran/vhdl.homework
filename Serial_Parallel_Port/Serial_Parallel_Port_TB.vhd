library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Serial_Parallel_Port_TB_Ent is
end entity ;

architecture Serial_Parallel_Port_TB_Arch of Serial_Parallel_Port_TB_Ent is

component Serial_to_Parallel_Port_TL_Ent is
  port(
    iclk : in std_logic;
    idata : in std_logic;
    odv : out std_logic;
    odata : out std_logic_vector(7 downto 0)
  );
end component ;

component Parallel_to_Serial_Port_TL_Ent is
  port(
    iclk : in std_logic;
    idata : in std_logic_vector(7 downto 0);
    idr : in std_logic;
    odata : out std_logic
  );
end component ;

  signal iclk : std_logic := '0';
  signal sdata : std_logic;

  signal ipdata : std_logic_vector(7 downto 0) := X"00";
  signal idr : std_logic := '0';
  
  signal odv : std_logic;
  signal opdata : std_logic_vector(7 downto 0);
  
begin
  
  S2P_TL : Serial_to_Parallel_Port_TL_Ent port map (
    iclk => iclk,
    idata => sdata,
    odv => odv,
    odata => opdata
  );

  P2S_TL : Parallel_to_Serial_Port_TL_Ent port map (
    iclk => iclk,
    idata => ipdata,
    idr => idr,
    odata => sdata
  );
    
  iclk <= not iclk after 500 ns;
  idr <= '1' after 20 us;
  ipdata <= X"AA" after 20 us,
            X"55" after 210 us,
            X"15" after 314 us;

end architecture ;
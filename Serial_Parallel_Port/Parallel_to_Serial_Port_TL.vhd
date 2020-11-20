library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Parallel_to_Serial_Port_TL_Ent is 
  port (
    iclk : in std_logic;
    idata : in std_logic_vector(7 downto 0);
    idr : in std_logic;
    odata : out std_logic
  );
end entity;

architecture Parallel_to_Serial_Port_TL_Arch of Parallel_to_Serial_Port_TL_Ent is
  
component Parallel_to_Serial_Port_DP_Ent is
  port (
    iclk : in std_logic;
    idata : in std_logic_vector(7 downto 0);
    il : in std_logic;
    odata : out std_logic
  );
end component ;

component Parallel_to_Serial_Port_CR_Ent is
  port(
    iclk : in std_logic;
    idr : in std_logic;
    ol : out std_logic
  );
end component ;

  signal load : std_logic;
  signal clk : std_logic;
  signal count : std_logic_vector(6 downto 0) := "0000000";

  begin
    
  P2S_DP : Parallel_to_Serial_Port_DP_Ent port map (
    iclk => clk,
    idata => idata,
    il => load,
    odata => odata
  );
  
  P2S_CR : Parallel_to_Serial_Port_CR_Ent port map (
    iclk => clk,
    idr => idr,
    ol => load
  );
  
  clk <= '1' when count > 50 else '0';
  
  process (iclk)
    begin
      if (rising_edge(iclk)) then
        if (count < 103) then
          count <= count + 1;
        else
          count <= "0000000";
        end if;
      end if;
  end process;

end architecture;
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Serial_to_Parallel_Port_TL_Ent is 
  port (
    iclk : in std_logic;
    idata : in std_logic;
    odv : out std_logic;
    odata : out std_logic_vector(7 downto 0)
  );
end entity;

architecture Serial_to_Parallel_Port_TL_Arch of Serial_to_Parallel_Port_TL_Ent is
  
component Serial_to_Parallel_Port_DP_Ent is
  port (
    iclk : in std_logic;
    idata : in std_logic;
    ocbs : out std_logic_vector(2 downto 0);
    odata : out std_logic_vector(7 downto 0)
  );
end component ;

component Serial_to_Parallel_Port_CR_Ent is
  port(
    iclk : in std_logic;
    icbs : in std_logic_vector(2 downto 0);
    odv : out std_logic
  );
end component ;

  signal clk : std_logic;
  signal count : std_logic_vector(6 downto 0);
  signal cbs : std_logic_vector(2 downto 0);

  begin
    
  S2P_DP : Serial_to_Parallel_Port_DP_Ent port map (
    iclk => clk,
    idata => idata,
    ocbs => cbs,
    odata => odata
  );
  
  S2P_CR : Serial_to_Parallel_Port_CR_Ent port map (
    iclk => clk,
    icbs => cbs,
    odv => odv
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
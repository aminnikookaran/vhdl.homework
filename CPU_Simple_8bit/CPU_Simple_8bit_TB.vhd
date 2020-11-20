library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity CPU_Simple_8bit_TB_Ent is
end entity ;

architecture CPU_Simple_8bit_TB_Arch of CPU_Simple_8bit_TB_Ent is

  component CPU_Simple_8bit_TL_Ent is
    port(
      iclk : in std_logic;
      irst : in std_logic;
      iswch : in std_logic_vector(3 downto 0);
      o7seg : out std_logic_vector(3 downto 0)
    );
  end component ;

  signal iclk : std_logic := '1';
  signal irst : std_logic;
  signal iswch : std_logic_vector(3 downto 0);
  signal o7seg : std_logic_vector(3 downto 0);

begin
  
  CPU_TL : CPU_Simple_8bit_TL_Ent port map (
    iclk => iclk,
    irst => irst,
    iswch => iswch,
    o7seg => o7seg
  );
    
  iclk <= not iclk after 1 ns;
  irst <= '1', '0' after 3 ns;
  iswch <= X"2" after 5 ns,
           X"3" after 9 ns,
           X"1" after 13 ns;

end architecture;
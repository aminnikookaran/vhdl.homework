library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity CPU_Simple_8bit_TL_Ent is 
  port (
    iclk : in std_logic;
    irst : in std_logic;
    iswch : in std_logic_vector(3 downto 0);
    o7seg : out std_logic_vector(3 downto 0)
  );
end entity;

architecture CPU_Simple_8bit_TL_Arch of CPU_Simple_8bit_TL_Ent is

  component CPU_Simple_8bit_CR_Ent is 
    port (
      iclk : in std_logic;
      irst : in std_logic;
      ictrl : in std_logic_vector(6 downto 0);
      oload : out std_logic_vector(9 downto 0);
      osele : out std_logic_vector(1 downto 0)
    );
  end component;

  component CPU_Simple_8bit_DP_Ent is 
    port (
      iclk : in std_logic;
      irst : in std_logic;
      iload : in std_logic_vector(9 downto 0);
      isele : in std_logic_vector(1 downto 0);
      iswch : in std_logic_vector(3 downto 0);
      octrl : out std_logic_vector(6 downto 0);
      o7seg : out std_logic_vector(3 downto 0)
    );
  end component;

  signal ctrl : std_logic_vector(6 downto 0);
  signal load : std_logic_vector(9 downto 0);
  signal sele : std_logic_vector(1 downto 0);

  begin
    
    CPU_CR : CPU_Simple_8bit_CR_Ent port map (
      iclk => iclk,
      irst => irst,
      ictrl => ctrl,
      oload => load,
      osele => sele
    );

    CPU_DP : CPU_Simple_8bit_DP_Ent port map (
      iclk => iclk,
      irst => irst,
      iload => load,
      isele => sele,
      iswch => iswch,
      octrl => ctrl,
      o7seg => o7seg
    );

end architecture;
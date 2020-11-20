library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Arithmetic_Encoder_TL_Ent is 
  port (
    iclk : in std_logic;
    irst : in std_logic;
    idata : in std_logic_vector(7 downto 0);
    ocode : out std_logic_vector(7 downto 0);
    odv : out std_logic;
    oend : out std_logic
  );
end entity;

architecture Arithmetic_Encoder_TL_Arch of Arithmetic_Encoder_TL_Ent is

  component Arithmetic_Encoder_CR_Ent is 
    port (
      iclk : in std_logic;
      irst : in std_logic;
      itrnge : in std_logic_vector(7 downto 0);
      idata : in std_logic_vector(7 downto 0);
      iladdr : in std_logic_vector(7 downto 0);
      olrrom : out std_logic;
      olmrnge : out std_logic;
      olreg : out std_logic;
      osele : out std_logic;
      odv : out std_logic;
      oend : out std_logic
    );
  end component;

  component Arithmetic_Encoder_DP_Ent is 
    port (
      iclk : in std_logic;
      irst : in std_logic;
      isele : in std_logic;
      ilrrom : in std_logic;
      ilmrnge : in std_logic;
      ilreg : in std_logic;
      idata : in std_logic_vector(7 downto 0);
      oladdr : out std_logic_vector(7 downto 0);
      otrnge : out std_logic_vector(7 downto 0);
      odata : out std_logic_vector(7 downto 0);
      ocode : out std_logic_vector(7 downto 0)
    );
  end component;

  signal trnge : std_logic_vector(7 downto 0);
  signal data : std_logic_vector(7 downto 0);
  signal laddr : std_logic_vector(7 downto 0);
  signal lrrom : std_logic;
  signal lmrnge : std_logic;
  signal lreg : std_logic;
  signal sele : std_logic;

  begin

    AE_CR : Arithmetic_Encoder_CR_Ent port map (
      iclk => iclk,
      irst => irst,
      itrnge => trnge,
      idata => data,
      iladdr => laddr,
      olrrom => lrrom,
      olmrnge => lmrnge,
      olreg => lreg,
      osele => sele,
      odv => odv,
      oend => oend
    );

    AE_DP : Arithmetic_Encoder_DP_Ent port map (
      iclk => iclk,
      irst => irst,
      isele => sele,
      ilrrom => lrrom,
      ilmrnge => lmrnge,
      ilreg => lreg,
      idata => idata,
      oladdr => laddr,
      otrnge => trnge,
      odata => data,
      ocode => ocode
    );

end architecture;
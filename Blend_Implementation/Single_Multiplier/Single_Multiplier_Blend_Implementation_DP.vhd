library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Single_Multiplier_Blend_Implementation_DP_Ent is
  port (
    clk : in std_logic;
    rst : in std_logic;
    f : in std_logic_vector(8 downto 0);
    ca : in std_logic_vector(7 downto 0);
    cb : in std_logic_vector(7 downto 0);
    msel : in std_logic;
    ld : in std_logic_vector(2 downto 0);
    cnew : out std_logic_vector(7 downto 0)
  );
end entity;

architecture Single_Multiplier_Blend_Implementation_DP_Arch of Single_Multiplier_Blend_Implementation_DP_Ent is
  
  component One_Minus_MD_Ent is
    port (
      a : in std_logic_vector(8 downto 0);
      y : out std_logic_vector(8 downto 0)
    );
  end component;

  component Blend_Multiplier_MD_Ent is
    port (
      c : in std_logic_vector(7 downto 0);
      f : in std_logic_vector(8 downto 0);
      y : out std_logic_vector(7 downto 0)
    );
  end component;
  
  component Register_8bit_MD_Ent is 
    port (
      iclk : in std_logic;
      irst : in std_logic;
      ice : in std_logic;
      idata : in std_logic_vector(7 downto 0);
      odata : out std_logic_vector(7 downto 0)
    );
  end component;

  component Saturating_Adder_MD_Ent is
    port (
      a : in std_logic_vector(7 downto 0);
      b : in std_logic_vector(7 downto 0);
      y : out std_logic_vector(7 downto 0)
    );
  end component;

  signal mf : std_logic_vector(8 downto 0);
  signal mc : std_logic_vector(7 downto 0);
  signal u1y : std_logic_vector(8 downto 0);
  signal u2y : std_logic_vector(7 downto 0);
  signal u2q : std_logic_vector(7 downto 0);
  signal u3q : std_logic_vector(7 downto 0);
  signal u4y : std_logic_vector(7 downto 0);

  begin
    
    u1 : One_Minus_MD_Ent port map (
      a => f,
      y => u1y
    );
    
    mf <= f when msel = '0' else u1y when msel = '1';
    mc <= ca when msel = '0' else cb when msel = '1';
    
    u2 : Blend_Multiplier_MD_Ent port map (
      c => mc,
      f => mf,
      y => u2y
    );

    rA : Register_8bit_MD_Ent port map (
      iclk => clk,
      irst => rst,
      ice => ld(0),
      idata => u2y,
      odata => u2q
    );

    rB : Register_8bit_MD_Ent port map (
      iclk => clk,
      irst => rst,
      ice => ld(1),
      idata => u2y,
      odata => u3q
    );

    satadd : Saturating_Adder_MD_Ent port map (
      a => u2q,
      b => u3q,
      y => u4y
    );

    rC : Register_8bit_MD_Ent port map (
      iclk => clk,
      irst => rst,
      ice => ld(2),
      idata => u4y,
      odata => cnew
    );

end architecture;
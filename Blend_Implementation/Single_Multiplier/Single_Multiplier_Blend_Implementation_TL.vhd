library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Single_Multiplier_Blend_Implementation_TL_Ent is
  port (
    clk : in std_logic;
    rst : in std_logic;
    f : in std_logic_vector(8 downto 0);
    ca : in std_logic_vector(7 downto 0);
    cb : in std_logic_vector(7 downto 0);
    cnew : out std_logic_vector(7 downto 0)
  );
end entity;

architecture Single_Multiplier_Blend_Implementation_TL_Arch of Single_Multiplier_Blend_Implementation_TL_Ent is
  
  component Single_Multiplier_Blend_Implementation_DP_Ent is
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
  end component;

  component Single_Multiplier_Blend_Implementation_CR_Ent is
    port (
      clk : in std_logic;
      rst : in std_logic;
      msel : out std_logic;
      ld : out std_logic_vector(2 downto 0)
    );
  end component;
  

  signal msel : std_logic;
  signal ld : std_logic_vector(2 downto 0);

  begin
    
    SMBI_DP : Single_Multiplier_Blend_Implementation_DP_Ent port map (
      clk => clk,
      rst => rst,
      f => f,
      ca => ca,
      cb => cb,
      msel => msel,
      ld => ld,
      cnew => cnew
    );

    SMBI_CR : Single_Multiplier_Blend_Implementation_CR_Ent port map (
      clk => clk,
      rst => rst,
      msel => msel,
      ld => ld
    );

end architecture;
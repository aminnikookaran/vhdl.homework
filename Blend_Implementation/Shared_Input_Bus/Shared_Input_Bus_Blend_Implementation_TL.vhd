library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Shared_Input_Bus_Blend_Implementation_TL_Ent is
  port (
    clk : in std_logic;
    rst : in std_logic;
    irdy : in std_logic;
    din : in std_logic_vector(8 downto 0);
    cnew : out std_logic_vector(7 downto 0);
    ordy : out std_logic
  );
end entity;

architecture Shared_Input_Bus_Blend_Implementation_TL_Arch of Shared_Input_Bus_Blend_Implementation_TL_Ent is
  
  component Single_Multiplier_Blend_Implementation_DP_Ent is
    port (
      clk : in std_logic;
      rst : in std_logic;
      din : in std_logic_vector(8 downto 0);
      msel : in std_logic;
      ld : in std_logic_vector(3 downto 0);
      cnew : out std_logic_vector(7 downto 0)
    );
  end component;

  component Single_Multiplier_Blend_Implementation_CR_Ent is
    port (
      clk : in std_logic;
      rst : in std_logic;
      irdy : in std_logic;
      msel : out std_logic;
      ld : out std_logic_vector(3 downto 0);
      ordy : out std_logic
    );
  end component;
  

  signal msel : std_logic;
  signal ld : std_logic_vector(3 downto 0);

  begin
    
    SMBI_DP : Single_Multiplier_Blend_Implementation_DP_Ent port map (
      clk => clk,
      rst => rst,
      din => din,
      msel => msel,
      ld => ld,
      cnew => cnew
    );

    SMBI_CR : Single_Multiplier_Blend_Implementation_CR_Ent port map (
      clk => clk,
      rst => rst,
      irdy => irdy,
      msel => msel,
      ld => ld,
      ordy => ordy
    );

end architecture;
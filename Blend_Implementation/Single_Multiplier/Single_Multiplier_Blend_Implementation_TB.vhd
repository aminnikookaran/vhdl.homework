library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Single_Multiplier_Blend_Implementation_TB_Ent is 
end entity;

architecture Single_Multiplier_Blend_Implementation_TB_Arch of Single_Multiplier_Blend_Implementation_TB_Ent is 

  component Single_Multiplier_Blend_Implementation_TL_Ent is 
    port (
      clk : in std_logic;
      rst : in std_logic;
      f : in std_logic_vector(8 downto 0);
      ca : in std_logic_vector(7 downto 0);
      cb : in std_logic_vector(7 downto 0);
      cnew : out std_logic_vector(7 downto 0)
    );
  end component;

  signal clk : std_logic := '0';
  signal rst : std_logic;
  signal f : std_logic_vector(8 downto 0);
  signal ca : std_logic_vector(7 downto 0);
  signal cb : std_logic_vector(7 downto 0);
  signal cnew : std_logic_vector(7 downto 0);
    
  begin
  
    SMBI_TL : Single_Multiplier_Blend_Implementation_TL_Ent port map  (
      clk => clk,
      rst => rst,
      f => f,
      ca => ca,
      cb => cb,
      cnew => cnew
    );

  clk <= not clk after 1 ns;
  rst <= '1', '0' after 2 ns;
  
  f <= std_logic_vector(to_unsigned(256,9)), std_logic_vector(to_unsigned(0,9)) after 6 ns, std_logic_vector(to_unsigned(128,9)) after 10 ns;
  ca <= std_logic_vector(to_unsigned(10,8)), std_logic_vector(to_unsigned(30,8)) after 4 ns, std_logic_vector(to_unsigned(50,8)) after 8 ns;
  cb <= std_logic_vector(to_unsigned(20,8)), std_logic_vector(to_unsigned(40,8)) after 6 ns, std_logic_vector(to_unsigned(60,8)) after 10 ns;
  
end architecture;
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Pipelined_Multiplier_Blend_Implementation_MD_Ent is
  port (
    clk : in std_logic;
    f : in std_logic_vector(8 downto 0);
    ca : in std_logic_vector(7 downto 0);
    cb : in std_logic_vector(7 downto 0);
    cnew : out std_logic_vector(7 downto 0)
  );
end entity;

architecture Pipelined_Multiplier_Blend_Implementation_MD_Arch of Pipelined_Multiplier_Blend_Implementation_MD_Ent is
  
  component One_Minus_MD_Ent is
    port (
      a : in std_logic_vector(8 downto 0);
      y : out std_logic_vector(8 downto 0)
    );
  end component;

  component Pipelind_Blend_Multiplier_MD_Ent is
    port (
      clk : in std_logic;
      c : in std_logic_vector(7 downto 0);
      f : in std_logic_vector(8 downto 0);
      y : out std_logic_vector(7 downto 0)
    );
  end component;
  
  component Saturating_Adder_MD_Ent is
    port (
      a : in std_logic_vector(7 downto 0);
      b : in std_logic_vector(7 downto 0);
      y : out std_logic_vector(7 downto 0)
    );
  end component;

  signal u1y : std_logic_vector(8 downto 0);
  signal u2y : std_logic_vector(7 downto 0);
  signal u3y : std_logic_vector(7 downto 0);
  signal u2q : std_logic_vector(7 downto 0);
  signal u3q : std_logic_vector(7 downto 0);
  signal u4y : std_logic_vector(7 downto 0);

  begin
    
    u1 : One_Minus_MD_Ent port map (
      a => f,
      y => u1y
    );
    
    u2 : Pipelind_Blend_Multiplier_MD_Ent port map (
      clk => clk,
      c => ca,
      f => f,
      y => u2y
    );
  
    u3 : Pipelind_Blend_Multiplier_MD_Ent port map (
      clk => clk,
      c => ca,
      f => f,
      y => u3y
    );

    process (clk)
      begin
        if rising_edge(clk) then
          u3q <= u3y;
          u2q <= u2y;
          cnew <= u4y;
        end if;
    end process;
    
    u4 : Saturating_Adder_MD_Ent port map (
      a => u3q,
      b => u2q,
      y => u4y
    );

end architecture;
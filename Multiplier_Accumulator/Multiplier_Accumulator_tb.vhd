library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity tb_Multiplier_Accumulator_Ent is
end entity ;

architecture tb_Multiplier_Accumulator_Arch of tb_Multiplier_Accumulator_Ent is

component Multiplier_Accumulator_TL_Ent is
  port(
    iclk : in std_logic;
    ice : in std_logic;
    idataR : in std_logic;
    idataA : in std_logic_vector(7 downto 0);
    idataB : in std_logic_vector(7 downto 0);
    imaxval : in std_logic_vector(7 downto 0);
    odataV : out std_logic;
    os : out std_logic_vector(31 downto 0)
  );
end component ;

  signal iclk : std_logic := '0';
  signal ice : std_logic := '0';
  signal idataR : std_logic := '0';
  signal idataA : std_logic_vector(7 downto 0) := std_logic_vector(to_unsigned(0,8));
  signal idataB : std_logic_vector(7 downto 0) := std_logic_vector(to_unsigned(0,8));
  signal imaxval : std_logic_vector(7 downto 0) := std_logic_vector(to_unsigned(0,8));
  signal odataV : std_logic;
  signal os : std_logic_vector(31 downto 0);
  
begin
  
  UUT : Multiplier_Accumulator_TL_Ent port map (
    iclk => iclk,
    ice => ice,
    idataR => idataR,
    idataA => idataA,
    idataB => idataB,
    imaxval => imaxval,
    odataV => odataV,
    os => os
    );
  
  iclk <= not iclk after 5 ns;
  ice <= '0', '1' after 2 ns, '0' after 23 ns, '1' after 27 ns;
  imaxval <= std_logic_vector(to_unsigned(5,8));
  idataR <= '0', '1' after 2 ns;
  idataA <= std_logic_vector(to_unsigned(2,8)), std_logic_vector(to_unsigned(3,8)) after 6 ns, std_logic_vector(to_unsigned(4,8)) after 16 ns, std_logic_vector(to_unsigned(5,8)) after 26 ns, std_logic_vector(to_unsigned(6,8)) after 36 ns, std_logic_vector(to_unsigned(6,8)) after 46 ns;
  idataB <= std_logic_vector(to_unsigned(2,8)), std_logic_vector(to_unsigned(3,8)) after 6 ns, std_logic_vector(to_unsigned(4,8)) after 16 ns, std_logic_vector(to_unsigned(5,8)) after 26 ns, std_logic_vector(to_unsigned(6,8)) after 36 ns, std_logic_vector(to_unsigned(6,8)) after 46 ns;

end architecture ;
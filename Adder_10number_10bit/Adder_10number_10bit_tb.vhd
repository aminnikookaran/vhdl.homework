library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity tb_Adder_10number_10bit is 
end entity;

architecture tb_Adder_10number_10bit_Arch of tb_Adder_10number_10bit is 

component Adder_10number_10bit_Ent is 
            port (
                 ia : in std_logic_vector(9 downto 0);
                 ib : in std_logic_vector(9 downto 0);
                 ic : in std_logic_vector(9 downto 0);
                 id : in std_logic_vector(9 downto 0);
                 ie : in std_logic_vector(9 downto 0);
                 ig : in std_logic_vector(9 downto 0);
                 ih : in std_logic_vector(9 downto 0);
                 ii : in std_logic_vector(9 downto 0);
                 ij : in std_logic_vector(9 downto 0);
                 ik : in std_logic_vector(9 downto 0);
                 osum : out std_logic_vector(12 downto 0);
                 oc : out std_logic
                  );
end component;

    signal ia :  std_logic_vector(9 downto 0) := std_logic_vector(to_unsigned(0,10));
    signal ib :  std_logic_vector(9 downto 0) := std_logic_vector(to_unsigned(0,10));
    signal ic :  std_logic_vector(9 downto 0) := std_logic_vector(to_unsigned(0,10));
    signal id :  std_logic_vector(9 downto 0) := std_logic_vector(to_unsigned(0,10));
    signal ie :  std_logic_vector(9 downto 0) := std_logic_vector(to_unsigned(0,10));
    signal ig :  std_logic_vector(9 downto 0) := std_logic_vector(to_unsigned(0,10));
    signal ih :  std_logic_vector(9 downto 0) := std_logic_vector(to_unsigned(0,10));
    signal ii :  std_logic_vector(9 downto 0) := std_logic_vector(to_unsigned(0,10));
    signal ij :  std_logic_vector(9 downto 0) := std_logic_vector(to_unsigned(0,10));
    signal ik :  std_logic_vector(9 downto 0) := std_logic_vector(to_unsigned(0,10));
    
    signal osum : std_logic_vector(12 downto 0);
    signal oc : std_logic;

begin
  
  UUT: Adder_10number_10bit_Ent port map  (
                 ia => ia,
                 ib => ib,
                 ic => ic,
                 id => id,
                 ie => ie,
                 ig => ig,
                 ih => ih,
                 ii => ii,
                 ij => ij,
                 ik => ik,
                 osum => osum,
                 oc => oc
                  );
                  
  ia <= std_logic_vector(to_unsigned(0,10)), std_logic_vector(to_unsigned(14,10)) after 200 ns, std_logic_vector(to_unsigned(75,10)) after 400 ns, std_logic_vector(to_unsigned(289,10)) after 600 ns, std_logic_vector(to_unsigned(859,10)) after 800 ns, std_logic_vector(to_unsigned(772,10)) after 1000 ns;
  ib <= std_logic_vector(to_unsigned(0,10)), std_logic_vector(to_unsigned(23,10)) after 300 ns, std_logic_vector(to_unsigned(94,10)) after 500 ns, std_logic_vector(to_unsigned(476,10)) after 700 ns, std_logic_vector(to_unsigned(149,10)) after 900 ns, std_logic_vector(to_unsigned(943,10)) after 1100 ns;
  ic <= std_logic_vector(to_unsigned(0,10)), std_logic_vector(to_unsigned(14,10)) after 200 ns, std_logic_vector(to_unsigned(75,10)) after 400 ns, std_logic_vector(to_unsigned(289,10)) after 600 ns, std_logic_vector(to_unsigned(859,10)) after 800 ns, std_logic_vector(to_unsigned(772,10)) after 1000 ns;
  id <= std_logic_vector(to_unsigned(0,10)), std_logic_vector(to_unsigned(23,10)) after 300 ns, std_logic_vector(to_unsigned(94,10)) after 500 ns, std_logic_vector(to_unsigned(476,10)) after 700 ns, std_logic_vector(to_unsigned(149,10)) after 900 ns, std_logic_vector(to_unsigned(943,10)) after 1100 ns;
  ie <= std_logic_vector(to_unsigned(0,10)), std_logic_vector(to_unsigned(14,10)) after 200 ns, std_logic_vector(to_unsigned(75,10)) after 400 ns, std_logic_vector(to_unsigned(289,10)) after 600 ns, std_logic_vector(to_unsigned(859,10)) after 800 ns, std_logic_vector(to_unsigned(772,10)) after 1000 ns;
  ig <= std_logic_vector(to_unsigned(0,10)), std_logic_vector(to_unsigned(23,10)) after 300 ns, std_logic_vector(to_unsigned(94,10)) after 500 ns, std_logic_vector(to_unsigned(476,10)) after 700 ns, std_logic_vector(to_unsigned(149,10)) after 900 ns, std_logic_vector(to_unsigned(943,10)) after 1100 ns;
  ih <= std_logic_vector(to_unsigned(0,10)), std_logic_vector(to_unsigned(14,10)) after 200 ns, std_logic_vector(to_unsigned(75,10)) after 400 ns, std_logic_vector(to_unsigned(289,10)) after 600 ns, std_logic_vector(to_unsigned(859,10)) after 800 ns, std_logic_vector(to_unsigned(772,10)) after 1000 ns;
  ii <= std_logic_vector(to_unsigned(0,10)), std_logic_vector(to_unsigned(23,10)) after 300 ns, std_logic_vector(to_unsigned(94,10)) after 500 ns, std_logic_vector(to_unsigned(476,10)) after 700 ns, std_logic_vector(to_unsigned(149,10)) after 900 ns, std_logic_vector(to_unsigned(943,10)) after 1100 ns;
  ij <= std_logic_vector(to_unsigned(0,10)), std_logic_vector(to_unsigned(14,10)) after 200 ns, std_logic_vector(to_unsigned(75,10)) after 400 ns, std_logic_vector(to_unsigned(289,10)) after 600 ns, std_logic_vector(to_unsigned(859,10)) after 800 ns, std_logic_vector(to_unsigned(772,10)) after 1000 ns;
  ik <= std_logic_vector(to_unsigned(0,10)), std_logic_vector(to_unsigned(23,10)) after 300 ns, std_logic_vector(to_unsigned(94,10)) after 500 ns, std_logic_vector(to_unsigned(476,10)) after 700 ns, std_logic_vector(to_unsigned(149,10)) after 900 ns, std_logic_vector(to_unsigned(943,10)) after 1100 ns;
   
end architecture;
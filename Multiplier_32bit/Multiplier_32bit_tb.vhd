library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity tb_Multiplier_32bit is 
end entity;

architecture tb_Multiplier_32bit_Arch of tb_Multiplier_32bit is 

component Multiplier_32bit_Ent is 
            port (
                 a : in std_logic_vector(31 downto 0);
                 b : in std_logic_vector(31 downto 0);
                 mult : out std_logic_vector(63 downto 0)
                  );
end component;

    signal a :  std_logic_vector(31 downto 0) := std_logic_vector(to_unsigned(0,32));
    signal b :  std_logic_vector(31 downto 0) := std_logic_vector(to_unsigned(0,32));
    
    signal mult :  std_logic_vector(63 downto 0);

begin
  
  UUT: Multiplier_32bit_Ent port map  (
                 a => a,
                 b => b,
                 mult => mult
                  );
                  
  a <= std_logic_vector(to_unsigned(0,32)), std_logic_vector(to_unsigned(14,32)) after 200 ns, std_logic_vector(to_unsigned(75,32)) after 400 ns, std_logic_vector(to_unsigned(289,32)) after 600 ns, std_logic_vector(to_unsigned(8590,32)) after 800 ns, std_logic_vector(to_unsigned(77215,32)) after 1000 ns;
  b <= std_logic_vector(to_unsigned(0,32)), std_logic_vector(to_unsigned(23,32)) after 300 ns, std_logic_vector(to_unsigned(94,32)) after 500 ns, std_logic_vector(to_unsigned(476,32)) after 700 ns, std_logic_vector(to_unsigned(14978,32)) after 900 ns, std_logic_vector(to_unsigned(943627,32)) after 1100 ns;
   
end architecture;
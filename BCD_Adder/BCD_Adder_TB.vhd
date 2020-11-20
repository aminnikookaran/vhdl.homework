library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity tb_BCD_Adder is 
end entity;

architecture BCD_Adder_Arch of tb_BCD_Adder is 

component BCD_Adder_Ent is 
            port (
                 a : in std_logic_vector(15 downto 0);
                 b : in std_logic_vector(15 downto 0);
                 ic : in std_logic;
                 sum : out std_logic_vector(15 downto 0);
                 oc : out std_logic                 
                  );
end component;

    signal a :  std_logic_vector(15 downto 0) := X"0000";
    signal b :  std_logic_vector(15 downto 0) := X"0000";
    signal ic :  std_logic := '0';
    
    signal sum :  std_logic_vector(15 downto 0);
    signal oc :  std_logic;                 

begin
  
  UUT: BCD_Adder_Ent port map  (
                 a => a,
                 b => b,
                 ic => ic,
                 sum => sum,
                 oc => oc
                  );
                  
  a <= X"9999", X"0527" after 200 ns, X"0123" after 400 ns, X"6342" after 600 ns, X"0001" after 800 ns, X"0424" after 1000 ns;
  b <= X"9999", X"9856" after 300 ns, X"1023" after 500 ns, X"7898" after 700 ns, X"9876" after 900 ns, X"4240" after 1100 ns;
  ic <= not ic after 1 us;
  
end architecture;
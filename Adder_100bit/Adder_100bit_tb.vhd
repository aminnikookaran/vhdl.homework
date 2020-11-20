library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity tb_Adder_100bit is 
end entity;

architecture tb_Adder_100bit_Arch of tb_Adder_100bit is 

component Adder_100bit_Ent is 
            port (
                 ia : in std_logic_vector(99 downto 0);
                 ib : in std_logic_vector(99 downto 0);
                 ic : in std_logic;
                 osum : out std_logic_vector(99 downto 0);
                 oc : out std_logic                 
                  );
end component;

    signal ia :  std_logic_vector(99 downto 0) := X"0000000000000000000000000";
    signal ib :  std_logic_vector(99 downto 0) := X"0000000000000000000000000";
    signal ic :  std_logic := '0';
    
    signal osum :  std_logic_vector(99 downto 0);
    signal oc :  std_logic;                 

begin
  
  UUT: Adder_100bit_Ent port map  (
                 ia => ia,
                 ib => ib,
                 ic => ic,
                 osum => osum,
                 oc => oc
                  );
                  
  ia <= std_logic_vector(to_unsigned(0,100)), X"0300000000000000000000000" after 200 ns, X"0C00000000000000000000000" after 400 ns, X"3000000000000000000000000" after 600 ns, X"C000000000000000000000000" after 800 ns, X"0000000000000000000000000" after 1000 ns;
  ib <= X"0100000000000000000000000", X"0600000000000000000000000" after 300 ns, X"1800000000000000000000000" after 500 ns, X"6000000000000000000000000" after 700 ns, X"8000000000000000000000000" after 900 ns, X"AA00000000000000000000000" after 1100 ns;
  ic <= not ic after 1 us;
  
end architecture;
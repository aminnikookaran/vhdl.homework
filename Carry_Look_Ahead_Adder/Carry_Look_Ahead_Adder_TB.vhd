library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity tb_Carry_Look_Ahead_Adder is 
end entity;

architecture tb_Carry_Look_Ahead_Adder_Arch of tb_Carry_Look_Ahead_Adder is 

component Carry_Look_Ahead_Adder_Ent is 
            port (
                 ia : in std_logic_vector(9 downto 0);
                 ib : in std_logic_vector(9 downto 0);
                 ic : in std_logic;
                 osum : out std_logic_vector(9 downto 0);
                 oc : out std_logic                 
                  );
end component;

    signal ia :  std_logic_vector(9 downto 0) := "00" & X"00";
    signal ib :  std_logic_vector(9 downto 0) := "00" & X"00";
    signal ic :  std_logic := '0';
    
    signal osum :  std_logic_vector(9 downto 0);
    signal oc :  std_logic;                 

begin
  
  UUT: Carry_Look_Ahead_Adder_Ent port map  (
                 ia => ia,
                 ib => ib,
                 ic => ic,
                 osum => osum,
                 oc => oc
                  );
                  
  ia <= "00" & X"01", "00" & X"03" after 200 ns, "00" & X"0C" after 400 ns, "00" & X"30" after 600 ns, "00" & X"C0" after 800 ns, "11" & X"00" after 1000 ns;
  ib <= "00" & X"01", "00" & X"06" after 300 ns, "00" & X"18" after 500 ns, "00" & X"60" after 700 ns, "01" & X"80" after 900 ns, "10" & X"AA" after 1100 ns;
  ic <= not ic after 1 us;
  
end architecture;
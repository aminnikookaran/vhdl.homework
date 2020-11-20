library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Ripple_Carry_Adder_10bit_Ent is 
            port (
                 ia : in std_logic_vector(9 downto 0);
                 ib : in std_logic_vector(9 downto 0);
                 ic : in std_logic;
                 osum : out std_logic_vector(9 downto 0);
                 oc : out std_logic                 
                  );
end entity;

architecture Ripple_Carry_Adder_10bit_Arch of Ripple_Carry_Adder_10bit_Ent is
component Full_Adder_Ent
    port(
      a : in std_logic;
      b : in std_logic;
      c : in std_logic;
      sum : out std_logic;
      carry : out std_logic 
      );
    end component;
    
  signal ocarry : std_logic_vector(10 downto 0);
begin
  
  ocarry(0) <= ic;
lbl:  for i in 0 to 9 generate
          Full_Adder : Full_Adder_Ent port map(
              a => ia(i),
              b => ib(i),
              c => ocarry(i),
              sum => osum(i),
              carry => ocarry(i+1) );
      end generate;
  oc <= ocarry(10);
  
end architecture;
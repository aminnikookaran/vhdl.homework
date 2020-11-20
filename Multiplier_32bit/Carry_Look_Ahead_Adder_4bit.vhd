library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Carry_Look_Ahead_Adder_4bit_Ent is 
            port (
                 ia : in std_logic_vector(3 downto 0);
                 ib : in std_logic_vector(3 downto 0);
                 ic : in std_logic;
                 osum : out std_logic_vector(3 downto 0);
                 oc : out std_logic                
                  );
end entity;

architecture Carry_Look_Ahead_Adder_4bit_Arch of Carry_Look_Ahead_Adder_4bit_Ent is 
  signal p : std_logic_vector(3 downto 0);
  signal g : std_logic_vector(3 downto 0);
  signal c : std_logic_vector(3 downto 0);
  signal pp1 : std_logic_vector(3 downto 0);
  signal pp2 : std_logic_vector(3 downto 2);
  signal pg1 : std_logic_vector(2 downto 0);
  signal pg2 : std_logic_vector(3 downto 3);
begin
    
    p <= ia xor ib;
    g <= ia and ib;

    pp1(0) <= p(0) and ic;
    lbl0: for i in 1 to 3 generate
      pp1(i) <= p(i) and p(i-1);
    end generate;

    lbl1: for i in 2 to 3 generate
      pp2(i) <= pp1(i) and pp1(i-2);
    end generate;

    lbl2: for i in 0 to 2 generate
      pg1(i) <= p(i+1) and g(i);
    end generate;

    pg2(3) <= pp1(3) and pg1(0);

    c(0) <= g(0) or pp1(0);
    c(1) <= (g(1) or pg1(0)) or (p(1) and pp1(0));
    c(2) <= (g(2) or pg1(1)) or ((p(2) and pg1(0)) or pp2(2));
    c(3) <= ((g(3) or pg1(2)) or ((p(3) and pg1(1)) or pg2(3))) or (p(3) and pp2(2));

    osum <= p xor (c(2 downto 0) & ic);
    oc <= c(3);
  
end architecture;
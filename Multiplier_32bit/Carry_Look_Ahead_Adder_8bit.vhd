library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Carry_Look_Ahead_Adder_8bit_Ent is 
            port (
                 ia : in std_logic_vector(7 downto 0);
                 ib : in std_logic_vector(7 downto 0);
                 ic : in std_logic;
                 osum : out std_logic_vector(7 downto 0);
                 oc : out std_logic                
                  );
end entity;

architecture Carry_Look_Ahead_Adder_8bit_Arch of Carry_Look_Ahead_Adder_8bit_Ent is 
  signal p : std_logic_vector(7 downto 0);
  signal g : std_logic_vector(7 downto 0);
  signal c : std_logic_vector(7 downto 0);
  signal pp1 : std_logic_vector(7 downto 0);
  signal pp2 : std_logic_vector(7 downto 2);
  signal pg1 : std_logic_vector(6 downto 0);
  signal pg2 : std_logic_vector(7 downto 3);
begin
    
    p <= ia xor ib;
    g <= ia and ib;

    pp1(0) <= p(0) and ic;
    lbl0: for i in 1 to 7 generate
      pp1(i) <= p(i) and p(i-1);
    end generate;

    lbl1: for i in 2 to 7 generate
      pp2(i) <= pp1(i) and pp1(i-2);
    end generate;

    lbl2: for i in 0 to 6 generate
      pg1(i) <= p(i+1) and g(i);
    end generate;

    lbl3: for i in 3 to 7 generate
      pg2(i) <= pp1(i) and pg1(i-3);
    end generate;

    c(0) <= g(0) or pp1(0);
    c(1) <= (g(1) or pg1(0)) or (p(1) and pp1(0));
    c(2) <= (g(2) or pg1(1)) or ((p(2) and pg1(0)) or pp2(2));
    c(3) <= ((g(3) or pg1(2)) or ((p(3) and pg1(1)) or pg2(3))) or (p(3) and pp2(2));
    c(4) <= ((g(4) or pg1(3)) or ((p(4) and pg1(2)) or pg2(4))) or ((p(4) and pg2(3)) or (pp1(4) and pp2(2)));
    c(5) <= ((g(5) or pg1(4)) or ((p(5) and pg1(3)) or pg2(5))) or (((p(5) and pg2(4)) or (pp1(5) and pg2(3))) or (p(5) and pp1(4) and pp2(2)));
    c(6) <= ((g(6) or pg1(5)) or ((p(6) and pg1(4)) or pg2(6))) or (((p(6) and pg2(5)) or (pp1(6) and pg2(4))) or ((p(6) and pp1(5) and pg2(3)) or (pp2(6) and pp2(2))));
    c(7) <= (((g(7) or pg1(6)) or ((p(7) and pg1(5)) or pg2(7))) or (((p(7) and pg2(6)) or (pp1(7) and pg2(5))) or ((p(7) and pp1(6) and pg2(4)) or (pp2(7) and pg2(3))))) or (p(7) and (pp2(6) and pp2(2)));

    osum <= p xor (c(6 downto 0) & ic);
    oc <= c(7);
  
end architecture;
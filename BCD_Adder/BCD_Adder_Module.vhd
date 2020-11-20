library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity BCD_Adder_Ent is 
            port (
                 a : in std_logic_vector(15 downto 0);
                 b : in std_logic_vector(15 downto 0);
                 ic : in std_logic;
                 sum : out std_logic_vector(15 downto 0);
                 oc : out std_logic                 
                  );
end entity;

architecture BCD_Adder_Arch of BCD_Adder_Ent is 
  signal s1 : std_logic_vector(4 downto 0);
  signal s2 : std_logic_vector(4 downto 0);
  signal s3 : std_logic_vector(4 downto 0);
  signal s4 : std_logic_vector(4 downto 0);
  signal c : std_logic_vector(3 downto 0);
begin
  
  s1 <= ('0' & a(3 downto 0)) + ('0' & b(3 downto 0)) + (X"0" & ic);
  c(0) <= (s1(4) or (s1(3) and s1(2)) or(s1(3) and s1(1)));
  
  s2 <= ('0' & a(7 downto 4)) + ('0' & b(7 downto 4)) + (X"0" & c(0));
  c(1) <= (s2(4) or (s2(3) and s2(2)) or(s2(3) and s2(1)));
  
  s3 <= ('0' & a(11 downto 8)) + ('0' & b(11 downto 8)) + (X"0" & c(1));
  c(2) <= (s3(4) or (s3(3) and s3(2)) or(s3(3) and s3(1)));
  
  s4 <= ('0' & a(15 downto 12)) + ('0' & b(15 downto 12)) + (X"0" & c(2));
  c(3) <= (s4(4) or (s4(3) and s4(2)) or(s4(3) and s4(1)));
    
  sum <= (s4(3 downto 0) + ('0' & c(2) & c(2) & '0')) & (s3(3 downto 0) + ('0' & c(1) & c(1) & '0')) & (s2(3 downto 0) + ('0' & c(1) & c(1) & '0')) & (s1(3 downto 0) + ('0' & c(0) & c(0) & '0'));
  oc <= c(3);
  
end architecture;
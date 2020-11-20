library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Carry_Save_Adder_10bit_Ent is 
            port (
                 ia : in std_logic_vector(9 downto 0);
                 ib : in std_logic_vector(9 downto 0);
                 ic : in std_logic_vector(9 downto 0);
                 osum : out std_logic_vector(10 downto 0);
                 oc : out std_logic
                  );
end entity;

architecture Carry_Save_Adder_10bit_Arch of Carry_Save_Adder_10bit_Ent is
component Full_Adder_Ent
    port(
      a : in std_logic;
      b : in std_logic;
      c : in std_logic;
      sum : out std_logic;
      carry : out std_logic 
      );
    end component;
      
    component Carry_Look_Ahead_Adder_Ent
    port(
      a : in std_logic_vector(9 downto 0);
      b : in std_logic_vector(9 downto 0);
      icarry : in std_logic;
      sum : out std_logic_vector(9 downto 0);
      ocarry : out std_logic 
      );
    end component;
    
  signal c1 : std_logic_vector(10 downto 0);
  signal s1 : std_logic_vector(10 downto 0);
  signal s : std_logic_vector(10 downto 0);
  
begin
  
lbl1:  for i in 0 to 9 generate
          Full_Adder : Full_Adder_Ent port map(
              a => ia(i),
              b => ib(i),
              c => ic(i),
              sum => s1(i),
              carry => c1(i) );
      end generate;
      
      s1(10) <= '0';
      c1(9) <= '0';
      Carry_Look_Ahead_Adder : Carry_Look_Ahead_Adder_Ent port map(
              a => s1(10 downto 1),
              b => c1(9 downto 0),
              icarry => '0',
              sum => s(9 downto 0),
              ocarry => s(10) );

      osum(0) <= s1(0);
      osum(9 downto 1) <= s(8 downto 0);
          Full_Adder : Full_Adder_Ent port map(
              a => s(9),
              b => c1(9),
              c => '0',
              sum => osum(10),
              carry => oc );
                  
end architecture;
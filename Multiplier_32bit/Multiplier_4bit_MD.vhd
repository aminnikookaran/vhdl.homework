library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Multiplier_4bit_Ent is 
            port (
                 a : in std_logic_vector(3 downto 0);
                 b : in std_logic_vector(3 downto 0);
                 mult : out std_logic_vector(7 downto 0)
                  );
end entity;

architecture Multiplier_4bit_Arch of Multiplier_4bit_Ent is

component Full_Adder_Ent
    port(
      a : in std_logic;
      b : in std_logic;
      c : in std_logic;
      sum : out std_logic;
      carry : out std_logic 
      );
    end component;

component Half_Adder_Ent
    port(
      a : in std_logic;
      b : in std_logic;
      sum : out std_logic;
      carry : out std_logic 
      );
    end component;

  signal m0 : std_logic_vector(3 downto 0);
  signal m1 : std_logic_vector(3 downto 0);
  signal m2 : std_logic_vector(3 downto 0);
  signal m3 : std_logic_vector(3 downto 0);
  signal c : std_logic_vector(10 downto 0);
  signal sum : std_logic_vector(5 downto 0);
begin
  
lbl0 :  for i in 0 to 3 generate
          m0(i) <= a(0) and b(i);
          m1(i) <= a(1) and b(i);
          m2(i) <= a(2) and b(i);
          m3(i) <= a(3) and b(i);
        end generate;
        
        mult(0) <= m0(0);
        Half_Adder0 : Half_Adder_Ent port map(
          a => m0(1),
          b => m1(0),
          sum => mult(1),
          carry => c(0) );
          
        Full_Adder1 : Full_Adder_Ent port map(
          a => m0(2),
          b => m1(1),
          c => m2(0),
          sum => sum(0),
          carry => c(1) );
          
        Half_Adder2 : Half_Adder_Ent port map(
          a => sum(0),
          b => c(0),
          sum => mult(2),
          carry => c(2) );

        Full_Adder3 : Full_Adder_Ent port map(
          a => m0(3),
          b => m1(2),
          c => m2(1),
          sum => sum(1),
          carry => c(3) );

        Full_Adder4 : Full_Adder_Ent port map(
          a => sum(1),
          b => m3(0),
          c => c(1),
          sum => sum(2),
          carry => c(4) );

        Half_Adder5 : Half_Adder_Ent port map(
          a => sum(2),
          b => c(2),
          sum => mult(3),
          carry => c(5) );
  
        Full_Adder6 : Full_Adder_Ent port map(
          a => m1(3),
          b => m2(2),
          c => m3(1),
          sum => sum(3),
          carry => c(6) );

        Full_Adder7 : Full_Adder_Ent port map(
          a => c(3),
          b => c(4),
          c => c(5),
          sum => sum(4),
          carry => c(7) );

        Half_Adder8 : Half_Adder_Ent port map(
          a => sum(3),
          b => sum(4),
          sum => mult(4),
          carry => c(8) );

        Full_Adder9 : Full_Adder_Ent port map(
          a => m2(3),
          b => m3(2),
          c => c(6),
          sum => sum(5),
          carry => c(9) );

        Full_Adder10 : Full_Adder_Ent port map(
          a => sum(5),
          b => c(7),
          c => c(8),
          sum => mult(5),
          carry => c(10) );

        Full_Adder11 : Full_Adder_Ent port map(
          a => m3(3),
          b => c(9),
          c => c(10),
          sum => mult(6),
          carry => mult(7) );
  
end architecture;
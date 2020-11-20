library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Adder_10number_10bit_Ent is 
            port (
                 ia : in std_logic_vector(9 downto 0);
                 ib : in std_logic_vector(9 downto 0);
                 ic : in std_logic_vector(9 downto 0);
                 id : in std_logic_vector(9 downto 0);
                 ie : in std_logic_vector(9 downto 0);
                 ig : in std_logic_vector(9 downto 0);
                 ih : in std_logic_vector(9 downto 0);
                 ii : in std_logic_vector(9 downto 0);
                 ij : in std_logic_vector(9 downto 0);
                 ik : in std_logic_vector(9 downto 0);
                 osum : out std_logic_vector(12 downto 0);
                 oc : out std_logic
                  );
end entity;

architecture Adder_10number_10bit_Arch of Adder_10number_10bit_Ent is
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
    
    component Carry_Save_Adder_Ent
    port(
      ain : in std_logic_vector(9 downto 0);
      bin : in std_logic_vector(9 downto 0);
      cin : in std_logic_vector(9 downto 0);
      sumout : out std_logic_vector(10 downto 0);
      cout : out std_logic 
      );
    end component;
    
  signal sum0 : std_logic_vector(10 downto 0);
  signal sum1 : std_logic_vector(10 downto 0);
  signal sum2 : std_logic_vector(10 downto 0);
  signal sum3 : std_logic_vector(10 downto 0);
  signal sum4 : std_logic;
  signal sum5 : std_logic;
  signal c : std_logic_vector(7 downto 0);
  signal c2 : std_logic_vector(2 downto 0);
begin
  
        Carry_Save_Adder0 : Carry_Save_Adder_Ent port map(
              ain => ia,
              bin => ib,
              cin => ic,
              sumout => sum0,
              cout => c(0) );
  
        Carry_Save_Adder1 : Carry_Save_Adder_Ent port map(
              ain => id,
              bin => ie,
              cin => ig,
              sumout => sum1,
              cout => c(1) );

        Carry_Save_Adder2 : Carry_Save_Adder_Ent port map(
              ain => ih,
              bin => ii,
              cin => ij,
              sumout => sum2,
              cout => c(2) );
  
        Carry_Save_Adder3 : Carry_Save_Adder_Ent port map(
              ain => sum0(9 downto 0),
              bin => sum1(9 downto 0),
              cin => sum2(9 downto 0),
              sumout => sum3,
              cout => c(3) );

      Carry_Look_Ahead_Adder : Carry_Look_Ahead_Adder_Ent port map(
              a => sum3(9 downto 0),
              b => ik,
              icarry => '0',
              sum => osum(9 downto 0),
              ocarry => sum4 );

      Full_Adder0 : Full_Adder_Ent port map(
              a => sum0(10),
              b => sum1(10),
              c => sum2(10),
              sum => sum5,
              carry => c(4) );

      Full_Adder1 : Full_Adder_Ent port map(
              a => sum3(10),
              b => sum4,
              c => sum5,
              sum => osum(10),
              carry => c(5) );

      Full_Adder2 : Full_Adder_Ent port map(
              a => c(0),
              b => c(1),
              c => c(2),
              sum => c(6),
              carry => c2(0) );

      Full_Adder3 : Full_Adder_Ent port map(
              a => c(3),
              b => c(4),
              c => c(5),
              sum => c(7),
              carry => c2(1) );

      Full_Adder4 : Full_Adder_Ent port map(
              a => c(6),
              b => c(7),
              c => '0',
              sum => osum(11),
              carry => c2(2) );

      Full_Adder5 : Full_Adder_Ent port map(
              a => c2(0),
              b => c2(1),
              c => c2(2),
              sum => osum(12),
              carry => oc );
                  
end architecture;
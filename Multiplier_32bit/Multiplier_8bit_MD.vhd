library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Multiplier_8bit_Ent is 
            port (
                 a : in std_logic_vector(7 downto 0);
                 b : in std_logic_vector(7 downto 0);
                 mult : out std_logic_vector(15 downto 0)
                  );
end entity;

architecture Multiplier_8bit_Arch of Multiplier_8bit_Ent is

component Multiplier_4bit_Ent
    port(
      a : in std_logic_vector(3 downto 0);
      b : in std_logic_vector(3 downto 0);
      mult : out std_logic_vector(7 downto 0) 
      );
    end component;
    
component Carry_Look_Ahead_Adder_4bit_Ent
    port(
      ia : in std_logic_vector(3 downto 0);
      ib : in std_logic_vector(3 downto 0);
      ic : in std_logic;
      osum : out std_logic_vector(3 downto 0);
      oc : out std_logic
      );
    end component;

  signal m0 : std_logic_vector(7 downto 0);
  signal m1 : std_logic_vector(7 downto 0);
  signal m2 : std_logic_vector(7 downto 0);
  signal m3 : std_logic_vector(7 downto 0);
  signal c : std_logic_vector(4 downto 0);
  signal sum : std_logic_vector(7 downto 0);
  signal temp : std_logic_vector(3 downto 0);
begin
  
        Multiplier_4bit0 : Multiplier_4bit_Ent port map(
          a => a(3 downto 0),
          b => b(3 downto 0),
          mult => m0 );

        Multiplier_4bit1 : Multiplier_4bit_Ent port map(
          a => a(3 downto 0),
          b => b(7 downto 4),
          mult => m1 );
          
        Multiplier_4bit2 : Multiplier_4bit_Ent port map(
          a => a(7 downto 4),
          b => b(3 downto 0),
          mult => m2 );
          
        Multiplier_4bit3 : Multiplier_4bit_Ent port map(
          a => a(7 downto 4),
          b => b(7 downto 4),
          mult => m3 );
          
          mult(3 downto 0) <= m0(3 downto 0);
          
        Carry_Look_Ahead_Adder_4bit0 : Carry_Look_Ahead_Adder_4bit_Ent port map(
          ia => m0(7 downto 4),
          ib => m1(3 downto 0),
          ic => '0',
          osum => sum(3 downto 0),
          oc => c(0) );
  
        Carry_Look_Ahead_Adder_4bit1 : Carry_Look_Ahead_Adder_4bit_Ent port map(
          ia => sum(3 downto 0),
          ib => m2(3 downto 0),
          ic => '0',
          osum => mult(7 downto 4),
          oc => c(1) );

        Carry_Look_Ahead_Adder_4bit2 : Carry_Look_Ahead_Adder_4bit_Ent port map(
          ia => m1(7 downto 4),
          ib => m2(7 downto 4),
          ic => c(0),
          osum => sum(7 downto 4),
          oc => c(2) );

        Carry_Look_Ahead_Adder_4bit3 : Carry_Look_Ahead_Adder_4bit_Ent port map(
          ia => sum(7 downto 4),
          ib => m3(3 downto 0),
          ic => c(1),
          osum => mult(11 downto 8),
          oc => c(3) );

          temp <= "000" & c(2);

        Carry_Look_Ahead_Adder_4bit4 : Carry_Look_Ahead_Adder_4bit_Ent port map(
          ia => m3(7 downto 4),
          ib => temp,
          --ib => "000" & c(2),
          ic => c(3),
          osum => mult(15 downto 12),
          oc => c(4) );
          
end architecture;
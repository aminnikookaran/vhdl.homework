library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Adder_100bit_Ent is 
            port (
                 ia : in std_logic_vector(99 downto 0);
                 ib : in std_logic_vector(99 downto 0);
                 ic : in std_logic;
                 osum : out std_logic_vector(99 downto 0);
                 oc : out std_logic                
                  );
end entity;

architecture Adder_100bit_Arch of Adder_100bit_Ent is 
  
  component Carry_Look_Ahead_Adder_Ent
    port(
      a : in std_logic_vector(9 downto 0);
      b : in std_logic_vector(9 downto 0);
      icarry : in std_logic;
      sum : out std_logic_vector(9 downto 0);
      ocarry : out std_logic 
      );
    end component;

  signal c : std_logic_vector(8 downto 0);
begin
      
        Carry_Look_Ahead_Adder0 : Carry_Look_Ahead_Adder_Ent port map(
          a => ia(9 downto 0),
          b => ib(9 downto 0),
          icarry => ic,
          sum => osum(9 downto 0),
          ocarry => c(0) );

        Carry_Look_Ahead_Adder1 : Carry_Look_Ahead_Adder_Ent port map(
          a => ia(19 downto 10),
          b => ib(19 downto 10),
          icarry => c(0),
          sum => osum(19 downto 10),
          ocarry => c(1) );
          
        Carry_Look_Ahead_Adder2 : Carry_Look_Ahead_Adder_Ent port map(
          a => ia(29 downto 20),
          b => ib(29 downto 20),
          icarry => c(1),
          sum => osum(29 downto 20),
          ocarry => c(2) );
          
        Carry_Look_Ahead_Adder3 : Carry_Look_Ahead_Adder_Ent port map(
          a => ia(39 downto 30),
          b => ib(39 downto 30),
          icarry => c(2),
          sum => osum(39 downto 30),
          ocarry => c(3) );
          
        Carry_Look_Ahead_Adder4 : Carry_Look_Ahead_Adder_Ent port map(
          a => ia(49 downto 40),
          b => ib(49 downto 40),
          icarry => c(3),
          sum => osum(49 downto 40),
          ocarry => c(4) );
          
        Carry_Look_Ahead_Adder5 : Carry_Look_Ahead_Adder_Ent port map(
          a => ia(59 downto 50),
          b => ib(59 downto 50),
          icarry => c(4),
          sum => osum(59 downto 50),
          ocarry => c(5) );

        Carry_Look_Ahead_Adder6 : Carry_Look_Ahead_Adder_Ent port map(
          a => ia(69 downto 60),
          b => ib(69 downto 60),
          icarry => c(5),
          sum => osum(69 downto 60),
          ocarry => c(6) );

        Carry_Look_Ahead_Adder7 : Carry_Look_Ahead_Adder_Ent port map(
          a => ia(79 downto 70),
          b => ib(79 downto 70),
          icarry => c(6),
          sum => osum(79 downto 70),
          ocarry => c(7) );

        Carry_Look_Ahead_Adder8 : Carry_Look_Ahead_Adder_Ent port map(
          a => ia(89 downto 80),
          b => ib(89 downto 80),
          icarry => c(7),
          sum => osum(89 downto 80),
          ocarry => c(8) );

        Carry_Look_Ahead_Adder9 : Carry_Look_Ahead_Adder_Ent port map(
          a => ia(99 downto 90),
          b => ib(99 downto 90),
          icarry => c(8),
          sum => osum(99 downto 90),
          ocarry => oc );

end architecture;
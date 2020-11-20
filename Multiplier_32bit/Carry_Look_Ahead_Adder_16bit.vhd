library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Carry_Look_Ahead_Adder_16bit_Ent is 
            port (
                 ia : in std_logic_vector(15 downto 0);
                 ib : in std_logic_vector(15 downto 0);
                 ic : in std_logic;
                 osum : out std_logic_vector(15 downto 0);
                 oc : out std_logic                
                  );
end entity;

architecture Carry_Look_Ahead_Adder_16bit_Arch of Carry_Look_Ahead_Adder_16bit_Ent is 

component Carry_Look_Ahead_Adder_8bit_Ent
    port(
      ia : in std_logic_vector(7 downto 0);
      ib : in std_logic_vector(7 downto 0);
      ic : in std_logic;
      osum : out std_logic_vector(7 downto 0);
      oc : out std_logic
      );
    end component;

  signal c : std_logic;
begin
 
         Carry_Look_Ahead_Adder_8bit0 : Carry_Look_Ahead_Adder_8bit_Ent port map(
          ia => ia(7 downto 0),
          ib => ib(7 downto 0),
          ic => ic,
          osum => osum(7 downto 0),
          oc => c );
   
         Carry_Look_Ahead_Adder_8bit1 : Carry_Look_Ahead_Adder_8bit_Ent port map(
          ia => ia(15 downto 8),
          ib => ib(15 downto 8),
          ic => c,
          osum => osum(15 downto 8),
          oc => oc );

end architecture;
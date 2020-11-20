library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Encoder_4x7bit_Ent is 
  port (
    iclk : in std_logic;
    idata : in std_logic_vector(3 downto 0);
    ocode : out std_logic_vector(6 downto 0)
  );
end entity;

architecture Encoder_4x7bit_Arch of Encoder_4x7bit_Ent is

  signal code : std_logic_vector(6 downto 0);
  
  begin

    with idata select
      code <= "0000000" when "0000",
              "0000111" when "0001",
              "0011001" when "0010",
              "0011110" when "0011",
              "0101010" when "0100",
              "0101101" when "0101",
              "0110011" when "0110",
              "0110100" when "0111",
              "1001011" when "1000",
              "1001100" when "1001",
              "1010010" when "1010",
              "1010101" when "1011",
              "1100001" when "1100",
              "1100110" when "1101",
              "1111000" when "1110",
              "1111111" when "1111",
              "XXXXXXX" when others;
    
    process (iclk)
      begin
        if rising_edge(iclk) then
          ocode <= code;
        end if;
    end process;
    
end architecture;
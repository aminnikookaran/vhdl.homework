library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Decoder_7x4bit_Ent is 
  port (
    iclk : in std_logic;
    icode : in std_logic_vector(6 downto 0);
    oerror : out std_logic;
    odata : out std_logic_vector(3 downto 0)
  );
end entity;

architecture Decoder_7x4bit_Arch of Decoder_7x4bit_Ent is
  
  signal code : std_logic_vector(6 downto 0);
  signal z : std_logic_vector(2 downto 0);-- := std_logic_vector(to_unsigned(0,3));
  signal z1 : std_logic_vector(6 downto 0);-- := std_logic_vector(to_unsigned(0,7));
  signal z2 : std_logic_vector(6 downto 0);-- := std_logic_vector(to_unsigned(0,7));
  signal z3 : std_logic_vector(6 downto 0);-- := std_logic_vector(to_unsigned(0,7));
  signal r : std_logic_vector(6 downto 0);-- := std_logic_vector(to_unsigned(0,7));
  
  begin
    
    process (iclk)
      begin
        if rising_edge(iclk) then
          code <= icode;
        end if;
    end process;
    
    z1 <= "1010101" and code;
    z2 <= "1100110" and code;
    z3 <= "1111000" and code;
    
    z(0) <= ((z1(0) xor z1(1)) xor (z1(2) xor z1(3))) xor (z1(4) xor z1(5)) xor z1(6);
    z(1) <= ((z2(0) xor z2(1)) xor (z2(2) xor z2(3))) xor (z2(4) xor z2(5)) xor z2(6);
    z(2) <= ((z3(0) xor z3(1)) xor (z3(2) xor z3(3))) xor (z3(4) xor z3(5)) xor z3(6);
    
    with z select
      r <= code when "000",
           (code(6 downto 1) & (not code(0))) when "001",
           (code(6 downto 2) & (not code(1)) & code(0)) when "010",
           (code(6 downto 3) & (not code(2)) & code(1 downto 0)) when "011",
           (code(6 downto 4) & (not code(3)) & code(2 downto 0)) when "100",
           (code(6 downto 5) & (not code(4)) & code(3 downto 0)) when "101",
           (code(6) & (not code(5)) & code(4 downto 0)) when "110",
           ((not code(6)) & code(5 downto 0)) when "111",
           "XXXXXXX" when others;
    
    with z select
      oerror <= '0' when "000",
                '1' when "001"|"010"|"011"|"100"|"101"|"110"|"111",
                'X' when others;
    
    odata <= r(6 downto 4) & r(2);
    
end architecture;
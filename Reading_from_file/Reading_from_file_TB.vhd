library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use std.textio.all;
use ieee.numeric_std.all;

entity Arithmetic_Encoder_TB_Ent is
end entity;

architecture Arithmetic_Encoder_TB_Arch of Arithmetic_Encoder_TB_Ent is

  function to_hex(c: character) return std_logic_vector is
    variable result : std_logic_vector(3 downto 0);
    begin
      if (c = '0') then result := X"0";
      elsif (c = '1') then result := X"1";
      elsif (c = '2') then result := X"2";
      elsif (c = '3') then result := X"3";
      elsif (c = '4') then result := X"4";
      elsif (c = '5') then result := X"5";
      elsif (c = '6') then result := X"6";
      elsif (c = '7') then result := X"7";
      elsif (c = '8') then result := X"8";
      elsif (c = '9') then result := X"9";
      elsif (c = 'A') then result := X"A";
      elsif (c = 'B') then result := X"B";
      elsif (c = 'C') then result := X"C";
      elsif (c = 'D') then result := X"D";
      elsif (c = 'E') then result := X"E";
      else result := X"F"; end if;
      return result;
    end to_hex;

  signal iclk : std_logic := '0';
  signal wen : std_logic := '0';
  signal write : std_logic_vector(15 downto 0) := X"0000";

  begin
    
    iclk <= not iclk after 1 ns;
    wen <= '1' after 4 ns;
      
    process
      variable inline : line;
      variable a1 ,a2 ,a3 ,a4 : character;
      variable end_of_line : boolean := true;
      file myfile : text is "data.txt";
      
      begin
          wait until rising_edge(wen);
          if not endfile(myfile) then
            readline(myfile,inline);
            while end_of_line loop
              read(inline,a1,end_of_line);
              read(inline,a2,end_of_line);
              read(inline,a3,end_of_line);
              read(inline,a4,end_of_line);
              wait until rising_edge(iclk);
              write <= to_hex(a1) & to_hex(a2) & to_hex(a3) & to_hex(a4);
            end loop;
          end if;
      end process;

end architecture;

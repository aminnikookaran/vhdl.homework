library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use std.textio.all;
use ieee.numeric_std.all;

entity Arithmetic_Encoder_TB_Ent is
end entity;

architecture Arithmetic_Encoder_TB_Arch of Arithmetic_Encoder_TB_Ent is

  function char_to_hex(c: character) return std_logic_vector is
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
    end char_to_hex;

  function hex_to_char(s: std_logic_vector) return character is
    variable result : character;
    begin
      if (s = X"0") then result := '0';
      elsif (s = X"1") then result := '1';
      elsif (s = X"2") then result := '2';
      elsif (s = X"3") then result := '3';
      elsif (s = X"4") then result := '4';
      elsif (s = X"5") then result := '5';
      elsif (s = X"6") then result := '6';
      elsif (s = X"7") then result := '7';
      elsif (s = X"8") then result := '8';
      elsif (s = X"9") then result := '9';
      elsif (s = X"A") then result := 'A';
      elsif (s = X"B") then result := 'B';
      elsif (s = X"C") then result := 'C';
      elsif (s = X"D") then result := 'D';
      elsif (s = X"E") then result := 'E';
      else result := 'F'; end if;
      return result;
    end hex_to_char;

  component Arithmetic_Encoder_TL_Ent is
    port(
      iclk : in std_logic;
      irst : in std_logic;
      idata : in std_logic_vector(7 downto 0);
      ocode : out std_logic_vector(7 downto 0);
      odv : out std_logic;
      oend : out std_logic
    );
  end component;

  signal iclk : std_logic := '0';
  signal irst : std_logic;
  signal idata : std_logic_vector(7 downto 0);
  signal ocode : std_logic_vector(7 downto 0);
  signal odv : std_logic;
  signal oend : std_logic;
  
  begin

    AE_TL : Arithmetic_Encoder_TL_Ent port map (
      iclk => iclk,
      irst => irst,
      idata => idata,
      ocode => ocode,
      odv => odv,
      oend => oend
    );

    iclk <= not iclk after 1 ns;
    irst <= '1', '0' after 2 ns;

    process --read process
      variable dataline : line;
      variable c1, c2 : character;
      variable end_of_line : boolean := true;
      file datafile : text is in "data.txt";
      
      begin
        wait until falling_edge(irst);
        readline(datafile,dataline);
        while end_of_line loop
          read(dataline, c1, end_of_line);
          read(dataline, c2, end_of_line);
          idata <= char_to_hex(c1) & char_to_hex(c2);
          wait until rising_edge(iclk);
        end loop;
      end process;

    process --write process
      variable codeline : line;
      variable c1, c2 : character;
      variable end_of_line : boolean := true;
      file codefile : text is out "code.txt";
      
      begin
          wait until falling_edge(odv);
          c1 := hex_to_char(ocode(7 downto 4));
          c2 := hex_to_char(ocode(3 downto 0));
          write(codeline, c1);
          write(codeline, c2);
          if (oend = '1') then
            writeline(codefile, codeline);
          end if;
      end process;

end architecture;
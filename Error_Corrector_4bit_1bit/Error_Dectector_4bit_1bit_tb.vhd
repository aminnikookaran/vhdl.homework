library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity tb_Error_Detector_4bit_1bit_Ent is
end entity ;

architecture tb_Error_Detector_4bit_1bit_Arch of tb_Error_Detector_4bit_1bit_Ent is

component Encoder_4x7bit_Ent is
  port(
    iclk : in std_logic;
    idata : in std_logic_vector(3 downto 0);
    ocode : out std_logic_vector(6 downto 0)
  );
end component ;

component Decoder_7x4bit_Ent is
  port(
    iclk : in std_logic;
    icode : in std_logic_vector(6 downto 0);
    oerror : out std_logic;
    odata : out std_logic_vector(3 downto 0)
  );
end component ;

component LFSR_4bit_Ent is
  port(
    iclk : in std_logic;
    odata : out std_logic_vector(3 downto 0)
  );
end component ;

  signal iclka : std_logic := '0';
  signal idata : std_logic_vector(3 downto 0) := "0000";
  signal ocode : std_logic_vector(6 downto 0);
    
  signal iclkb : std_logic := '1';
  signal icode : std_logic_vector(6 downto 0) := "0000000";
  signal oerror : std_logic;
  signal odata : std_logic_vector(3 downto 0);
  
  signal iclkc : std_logic := '0';
  signal olfsr : std_logic_vector(3 downto 0);
  
begin
  
  Encoder : Encoder_4x7bit_Ent port map (
    iclk => iclka,
    idata => idata,
    ocode => ocode
  );
  
  Decoder : Decoder_7x4bit_Ent port map (
    iclk => iclkb,
    icode => icode,
    oerror => oerror,
    odata => odata
  );

  LFSR : LFSR_4bit_Ent port map (
    iclk => iclkc,
    odata => olfsr
  );

  iclka <= not iclka after 5 ns;
  iclkb <= not iclkb after 5 ns;
  iclkc <= not iclkc after 1 ns;
  
  with olfsr select
    icode <= (ocode(6 downto 1) & (not ocode(0))) when "0001",
             (ocode(6 downto 2) & (not ocode(1)) & ocode(0)) when "0010",
             (ocode(6 downto 3) & (not ocode(2)) & ocode(1 downto 0)) when "0011",
             (ocode(6 downto 4) & (not ocode(3)) & ocode(2 downto 0)) when "0100",
             (ocode(6 downto 5) & (not ocode(4)) & ocode(3 downto 0)) when "0101",
             (ocode(6) & (not ocode(5)) & ocode(4 downto 0)) when "0110",
             ((not ocode(6)) & ocode(5 downto 0)) when "0111",
             ocode when others;
  
  idata <= X"0",
           X"1" after 14 ns,
           X"2" after 24 ns,
           X"3" after 34 ns,
           X"4" after 44 ns,
           X"6" after 54 ns,
           X"7" after 64 ns,
           X"8" after 74 ns,
           X"9" after 84 ns,
           X"a" after 94 ns,
           X"b" after 104 ns,
           X"c" after 114 ns,
           X"d" after 124 ns,
           X"e" after 134 ns,
           X"f" after 144 ns;

end architecture ;
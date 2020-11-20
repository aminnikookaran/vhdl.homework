library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity ROM_256x8bit_MD_Ent is 
  port (
    iclk : in std_logic;
    iaddr : in std_logic_vector(7 downto 0);
    odata : out std_logic_vector(7 downto 0)
  );
end entity;

architecture ROM_256x8bit_MD_Arch of ROM_256x8bit_MD_Ent is

  type Mem is array(255 downto 0) of std_logic_vector(7 downto 0);
  signal rom : mem;

  begin

    rom <= (0|4|8 => X"00",
            1|5|9 => X"01",
            2|6|10 => X"02",
            3|7|11 => X"03",
            others => X"FF");
    odata <= rom(conv_integer(iaddr));

end architecture;
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Rom_16x8bit_MD_Ent is 
  port (
    iaddr : in std_logic_vector(3 downto 0);
    odata : out std_logic_vector(7 downto 0)
  );
end entity;

architecture Rom_16x8bit_MD_Arch of Rom_16x8bit_MD_Ent is

  type mem is array(15 downto 0) of std_logic_vector(7 downto 0);
  signal rom : mem;

  begin

  	rom <= (0 => X"30",
			1 => X"31",
			2 => X"32",
			3 => X"E9",
			4 => X"B7",
			5 => X"D3",
			6 => X"83",
			others => X"03");
	odata <= rom(conv_integer(iaddr));

end architecture;
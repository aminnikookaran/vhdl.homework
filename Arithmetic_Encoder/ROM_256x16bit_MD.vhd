library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity ROM_256x16bit_MD_Ent is 
  port (
    iclk : in std_logic;
    iload : in std_logic;
    iaddr : in std_logic_vector(7 downto 0);
    idata : in std_logic_vector(15 downto 0);
    odata : out std_logic_vector(15 downto 0)
  );
end entity;

architecture ROM_256x16bit_MD_Arch of ROM_256x16bit_MD_Ent is

  type Mem is array(255 downto 0) of std_logic_vector(15 downto 0);

  begin

    process(iclk)
      variable rom : mem;
      begin
        if (rising_edge(iclk)) then
          if (iload = '1') then
            rom(conv_integer(iaddr)) := idata;
          end if;
          odata <= rom(conv_integer(iaddr));
        end if;
	    end process;

end architecture;
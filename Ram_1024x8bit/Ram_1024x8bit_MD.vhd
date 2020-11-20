library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Ram_1024x8bit_Ent is 
  port (
    irst : in std_logic;
    irw : in std_logic;
    iadr : in std_logic_vector(9 downto 0);
    idata : in std_logic_vector(7 downto 0);
    ice : in std_logic;
    iclk : in std_logic;
    odata : out std_logic_vector(7 downto 0)
  );
end entity;

architecture Ram_1024x8bit_Arch of Ram_1024x8bit_Ent is
  type Mem is array(0 to 1023) of std_logic_vector(7 downto 0);
  begin
    process(iclk)
      variable ram : mem;
      begin
        if (rising_edge(iclk)) then
          if (irst = '1') then
            ram := (others => (others => '0'));
          else
            if (ice = '1') then
              if (irw = '1') then
                odata <= ram(conv_integer(iadr));
              else
                ram(conv_integer(iadr)) := idata;
                odata <= idata;
              end if;
            end if;
          end if;
        end if;
    end process;
  
end architecture;
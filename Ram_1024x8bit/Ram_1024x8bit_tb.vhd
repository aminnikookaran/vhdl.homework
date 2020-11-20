library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity tb_Ram_1024x8bit is 
end entity;

architecture tb_Ram_1024x8bit_Arch of tb_Ram_1024x8bit is 

component Ram_1024x8bit_Ent is 
  port (
    irst : in std_logic;
    irw : in std_logic;
    iadr : in std_logic_vector(9 downto 0);
    idata : in std_logic_vector(7 downto 0);
    ice : in std_logic;
    iclk : in std_logic;
    odata : out std_logic_vector(7 downto 0)
  );
end component;

    signal irst : std_logic := '0';
    signal irw : std_logic := '0';
    signal iadr : std_logic_vector(9 downto 0) := std_logic_vector(to_unsigned(0,10));
    signal idata : std_logic_vector(7 downto 0) := std_logic_vector(to_unsigned(0,8));
    signal ice : std_logic := '0';
    signal iclk : std_logic := '0';
    signal odata : std_logic_vector(7 downto 0);

begin
  
  UUT : Ram_1024x8bit_Ent port map  (
                 irst => irst,
                 irw => irw,
                 iadr => iadr,
                 idata => idata,
                 ice => ice,
                 iclk => iclk,
                 odata => odata
                  );

irst <= '1', '0' after 1 ns, '1' after 55 ns, '0' after 56 ns;
irw <= '0' , '1' after 40 ns;
iadr <= std_logic_vector(to_unsigned(1,10)) ,  std_logic_vector(to_unsigned(10,10)) after 9 ns , std_logic_vector(to_unsigned(52,10)) after 19 ns ,std_logic_vector(to_unsigned(70,10)) after 29 ns , std_logic_vector(to_unsigned(10,10))after 41 ns,  std_logic_vector(to_unsigned(70,10))after 51 ns, std_logic_vector(to_unsigned(10,10))after 61 ns;
idata <= std_logic_vector(to_unsigned(15,8)) , std_logic_vector(to_unsigned(42,8)) after 10 ns ,std_logic_vector(to_unsigned(81,8)) after 20 ns , std_logic_vector(to_unsigned(11,8)) after 30 ns ;
ice <= '1' , '0' after 29 ns , '1' after 33 ns ;
iclk <= not iclk after 1 ns;

end architecture;
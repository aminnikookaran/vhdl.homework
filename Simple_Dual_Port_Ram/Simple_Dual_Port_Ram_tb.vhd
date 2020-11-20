library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity tb_Simple_Dual_Port_Ram_1024x8bit is 
end entity;

architecture tb_Simple_Dual_Port_Ram_1024x8bit_Arch of tb_Simple_Dual_Port_Ram_1024x8bit is 

component Simple_Dual_Port_Ram_1024x8bit_Ent is 
  port (
    iwA : in std_logic;
    iadrA : in std_logic_vector(9 downto 0);
    iclkA : in std_logic;
    idataA : in std_logic_vector(7 downto 0);
    
    irB : in std_logic;
    iadrB : in std_logic_vector(9 downto 0);
    iclkB : in std_logic;
    odataB : out std_logic_vector(7 downto 0)
  );
end component;

    signal iwA : std_logic := '0';
    signal iadrA : std_logic_vector(9 downto 0) := std_logic_vector(to_unsigned(0,10));
    signal iclkA : std_logic := '0';
    signal idataA : std_logic_vector(7 downto 0) := std_logic_vector(to_unsigned(0,8));
    
    signal irB : std_logic := '0';
    signal iadrB : std_logic_vector(9 downto 0) := std_logic_vector(to_unsigned(0,10));
    signal iclkB : std_logic := '0';
    signal odataB : std_logic_vector(7 downto 0);

begin
  
  UUT : Simple_Dual_Port_Ram_1024x8bit_Ent port map  (
    iwA => iwA,
    iadrA => iadrA,
    iclkA => iclkA,
    idataA => idataA,
    irB => irB,
    iadrB => iadrB,
    iclkB => iclkB,
    odataB => odataB
  );

  iclkA <= not iclkA after 1 ns;
  iclkB <= not iclkB after 2 ns;

  iwA <= '1' after 0 ns, '0' after 2 ns;
  idataA <= std_logic_vector(to_unsigned(22,8)) after 0 ns;
  iadrA <= std_logic_vector(to_unsigned(555,10)) after 0 ns;
  
  irB <= '1' after 1 ns, '0' after 3 ns;
  iadrB <= std_logic_vector(to_unsigned(555,10)) after 1 ns;

end architecture;
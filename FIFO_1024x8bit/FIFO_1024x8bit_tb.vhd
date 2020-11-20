library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity tb_FIFO_1024x8bit is 
end entity;

architecture tb_FIFO_1024x8bit_Arch of tb_FIFO_1024x8bit is 

component FIFO_1024x8bit_Ent is 
  port (
    idata : in std_logic_vector(7 downto 0);
    iwen : in std_logic;
    iren : in std_logic;
    iwclk : in std_logic;
    irclk : in std_logic;
    irs : in std_logic;
    
    odata : out std_logic_vector(7 downto 0);
    owcount : out std_logic_vector(9 downto 0);
    orcount : out std_logic_vector(9 downto 0);
    oafull : out std_logic;
    oaempty : out std_logic;
    ofull : out std_logic;
    oempty : out std_logic
  );
end component;

    signal idata : std_logic_vector(7 downto 0) := std_logic_vector(to_unsigned(0,8));
    signal iwen : std_logic := '0';
    signal iren : std_logic := '0';
    signal iwclk : std_logic := '0';
    signal irclk : std_logic := '0';
    signal irs : std_logic := '1';
    
    signal odata : std_logic_vector(7 downto 0);
    signal owcount : std_logic_vector(9 downto 0);
    signal orcount : std_logic_vector(9 downto 0);
    signal oafull : std_logic;
    signal oaempty : std_logic;
    signal ofull : std_logic;
    signal oempty : std_logic;

begin
  
  UUT : FIFO_1024x8bit_Ent port map  (
    idata => idata,
    iwen => iwen,
    iren => iren,
    iwclk => iwclk,
    irclk => irclk,
    irs => irs,
    
    odata => odata,
    owcount => owcount,
    orcount => orcount,
    oafull => oafull,
    oaempty => oaempty,
    ofull => ofull,
    oempty => oempty
  );

  iwclk <= not iwclk after 1 ns;
  irclk <= not irclk after 2 ns;
  
  irs <= '0' after 3 ns;
  
  iwen <= '1' after 4 ns;--, '0' after 6 ns;
  idata <= std_logic_vector(to_unsigned(1,8)) after 4 ns;
  iren <= '1' after 5 ns;-- , '0' after 7 ns;
  
--  process
--    begin 
--      wait for 4 ns ;
--      for i in 0 to 1023 loop
--        idata <= std_logic_vector(to_unsigned(i,8)) ;
--        wait for 2 ns ;
--      end loop ;
--      iwen <= '0';
--      iren <= '1';
--  end process ;

end architecture;
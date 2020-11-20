library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity FIFO_1024x8bit_Ent is 
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
end entity;

architecture FIFO_1024x8bit_Arch of FIFO_1024x8bit_Ent is
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
  
  component Counter_11bit_Ent
    port(
    ien : in std_logic;
    irs : in std_logic;
    iclk : in std_logic;
    odata : out std_logic_vector(10 downto 0)
    );
  end component;
  
  signal readadr : std_logic_vector(10 downto 0) := std_logic_vector(to_unsigned(0,11));
  signal writeadr : std_logic_vector(10 downto 0) := std_logic_vector(to_unsigned(0,11));
  signal count : std_logic_vector(10 downto 0) := std_logic_vector(to_unsigned(0,11));
  
  begin
                 
    Read_Address : Counter_11bit_Ent port map(
      ien => iren,
      irs => irs,
      iclk => irclk,
      odata => readadr
    );
           
    Write_Address : Counter_11bit_Ent port map(
      ien => iwen,
      irs => irs,
      iclk => iwclk,
      odata => writeadr
    );
    
    FIFO : Simple_Dual_Port_Ram_1024x8bit_Ent port map(
      iwA => iwen,
      iadrA => writeadr(9 downto 0),
      iclkA => iwclk,
      idataA => idata,
      
      irB => iren,
      iadrB => readadr(9 downto 0),
      iclkB => irclk,
      odataB => odata
    );
    
    count <= writeadr - readadr;
    
    oaempty <= '1' when (count = 1) else
               '0';
    oafull <= '1' when (count = 1023) else
              '0';
    oempty <= '1' when (count = 0) else
              '0';
    ofull <= '1' when (count = 1024) else
             '0';
    
    process (irclk,irs)
      begin
      	if (irs = '1') then
      	  orcount <= std_logic_vector(to_unsigned(0,10));
        elsif rising_edge(irclk) then
          if (iren = '1') then
            orcount <= count(9 downto 0) - 1;
          else
            orcount <= count(9 downto 0);
          end if;
        end if;
    end process;

    process (iwclk,irs)
      begin
      	if (irs = '1') then
      	  owcount <= std_logic_vector(to_unsigned(0,10));
        elsif rising_edge(iwclk) then
          if (iwen = '1') then
            owcount <= count(9 downto 0) + 1;
          else
            owcount <= count(9 downto 0);
          end if;
        end if;
    end process;
    
end architecture;
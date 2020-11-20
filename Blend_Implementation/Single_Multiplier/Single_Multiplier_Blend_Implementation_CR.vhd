library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Single_Multiplier_Blend_Implementation_CR_Ent is
  port (
    clk : in std_logic;
    rst : in std_logic;
    msel : out std_logic;
    ld : out std_logic_vector(2 downto 0)
  );
end entity;

architecture Single_Multiplier_Blend_Implementation_CR_Arch of Single_Multiplier_Blend_Implementation_CR_Ent is
  
  signal state : std_logic_vector(1 downto 0);

  begin
    
    process (clk)
      begin
        if rising_edge(clk) then
          if (rst = '1') then
            state <= "00";
            msel <= '0';
            ld <= "000" ;
            
          elsif (state = "00") then
            state <= "01";
            msel <= '0';
            ld <= "001" ;

          elsif (state = "01") then
            state <= "10";
            msel <= '1';
            ld <= "010" ;

          elsif (state = "10") then
            state <= "00";
            msel <= '0';
            ld <= "100" ;

          end if;
        end if;
    end process;
    
end architecture;
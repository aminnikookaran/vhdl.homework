library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Shared_Input_Bus_Blend_Implementation_CR_Ent is
  port (
    clk : in std_logic;
    rst : in std_logic;
    irdy : in std_logic;
    msel : out std_logic;
    ld : out std_logic_vector(3 downto 0);
    ordy : out std_logic
  );
end entity;

architecture Shared_Input_Bus_Blend_Implementation_CR_Arch of Shared_Input_Bus_Blend_Implementation_CR_Ent is
  
  signal state : std_logic_vector(1 downto 0);
  signal rdy : std_logic;

  begin
    
    process (clk)
      begin
        if rising_edge(clk) then
          if (rst = '1') then
            state <= "00";
            msel <= '0';
            ld <= X"0" ;
            rdy <= '0';
            
          elsif (state = "00") then
            if (irdy = '0') then
              state <= "00";
            else
              state <= "01";
            end if;
            msel <= '0';
            ld <= X"F" ;
            rdy <= '0';

          elsif (state = "01") then
            state <= "10";
            msel <= '0';
            ld <= X"1" ;
            rdy <= '0';

          elsif (state = "10") then
            state <= "11";
            msel <= '1';
            ld <= X"2" ;
            rdy <= '0';

          elsif (state = "11") then
            state <= "00";
            msel <= '0';
            ld <= X"4" ;
            rdy <= '1';

          end if;
        end if;
    end process;
    
    process (clk)
      begin
        if rising_edge(clk) then
          ordy <= rdy;
        end if;
    end process;
    
end architecture;
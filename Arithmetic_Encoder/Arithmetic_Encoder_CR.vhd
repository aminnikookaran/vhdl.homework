library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Arithmetic_Encoder_CR_Ent is 
  port (
    iclk : in std_logic;
    irst : in std_logic;
    itrnge : in std_logic_vector(7 downto 0);
    idata : in std_logic_vector(7 downto 0);
    iladdr : in std_logic_vector(7 downto 0);
    olrrom : out std_logic;
    olmrnge : out std_logic;
    olreg : out std_logic;
    osele : out std_logic;
    odv : out std_logic;
    oend : out std_logic
  );
end entity;

architecture Arithmetic_Encoder_CR_Arch of Arithmetic_Encoder_CR_Ent is

  signal state : std_logic_vector(2 downto 0);

  begin

    process (iclk ,irst)
      begin
        if (irst = '1') then
          state <= "000"; --reset
          olrrom <= '0';
          olmrnge <= '0';
          olreg <= '0';
          osele <= '0';
          odv <= '0';
          oend <= '0';
          
        elsif rising_edge(iclk) then
          olrrom <= '0';
          olmrnge <= '0';
          olreg <= '0';
          osele <= '0';
          odv <= '0';
          oend <= '0';
        
          if (state = "000") then --rom load
            state <= "001";
            olrrom <= '1';
            
          elsif (state = "001") then
            if iladdr = X"FF" then --finished loading rom
              state <= "010";
              olmrnge <= '1';
            else --not finished loading rom
              state <= "000";
            end if;
            
          elsif (state = "010") then --wait state for data comming out of rom
            state <= "011";
            
          elsif (state = "011") then --wait state for data entering last_data reg
            state <= "100";
            olreg <= '1';
            
          elsif (state = "100") then --wait state for data entering last_data reg
            state <= "101";
            olreg <= '1';

          elsif (state = "101") then
            olreg <= '1';
            if (idata = X"FF") then --data finished
              state <= "110";
            else
              state <= "101";
            end if;
            
            if (not (itrnge = X"00")) then --byte of code calculating...
              osele <= '1';
            end if;
            
            if ((itrnge = X"00") and (idata < X"FF")) then --byte of code ready start another
              odv <= '1';
            end if;
            
          elsif (state = "110") then --wait state for odv
            state <= "111";
            odv <= '1';
            oend <= '1';
            
          else --final state
            state <= "111";
            oend <= '1';
          end if;
        end if;
      end process;

end architecture;
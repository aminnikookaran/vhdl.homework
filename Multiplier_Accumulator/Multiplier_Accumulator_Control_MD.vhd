library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Multiplier_Accumulator_Control_Ent is 
  port (
    iclk : in std_logic;
    ice : in std_logic;
    idataR : in std_logic;
    imaxval : in std_logic_vector(7 downto 0);
    odataV : out std_logic;
    omc : out std_logic_vector(1 downto 0);
    oce : out std_logic
  );
end entity;

architecture Multiplier_Accumulator_Control_Arch of Multiplier_Accumulator_Control_Ent is
  
  signal count : std_logic_vector(7 downto 0) := X"00";
  signal maxval : std_logic_vector(7 downto 0) := X"00";
  signal datavalid : std_logic := '0';
  
  begin
    
    process (iclk,idataR)
      begin
        if (idataR = '0') then
          datavalid <= '0';
          count <= X"00";
        elsif rising_edge(iclk) then
          if (ice = '1') then
            if (count = maxval) then
              datavalid <= '1';
            else
              count <= count + 1;
            end if;
          end if;
        end if;
    end process;
    
    process (idataR)
      begin
        if rising_edge(idataR) then
          maxval <= imaxval;
        end if;
    end process;
    
    odataV <= datavalid;
    oce <= ice and (not datavalid);
    omc(0) <= '1' when (count = X"00") else '0';
    omc(1) <= '1' when (count = maxval) else '0';
    
end architecture;
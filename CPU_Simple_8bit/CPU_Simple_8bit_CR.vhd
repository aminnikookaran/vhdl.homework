library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity CPU_Simple_8bit_CR_Ent is 
  port (
    iclk : in std_logic;
    irst : in std_logic;
    ictrl : in std_logic_vector(6 downto 0);
    oload : out std_logic_vector(9 downto 0);
    osele : out std_logic_vector(1 downto 0)
  );
end entity;

architecture CPU_Simple_8bit_CR_Arch of CPU_Simple_8bit_CR_Ent is

  signal state : std_logic_vector(1 downto 0);

  begin

    process (iclk) --state
      begin
        if falling_edge(iclk) then
          if (irst = '1') then --reset
            state <= "00";

          elsif (state = "00") then --reset
            state <= "01";

          elsif (state = "01") then  --fetch/decode
            if (ictrl(5 downto 2) = X"0") then
              state <= "01";
            elsif (ictrl(5 downto 4) = "11") then
              state <= "10";
            else
              state <= "11";
            end if;

          elsif (state = "10") then --run
            state <= "11";

          elsif (state = "11") then --run2
            state <= "01";

          end if;
        end if;
    end process;

    process (iclk) --osele(0)
      begin
        if falling_edge(iclk) then
          if state = "01" then
            if ictrl(5 downto 4) = "10" and
               ((ictrl(3 downto 2) = "00") or
               (ictrl(3) = '1' and (ictrl(2) = ictrl(6)))) then
              osele(0) <= '1';
            else
              osele(0) <= '0';
            end if;
          else
            osele(0) <= '0';
        end if;
      end if;
    end process;

    process (iclk) --osele(1)
      begin
        if falling_edge(iclk) then
          if state = "01" then
            if ictrl(5 downto 2) = X"3" then
              osele(1) <= '1';
            else
              osele(1) <= '0';
            end if;
          else
            osele(1) <= '0';
          end if;
        end if;
    end process;

    process (iclk)
      begin
        if falling_edge(iclk) then
          if (irst = '1') then --reset
            oload <= "00" & X"00";

          elsif (state = "00") then --reset
            oload <= "00" & X"20";

          elsif (state = "01") then --fetch/decode

            if (ictrl(5 downto 4) = "00") then --in/out
              if (ictrl(3 downto 2) = "00") then --out
                oload <= "01" & X"00";

              elsif (ictrl(3 downto 2) = "11") then --in
                if (ictrl(1 downto 0) = "00") then
                  oload <= "00" & X"03";
                elsif (ictrl(1 downto 0) = "01") then
                  oload <= "00" & X"05";
                elsif (ictrl(1 downto 0) = "10") then
                  oload <= "00" & X"09";
                else
                  oload <= "00" & X"11";
                end if;
              end if;

            elsif (ictrl(5 downto 4) = "10") then --branch
              oload <=  "00" & X"01";

            elsif (ictrl(5 downto 4) = "11") then --arithmetic
              oload <= "00" & X"C0";
            end if;

          elsif (state = "10") then --run
            if (ictrl(1 downto 0) = "00") then
              oload <= "10" & X"03";
            elsif (ictrl(1 downto 0) = "01") then
              oload <= "10" & X"05";
            elsif (ictrl(1 downto 0) = "10") then
              oload <= "10" & X"09";
            else
              oload <= "10" & X"11";
            end if;

          elsif (state = "11") then --run2
            oload <= "00" & X"20";

          end if;
        end if;
    end process;

end architecture;
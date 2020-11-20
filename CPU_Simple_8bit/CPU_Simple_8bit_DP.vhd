library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity CPU_Simple_8bit_DP_Ent is 
  port (
    iclk : in std_logic;
    irst : in std_logic;
    iload : in std_logic_vector(9 downto 0);
    isele : in std_logic_vector(1 downto 0);
    iswch : in std_logic_vector(3 downto 0);
    octrl : out std_logic_vector(6 downto 0);
    o7seg : out std_logic_vector(3 downto 0)
  );
end entity;

architecture CPU_Simple_8bit_DP_Arch of CPU_Simple_8bit_DP_Ent is

  component Register_4bit_MD_Ent is
    port (
      iclk : in std_logic;
      irst : in std_logic;
      ice : in std_logic;
      idata : in std_logic_vector(3 downto 0);
      odata : out std_logic_vector(3 downto 0)
    );
  end component;

  component Rom_16x8bit_MD_Ent is
    port (
      iaddr : in std_logic_vector(3 downto 0);
      odata : out std_logic_vector(7 downto 0)
    );
  end component;

  signal ireg : std_logic_vector(3 downto 0);
  signal iPC : std_logic_vector(3 downto 0);
  signal iIR : std_logic_vector(7 downto 0);
  signal isrc : std_logic_vector(3 downto 0);
  signal idst : std_logic_vector(3 downto 0);
  signal alu : std_logic_vector(4 downto 0);
  signal c : std_logic;
  
  signal oR1 : std_logic_vector(3 downto 0);
  signal oR2 : std_logic_vector(3 downto 0);
  signal oR3 : std_logic_vector(3 downto 0);
  signal oR4 : std_logic_vector(3 downto 0);
  signal oPC : std_logic_vector(3 downto 0);
  signal oIR : std_logic_vector(7 downto 0);
  signal osrc : std_logic_vector(3 downto 0);
  signal odst : std_logic_vector(3 downto 0);

  begin
    
  R1 : Register_4bit_MD_Ent port map (
    iclk => iclk,
    irst => irst,
    ice => iload(1),
    idata => ireg,
    odata => oR1
  );

  R2 : Register_4bit_MD_Ent port map (
    iclk => iclk,
    irst => irst,
    ice => iload(2),
    idata => ireg,
    odata => oR2
  );

  R3 : Register_4bit_MD_Ent port map (
    iclk => iclk,
    irst => irst,
    ice => iload(3),
    idata => ireg,
    odata => oR3
  );

  R4 : Register_4bit_MD_Ent port map (
    iclk => iclk,
    irst => irst,
    ice => iload(4),
    idata => ireg,
    odata => oR4
  );

  IR1 : Register_4bit_MD_Ent port map (
    iclk => iclk,
    irst => irst,
    ice => iload(5),
    idata => iIR(3 downto 0),
    odata => oIR(3 downto 0)
  );

  IR2 : Register_4bit_MD_Ent port map (
    iclk => iclk,
    irst => irst,
    ice => iload(5),
    idata => iIR(7 downto 4),
    odata => oIR(7 downto 4)
  );

  PC : Register_4bit_MD_Ent port map (
    iclk => iclk,
    irst => irst,
    ice => iload(0),
    idata => iPC,
    odata => oPC
  );

  SRC : Register_4bit_MD_Ent port map (
    iclk => iclk,
    irst => irst,
    ice => iload(6),
    idata => isrc,
    odata => osrc
  );

  DST : Register_4bit_MD_Ent port map (
    iclk => iclk,
    irst => irst,
    ice => iload(7),
    idata => idst,
    odata => odst
  );

  SEVEN_SEG : Register_4bit_MD_Ent port map (
    iclk => iclk,
    irst => irst,
    ice => iload(8),
    idata => idst,
    odata => o7seg
  );

  ROM : Rom_16x8bit_MD_Ent port map (
    iaddr => oPC,
    odata => iIR
  );
  
  octrl <= c & oIR(7 downto 4) & oIR(1 downto 0);
  iPC <= (oPC + 1) when isele(0) = '0' else
         oIR(3 downto 0);
  isrc <= oR1 when oIR(3 downto 2) = "00" else
          oR2 when oIR(3 downto 2) = "01" else
          oR3 when oIR(3 downto 2) = "10" else
          oR4;
  idst <= oR1 when oIR(1 downto 0) = "00" else
          oR2 when oIR(1 downto 0) = "01" else
          oR3 when oIR(1 downto 0) = "10" else
          oR4;
  alu <= (('0' & osrc) + ('0' & odst) + ("0000" & c)) when oIR(5 downto 4) = "01" else
         (('0' & odst) + ("0000" & c) - ('0' & osrc)) when oIR(5 downto 4) = "10" else
         (('0' & osrc) + ("0000" & c));  
  ireg <= alu(3 downto 0) when isele(1) = '0' else
          iswch;

    process (iclk)
      begin
        if rising_edge(iclk) then
          if (irst = '1') then
            c <= '0';
          elsif (iload(9) = '1')  then
            c <= alu(4);
          end if;
        end if;
    end process;

end architecture;
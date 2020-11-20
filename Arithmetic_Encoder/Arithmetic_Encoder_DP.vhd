library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Arithmetic_Encoder_DP_Ent is 
  port (
    iclk : in std_logic;
    irst : in std_logic;
    isele : in std_logic;
    ilrrom : in std_logic;
    ilmrnge : in std_logic;
    ilreg : in std_logic;
    idata : in std_logic_vector(7 downto 0);    
    oladdr : out std_logic_vector(7 downto 0);
    otrnge : out std_logic_vector(7 downto 0);
    odata: out std_logic_vector(7 downto 0);
    ocode : out std_logic_vector(7 downto 0)
  );
end entity;

architecture Arithmetic_Encoder_DP_Arch of Arithmetic_Encoder_DP_Ent is

  component ROM_256x16bit_MD_Ent is 
    port (
      iclk : in std_logic;
      iload : in std_logic;
      iaddr : in std_logic_vector(7 downto 0);
      idata : in std_logic_vector(15 downto 0);
      odata : out std_logic_vector(15 downto 0)
    );
  end component;

  component Flip_Flop_8bit_MD_Ent is
    port (
      iclk : in std_logic;
      idata : in std_logic_vector(7 downto 0);
      odata : out std_logic_vector(7 downto 0)
    );
  end component;

  component Register_8bit_MD_Ent is
    port (
      iclk : in std_logic;
      irst : in std_logic;
      iload : in std_logic;
      idata : in std_logic_vector(7 downto 0);
      odata : out std_logic_vector(7 downto 0)
    );
  end component;

  signal oldata : std_logic_vector(7 downto 0);
  signal orlow : std_logic_vector(7 downto 0);
  signal orhigh : std_logic_vector(7 downto 0);
  
  signal ollow : std_logic_vector(7 downto 0);
  signal omrnge : std_logic_vector(7 downto 0);

  signal ilow : std_logic_vector(7 downto 0);
  signal olow : std_logic_vector(7 downto 0);

  signal ihigh : std_logic_vector(7 downto 0);
  signal laddr : std_logic_vector(7 downto 0);

  signal arrom : std_logic_vector(7 downto 0);
  signal irrom : std_logic_vector(15 downto 0);
  signal orrom : std_logic_vector(15 downto 0);

  signal irnge : std_logic_vector(7 downto 0);
  signal ornge : std_logic_vector(7 downto 0);

  signal prnge : std_logic_vector(7 downto 0);
  signal plow : std_logic_vector(7 downto 0);

  signal mult_low : std_logic_vector(15 downto 0);
  signal mult_high : std_logic_vector(15 downto 0);
  signal mult_min : std_logic_vector(15 downto 0);

  signal add_low : std_logic_vector(7 downto 0);
  signal add_high : std_logic_vector(7 downto 0);

  signal itrnge : std_logic_vector(7 downto 0);

  begin

    region_rom : ROM_256x16bit_MD_Ent port map (
      iclk => iclk,
      iload => ilrrom,
      iaddr => arrom,
      idata => irrom,
      odata => orrom
    );
    
    irrom <= oldata & idata;
    arrom <= laddr when (ilrrom = '1') else idata;
    oladdr <= laddr;
    
    process (iclk,irst)
      begin
        if (irst = '1') then
          laddr <= X"00";
        elsif rising_edge(iclk) then
          if (ilrrom = '1') then
            laddr <= laddr + 1;
          end if;
        end if;
      end process;

    last_data : Register_8bit_MD_Ent port map (
      iclk => iclk,
      irst => irst,
      iload => '1',
      idata => idata,
      odata => oldata
    );

    rom_low : Register_8bit_MD_Ent port map (
      iclk => iclk,
      irst => irst,
      iload => ilreg,
      idata => orrom(7 downto 0),
      odata => orlow
    );

    rom_high : Register_8bit_MD_Ent port map (
      iclk => iclk,
      irst => irst,
      iload => ilreg,
      idata => orrom(15 downto 8),
      odata => orhigh
    );

    low : Register_8bit_MD_Ent port map (
      iclk => iclk,
      irst => irst,
      iload => ilreg,
      idata => ilow,
      odata => olow
    );

    last_low : Register_8bit_MD_Ent port map (
      iclk => iclk,
      irst => irst,
      iload => ilreg,
      idata => olow,
      odata => ollow
    );

    rnge : Register_8bit_MD_Ent port map (
      iclk => iclk,
      irst => irst,
      iload => ilreg,
      idata => irnge,
      odata => ornge
    );
    
    min_range : Register_8bit_MD_Ent port map (
      iclk => iclk,
      irst => irst,
      iload => ilmrnge,
      idata => idata,
      odata => omrnge
    );
    
    mult_low <= prnge * orrom(7 downto 0);
    mult_high <= prnge * orrom(15 downto 8);
    mult_min <= prnge * omrnge;

    prnge <= ornge when (isele = '1') else (orhigh - orlow);
    plow <= olow when (isele = '1') else orlow;

    add_low <= plow + mult_low(15 downto 8);
    add_high <= plow + mult_high(15 downto 8);

    ilow <= add_low;
    ihigh <= add_high;

    irnge <= ihigh - ilow;
    itrnge <= mult_min(15 downto 8);

    ocode <= ollow;
    otrnge <= itrnge;
    odata <= oldata;

end architecture;
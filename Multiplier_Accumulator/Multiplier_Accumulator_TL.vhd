library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Multiplier_Accumulator_TL_Ent is 
  port (
    iclk : in std_logic;
    ice : in std_logic;
    idataR : in std_logic;
    idataA : in std_logic_vector(7 downto 0);
    idataB : in std_logic_vector(7 downto 0);
    imaxval : in std_logic_vector(7 downto 0);
    odataV : out std_logic;
    os : out std_logic_vector(31 downto 0)
  );
end entity;

architecture Multiplier_Accumulator_TL_Arch of Multiplier_Accumulator_TL_Ent is
  component Multiplier_Accumulator_DataPath_Ent
    port(
      iclk : in std_logic;
      irst : in std_logic;
      ice : in std_logic;
      imc : in std_logic_vector(1 downto 0);
      idataA : in std_logic_vector(7 downto 0);
      idataB : in std_logic_vector(7 downto 0);
      odata : out std_logic_vector(31 downto 0)
    );
  end component;
  
  component Multiplier_Accumulator_Control_Ent
    port(
      iclk : in std_logic;
      ice : in std_logic;
      idataR : in std_logic;
      imaxval : in std_logic_vector(7 downto 0);
      odataV : out std_logic;
      omc : out std_logic_vector(1 downto 0);
      oce : out std_logic
    );
  end component;

  signal ce : std_logic := '0';
  signal mc : std_logic_vector(1 downto 0) := "01";

  begin
    
    Data_Path : Multiplier_Accumulator_DataPath_Ent port map(
      iclk => iclk,
      irst => idataR,
      ice => ce,
      imc => mc,
      idataA => idataA,
      idataB => idataB,
      odata => os
    );

    Control : Multiplier_Accumulator_Control_Ent port map(
      iclk => iclk,
      ice => ice,
      idataR => idataR,
      imaxval => imaxval,
      odataV => odataV,
      omc => mc,
      oce => ce
    );

end architecture;
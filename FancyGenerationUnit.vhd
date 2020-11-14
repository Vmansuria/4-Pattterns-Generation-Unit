-- Team Number 7
-- Vishal Mansuria, Sean McCray 
-- vpm5113@psu.edu, smm7442@psu.edu
-- FancyGenerationUnit.vhd
-- Version 1.0 , 9/17/2020

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FancyGenerationUnit is
Port(
	CLK, RST_Global_Ext : in std_logic;
	RST_Ext, DIR_Ext, EN_Ext : in std_logic_vector(3 downto 0);
	DP_Ext : out std_logic;
	An_Ext : out std_logic_vector(3 downto 0);
	Ca_Ext : out std_logic_vector(6  downto 0)
); 
end FancyGenerationUnit;

architecture structural of FancyGenerationUnit is

component ClockDividerExternal
port(
		clock : in std_logic;
        RSET : in std_logic;
        s_out : out std_logic
	);
end component;

component GenerationUnit
port(
	CLK_in, RST_Global_in : in std_logic;
	RST_in, DIR_in, EN_in : in std_logic_vector(3 downto 0);

	Prime_out, Odd_out, Even_out, Counter_out : out std_logic_vector(3 downto 0)
);
end component;

component Sequential_7Segments_Decoder
port(
	value : in std_logic_vector(15 downto 0);
	RESET: in std_logic;
	clk : in std_logic;
	dp : out std_logic;
	-- The anodes will be treated as if they are different 
	-- communication channels, which are getting activated and deactivated according to the internal subclock (Sclk)
	channels : out std_logic_vector(3 downto 0);
    segs : out std_logic_vector(6 downto 0)
);
end component;

signal Prime_Internal, Odd_Internal, Even_Internal, Counter_Interal : std_logic_vector(3 downto 0);
signal subclk : std_logic;
begin 

CLKDIV: ClockDividerExternal port map (CLK, '0', subclk);
GENUNIT: GenerationUnit port map (subclk, RST_Global_Ext, RST_Ext, DIR_Ext, EN_Ext, Prime_Internal, Odd_Internal, Even_Internal, Counter_Interal);
DISPLAYCONTROLLER: Sequential_7Segments_Decoder port map(value(15 downto 12)=>Counter_Interal, value(11 downto 8)=>Even_Internal, value(7 downto 4)=>Odd_Internal, value(3 downto 0)=>Prime_Internal, RESET => '0', clk => CLK, dp => DP_Ext, channels => An_Ext, segs => Ca_Ext);

end structural; 
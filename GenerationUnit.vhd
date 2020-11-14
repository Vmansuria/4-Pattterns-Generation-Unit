-- Team Number 7
-- Vishal Mansuria, Sean McCray 
-- vpm5113@psu.edu, smm7442@psu.edu
-- GenerationUnit.vhd
-- Version 1.0 , 9/17/2020

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity GenerationUnit is
Port (
    
	CLK_in, RST_Global_in : in std_logic;
	RST_in, DIR_in, EN_in : in std_logic_vector(3 downto 0);

	Prime_out, Odd_out, Even_out, Counter_out : out std_logic_vector(3 downto 0));

    
end GenerationUnit;
 
architecture Structural of GenerationUnit is
 

component PrimeGenerator
port(

    CLK, RST_Global: in std_logic;
    RST, DIR, EN: in std_logic_vector(3 downto 0);
    
    
    Q: out std_logic_vector(3 downto 0)

    );

end component;

component OddGenerator
port(

    CLK, RST_Global: in std_logic;
    RST, DIR, EN: in std_logic_vector(3 downto 0);
    
    
    Q: out std_logic_vector(3 downto 0)

    );

end component;

component EvenGenerator
port(

    CLK, RST_Global: in std_logic;
    RST, DIR, EN: in std_logic_vector(3 downto 0);
    
    
    Q: out std_logic_vector(3 downto 0)

    );

end component;


component BinaryCounter
port(

    CLK, RST_Global: in std_logic;
    RST, DIR, EN: in std_logic_vector(3 downto 0);
  
    
    Q: out std_logic_vector(3 downto 0)

    );

end component;

 
begin
 
-- Port Mapping of the 4 generators

GU0: PrimeGenerator port map(CLK_in,RST_Global_in,RST_in,DIR_in,EN_in,Prime_out);
GU1: OddGenerator port map(CLK_in,RST_Global_in,RST_in,DIR_in,EN_in,Odd_out);
GU2: EvenGenerator port map(CLK_in,RST_Global_in,RST_in,DIR_in,EN_in,Even_out);
GU3: BinaryCounter port map(CLK_in,RST_Global_in,RST_in,DIR_in,EN_in,Counter_out);

 
end Structural;



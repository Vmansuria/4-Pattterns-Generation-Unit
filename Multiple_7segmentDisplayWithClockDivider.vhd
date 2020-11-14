-- Team Number 7
-- Vishal Mansuria, Sean McCray 
-- vpm5113@psu.edu, smm7442@psu.edu
-- Multiple_7segmentDisplayWithClockDivider.vhd
-- Version 1.0 , 9/17/2020
---
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Sequential_7Segments_Decoder is
    Port ( 
		
		value : in std_logic_vector(15 downto 0);
		RESET: in std_logic;
		clk : in std_logic;
		dp : out std_logic;
		-- The anodes will be treated as if they are different 
		-- communication channels, which are getting activated and deactivated according to the internal subclock (Sclk)
		channels : out std_logic_vector(3 downto 0);
	    segs : out std_logic_vector(6 downto 0));
end Sequential_7Segments_Decoder;


architecture behavioral of Sequential_7Segments_Decoder is

component ClockDivider
port(
        clock : in std_logic;
        RSET : in std_logic;
        s_out : out std_logic
    );
    end component;

component ClockDivider2
port(
        clock : in std_logic;
        RSET : in std_logic;
        s_out : out std_logic
    );
    end component;    
    
    signal counting: integer :=1; 
	signal cnt: std_logic_vector(23 downto 0); -- divider counter for ~95.3Hz refresh rate (with 100MHz main clock)
	signal intAn: std_logic_vector(3 downto 0); -- internal signal representing Anodes' Values

     --   signal channelsBuffer: std_logic_vector(7 downto 0):= X"00";

signal value1 : std_logic_vector(3 downto 0);
signal value2 : std_logic_vector(3 downto 0); 
signal value3 : std_logic_vector(3 downto 0);
signal value4 : std_logic_vector(3 downto 0); 
signal Sclk, Sclk2 : std_logic; 

begin
	
	clockdiv1: ClockDivider port map(clock => clk, RSET => RESET, s_out => Sclk); 
	clockdiv2: ClockDivider2 port map(clock => Sclk,RSET => RESET,s_out => Sclk2);
	
	
	
	value1 <= value(3 downto 0);
	value2 <= value(7 downto 4);
	value3 <= value(11 downto 8);
	value4 <= value (15 downto 12);
	
	channels <= intAn;
  
    process (Sclk,Sclk2) 
	begin
	
       if  (Sclk = '1' AND Sclk2 = '1')  then
               
               
              intAn <=  "0111";
              
			  dp <= '1';

    elsif  (Sclk = '1' AND Sclk2 = '0')  then
                         
                         
              intAn <=  "1011";
              dp <= '1';

    elsif  (Sclk = '0' AND Sclk2 = '1')  then
                          
                          
              intAn <=  "1101";
              dp <= '1';
                                                   
    --if  (Sclk = '0' AND Sclk2 = '0')  then
      else                     
                         
              intAn <= "1110";
              dp <= '1';
                                 
           end if;
	end process;
   	
	
    process (intAn) 
    begin
	
	if (intAn = "1110" ) THEN 
           case value1 is
       --   case counting is
		when "0000" => segs <= NOT "0111111"; -- 0
		when "0001" => segs <=NOT "0000110"; -- 1
		when "0010" => segs <=NOT "1011011"; -- 2
		when "0011" => segs <=NOT "1001111"; -- 3
		when "0100" => segs <=NOT "1100110"; -- 4
		when "0101" => segs <=NOT "1101101"; -- 5
		when "0110" => segs <=NOT "1111101"; -- 6
		when "0111" => segs <=NOT "0000111"; -- 7
		when "1000" => segs <=NOT "1111111"; -- 8
		when "1001" => segs <=NOT "1100111"; -- 9
		when "1010" => segs <=NOT "1110111"; -- A
		when "1011" => segs <=NOT "1111100"; -- b
		when "1100" => segs <=NOT "0111001"; -- c
		when "1101" => segs <=NOT "1011110"; -- d
		when "1110" => segs <=NOT "1111001"; -- E
		when others => segs <=NOT "1110001"; -- F
	    end case;
	 
	    
     elsif (intAn = "1101" ) THEN 
                case value2 is
             --   case counting is
        when "0000" => segs <= NOT "0111111"; -- 0
        when "0001" => segs <=NOT "0000110"; -- 1
        when "0010" => segs <=NOT "1011011"; -- 2
        when "0011" => segs <=NOT "1001111"; -- 3
        when "0100" => segs <=NOT "1100110"; -- 4
        when "0101" => segs <=NOT "1101101"; -- 5
        when "0110" => segs <=NOT "1111101"; -- 6
        when "0111" => segs <=NOT "0000111"; -- 7
        when "1000" => segs <=NOT "1111111"; -- 8
        when "1001" => segs <=NOT "1100111"; -- 9
        when "1010" => segs <=NOT "1110111"; -- A
        when "1011" => segs <=NOT "1111100"; -- b
        when "1100" => segs <=NOT "0111001"; -- c
        when "1101" => segs <=NOT "1011110"; -- d
        when "1110" => segs <=NOT "1111001"; -- E
        when others => segs <=NOT "1110001"; -- F
        end case;
	  
    elsif (intAn = "1011" ) THEN 
               case value3 is
            --   case counting is
        when "0000" => segs <= NOT "0111111"; -- 0
        when "0001" => segs <=NOT "0000110"; -- 1
        when "0010" => segs <=NOT "1011011"; -- 2
        when "0011" => segs <=NOT "1001111"; -- 3
        when "0100" => segs <=NOT "1100110"; -- 4
        when "0101" => segs <=NOT "1101101"; -- 5
        when "0110" => segs <=NOT "1111101"; -- 6
        when "0111" => segs <=NOT "0000111"; -- 7
        when "1000" => segs <=NOT "1111111"; -- 8
        when "1001" => segs <=NOT "1100111"; -- 9
        when "1010" => segs <=NOT "1110111"; -- A
        when "1011" => segs <=NOT "1111100"; -- b
        when "1100" => segs <=NOT "0111001"; -- c
        when "1101" => segs <=NOT "1011110"; -- d
        when "1110" => segs <=NOT "1111001"; -- E
        when others => segs <=NOT "1110001"; -- F
        end case;	    
	    	    
    else 
	    
	    case value4 is
     --   case counting is
        when "0000" => segs <= NOT "0111111"; -- 0
        when "0001" => segs <=NOT "0000110"; -- 1
        when "0010" => segs <=NOT "1011011"; -- 2
        when "0011" => segs <=NOT "1001111"; -- 3
        when "0100" => segs <=NOT "1100110"; -- 4
        when "0101" => segs <=NOT "1101101"; -- 5
        when "0110" => segs <=NOT "1111101"; -- 6
        when "0111" => segs <=NOT "0000111"; -- 7
        when "1000" => segs <=NOT "1111111"; -- 8
        when "1001" => segs <=NOT "1100111"; -- 9
        when "1010" => segs <=NOT "1110111"; -- A
        when "1011" => segs <=NOT "1111100"; -- b
        when "1100" => segs <=NOT "0111001"; -- c
        when "1101" => segs <=NOT "1011110"; -- d
        when "1110" => segs <=NOT "1111001"; -- E
        when others => segs <=NOT "1110001"; -- F
        end case;
        
        
	end if;
	
    end process;
    
  

end behavioral;
  
    
----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/20/2021 04:36:39 PM
-- Design Name: 
-- Module Name: DUT_TB - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
library work;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
use STD.TEXTIO.ALL;
use work.<YOUR_PACKAGE_NAME>.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DUT_TB is
--  Port ( );
end DUT_TB;

architecture Behavioral of DUT_TB is

-- =============================================================================
-- =============================================================================
-- =============================================================================
-- =============================================================================
-- =============================================================================
-- Constant Decleration 
-- =============================================================================

	-- Clock Features 
		constant C_Clock_Freq			: INTEGER  := 100e6;
		Constant C_Clock_Period 		: TIME 	   := 1000ms / C_Clock_Freq;
		
	-- Interval period 
		Constant C_interval_period 		: INTEGER RANGE 0 TO 31 := 16;
		Constant C_bit_widths	 		: INTEGER RANGE 0 TO 63 := 32;
		Constant C_half_bit_widths 		: INTEGER RANGE 0 TO 31 := 16;
		
	-- FILE NAME CONSTANT 
		Constant C_fileNumber_reim		: INTEGER RANGE 0 TO 63 := 12;
		Constant C_input_Number 		: INTEGER RANGE 0 TO 63 := 6;
		
-- =============================================================================
-- Signal Decleration 
-- =============================================================================
	
	-- CLOCK AND RESET
		Signal s_Clk		: STD_LOGIC := '0';
		Signal S_Reset		: STD_LOGIC := '0';
	
	-- DUT
		< SIGNALS OF YOUR DUT >
	
	-- FILE NAME STRING 
		Signal s_str_filenames : STR_ARRAY( 1 TO C_fileNumber_reim ) := 
			(
				"Pyt_Out_XXXXXX_00_Real.txt", 
				"Pyt_Out_XXXXXX_00_Imag.txt",
				"Pyt_Out_XXXXXX_01_Real.txt", 
				"Pyt_Out_XXXXXX_01_Imag.txt",
				"Pyt_Out_XXXXXX_02_Real.txt",
				"Pyt_Out_XXXXXX_02_Imag.txt",
				"Pyt_Out_XXXXXX_03_Real.txt",
				"Pyt_Out_XXXXXX_03_Imag.txt",
				"Pyt_Out_XXXXXX_04_Real.txt",
				"Pyt_Out_XXXXXX_04_Imag.txt",
				"Pyt_Out_XXXXXX_05_Real.txt",
				"Pyt_Out_XXXXXX_05_Imag.txt"
			);
				
	TYPE STR_WRITE_ARRAY IS ARRAY ( NATURAL RANGE <> ) OF STRING( 1 TO 126 );
		Signal s_str_WW_filenames : STR_WRITE_ARRAY( 1 TO 10 ) := 
			(
				"< PATH_OF_THE_PROJECT >\<YOUR_PROJECT_NAME>.srcs\sim_1\TestFiles\Viv_Out_XXXXXX_00_Real.txt",
				"< PATH_OF_THE_PROJECT >\<YOUR_PROJECT_NAME>.srcs\sim_1\TestFiles\Viv_Out_XXXXXX_00_Imag.txt",
				"< PATH_OF_THE_PROJECT >\<YOUR_PROJECT_NAME>.srcs\sim_1\TestFiles\Viv_Out_XXXXXX_01_Real.txt",
				"< PATH_OF_THE_PROJECT >\<YOUR_PROJECT_NAME>.srcs\sim_1\TestFiles\Viv_Out_XXXXXX_01_Imag.txt",
				"< PATH_OF_THE_PROJECT >\<YOUR_PROJECT_NAME>.srcs\sim_1\TestFiles\Viv_Out_XXXXXX_02_Real.txt",
				"< PATH_OF_THE_PROJECT >\<YOUR_PROJECT_NAME>.srcs\sim_1\TestFiles\Viv_Out_XXXXXX_02_Imag.txt",
				"< PATH_OF_THE_PROJECT >\<YOUR_PROJECT_NAME>.srcs\sim_1\TestFiles\Viv_Out_XXXXXX_03_Real.txt",
				"< PATH_OF_THE_PROJECT >\<YOUR_PROJECT_NAME>.srcs\sim_1\TestFiles\Viv_Out_XXXXXX_03_Imag.txt",
				"< PATH_OF_THE_PROJECT >\<YOUR_PROJECT_NAME>.srcs\sim_1\TestFiles\Viv_Out_XXXXXX_04_Real.txt",
				"< PATH_OF_THE_PROJECT >\<YOUR_PROJECT_NAME>.srcs\sim_1\TestFiles\Viv_Out_XXXXXX_04_Imag.txt"
			);	
	
	
begin

-- $$$$$$$$$$$$###########%%%%%%%%%%%%%% USING THIS MODULE YOU CAN READ YOUR OWN DATASET FROM MATLAB 
-- READING XD DATA HERE
INPUT_DATA_GENERATOR : FOR i in 0 to ( C_input_Number - 1 ) GENERATE 
	DATA_GENERATOR : Entity Work.FileReaderv_1 
		GENERIC MAP 
			(
				G_interval				=> C_interval_period, 
				G_data_width 			=> C_bit_widths, 
				G_half_width 			=> C_half_bit_widths, --this parameter is equal to G_data_width/2;
				real_file_name_addr 	=> s_str_filenames( 2 * I + 1 ),
				imag_file_name_addr 	=> s_str_filenames( 2 * I + 2 )
			)
		PORT MAP 
			(
				i_Clk   				=> s_Clk					,
				i_Reset 				=> s_Reset                  ,
				o_ax_1_data_tdata   	=> DUT_INPUT_DATA_TDATA( I ),
				o_ax_1_data_tvalid  	=> DUT_INPUT_DATA_TVALID( I )
			);
END GENERATE INPUT_DATA_GENERATOR;

			
	DUT : Entity Work.<DUT_NAME>
		PORT MAP 
			(
				DUT_PORT_MAPPING;
			);


-- $$$$$$$$$$$$###########%%%%%%%%%%%%%% USING THIS MODULE YOU CAN WRITE YOUR OWN DATASET ON FILE
DATA_WRITER : FOR I IN 0 TO 4 GENERATE
	WRITER : Entity Work.FileWriter 
		GENERIC MAP
			(
				G_data_width 			=> 64,
				G_half_width 			=> 32,
				real_file_name_addr 	=> s_str_WW_filenames( 2 * I + 1 ),
				imag_file_name_addr 	=> s_str_WW_filenames( 2 * I + 2 )
			)
		PORT MAP 
			(
				i_Clk   				=> s_Clk,
				i_Reset 				=> s_Reset,
				i_ax_1_data_tdata   	=> DUT_OUTPUT_DATA_TDATA( I ),
				i_ax_1_data_tvalid  	=> DUT_OUTPUT_DATA_TVALID( I )
		
			);
END GENERATE DATA_WRITER;


-- CLOCK GENERATING PROCESS 
	s_Clk <= NOT s_Clk AFTER C_Clock_Period / 2 ;
	
end Behavioral;

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ALU1 IS  -- ALU unit includes Reg. 3
    PORT (
        clk, res   : IN  std_logic;
        A, B       : IN  std_logic_vector(7 DOWNTO 0); -- 8-bit inputs A & B from Reg. 1 & Reg. 2
        opcode     : IN  std_logic_vector(7 DOWNTO 0); -- 8-bit opcode from Decoder
        Result     : BUFFER std_logic_vector(7 DOWNTO 0);
		  Upper4     : OUT std_logic_vector(3 DOWNTO 0);  -- Result(7 downto 4)
        Lower4     : OUT std_logic_vector(3 DOWNTO 0);   -- Result(3 downto 0)
		  MSB_lower  : OUT std_logic;
		  MSB_upper  : OUT std_logic
    );
END ALU1;

ARCHITECTURE calculation OF ALU1 IS
BEGIN
    PROCESS (clk, res)
    BEGIN
        IF res = '0' THEN
            Result <= (OTHERS => '0');  -- Reset result to 0
        ELSIF rising_edge(clk) THEN
           CASE opcode IS
                WHEN "00000001" =>  -- Operation 0: ADD
                    Result <= std_logic_vector(unsigned(A) + unsigned(B));

                WHEN "00000010" =>  -- Operation 1: SUB
                    Result <= std_logic_vector(unsigned(A) - unsigned(B));

                WHEN "00000100" =>  -- Operation 2: INVERT Reg1
                    Result <= NOT A;

                WHEN "00001000" =>  -- Operation 3: NAND
                    Result <= NOT (A AND B);

                WHEN "00010000" =>  -- Operation 4: NOR
                    Result <= NOT (A OR B);

                WHEN "00100000" =>  -- Operation 5: AND
                    Result <= A AND B;

                WHEN "01000000" =>  -- Operation 6: XOR
                    Result <= A XOR B;

                WHEN "10000000" =>  -- Operation 7: OR
                    Result <= A OR B;

                WHEN OTHERS =>
                    NULL;
            END CASE;
				   END IF;
    END PROCESS;
	 
	  -- Always reflect current Result bits into Upper4 and Lower4
    Upper4 <= Result(7 downto 4);
    Lower4 <= Result(3 downto 0);
	 MSB_upper <= Result(7);
	 MSB_lower <= Result(3);
	 
END calculation;
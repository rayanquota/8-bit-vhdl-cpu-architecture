LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ALU2 IS  -- ALU unit includes Reg. 3
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
END ALU2;

ARCHITECTURE calculation OF ALU2 IS
BEGIN
    PROCESS (clk, res)
	 variable A_signed, B_signed: signed (7 downto 0); 
    BEGIN
        IF res = '0' THEN
            Result <= (OTHERS => '0');  -- Reset result to 0
        ELSIF rising_edge(clk) THEN
            CASE opcode IS
                 
					 WHEN "00000001" =>  -- Operation 1: SUB
					 A_signed:= signed (A);
					 B_signed:= signed (B);
                    Result <= std_logic_vector(A_Signed - B_signed);


                WHEN "00000010" =>  -- Operation 2: 2'S COMPLEMENT
                    Result <= std_logic_vector(unsigned(NOT B) + 1);

                WHEN "00000100" =>  -- Operation 3: SWAP LOWER 4 BITS
                    Result <= A(7 DOWNTO 4) & B(3 DOWNTO 0);

                WHEN "00001000" =>  -- Operation 4: NULL
                    Result <= NULL;

                WHEN "00010000" =>  -- Operation 5: B MINUS 5
                    Result <= std_logic_vector((signed(B)) - 5);

                WHEN "00100000" =>  -- Operation 6: REVERSE
                    Result <= A(0) & A(1) & A(2) & A(3) & A(4) & A(5) & A(6) & A(7);

                WHEN "01000000" =>  -- Operation 7: SHIFT 3 BITS TO THE RIGHT
                    Result <= A(4 DOWNTO 0) & "111";
						  
					 WHEN "10000000" =>  -- Operation 8: A PLUS 3
                    Result <= std_logic_vector(signed(A) + 3);

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
// setup
// makes RAM[6] our leading one check 
// makes RAM[7] our adding one to end number


@32767
A=A+1
D=A
@6
M=D

@1
D=A
@7
M=D



// loop starts
(LOOP)
	// decrement counter RAM[4]
	@4
	D=M
	D=D-1
	@4
	M=D

	// main function starts

		// putting a copy of RAM[3] in RAM[9]
		@3
		D=M
		@9
		M=D

		// compares RAM[3] and RAM[6]
		@6
		D=D&M


		// if statement
		@IfLeadingZero
		D;JEQ
		// else (if leading one)
		@3
		D=M
		@9 // times D by two
		D=D+M //MIGHT NOT WORK added @9 

	// GETS OUR TAILING ONE
		@7 
		D=D|M
		@3
		M=D //STORE SHIFTED IN RAM3 TIL END OF LOOP

		@ENDIF
		0;JMP

		// if function
		(IfLeadingZero)
		@3
		D=M
		@9
		D=D+M // MIGHT NOT WORK
		@3
		M=D

		// endif lands here
		(ENDIF)
	// main function ends
	
// loop continues if RAM[4] != zero 
	@4
	D=M
	@LOOP
	D;JNE
// put final value of RAM3 in RAM5
@3
D=M
@5
M=D
(END)
@END
0;JMP





// end of program
(END)
@END
0;JMP

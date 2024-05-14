// SAVE BF ADDING DUBLICATES TO L AND R
// setup---------------------------------------------------------- 
// __set masks __________
@255
D=A
@MaskForLeft
M=D

@32640
D=A
@MaskForRight
M=D
@MaskForRight
M=M+D
//-----------------
// ___________________SEPARATE RIGHT AND LEFT TEXT FROM RAM[2]
@R2
D=M // get 16 bit plaintext
@MaskForLeft
D=D&M // and it so only one half remains
@LeftPlainText
M=D

@R2
D=M // get 16 bit plaintext
@MaskForRight
D=D&M // and it so only one half remains
@RightPlainText
M=D

// ___________________SEPARATE RIGHT AND LEFT TEXT
// SET ROTATABLE KEY - RAM1 = K0_________________________________________ WORKS
// ROTATION LOOP COUNTER = 8 IN RAM[8]
@8
D=A
@R8
M=D
// create copy of key to OR later
@R1
D=M // get key
@ogKey
M=D // copy it in RAM[12]
// LOOP FOR ROTATION 8 TIMES (shouldnt need the if statement)

(RotateKey)
	// ---- decrement counter RAM[8]
	@R8
	D=M
	D=D-1
	@R8
	M=D
    // main function --------------
        @R1
        D=M // get key
        @R11
        M=D // copy it in RAM[11]

        @R1
        D=M // get key
        @R11
        D=D+M // times key by two aka shift it aka add it to itself
        @R1 // save it back in RAM[1]
        M=D
    // main function ends --------------
// loop continues if RAM[8] != zero 
    @R8
    D=M
    @RotateKey
    D;JNE
// OR FINAL RESULT WITH K0 AND MAKE ROTATABLE KEY
@ogKey
D=M
@R1
M=M|D
// __set counter________
@4
D=A
@counter
M=D
//__________________________________________________________________________
// ---------------------------------------------------------- LOOP ----------------------------------------------------------
(MainLoop)
    // get R and put it in temp ---
    @RightPlainText
    D=M 
    // Apply F(R, Key)





// check end of loop/ pre loop reset:----------------------------------------------------------------------------------------
// rotate K0 to K1
// counter--
// if counter == 0, exit loop

// ---------------------------------------------------------- AFTER LOOP ----------------------------------------------------------
// R0 = left and right


//
//R1 = 

// setup----------------------------------------------------------
// __set counter________
@4
D=A
@MainLoopCounter
M=D
// __leading one setup ____
// makes @LeadingOneCheck our leading one check 
// makes @AddOneToLSB our adding one to end number
@32767
A=A+1
D=A
@LeadingOneCheck
M=D
@1
D=A
@AddOneToLSB
M=D
// __set masks __________
@255 
D=A
@MaskForRight // = 0000000011111111
M=D

@32640
D=A
@MaskForLeft
M=D
@MaskForLeft // = 1111111100000000
M=M+D
//-----------------
// ___________________SEPARATE RIGHT AND LEFT TEXT FROM RAM[2]
@R2
D=M // get 16 bit plaintext
@MaskForLeft
D=D&M // and it so only one half remains
@LeftPlainText
M=D
@L // create copy and then use it to or with shifted LeftPlainText
M=D

@R2
D=M // get 16 bit plaintext
@MaskForRight
D=D&M // and it so only one half remains
@RightPlainText
M=D
@R // create copy and then use it to or with shifted RightPlainText
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
	M=D // line 52
    // main function --------------
        // ----- ROTATE KEY
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
        // ------ ROTATE RIGHT TEXT
        @RightPlainText
        D=M // get P(right)
        @R2
        M=D // copy it in RAM[2]
        @RightPlainText // check to see if this simpler version works!
        D=D+M 
        M=D
        // ------ ROTATE LEFT TEXT
        @LeftPlainText
        D=M // get P(Left)
        @R2
        M=D // copy it in RAM[2]
            // check for leading one
            @LeadingOneCheck
            D=D&M // checks to see if there is a leading one
            // if statement
            @IfLeadingZero
            D;JEQ
                // else continue (if there is a leading one)
                @LeftPlainText
                D=M
                @R2
                D=D+M
                // gets tailing one
                @AddOneToLSB
                D=D|M
                @LeftPlainText
                M=D 
                @ENDIF
                0;JMP
            // if function jumps here
            (IfLeadingZero)
            @LeftPlainText
            D=M
            @R2
            D=D+M
            @LeftPlainText
            M=D

            // endif jumps here
            (ENDIF)



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

// final result is stored in L
@RightPlainText
D=M
@R
D=D|M
M=D
@LeftPlainText
D=M
@L
D=D|M
M=D

//__________________________________________________________________________
// ---------------------------------------------------------- LOOP ----------------------------------------------------------
(MainLoop)
    // create first time xor variable and set it to 1
    @1
    D=A
    @whichXor
    M=D
    // get R and put it in temp ---
    @R
    D=M
    @temp
    M=D
    

    // __________Apply F(R, Key)
    // create variables to pass in XOR function
    //@x = R
    @R
    D=M
    @x
    M=D
    //@y = !key
    @R1 //key is in R1
    D=M
    D=!D //not Key
    @y
    M=D
    // call on XOR function returns @xorResult
    @XORfunction
    0;JMP
    (firstXor) // exits the xor function and returns here if @whichXor == 1
    // changes @whichXor to 0
    @0
    D=A
    @whichXor
    M=D

    //@x = @xorResult
    @xorResult
    D=M
    @x
    M=D
    //y=L
    @L
    D=M
    @y
    M=D
    // call on XOR again
    @XORfunction
    0;JMP
    (secondXor) // exits the xor function and returns here if @whichXor == 0
    // @R = xorResult
    @xorResult
    D=M
    @R
    M=D
    // @L = @temp
    @temp
    D=M
    @L
    M=D
    // skips to after the xor function
    @SkipXORfunction
    0;JMP
    // place xor function here
    (XORfunction)
    // this function XORs value stored in @x and @y
        // XOR function between two 16 bit values stored in RAM[3] and RAM[4] and stores the result in RAM[5]
        // ram3 = x 
        // ram4 = y
        // ram5 = result (xorResult)
        // nam6 = !x (notX)
        // ram7 = !y (notY)
        // ram8 = !x & y (notXandY)
        // ram9 =  x & !y (XandNotY)

        //LOAD value in RAM[3] -> X
        @x
        D=M

        // Not the value and store it in memory address 6
        // !x in RAM[6]
        D=!D
        @notX
        M=D

        // !x[6] and y[4] in RAM[8]
        @y
        D=D&M
        @notXandY
        M=D

        //LOAD value in RAM[4] -> Y
        @y
        D=M

        // Not the value and store it in memory address 7
        // !y in @notY RAM[7]
        D=!D
        @notY
        M=D

        // !y[7] and x[3] in RAM[9]
        @x
        D=D&M
        @XandNotY
        M=D

        // x XOR y
        // (!x&y)[8] OR (x&!y)[9]
        // store it in RAM[5]

        @notXandY
        D=D|M
        @xorResult
        M=D

        // check whether this is the first(1) or second time (0) XOR Function has been called
        // this will effect where the loop will return to
        @whichXor
        D=M
        @secondXor // if 0 
        D;JEQ
        // else go to @firstXor
        @firstXor
        D;JMP



    // (END OF XOR FUNCTION)
    (SkipXORfunction)
    // skip function skips here
    


// check end of loop/ pre loop reset:----------------------------------------------------------------------------------------
// rotate K0 to K1
// ----- ROTATE KEY (this isnt a loop btw)
        @R1
        D=M // get key
        @R11
        M=D // copy it in RAM[11]

      //  @R1
      //  D=M // get key
      //  @R11
      //  D=D+M // times key by two aka shift it aka add it to itself
      //  @R1 // save it back in RAM[1]
      //  M=D

        
            // check for leading one
            @LeadingOneCheck
            D=D&M // checks to see if there is a leading one
            // if statement
            @IfLeadingZero2
            D;JEQ
                // else continue (if there is a leading one)
                @R1
                D=M
                @R11
                D=D+M
                // gets tailing one
                @AddOneToLSB
                D=D|M
                @R1
                M=D 
                @EndIf
                0;JMP
            // if function jumps here
            (IfLeadingZero2)
                @R1
                D=M // get key
                @R11
                D=D+M // times key by two aka shift it aka add it to itself
                @R1 // save it back in RAM[1]
                M=D

            // endif jumps here
            (EndIf)



// MainLoopCounter-- (would be at the top just as the mainloop starts but bc this is only going to have 4 loops each time, its easier for it to be here)
@MainLoopCounter
D=M
D=D-1
M=D
// if MainLoopCounter != 0, continue loop
@MainLoop
D;JNE //else continue 

// ---------------------------------------------------------- AFTER LOOP ----------------------------------------------------------
// R0 = left and right
@L
D=M
@MaskForLeft
D=D&M 
@LeftPlainText
M=D

@R
D=M
@MaskForRight
D=D&M
@RightPlainText
M=D

// RightPlainText (D) or LeftPlainText = RAM[0]
@LeftPlainText
D=D|M
@R0
M=D


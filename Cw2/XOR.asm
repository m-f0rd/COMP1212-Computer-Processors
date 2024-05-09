// XOR function between two 16 bit values stored in RAM[3] and RAM[4] and stores the result in RAM[5]

//LOAD value in RAM[3] -> X
@3
D=M


// Not the value and store it in memory address 6
// !x in RAM[6]
D=!D
@6
M=D

// !x[6] and y[4] in RAM[8]
@4
D=D&M
@8
M=D


//LOAD value in RAM[4] -> Y
@4
D=M

// Not the value and store it in memory address 7
// !y in RAM[7]
D=!D
@7
M=D


// !y[7] and x[3] in RAM[9]
@3
D=D&M
@9
M=D



// x XOR y
// (!x&y)[8] OR (x&!y)[9]
// store it in RAM[5]

@8
D=D|M
@5
M=D

(END)
@END
0;JMP

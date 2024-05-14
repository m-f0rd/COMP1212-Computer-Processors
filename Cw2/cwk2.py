
# a) Write a program (XOR.asm) in HACK assembly that implements a bit-wise XOR function between two 16-bit values stored in RAM[3] and RAM[4] and stores the result in RAM[5].



RAM0 = 0
RAM1 = 0
RAM2 = 0


RAM3 = int(10)
RAM4 = int(11)
RAM5 = bin(RAM3 ^ RAM4)
print(RAM5)

key = 76543210

shift1 = 1010111100000000
shift2 = 0
check = 111100000000101 # 0111100000000101

def leftShift(number, times):
    stringNum = str(number)

    for i in range(times):
        temp = stringNum[0]
        stringNum = stringNum[1:]
        stringNum = stringNum + temp

    return((stringNum))

print(leftShift(shift1, 3))
print("0111100000000101") #works
n1 = (10) #1010
n2 = (4)  #0100
n3 = n1+n2
n11 = n1+n1
print(f"The binary addition of {bin(n1)[2:]} and 0{bin(n2)[2:]} is ", bin(n3)[2:])
print(f"The binary addition of {bin(n1)[2:]} is ", bin(n11)[2:])


# def shift(num, rotes):
#     for i in range(rotes):
#         shifted = 
# def feistel_block(plain_text, keys):
#     L, R = plain_text[:8], plain_text[8:]
#     for key in keys:
#         temp = R
#         R = bin(int(L, 2) ^ int(F(R, key), 2))[2:].zfill(8)
#         L = temp
#     return R + L

# def F(R, key): 
#     # This is a toy Feistel function.
#     # In a real Feistel cipher, this would be a more complex function.
#     return bin(int(R, 2) ^ key)[2:].zfill(8)

# plain_text = '0110111101111011'
# keys = [0b10101010, 0b11001100, 0b11110000, 0b10101011]

# cipher_text = feistel_block(plain_text, keys)
# print('Cipher text:', cipher_text)

"""
16-bit Feistel Cipher
4 rounds
F(A,B) = A XOR (NOT B)
8-bit key K
K0 =b7b6b5b4b3b2b1b0 
K1 =b6b5b4b3b2b1b0b7 
K2 =b5b4b3b2b1b0b7b6 
K3 =b4b3b2b1b0b7b6b5


"""


""" from before 14/05 15:48

// setup----------------------------------------------------------
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
@MaskForRight
M=D

@32640
D=A
@MaskForLeft
M=D
@MaskForLeft
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
	M=D
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
// __set counter________
@4
D=A
@counter
M=D

"""
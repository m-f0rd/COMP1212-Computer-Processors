
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
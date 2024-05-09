# Write a program (FeistelEncryption.asm) in HACK assembly, that implements
# the described Feistel encryption system. The initial key, K0, will be stored in
# RAM[1], and the plaintext to be encrypted will be represented by a 16-bit value
# stored in RAM[2]. The result of the encryption should be stored in RAM[0].

# K0 = 0
# P = 0000000000000000
# #-----------------------------
# RAM1 = K0
# RAM2 = P
# RAM0 = 0 #result

# # setup
# RAM4 = 1111111100000000 #FRONT MASK
# RAM5 = 11111111         #BACK MASK
# RAM3 = 0 # temp

# RAM7 = 0 #L
# RAM8 = 0 #R

# def getLeft(plaintext, backMask):
#     pass
# def getRight(plaintext, frontMask):
#     pass

# def F(A, B):
#     # A XOR !B
#     pass

# def xor(A, B):
#     pass
# RAM7 = getLeft(RAM2, RAM5)
# RAM8 = getRight(RAM2, RAM4)



def feistel_block(plain_text, keys): 

    L, R = plain_text[:8], plain_text[8:] 

    for key in keys: 

        temp = R 

        R = bin(int(L, 2) ^ int(F(R, key), 2))[2:].zfill(8) 

        L = temp 

    return R + L 

  

def F(R, key):  

    # This is a toy Feistel function. 

    # In a real Feistel cipher, this would be a more complex function. 

    return bin(int(R, 2) ^ key)[2:].zfill(8) 

  

#plain_text = '0110111101111011' 
plain_text = '0000000000000000' 

#keys = [0b10101010, 0b11001100, 0b11110000, 0b10101011] 
keys = [0b00000000, 0b00000000, 0b00000000, 0b00000000] 

  

cipher_text = feistel_block(plain_text, keys) 

print('Cipher text:', cipher_text)


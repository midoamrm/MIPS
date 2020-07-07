import numpy as np

def decimalToBinaryin5digits(n):
    a ="0"
    b =bin(n).replace("0b", "")
    for i in range( 5 - len(b) ):
        b = a+b
    return b

def decimalToBinaryin16digits(n):
    b = np.binary_repr(n,16)
    """nn =0
    if (n < 0):
        nn = 1
        n = n*-1

    a="0"
    b =  bin(n).replace("0b", "")
    for i in range(16 - len(b)):
        b= a+b

    if (nn==1):

        for i in range(16):
            if (b[15 - i] == "1"):
                u = b[15 - i:]
                b= b[:15-i]
                break
        #print(b)
        b.replace("0", "5")
        #print(b)
        b.replace("1", "0")
        #print(b)
        b.replace("5", "1")
        #print(b)
        b = b +u
        #print(b)"""

    """if (nn == 1):
        hh =0

        for i in range(16):
            #print(b)

            if (hh==1):
                if (b[15 - i] == "1"):
                    b = b[:15 - i - 1] + "0" + b[15 - i + 1:]
                if (b[15 - i] == "0"):
                    b = b[:15-i-1]+"1"+b[15-i+1:]

            if (hh==0):
                if (b[15-i] == "1"):
                    hh=1
    """

    return b

def decimalToBinaryin26digits(n):
    a="0"
    b = bin(n).replace("0b", "")
    if(len(b)< 26):
        for i in range(26 - len(b)):
            b= a+b
    if(len(b) > 26):
        b = b[len(b) - 26:]
    return b

def registers(p):
    if(p[:4] == "zero"):
        return "00000"
    if (p[:2] == "ra"):
        return "11111"
    if (p[:2] == "fp"):
        return "11110"
    if (p[:2] == "sp"):
        return "11101"
    if (p[:2] == "gp"):
        return "11100"
    if (p[0] == "v"):
        return decimalToBinaryin5digits(int(p[1])+2)
    if (p[0] == "a"):
        return decimalToBinaryin5digits(int(p[1])+4)
    if (p[0] == "t"):
        if(int(p[1])<8):
            return decimalToBinaryin5digits(int(p[1])+8)
        else :
            return decimalToBinaryin5digits(int(p[1]) + 16)
    if (p[0] == "s"):
        return decimalToBinaryin5digits(int(p[1])+16)

def codewrite(a,b,c,d,e,noop):

    z="" #"00000000000000000000000000000000"

    if(noop==0):
        if (a == "000000"):
            if (e == "001000"):  # jr
                z = a + str(registers(b)) + "00000" + "00000" + "00000" + e + "\n"

            elif (e == "000000"):  # sll
                z = a + "00000" + str(registers(c)) + str(registers(b)) + decimalToBinaryin5digits(int(d)) + e + "\n"

            else:  # add or slt and sub
                z = a + str(registers(c)) + str(registers(d)) + str(registers(b)) + "00000" + e + "\n"

        if (a == "100011" or a == "101011"):  # lw sw
            z = a + str(registers(d)) + str(registers(b)) + decimalToBinaryin16digits(int(c)) + "\n"

        if (a == "001000" or a == "001101"):  # addi ori
            z = a + str(registers(c)) + str(registers(b)) + decimalToBinaryin16digits(int(d)) + "\n"

        if (a == "000100"):  # beq
            z = a + str(registers(b)) + str(registers(c)) + decimalToBinaryin16digits(int(d)) + "\n"
        if (a == "000010" or a == "000011"):  # j jal
            z = a + d + "\n"
    f.write(z)

#print(decimalToBinaryin16digits(8))
#print(decimalToBinaryin16digits(-8))
#print("0123456"[4:2+4])

x= -1
lables = []
lable_adresses =[]
m=0
# reading and saving into assembly
with open('assembly.txt',"r") as f:
    asslembly =f.readlines()

    for i in range (len(asslembly)):
        asslembly[i] = asslembly[i].replace(" ", "")
        x =asslembly[i].find(":")
        if (x != -1) :
            lables.append(asslembly[i][:x])
            lable_adresses.append(i)
            if(asslembly[i][:x]== "main"):
                m=i
            asslembly[i] = asslembly[i][x + 1:]

#determinde the function
with open('machine_code.txt',"w") as f:
    codewrite("000010", "00000", "00000", decimalToBinaryin26digits(m+1), "000000",0)
    for i in range(len(asslembly)):

        noop=0
        a = e = "000000"
        b = c = d = "00000"

        #while (asslembly[i][0] == " "):
            #asslembly[i] = asslembly[i][1:]

        b = asslembly[i][asslembly[i].find("$") + 1: asslembly[i].find(",")]

        if (asslembly[i].find(",") == -1):
            b = asslembly[i][asslembly[i].find("$") + 1:]
        if (asslembly[i][:4]) == "addi":
            #print("addi",i)
            a = "001000"
            c = asslembly[i][asslembly[i].find("$", asslembly[i].find("$") + 1) + 1: asslembly[i].find(",", asslembly[
                i].find(",") + 1)]
            d = asslembly[i][asslembly[i].find(",", asslembly[i].find(",") + 1) + 1:]

        elif (asslembly[i][:3] == "ori"):
            #print("ori",i)
            a = "001101"
            c = asslembly[i][asslembly[i].find("$", asslembly[i].find("$") + 1) + 1: asslembly[i].find(",", asslembly[
                i].find(",") + 1)]
            d = asslembly[i][asslembly[i].find(",", asslembly[i].find(",") + 1) + 1:]
        elif (asslembly[i][:2] == "sw"):
            #print("sw",i)
            a = "101011"
            c = asslembly[i][asslembly[i].find(",") + 1: asslembly[i].find("(")]
            d = asslembly[i][asslembly[i].find("(") + 2:asslembly[i].find(")")]
        elif (asslembly[i][:2] == "lw"):
            #print("lw",i)
            a = "100011"
            c = asslembly[i][asslembly[i].find(",") + 1: asslembly[i].find("(")]
            d = asslembly[i][asslembly[i].find("(") + 2:asslembly[i].find(")")]
        elif (asslembly[i][:3] == "beq"):
            #print("beq", i)
            a = "000100"
            c = asslembly[i][asslembly[i].find("$", asslembly[i].find("$") + 1) + 1: asslembly[i].find(",", asslembly[
                i].find(",") + 1)]
            for j in range(len(lables)):
                if (lables[j] == asslembly[i][asslembly[i].find(",", asslembly[i].find(",") + 1)+1:len(lables[j])+1+asslembly[i].find(",", asslembly[i].find(",") + 1)]):
                    d =  (-i + lable_adresses[j]) - 1
        elif (asslembly[i][:2] == "jr"):
            #print("jr", i)
            a = "000000"
            e = "001000"
        elif (asslembly[i][:3] == "jal"):
            #print("jal", i)
            a = "000011"
            for j in range(len(lables)):
                if (lables[j] == asslembly[i][3 :len(lables[j])+3]):
                    d =  decimalToBinaryin26digits(lable_adresses[j]+1)

        elif (asslembly[i][0] == "j" and asslembly[i][1] != "r"): #مش jr
            #print("j", i)
            a = "000010"
            for j in range(len(lables)):

                if (lables[j] == asslembly[i][1 :len(lables[j])+1]):
                    d =  decimalToBinaryin26digits(lable_adresses[j]+1)

        elif (asslembly[i][:3] == "add"):
            #print("add", i)
            a = "000000"
            e = "100000"
            c = asslembly[i][asslembly[i].find("$", asslembly[i].find("$") + 1) + 1: asslembly[i].find(",", asslembly[
                i].find(",") + 1)]
            d = asslembly[i][asslembly[i].find(",", asslembly[i].find(",") + 2) + 2:]

        elif (asslembly[i][:3] == "sub"):
            #print("add", i)
            a = "000000"
            e = "100010"
            c = asslembly[i][asslembly[i].find("$", asslembly[i].find("$") + 1) + 1: asslembly[i].find(",", asslembly[
                i].find(",") + 1)]
            d = asslembly[i][asslembly[i].find(",", asslembly[i].find(",") + 2) + 2:]


        elif (asslembly[i][:3] == "sll"):
            #print("sll", i)
            a = "000000"
            e = "000000"
            c = asslembly[i][asslembly[i].find("$", asslembly[i].find("$") + 1) + 1: asslembly[i].find(",", asslembly[
                i].find(",") + 1)]
            d = asslembly[i][asslembly[i].find(",", asslembly[i].find(",") + 1) + 1:]
        elif (asslembly[i][:3] == "and"):
            a = "000000"
            e = "100100"
            c = asslembly[i][asslembly[i].find("$", asslembly[i].find("$") + 1) + 1: asslembly[i].find(",", asslembly[
                i].find(",") + 1)]
            d = asslembly[i][asslembly[i].find(",", asslembly[i].find(",") + 2) + 2:]
        elif (asslembly[i][:2] == "or"):
            a = "000000"
            e = "100101"
            c = asslembly[i][asslembly[i].find("$", asslembly[i].find("$") + 1) + 1: asslembly[i].find(",", asslembly[
                i].find(",") + 1)]
            d = asslembly[i][asslembly[i].find(",", asslembly[i].find(",") + 2) + 2:]
        elif (asslembly[i][:3] == "slt"):
            a = "000000"
            e = "101010"
            c = asslembly[i][asslembly[i].find("$", asslembly[i].find("$") + 1) + 1: asslembly[i].find(",", asslembly[
                i].find(",") + 1)]
            d = asslembly[i][asslembly[i].find(",", asslembly[i].find(",") + 2) + 2:]
        else :
            print("no op in line ",i)
            noop=1




        codewrite(a, b, c, d, e,noop)

    f.write("11111111111111111111111111111111")

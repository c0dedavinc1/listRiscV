.data

testProf1: .string "ADD(1) ~ ADD(a) ~ ADD(a) ~ ADD(B) ~ ADD(;) ~ ADD(9) ~SORT~PRINT~DEL(b) ~DEL(B)~PRI~REV~PRINT"
testProf2: .string "ADD(1) ~ ADD(a) ~ add(B) ~ ADD(B) ~ ADD ~ ADD(9) ~PRINT~SORT(a)~PRINT~DEL(bb) ~DEL(B) ~PRINT~REV~PRINT"
testAdd: .string ""

.text

main:
    # I create the list 
    li s0, 0x10000000000
    li t0, 0
    sb t0, (0)s0
    sw t0, (1)s0
    
    jal test_emptylist
    
    
    
    # Terminate program 
    li a7, 10
    ecall
    

add:
    
del:
    
print:
    
sort:
    
rev:
    
sdx:
    
ssx:
              
# suite test

test_emptylist:
    
    jr ra
    
 


.data

testProf1: .string "ADD(1) ~ ADD(a) ~ ADD(a) ~ ADD(B) ~ ADD(;) ~ ADD(9) ~SORT~PRINT~DEL(b) ~DEL(B)~PRI~REV~PRINT"
testProf2: .string "ADD(1) ~ ADD(a) ~ add(B) ~ ADD(B) ~ ADD ~ ADD(9) ~PRINT~SORT(a)~PRINT~DEL(bb) ~DEL(B) ~PRINT~REV~PRINT"
testAdd: .string ""

.text
li s1, 1 # number of test 
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
    lb t0, (0)s0
    lw t1, (1)s0
    
    add t1, t1, t0 # t0 and t1 must be zero
    
    li a0, 0 # expected result
    mv a1, t1 # the result
    
    addi sp, sp, -4 # protocol for a nested function call
    sw ra, (0)sp   
    jal print_test   
    lw ra, (0)sp
    addi sp, sp, 4
    
    jr ra
    
print_test:
    li a7, 11 # preparing output for system call (print char)
    li a0, 84
    ecall

    li a7, 11 
    li a0, 69
    ecall
    
    li a7, 11 
    li a0, 83
    ecall
    
    li a7, 11 
    li a0, 84
    ecall
    
    li a7, 11 
    li a0, 32
    ecall
    
    li a7, 1
    mv a0, s1
    addi s1, s1, 1
    ecall
        
  
  
    li a7, 11 # new line
    li a0, 10
    ecall
    
    jr ra
 


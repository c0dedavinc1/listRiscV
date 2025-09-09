.data

testProf1: .string "  ADD(1) ~ ADD(a) ~ ADD(a) ~ ADD(B) ~ ADD(;) ~ ADD(9) ~SORT~PRINT~DEL(b) ~DEL(B)~PRI~REV~PRINT"
testProf2: .string "ADD(1) ~ ADD(a) ~ add(B) ~ ADD(B) ~ ADD ~ ADD(9) ~PRINT~SORT(a)~PRINT~DEL(bb) ~DEL(B) ~PRINT~REV~PRINT"
testAdd: .string ""

.text
li s1, 1 # number of test 
la s4, testProf1 # loading the command string
main:
    # I create the list 
    li s0, 0x10000000000
    li t0, 0
    sb t0, (0)s0
    sw t0, (1)s0
    
    jal test_emptylist
    # and test it
    
    li s3, 0 # s3 is the index of actual the character read by the program
    
    jal read_next_command
    
    
    
    # Terminate program 
    li a7, 10
    ecall
    

read_next_command:
    # reading the first null space
    add s4, s4, s3 # i start from I stopped the last reading 
    lb t0, (0)s4
    li t1, 32 # the null space is 32 in integer (ASCII table)
    rdc_reading_null:
        bne t0, t1, rdc_reading_null_end
    
    rdc_reading_null_end:
    jr ra

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
    li a2, 97 # the identifier of the test (a)
    
    addi sp, sp, -4 # protocol for a nested function call
    sw ra, (0)sp   
    jal print_test   
    lw ra, (0)sp
    addi sp, sp, 4
    
    jr ra
    
test_readCommand:
    
    
# a0: expected result, integer
# a1: result, integer
# a2: test ID
print_test:
    mv t0, a0 # I must save a0, it will be used in system calls
    
    li a7, 11
    mv a0, a2
    ecall
    
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
    li a0, 95
    ecall
    
    li a7, 1
    mv a0, s1
    addi s1, s1, 1
    ecall
        
    li a7, 11 
    li a0, 40
    ecall

    li a7, 11 
    li a0, 101
    ecall
    
    li a7, 11 
    li a0, 58
    ecall 
    
    li a7, 1
    mv a0, t0
    ecall
    
    li a7, 11
    li a0, 44
    ecall    
    
    li a7, 11
    li a0, 32
    ecall
    
    li a7, 11
    li a0 114
    ecall
    
    li a7, 11
    li a0, 58
    ecall 
    
    li a7, 1
    mv a0, a1
    ecall
    
    li a7, 11
    li a0, 41
    ecall
  
    li a7, 11 # new line
    li a0, 10
    ecall
    
    jr ra
 


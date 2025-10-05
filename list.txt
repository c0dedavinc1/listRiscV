.data
testProf1: .string "  ADD(1) ~ ADD(a) ~ ADD(a) ~ ADD(B) ~ ADD(;) ~ ADD(9) ~SORT~PRINT~DEL(b) ~DEL(B)~PRI~REV~PRINT"
testProf2: .string "ADD(1) ~ ADD(a) ~ add(B) ~ ADD(B) ~ ADD ~ ADD(9) ~PRINT~SORT(a)~PRINT~DEL(bb) ~DEL(B) ~PRINT~REV~PRINT"
testAdd: .string "ADD(B)    ~  "
testVoid: .string "    "
# test void by default has 3 empty space



.text
li s11, 0 # register used for testing stuff
li s1, 1 # number of test 

main:
    # I create the list 
    li s0, 0x10000000000
    li s2, 0x11000000000 # this will be ad address of an array with the rolling hash of every command
    
    addi sp, sp, -4
    sw ra, (0)sp
    jal setup_rollinghashvect
    lw ra, (0)sp
    addi sp, sp, 4
    
    li t0, 0
    sb t0, (0)s0
    sw t0, (1)s0
    
    jal test_emptylist
    # and test it
    
    la s4, testVoid # 
    
    li s3, 0 # s3 is the index of actual the character read by the program
    
    # we have to test if the read next command can read void
    jal test_rnc_1
    
    la s4, testAdd # loading the command string
    
    # The last part, when all the test are ok
    # will be executing the two test that are passed.
    
    # This will test the fact that we can read one command
    li s3, 0 # before every test we need to restart the counter of command string
    # because is a new string
    jal test_add_1
    
     
    # Terminate program 
    li a7, 10
    ecall

# This command will be insert in a for until the string is endend
read_next_command:
    # reading the first null space
    li t1, 32 # the null space is 32 in integer (ASCII table)
    rdc_reading_null:
        add s4, s4, s3 # i start from I stopped the last reading 
        lb t0, (0)s4
        bne t0, t1, rdc_reading_null_end
        # if i'm not reading a null space, go on 
        addi s3, s3, 1 # read the next character
        j rdc_reading_null
    rdc_reading_null_end:
    # at this point I will have the first character of the command just read
    # remember the list of commands: 
    # add, del, print, sort, rev, sdx, ssx
    
    # t5, index where to start
    mv t5, s3
    
    # command reading stops with (an empty space) or a parentesis
    # then I'll have where it starts the command and where
    # it ends. I will control the command before, then the
    # parenthesis (obv if the command have it)
    
    # t0: reading character
    # t1: 32, empty character
    # t2: = parenthesis
    # In the first GiF of the problem is where that stops.
        
    li t2, 40
    li t1, 32
    # The loop stops with empty character, 
    # open parenthesis, end character
    
    mv t3, s3 # that is the start of the command
    rdc_until_empty_space:
        beq t0, t1, end_rdc_until_empty_space
        beq t0, t2, end_rdc_until_empty_space
        beq t0, zero, end_rdc_until_empty_space
        
        addi s3, s3, 1 # read the next character
        add s4, s4, s3 
        lb t0, (0)s4
        
        j rdc_until_empty_space
    end_rdc_until_empty_space:
    #t3: the start of the command
    #t4: the end of command
    add s11, t3, s3 # this is a register used for testing 
    
    # checks if the command syntax is right
    command_hash:
           
    command_execute:
    
    end_commands:
        
    # if the command have wrong sintax we read until the
    # the next tilde
    rdc_next_tilde:
        
    end_rdc_next_tilde:
    
    jr ra
  
setup_rollinghashvect:
    li t0, 4936 # rolling hash di PRINT
    sw t0, (0)s2
    li t0, 928 # ADD
    sw t0, (4)s2
    li t0, 972 # DEL
    sw t0, (8)s2
    li t0, 1104 # REV
    sw t0, (12)s2
    li t0, 1172 # SSX
    sw t0, (16)s2
    li t0, 1112 # SDX 
    sw t0, (20)s2
    li t0, 2456 # SORT
    sw t0, (24)s2
    jr ra

add:
    
del:
    
print:
    
sort:
    
rev:
    
sdx:
    
ssx:
    
              
# suite test

# This will test the fact we can read a command without checking if
# it is right.
test_add_1:
    addi sp, sp, -4
    sw ra, (0)sp
    jal read_next_command
    lw ra, (0)sp
    addi sp, sp, 4
    
    li a0, 2 # the sum of the end and the start (0+2)
    mv a1, s11 # 
    li a2, 97 # the identifier of the test (a)
    
    addi sp, sp, -4 # protocol for a nested function call
    sw ra, (0)sp   
    jal print_test   
    lw ra, (0)sp
    addi sp, sp, 4
    
    li s11, 0
    
    jr ra
    
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
    
# Testing if read until the first right character for 
# command is okay.
test_rnc_1:
    # first we need to save the ra
    addi sp, sp, -4
    sw ra, (0)sp
    jal read_next_command
    lw ra, (0)sp
    addi sp, sp, 4
    # at this point we know that s3 need to be 3
    li a0, 3
    mv a1, s3
    li a2, 114 # the test is identified with r
    
    addi sp, sp, -4 
    sw ra, (0)sp
    jal print_test
    lw ra, (0)sp
    addi sp, sp, 4
    
    jr ra
    
    
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
 




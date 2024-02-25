# conversion.asm program
# For CMPSC 64
#
# Don't forget to:
#   make all arguments to any function go in $a0 and/or $a1
#   make all returned values from functions go in $v0

.text
conv:
    # TODO: Write your function code here
    # z is $t1, i is $t0, $a0 is x, $a1 is y
    li $t1, 0 
    li $t0, 0
    li $t3, 0

    loop:
        slti $t3, $t0, 8 # if i < 8 store in $t3
        beq $t3, $zero, exitloop # branch if !(i < 8)
        sll $t4, $a0, 3 # multiply x by 8

        add $t1, $t1, $a1 # add y to z
        sub $t1, $t1, $t4 # subtract 8x from zero

        slti $t5, $a0, 2 # determine if x is less than 2
        bne $t5, $zero, skip # if x is less than 2, skip
            addi, $a1, $a1, -1
        skip:
            addi $a0, $a0, 1

        addi $t0, $t0, 1

        j loop

    exitloop:
        move $v0, $t1
        j $ra


main:  # DO NOT MODIFY THE MAIN SECTION
    li $a0, 5
    li $a1, 7

    jal conv

    move $a0, $v0
    li $v0, 1
    syscall

exit:
	# TODO: Write code to properly exit a SPIM simulation
    li $v0, 10
    syscall

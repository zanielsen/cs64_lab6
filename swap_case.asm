# swap_case.asm program
# For CMPSC 64
#
# Data Area
.data
    buffer: .space 100
    input_prompt:   .asciiz "Enter string:\n"
    output_prompt:   .asciiz "Output:\n"
    convention: .asciiz "Convention Check\n"
    newline:    .asciiz "\n"

.text

# DO NOT MODIFY THE MAIN PROGRAM
main:
    la $a0, input_prompt    # prompt user for string input
    li $v0, 4
    syscall

    li $v0, 8       # take in input
    la $a0, buffer
    li $a1, 100
    syscall
    move $s0, $a0   # save string to s0

    ori $s1, $0, 0
    ori $s2, $0, 0
    ori $s3, $0, 0
    ori $s4, $0, 0
    ori $s5, $0, 0
    ori $s6, $0, 0
    ori $s7, $0, 0

    move $a0, $s0
    jal SwapCase

    add $s1, $s1, $s2
    add $s1, $s1, $s3
    add $s1, $s1, $s4
    add $s1, $s1, $s5
    add $s1, $s1, $s6
    add $s1, $s1, $s7
    add $s0, $s0, $s1

    la $a0, output_prompt    # give Output prompt
    li $v0, 4
    syscall

    move $a0, $s0
    jal DispString

    j Exit

DispString:
    addi $a0, $a0, 0
    li $v0, 4
    syscall
    jr $ra

ConventionCheck:
    addi    $t0, $0, -1
    addi    $t1, $0, -1
    addi    $t2, $0, -1
    addi    $t3, $0, -1
    addi    $t4, $0, -1
    addi    $t5, $0, -1
    addi    $t6, $0, -1
    addi    $t7, $0, -1
    ori     $v0, $0, 4
    la      $a0, convention
    syscall
    addi    $v0, $zero, -1
    addi    $v1, $zero, -1
    addi    $a0, $zero, -1
    addi    $a1, $zero, -1
    addi    $a2, $zero, -1
    addi    $a3, $zero, -1
    addi    $k0, $zero, -1
    addi    $k1, $zero, -1
    jr      $ra
    
Exit:
    ori     $v0, $0, 10
    syscall

# COPYFROMHERE - DO NOT REMOVE THIS LINE

# YOU CAN ONLY MODIFY THIS FILE FROM THIS POINT ONWARDS:
SwapCase:
    #TODO: write your code here, $a0 stores the address of the string
    # save $s0 and $s1 on the stack
        # PUSH these 2 words into stack
        addiu $sp, $sp, -8
        sw $s0, 0($sp)
	sw $ra, 4($sp)

	
	move $s0, $a0
	loop:
		lbu $t0, 0($s0)
		beq $t0, $zero, done
		slti $t1, $t0, 65
		beq $t1, $zero, checkMax
		j skip

		checkMax:
			slti $t1, $t0, 91
			beq $t1, $zero, checkLowercase
			addi $t2, $t0, 32

			move $a0, $t0
			li $v0, 11
			syscall

			la $a0, newline
			li $v0, 4
			syscall

			sb $t2, 0($s0)

			lbu $a0, 0($s0)
			li $v0, 11
			syscall

			la $a0, newline
			li $v0, 4
			syscall
				
			jal ConventionCheck

			j skip

		checkLowercase:
			slti $t1, $t0, 123
			beq $t1, $zero, skip
			slti $t1, $t0, 97 # if <61, then =1, so if 0, skip
			bne $t1, $zero, skip
			addi $t2, $t0, -32

			move $a0, $t0
			li $v0, 11
			syscall

			la $a0, newline
			li $v0, 4
			syscall

			sb $t2, 0($s0)

			lbu $a0, 0($s0)
			li $v0, 11
			syscall

			la $a0, newline
			li $v0, 4
			syscall

			jal ConventionCheck

			j skip

		skip:
			addi $s0, $s0, 1

		j loop
	
	done:
		lw $s0, 0($sp)
		lw $ra, 4($sp)
		addiu $sp, $sp, 8




    # Do not remove the "jr $ra" line below!!!
    # It should be the last line in your function code!
    jr $ra

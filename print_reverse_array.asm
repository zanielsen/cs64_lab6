# print_array.asm program
# For CMPSC 64
#
# Don't forget to:
#   make all arguments to any function go in $a0 and/or $a1
#   make all returned values from functions go in $v0

.data
	array: .word 1 2 3 4 5 6 7 8 9 10
	cout: .asciiz "The contents of the array in reverse order are:\n"
	newline: .asciiz "\n"

.text
printA:
    # TODO: Write your function code here
	li $t0, 0 # t0 is the iterator
	move $t2, $a0 # store array in $t2
	li $t4, 4
	mult $a1, $t4
	mflo $t4
	addi $t4, $t4, -4
	add $t2, $t2, $t4


	loop:
	slt $t1, $t0, $a1
	beq $t1, $zero, exitloop

	lw $a0, 0($t2)  # a0 = value at current p
	li $v0, 1
	syscall
	la $a0, newline
	li $v0, 4
	syscall

	# increment pointer by 4
	addi $t2, $t2, -4
	addi $t0, $t0, 1
	j loop

	exitloop:
		j $ra

main:  # DO NOT MODIFY THE MAIN SECTION
	li $v0, 4
	la $a0, cout
	syscall

	la $a0, array
	li $a1, 10

	jal printA

exit:
	# TODO: Write code to properly exit a SPIM simulation
	li $v0, 10
    syscall


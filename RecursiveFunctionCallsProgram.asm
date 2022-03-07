# Mohamed Yasser Anwar Mahmoud AlKayd
# Recursive Function Calls Program

# - Start of the Program -

.data
	prompt: .asciiz "Enter a number to find the answer to the function: "
	result: .asciiz "The answer to the function is : "
	number: .word 0
	answer: .word 0
.text
	.globl main
	main: 
	# ask the user to enter an integer by asking for it by displaying the prompt
	li $v0, 4
	la $a0, prompt
	syscall
	
	# get input from the user by using the designated syscall, 5
	li $v0, 5
	syscall
	sw $v0, number
	
	# call the function 
	lw $a0, number 
	jal base # the value from function will be returned in $v0
	sw $v0, answer # get the answer from $v0 and move it into the global variable
	
	# display the message for the result
	li $v0, 4
	la $a0, result
	syscall
	
	# to display the result
	li $v0, 1
	lw $a0, answer
	syscall
	
	# the end of the program
	li $v0, 10
	syscall

base: # this is the base function
	bgt $a0, 1, function 
	addi $v0, $0, 1
	jr $ra
	
function:
	sub $sp, $sp, 12
	sw $ra, 0($sp) 
	
	sw $a0, 4($sp)       #saved n
	add $a0, $a0, -1	# n-1
	jal base		
	
	lw $a0, 4($sp)		# restore n
	sw $v0, 8($sp)		# save return value of f(n-1)
	
	add $a0, $a0, -3	# n-3
	jal base
	
	lw $t0, 8($sp)
	add $v0, $t0, $v0	# add 1
	addi $v0, $v0, 1
	
	lw $ra, 0($sp)
	add $sp, $sp, 12
	jr $ra

# - End of the Program -

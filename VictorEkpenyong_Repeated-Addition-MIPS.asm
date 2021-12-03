# Victor Ekpenyong
# Assembly Language
# Recursive Multiplication (Repeated Addition)

.data
	prompt1: .asciiz "Enter the multiplicand: "
	prompt2: .asciiz "Enter the multiplyer: "
	result:  .asciiz "The answer to "
	times:   .asciiz " * "
	is:	 .asciiz " is "
	
.text
	.globl main
main:
	#User prompted for multiplicand
	li $v0, 4
	la $a0, prompt1
	syscall
	
	#User inputs multiplicand 
	li $v0, 5
	syscall
	
	#User input stored in $a3 (for main function)
	move $a3, $v0
	
	#User prompted for multiplyer
	li $v0, 4
	la $a0, prompt2
	syscall
	
	#User inputs multiplyer
	li $v0, 5
	syscall
	
	#User input stored in $a2 (for main function)
	move $a2, $v0
	
	#User inputs stored in $a0 & $a1 for recursive function
	move $a1, $v0
	move $a0, $a3
	
	#Function Call
	jal Repeat_Addition
	
	#Answer returned from function call stored in $t0
	move $t0, $v0
	
	#The answer sentence shown to user
	li $v0, 4
	la $a0, result
	syscall
	
	#Inputed multiplicand shown again
	li $v0 1
	move $a0, $a3
	syscall
	
	# * symbol shown to show multiplication
	li $v0, 4
	la $a0, times
	syscall
	
	#Inputed multiplyer shown again
	li $v0 1
	move $a0, $a2
	syscall
	
	#The word is shown part of answer sentence (The answer of x * y is )
	li $v0, 4
	la $a0, is
	syscall
	
	#Answer from function shown next in answer sentence (The answer of x * y is z)
	li $v0, 1
	move $a0, $t0
	syscall
	
	#End of program
	li $v0, 10
	syscall
	

.globl Repeat_Addition

Repeat_Addition: 
	#Stack implemented with return address and multiplicand
	addi $sp, $sp, -8
	sw $ra, 0($sp)
	sw $a0, 4($sp)

	#Base case test to see if multiplyer is 1, if so jump to BaseCase label
	beq $a1, 1, BaseCase
	
	#Base case fails, subtract one from multiplyer
	add $a1, $a1, -1
	
	#Call function again recursively
	jal Repeat_Addition
	
	#Add current multiplicand to current value of $v0 into $v0
	add $v0, $v0, $a0
	
	#jump to exit label to restore stack
	j exit
	
BaseCase:
	#add multiplicand to $v0 then exit
	add $v0, $a0, $zero
	
exit:	
	#restore stack then jump to return address
	lw $ra, 0($sp)
	lw $a0, 4($sp)
	addi $sp, $sp, 8
	jr $ra
	
	
	 
	  
	    

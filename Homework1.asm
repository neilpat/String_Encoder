# HOMEWORK #1
# NAME: NIRAL PATEL
# SBU ID: 110626877

.data 
.align 2
numargs: .word 0
arg1: .word 0 
arg2: .word 0
arg3: .word 0 
Err_string: .asciiz "ARGUMENT ERROR"
part2: .asciiz "Part 2"
part3: .asciiz "Part 3"

arg_2: .asciiz "ARG2: "
arg_3: .asciiz "\nARG3: "
hammering: .asciiz "\nHamming Distance: "
sum: .asciiz "\nSum: "
odd_count: .asciiz "\n # of Odds: "
even_count: .asciiz "\n # of Even: "
last_value: .asciiz "\nLast Value Drawn: "
total_values: .asciiz "\nTotal Values: "
power_of_2: .asciiz "\nPower of 2: "
multiple_of_2: .asciiz "\nMultiple of 2: "
multiple_of_4: .asciiz "\nMultiple of 4: "
multiple_of_8: .asciiz "\nMultiple of 8: "







.macro load_args
	sw $a0, numargs		#stores contents of register $a0 into label arguments
	lw $t0, 0($a1)		#loads first argument into temp 0
	sw $t0, arg1		#transfers t0 into arg1
	lw $t0, 4($a1)		
	sw $t0, arg2
	lw $t0, 8($a1)
	sw $t0, arg3
.end_macro

.text
.globl main
main:
	load_args()
	lw $t0, numargs
	blt $t0, 2, error	
	bgt $t0, 3, error

#------------------------PART 1--------------------------------

	lw $t0,arg1
	lb $t1,1($t0)
	bnez $t1, error
	
	lb $t2, 0($t0)
	beq $t2, 65, part_2
	beq $t2, 97, part_2	
	beq $t2, 82, part_3
	bne $t2, 114, error
	j part_3

#to print error	

part_2:
	lw $t0, numargs
	bne $t0,3,error
	
#-------------------------ARGUMENT 2--------------------------
	lw $t0, arg2
	lb $t2,3($t0)
	sll $t2,$t2,8
	
	lb $t1,2($t0)
	add $t2,$t2,$t1
	sll $t2,$t2,8
	
	lb $t1,1($t0)
	add $t2,$t2,$t1
	sll $t2,$t2,8
	
	lb $t1,0($t0)
	add $t2,$t2,$t1
	
	move $s0,$t2		#store first 4 of arg2 in s0
	
	
	li $v0,4		#print ARG2: 
	la $a0,arg_2
	syscall
	
	li $v0,35		# BINARY
	la $a0,($t2)
	syscall
	
	li $a0, 32
	li $v0, 11  		# syscall number for printing character
	syscall	
	
	li $v0,34		# HEX
	la $a0,($t2)
	syscall
	
	li $a0, 32
	li $v0, 11  		# syscall number for printing character
	syscall
	
	li $v0,1		# 2's complement
	la $a0,($t2)
	syscall
	
	li $a0, 32
	li $v0, 11  		# syscall number for printing character
	syscall
	
	li $v0,100		# 1's complement
	la $a0,($t2)
	syscall
	
	li $a0, 32
	li $v0, 11  		# syscall number for printing character
	syscall	
	
	li $v0,101		#SIGNED MANGNITUDE
	la $a0,($t2)
	syscall
	
#ARGUMENT 3

	lw $t0, arg3
	lb $t3,3($t0)
	sll $t3,$t3,8
	
	lb $t1,2($t0)
	add $t3,$t3,$t1
	sll $t3,$t3,8
	
	lb $t1,1($t0)
	add $t3,$t3,$t1
	sll $t3,$t3,8
	
	lb $t1,0($t0)
	add $t3,$t3,$t1
	
	move $s1,$t3			#store first 4 of arg2 in s1
	
	li $v0,4			#print ARG3: 
	la $a0,arg_3
	syscall
	
	li $v0,35			# BINARY
	la $a0,($t3)
	syscall
	
	li $a0, 32
	li $v0, 11  			# syscall number for printing character
	syscall	
	
	li $v0,34			# HEX
	la $a0,($t3)
	syscall
	
	li $a0, 32
	li $v0, 11  			# syscall number for printing character
	syscall
	
	li $v0,1			# 2's complement
	la $a0,($t3)
	syscall
	
	li $a0, 32
	li $v0, 11 			# syscall number for printing character
	syscall
	
	li $v0,100			# 1's complement
	la $a0,($t3)
	syscall
	
	li $a0, 32
	li $v0, 11  			# syscall number for printing character
	syscall
	
	li $v0,101			#SIGNED MANGNITUDE
	la $a0,($t3)
	syscall

	li $v0,4
	la $a0, hammering
	syscall
	
	li $v0,1
	move $a0,$t4
	
	
	xor $t4,$t2,$t3			#store XOR of s0 and s1 in t4
	
	li $t5,0			#to count bits
	li $t7,0			#to count no. of non 0
	
	
betterforloop:
	andi $t1, $t4, 1
	bne $t1, 1, branch
	addi $t7, $t7, 1
	branch:	
	srl $t4, $t4, 1
	addi $t5, $t5, 1
	blt $t5, 35, betterforloop

	move $a0, $t7
	li $v0, 1
	syscall
	
	j end

	
part_3:
	lw $t0,numargs
	bne $t0,2,error
	lw $t0,arg2
	
  	li $t1,0			#for statment to get sum of string
  	li $t5,0			#stores sum of string
  	li $t6,0
  calculateSum:
  	lb $t4, 0($t0)
  	blt  $t4,'0',else
  	bgt  $t4,'9',else
  	
  	li $t7,'0'
  	li $t2,10
  	
  	mul $t6,$t5,$t2
  	sub $t7,$t4,$t7
  	add $t5,$t6,$t7
  	addi $t0,$t0,1
  	
  	j calculateSum
  	
  	else:
  	
  	li $v0,4		#display the string "sum"
  	la $a0,sum
  	syscall
  	
  	li $v0,1		#display the sum
  	la $a0,($t5)
  	syscall
  	
  	la $a0,0		#change a0 t0 0
  	move $a1,$t5		#move the sum to a1
	
	li $v0,40
	syscall
  	
  	li $s0,0		#number of values drawn
  	li $s1,0		#number of odd values drawn
  	li $s2,0		#number of even values drawn
  	li $s3,0		#number of values which are power of 2
  	li $s4,0		#number of values which are multiple of 2
  	li $s5,0		#number of values which are multiple of 4
  	li $s7,0		#number of values which are multiple of 8
  	
  while_loop:
  	la $a0,0
  	li $a0,1024
  	li $v0,42		
  	syscall			#generate Random Val
  	li $a0,1
  	syscall
  	
  	#printing the random number generated
  	li $v0,1
  	la $a0,($a0)
  	syscall
  	
  	#temp break statement
  	bgt $a0,52,print
  	
  	#increasing numbers generated count by 1
  	addi $s0,$s0,1
  	
  	li $a0, 32
	li $v0, 11  		# syscall number for printing character
	syscall
 
  	addi $s0,$s0,1		#add to values drawn counter
  	
  	li $s6,0
  	andi $s6,$a0,1
  	bne $s6,1,if_not_odd
  	addi $s1,$s1,1
  if_not_odd:
  	
  	j while_loop
  	
  print:
  	li $v0,4		#print total values string
  	la $a0,total_values
  	syscall 
  	li $v0,1		#print tota_values value
  	la $a0,($s0)
  	syscall
  	
  	li $v0,4		#print even count string
  	la $a0,even_count
  	syscall 
  	li $v0,1		#print even count value
  	la $a0,($s2)
  	syscall
  	
  	li $v0,4		#print odd count string
  	la $a0,odd_count
  	syscall 
  	li $v0,1		#print odd count value
  	la $a0,($s1)
  	syscall
  	
	j end
error:
	
	li $v0, 4
	la $a0, Err_string
	syscall

	li $v0,10
	syscall
end:
	li $v0,10
	syscall

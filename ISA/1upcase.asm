.data 
string: .asciiz "WELCOME TO COMPUTER ARCHITECTURE CLASS"
answer: .asciiz "\n"


.text
la $t1, string	        # Load address of the given string   

nextCh: 
lb $t2, 0($t1)         	# Load byte from string 

beq $t2,32,L1         	# if space (ascii value=32) branch to L1

L2:	                # Convert Upper case to lower case
beqz $t2, display	# if string ends branch to display

add $t2, $t2, 32	# add 0x20, i.e., 32 in decimal to convert from upper case to lower case, storing byte in $t2
sb $t2, 0($t1)	        # Restoring the byte (lower case ascii value)
bne $t1,0,L1	        # Branch to label L1 if $t1=0 

L1:	                # Move to the next byte
add $t1, $t1, 1	        # Increment $t1
j nextCh	        # Unconditional jump to label- nextCh

display:
 la $a0, string		# Load address of the string  
li $v0,4		# syscall number 4 will print string whose address is in $a0 
syscall 		# system call to actually print the string --- Final answer Lower case string 

la $a0, answer	        # Load address of the string 
li $v0,4		# syscall number 4 - print string
syscall	        	# system call to actually print the string --- newline character "\n"

li $v0, 10		# Syscall number 10 is to terminate the program --- load syscall number 10 in $v0
syscall 		# exit now




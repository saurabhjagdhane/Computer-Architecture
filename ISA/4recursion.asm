.data

# Create some null terminated strings to use
strPrompt1:	 .asciiz "Enter the value of i:" 
strPrompt2:	 .asciiz "Enter the value of x:" 
strResult:	 .asciiz "Fix(i,x) is " 
strCR:		 .asciiz "\n" 


.text
		.globl main
main:           
                
		# STEP 1 -- get the first operand
		# Print a prompt asking user for input
		li $v0, 4   # syscall number 4 will print string whose address is in $a0       
		la $a0, strPrompt1      # "load address" of the string
		syscall     # actually print the string  

		# Now read in the 1st operand 
		li $v0, 5      # syscall number 5 will read an int
		syscall        # actually read the int
		move $s0, $v0  # save result in $s0 for later
                
                # STEP 2 -- get the 2nd operand
		# Print a prompt asking user for input
		li $v0, 4   # syscall number 4 will print string whose address is in $a0       
		la $a0, strPrompt2      # "load address" of the string
		syscall     # actually print the string  

		# Now read in the 2nd operand 
		li $v0, 5      # syscall number 5 will read an int
		syscall        # actually read the int
		move $s1, $v0  # save result in $s0 for later
               
                #step 3 -- pass the arguments and call the function "fix"
		move $a0, $s0  #move 1st parameter i.e. i into $a0 
		move $a1, $s1  #move 2nd parameter i.e. x into $a1 
		jal fix        #call fix function
                move $s2, $t0  #move the returned value i.e. result from $t0 to $s2

		# STEP 4 -- print the result
                # First print the string prelude  
		li $v0, 4      # syscall number 4 -- print string
	        la $a0, strResult   
	        syscall        # actually print the string   
	        # Then print the result
	        li $v0, 1       # syscall number 1 -- print int
	        move $a0, $s2   # add our operands and put in $a0 for print
	        syscall         # actually print the int
		# Finally print a carriage return
		li $v0, 4      # syscall for print string
	        la $a0, strCR  # address of string with a carriage return
	        syscall        # actually print the string

		# STEP 5 -- exit
		li $v0, 10     # Syscall number 10 is to terminate the program
		syscall        # exit now

fix:            addi $sp, $sp, -8  #decrementing stack to store return address for the function call
                sw $ra, 0($sp)
                
                ble $a1, 0 elseif   # if(x>0)
                add $a1, $a1, -1    # decrementing x
                addi $t0,$t0,1      #add '1' to result if x>0
                
               jal fix
               addi $sp, $sp, 8  #incrementing stack to get return address
               lw $ra, 0($sp)    #load return address from stack to $ra
               jr $ra
                
elseif:        addi $sp, $sp, -8    #decrementing stack to store return address for the function call
               sw $ra, 0($sp)
               ble $a0, 0 else       #if(i>0)
               add $a0,$a0, -1       #decrementing i i.e. new i=i-1
               move $a1, $a0        # storing i in x i.e. passing both parameters as new i(i.e. old i-1)
               addi $t0,$t0,5       #return ans with adding 5
                
               jal fix
               addi $sp, $sp, 8  #incrementing stack to get return address
               lw $ra, 0($sp)    #load return address from stack to $ra
               jr $ra 
                
else:          addi $sp, $sp, -8  #decrementing stack to store return address for the function call
               sw $ra, 0($sp)
               addi $t0,$t0,1       #return 1
               addi $sp, $sp, 8  #incrementing stack to get return address
               lw $ra, 0($sp)    #load return address from stack to $ra
               jr $ra                                      

.data

str1:		 .asciiz "Enter the first operand:" 
str2:            .asciiz "Enter the second operand:" 
strResult1:	 .asciiz "square of op 1 is " 	 
strResult2:	 .asciiz "square of op 2 is " 
strmul:	         .asciiz "multiplication is " 	
strResult:	 .asciiz "10u^2 + 4uv + v^2 -1 =  " 
strCR:		 .asciiz "\n" 

.text
.globl main
main:
li $v0, 4         # syscall number 4 will print string whose address is in $a0       
la $a0, str1      # "load address" of the string
syscall           # actually print the string  

		  # Now read in the first operand 
li $v0, 5         #  syscall number 5 will read an int
syscall           # actually read the int
move $s0, $v0     # save result in $s0 for later

		  # STEP 2 -- repeat above steps to get the second operand
		  # First print the prompt
li $v0, 4         # syscall number 4 will print string whose address is in $a0   
la $a0, str2      # "load address" of the string
syscall           # actually print the string

		  #  Now read in the second operand 
li $v0, 5         # syscall number 5 will read an int
syscall           # actually read the int
move $s1, $v0     # save result in $s1 for later
sub $v0,$v0,$v0

move $a0,$s0      
jal sq            # call square function
move $s2, $v0     #move result i.e. u^2 into $s2 reg
sub $v0,$v0,$v0

move $a0,$s1
jal sq            # call square function
move $s3, $v0     # square of 2nd operand i.e. v^2 in s3

li $v0, 4         # syscall number 4 -- print string
la $a0, strResult1   
syscall           # actually print the string   
	          # Then print the actual result
li $v0, 1         # syscall number 1 -- print int
move $a0, $s2     # print $s2 i.e. u^2
syscall           

li $v0, 4         # syscall for print string
la $a0, strCR     # address of string with a carriage return
syscall           # actually print the string

li $v0, 4         # syscall number 4 -- print string
la $a0, strResult2   
syscall           # actually print the string   
	          # Then print the actual result
li $v0, 1         # syscall number 1 -- print int
move $a0, $s3     # print $s3 i.e. v^2
syscall    

move $a0,$s0      # store u in $a0 for passing as parameter 1
move $a1,$s1      # store v in $a1 for passing as parameter 2
jal mul           # call multiply function
move $s4,$v0      # store multiplication of 2 operands i.e. u*v in s4

li $v0, 4         # syscall for print string
la $a0, strCR     # address of string with a carriage return
syscall           # actually print the string

li $v0, 4         # syscall number 4 will print string whose address is in $a0   
la $a0, strmul    # "load address" of the string
syscall           # actually print the string

li $v0, 1         # syscall number 1 -- print int
move $a0, $s4     # print $s4
syscall     

move $a0,$s2      # store u as 1st parameter
li $a1,10         # pass 10 as 2nd parameter
jal mul           # call multiply function
move $s5,$v0      # store 10u^2 in $s5

add $s5,$s5,$s3   # 10u^2 + v^2

move $a0,$s4      
li $a1,4
jal mul           # call multiply function
add $s5,$s5,$v0   # 10u^2 + v^2 + 4uv 

add $s5,$s5,-1    # 10u^2 + v^2 + 4uv - 1    

li $v0, 4         # syscall for print string
la $a0, strCR     # address of string with a carriage return
syscall           # actually print the string

li $v0, 4         # syscall number 4 will print string whose address is in $a0   
la $a0, strResult # "load address" of the string
syscall           # actually print the string

li $v0, 1         # syscall number 1 -- print int
move $a0, $s5     # add our operands and put in $a0 for print
syscall           # actually print the int

li $v0, 10        # Syscall number 10 is to terminate the program
syscall     

                  #square function implemented by adding number to itself by that number times
sq: sub $v0,$v0,$v0
    move $t4,$a0
sq1:blez $t4,stop1  # branch to stop1 label if $t4 cintents are less than or equal to 0
    add $v0,$v0,$a0 # add parameter into $v0
    addi $t4,$t4,-1 # decrement the parameter
    j sq1           #loop
stop1: jr $ra       # jump to return address

                 #multiply function implemented by adding multiplicant to itself for multiplier times
mul:sub $v0,$v0,$v0
     move $t4,$a0
     move $t5,$a1
m1:  blez $t4,stop2   # branch to stop2 label if $t4 cintents are less than or equal to 0
     add $v0,$v0,$t5  # add 1st parameter into $v0
     addi $t4,$t4,-1  # decrement second parameter
     j m1	      #loop
stop2: jr $ra	      # return statement

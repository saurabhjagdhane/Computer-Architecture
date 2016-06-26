.data
	
strResult:	 .asciiz "sum of all array elements  =  " 
arrResult:	 .asciiz "All array elements  =  " 
strCR:		 .asciiz "\n" 
array:           .word   0 : 10        # "array" of 5 words
size:            .word  11             # size of "array" 
sum:             .space  4             #result
i: 		 .word 0
.text
.globl main
main:

# initialize array with values 
la $s1, array   # load address of array into $s1 reg     
la $s3, sum     # load address of sum into $s3 reg 
lw $s2, size    # load value of size into $s2 reg 
lw $t1, i       # load value of i into $t1 reg 
li $t2, 3       # load immediate value into $t2 reg 

start:bge $t1, $s2 mid   # branch to label mid if $t1 greater then equal to $s2
      addi $t1, $t1, 1   # increment $t1
      mult  $t1, $t2     # this step calculates 3(i+1)
      mflo $t3           # store contents of lo reg into $t3
      sw $t3, 0($s1)     # store result in memory at sum
      addi $s1, $s1, 4   # point to next array location
      j start            #loop

mid:  la $s1, array        # point to starting address of array
      lw $t1, i            # load value of i
      li $v0, 4      # syscall for print string
      la $a0, arrResult  # address of string with a carriage return
      syscall        # actually print the string

print:bge $t1, $s2 stop  # branch to label stop if i greater than equal to size
      addi $t1, $t1, 1   #increment i
      lw $t4, 0($s1)     # load element pointed by $s1 into $t4 
      
      li $v0, 4      # syscall for print string
      la $a0, strCR  # address of string with a carriage return
      syscall        # actually print the string 
      
      move $a0, $t4
      li $v0, 1         # syscall number 1 -- print int
      syscall           # actually print the int
      
      move $a0, $s1      # put pointer pointing array address as 1 parameter for psum function
      move $a1, $s3      # put pointer pointing result address as other parameter for psum function 
      jal psum           # call psum function
      addi $s1, $s1, 4   # increment pointer to point to next array element
      j print            #loop
      
      
 stop:li $v0, 4      # syscall for print string
      la $a0, strCR  # address of string with a carriage return
      syscall        # actually print the string

      li $v0, 4      # syscall for print string
      la $a0, strResult  # address of string with a carriage return
      syscall        # actually print the string

      li $v0, 1         # syscall number 1 -- print int
      lw $a0, 0($s3)
      syscall           # actually print the int
      
      li $v0, 10  # Syscall number 10 is to terminate the program
      syscall     

psum:lw $t3, 0($a0)     # load 1st parameter into $t3
     add $t5, $t5, $t3  # add array element pointed into the $t5 reg
     sw $t5, 0($a1)     # store $t5 contents into address pointed by 2nd parameter i.e. pointer
     jr $ra             # return statement

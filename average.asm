.text
nop
addi $3, $0, 1		#Init Values
sw $3, 1($0)
addi $3, $0, 2
sw $3, 2($0)
addi $3, $0, 3
sw $3, 3($0)
addi $3, $0, 4
sw $3, 4($0)
addi $3, $0, 5
sw $3, 5($0)
addi $3, $0, 6
sw $3, 6($0)
addi $3, $0, 7
sw $3, 7($0)

addu $3, $30, $0	# Add the switches
lw $4, 1($0)		# Sum 0-7 + Switches
addu $3, $3, $4
lw $4, 2($0)
addu $3, $3, $4
lw $4, 3($0)
addu $3, $3, $4
lw $4, 4($0)
addu $3, $3, $4
lw $4, 5($0)
addu $3, $3, $4
lw $4, 6($0)
addu $3, $3, $4
lw $4, 7($0)
addu $3, $3, $4

srl $3, $3, 3		# Divide by 8
sw $3, 8($0)		# Store in 8

# HEX 0
mult $3, $2        	# snapshot * .1
mfhi $3             	# snapshot/10
mflo $4             	# temp % 10
multu $4, $10         
mfhi $4
sll $4, $4, 0		# Offset temp           
add $6, $0, $4    	# Store digit           

# HEX 1
mult $3, $2        	# snapshot * .1
mfhi $3             	# snapshot/10
mflo $4             	# temp % 10
multu $4, $10         
mfhi $4
sll $4, $4, 4		# Offset temp           
add $6, $6, $4    	# Store digit   

# HEX 2
mult $3, $2        	# snapshot * .1
mfhi $3             	# snapshot/10
mflo $4             	# temp % 10
multu $4, $10         
mfhi $4
sll $4, $4, 8		# Offset temp           
add $6, $6, $4    	# Store digit   

# HEX 3
mult $3, $2        	# snapshot * .1
mfhi $3             	# snapshot/10
mflo $4             	# temp % 10
multu $4, $10         
mfhi $4
sll $4, $4, 12		# Offset temp           
add $6, $6, $4    	# Store digit  

# HEX 4
mult $3, $2        	# snapshot * .1
mfhi $3             	# snapshot/10
mflo $4             	# temp % 10
multu $4, $10         
mfhi $4
sll $4, $4, 16		# Offset temp           
add $6, $6, $4    	# Store digit  

# HEX 5
mult $3, $2        	# snapshot * .1
mfhi $3             	# snapshot/10
mflo $4             	# temp % 10
multu $4, $10         
mfhi $4
sll $4, $4, 20		# Offset temp           
add $6, $6, $4    	# Store digit  

# HEX 6
mult $3, $2        	# snapshot * .1
mfhi $3             	# snapshot/10
mflo $4             	# temp % 10
multu $4, $10         
mfhi $4
sll $4, $4, 24		# Offset temp           
add $6, $6, $4    	# Store digit  

# HEX 7
mult $3, $2        	# snapshot * .1
mfhi $3             	# snapshot/10
mflo $4             	# temp % 10
multu $4, $10         
mfhi $4
sll $4, $4, 28		# Offset temp           
add $6, $6, $4    	# Store digit  

add $30, $6, $0


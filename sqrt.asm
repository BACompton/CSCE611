#3 imported switch value
#4 guess, value
#5 step

# Proj 5 VSIM time: 48000 nm
	add $11, $30, $zero
        sll $11, $11, 14
        add $4, $0, $zero
        addi $5, $0, 256
        sll $5, $5, 14          #setup
       
begin:  	mult $4, $4             #algorithm
        	mflo $8
        	mfhi $9
        	srl $8, $8, 14
        	sll $9, $9, 18
        	add $6, $8, $9          #x^2
        	bgez $11, subtract
		srl $16, $6, 1
		srl $12, $11, 1
		sub $6, $16, $12
		j if
subtract:	sub $6, $6, $11          #subtract
if:       	beq $6, $zero, stop     #if equal to zero
        	bgez $6, ifg
 		
        	add $4, $4, $5          #if less than zero
       		j end
       
ifg:    	sub $4, $4, $5          #if greater than zero
        	j end
       
       
stop:   	add $5, $zero, $zero
       
end:     	srl $5, $5, 1
 		bne $5, $zero, begin

add $3, $4, $0
addi $10, $0, 10
addi $2, $0, 0x1999
sll $2, $2, 16
addi $2, $2, 0x999A

		addi $25, $0, 25000
		sll $25, $25, 2
		mult $3, $25
		mflo $4
		srl $4, $4, 13
		andi $6, $4, 0x1
		beq $zero, $6, mvhi
		addi $4, $4, 2
mvhi:	srl $4, $4, 1
		mfhi $5
		sll $5, $5, 18
		add $3, $4, $5

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

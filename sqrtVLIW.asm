#3 imported switch value
#4 guess, value
#5 step

# Proj 5 time: 44400 ns
# Proj 6 VSIM: 34000 ns
	add $11, $30, $zero
	add $4, $0, $zero
        
	sll $11, $11, 14
	addi $5, $0, 256
        
        sll $5, $5, 14          #setup
	addi $2, $0, 0x1999

begin:  	mult $4, $4             #algorithm
		lui $1, 0        	

		mflo $8
        	mfhi $9

        	srl $8, $8, 14
        	sll $9, $9, 18
        	
		add $6, $8, $9          #x^2
		addi $25, $0, 25000        	

		sub $6, $6, $11          #subtract
        	addi $10, $0, 10
		
		beq $6, $zero, stop     #if equal to zero
        	sll $25, $25, 2
        	
		bgez $6, ifg
        	nop 

		j end
        	add $4, $4, $5          #if less than zero

ifg:    	j end
		sub $4, $4, $5          #if greater than zero
        	       
       
stop:   	add $5, $zero, $zero
		nop
       
end:     	srl $5, $5, 1
		add $3, $4, $0	

 		bne $5, $zero, begin
		ori $1, $1, 0x999A
		
		mult $3, $25
		nop		

		mflo $4
		mfhi $5

		srl $4, $4, 13
		sll $5, $5, 18		

		andi $6, $4, 0x1
		sll $2, $2, 16

		beq $zero, $6, mvhi
		add $2, $2, $1

		addi $4, $4, 2
		nop

mvhi:	srl $4, $4, 1
		nop

		add $3, $4, $5
		nop

# HEX 0
mult $3, $2        	# snapshot * .1
nop

mfhi $3             	# snapshot/10
mflo $4             	# temp % 10

multu $4, $10         
nop

mfhi $4
mult $3, $2        	# snapshot * .1 HEX 1

sll $4, $4, 0		# Offset temp           
mfhi $3             	# snapshot/10 HEX 1

add $6, $0, $4    	# Store digit           
mflo $4             	# temp % 10

# HEX 1
multu $4, $10
nop
   
mfhi $4
mult $3, $2        	# snapshot * .1

sll $4, $4, 4		# Offset temp           
mfhi $3             	# snapshot/10

add $6, $6, $4    	# Store digit   
mflo $4             	# temp % 10

# HEX 2
multu $4, $10
nop
         
mfhi $4
mult $3, $2        	# snapshot * .1

sll $4, $4, 8		# Offset temp           
mfhi $3             	# snapshot/10

add $6, $6, $4    	# Store digit   
mflo $4             	# temp % 10

# HEX 3
multu $4, $10
nop
         
mfhi $4
mult $3, $2        	# snapshot * .1

sll $4, $4, 12		# Offset temp           
mfhi $3             	# snapshot/10

add $6, $6, $4    	# Store digit   
mflo $4             	# temp % 10

# HEX 4
multu $4, $10
nop
         
mfhi $4
mult $3, $2        	# snapshot * .1

sll $4, $4, 16		# Offset temp           
mfhi $3             	# snapshot/10

add $6, $6, $4    	# Store digit   
mflo $4             	# temp % 10

# HEX 5
multu $4, $10
nop
         
mfhi $4
mult $3, $2        	# snapshot * .1

sll $4, $4, 20		# Offset temp           
mfhi $3             	# snapshot/10

add $6, $6, $4    	# Store digit   
mflo $4             	# temp % 10

# HEX 6
multu $4, $10
nop
         
mfhi $4
mult $3, $2        	# snapshot * .1

sll $4, $4, 24		# Offset temp           
mfhi $3             	# snapshot/10

add $6, $6, $4    	# Store digit   
mflo $4             	# temp % 10

# HEX 7
multu $4, $10
nop
         
mfhi $4
mult $3, $2        	# snapshot * .1

sll $4, $4, 28		# Offset temp           
mfhi $3             	# snapshot/10

add $6, $6, $4    	# Store digit   
nop

add $30, $6, $0
nop

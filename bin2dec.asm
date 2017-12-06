.text

add $3, $30, $0     	# snapshot switches

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

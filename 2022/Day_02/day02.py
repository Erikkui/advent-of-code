import numpy as np


f = open( "Day_02/input.txt", "r" )
data = f.readlines()
f.close()

data = [ row.strip() for row in data ]

data = [ row.replace( "A", str(1) ) for row in data ]
data = [ row.replace( "B", str(2) ) for row in data ]
data = [ row.replace( "C", str(3) ) for row in data ]

data = [ row.replace( "X", str(1) ) for row in data ]
data = [ row.replace( "Y", str(2) ) for row in data ]
data = [ row.replace( "Z", str(3) ) for row in data ]

data =  np.array( [ row.split(" ") for row in data ] )
data1 = np.array( [ int( elem ) for elem in data[ :, 0 ] ] ).transpose()
data2 = np.array( [ int( elem ) for elem in data[ :, 1 ] ] ).transpose()

data = np.concatenate( (data1, data2), axis=1)



print( data )








# %% [markdown]
# # Advent of Code 2024
# ## Day 09
# 

# %% [markdown]
# ### Part 1

# %%
filename = 'input.txt'
filename = '2024/day-09/test_input.txt'

with open( filename ) as file:
    data = file.read()
    
data

files = [ int(x) for x in data[0::2] ]
free_blocks = [ int(x) for x in data[1::2] ]

total_files = sum( files ) 

file_dict = {}
data_number = 0
for ii in range( len( files ) ):
    file_dict[ ii ] = [ data_number, int( files[ii] ) ]
    data_number += 1
        
file_dict, free_blocks, total_files

# %%
import numpy as np

new_file_system = []
ans = 0
prev_start = 0
free_ind = 0
file_ind = 0
file_end_ind = len( file_dict ) - 1
block_end = 0

    
while True:

    file_num, file_length = file_dict[ file_ind ]
    # print( file_num, file_length )

    block_end = prev_start + file_length
    # print( file_length )

    coefficients = np.arange( prev_start, block_end )
    files = file_num*np.ones( file_length )

    ans += sum( coefficients * files )
    
    if block_end >= total_files:
        break
    
    prev_start = block_end
    file_ind += 1
    free_length = free_blocks[ free_ind ]
    if free_length > 0:
        while free_length > 0:
        
        
            file_num, file_length = file_dict[ file_end_ind ] 
            
            if free_length == file_length:
                block_end = prev_start + file_length
                
                coefficients = np.arange( prev_start, block_end )
                files = file_num*np.ones( file_length )
                ans += sum( coefficients * files )
                
                free_blocks[ free_ind ] = 0
                prev_start = block_end
                file_end_ind -= 1
                free_ind += 1
                free_length -= file_length
                
            elif free_length > file_length:
                block_end = prev_start + file_length
                
                coefficients = np.arange( prev_start, block_end )
                files = file_num*np.ones( file_length )
                ans += sum( coefficients * files )
            
                prev_start = block_end
                free_blocks[ free_ind ] -= file_length
                free_length -= file_length
                if free_blocks[ free_ind ] < 1:
                    free_ind += 1
                file_end_ind -= 1
            else:
                block_end = prev_start + free_length
                
                coefficients = np.arange( prev_start, block_end )
                files = file_num*np.ones( free_length )
                ans += sum( coefficients * files )
                
                free_blocks[ free_ind ] = 0
                prev_start = block_end
                file_dict[ file_end_ind ][1] -= free_length
                free_length -= file_length
                if file_dict[ file_ind ][1] < 1:
                    file_end_ind += 1
                free_ind += 1
            
        if block_end >= total_files:
            break
    else:
        free_ind += 1
        
print( ans )

# %% [markdown]
# ### Part 2



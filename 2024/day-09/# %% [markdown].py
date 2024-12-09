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
    file_dict[ ii ] = [ data_number, int( files[ii] ), total_files+ii ]
    data_number += 1
        
file_dict, free_blocks, total_files

# %%
import numpy as np

# new_file_system = []
# ans = 0
# prev_start = 0
# free_ind = 0
# file_ind = 0
# file_end_ind = len( file_dict ) - 1
# block_end = 0

    
# while True:

#     file_num, file_length, _ = file_dict[ file_ind ]
#     # print( file_num, file_length )

#     block_end = prev_start + file_length
#     # print( file_length )

#     coefficients = np.arange( prev_start, block_end )
#     files = file_num*np.ones( file_length )

#     ans += sum( coefficients * files )
    
#     if block_end >= total_files:
#         break
    
#     prev_start = block_end
#     file_ind += 1
#     free_length = free_blocks[ free_ind ]
#     if free_length > 0:
#         while free_length > 0:
        
        
#             file_num, file_length, _ = file_dict[ file_end_ind ] 
            
#             if free_length == file_length:
#                 block_end = prev_start + file_length
                
#                 coefficients = np.arange( prev_start, block_end )
#                 files = file_num*np.ones( file_length )
#                 ans += sum( coefficients * files )
                
#                 free_blocks[ free_ind ] = 0
#                 prev_start = block_end
#                 file_end_ind -= 1
#                 free_ind += 1
#                 free_length -= file_length
                
#             elif free_length > file_length:
#                 block_end = prev_start + file_length
                
#                 coefficients = np.arange( prev_start, block_end )
#                 files = file_num*np.ones( file_length )
#                 ans += sum( coefficients * files )
            
#                 prev_start = block_end
#                 free_blocks[ free_ind ] -= file_length
#                 free_length -= file_length
#                 if free_blocks[ free_ind ] < 1:
#                     free_ind += 1
#                 file_end_ind -= 1
#             else:
#                 block_end = prev_start + free_length
                
#                 coefficients = np.arange( prev_start, block_end )
#                 files = file_num*np.ones( free_length )
#                 ans += sum( coefficients * files )
                
#                 free_blocks[ free_ind ] = 0
#                 prev_start = block_end
#                 file_dict[ file_end_ind ][1] -= free_length
#                 free_length -= file_length
#                 if file_dict[ file_ind ][1] < 1:
#                     file_end_ind += 1
#                 free_ind += 1
            
#         if block_end >= total_files:
#             break
#     else:
#         free_ind += 1
        
# print( int(ans) )

# %% [markdown]
# ### Part 2

# %%
new_filesystem = []
ans = 0
prev_start = 0
free_ind = 0
file_ind = 0
file_end_ind = len( file_dict ) - 1
block_end = 0
end_loops = False
    
while True:
    if end_loops:
        break

    file_num, file_length, _ = file_dict[ file_ind ]

    block_end = prev_start + file_length

    file_dict[ file_ind ][2] = prev_start
    file_dict = dict( sorted( file_dict.items(), key=lambda item: item[1][2], reverse=False ) )
    # new_filesystem.append( file_dict[ file_ind ] )

    # ans += sum( coefficients * files )
    
    prev_start = block_end
    file_ind += 1
    
    if file_ind >= file_end_ind:
        break
    
    free_length = free_blocks[ free_ind ]
    if free_length > 0:
        
        while True:
            key = list( file_dict.keys() )[ file_end_ind ] 
            file_num, file_length, _ = file_dict[ key ] 
            
            if free_length == file_length:
                file_dict[ key ][2] = prev_start
                
                # new_filesystem.append( file_dict[ file_end_ind ] )
                file_dict = dict( sorted( file_dict.items(), key=lambda item: item[1][2], reverse=False ) )
                
                free_blocks.pop( free_ind )
                free_ind = 0
                
                block_end = prev_start + file_length
                prev_start = block_end
                break
            
            elif free_length > file_length:
                free_blocks[ free_ind ] -= file_length
                file_dict[ key ][2] = prev_start
                
                # new_filesystem.append( file_dict[ file_end_ind ] )
                file_dict = dict( sorted( file_dict.items(), key=lambda item: item[1][2], reverse=False ) )
                
                file_end_ind = len( file_dict ) - 1
                free_length -= file_length

                block_end = prev_start + file_length
                prev_start = block_end
                
                saved_ind = prev_start

            else:
                # file_end_ind -= 1
                block_end += free_length 
                free_ind += 1
                key_temp = file_ind-1+free_ind 
                print( file_dict[ key_temp ])
                block_end += file_dict[ key_temp ][1]
                
                if free_ind >= len( free_blocks ):
                    file_end_ind -= 1
                    if file_end_ind < 1:
                        end_loops = True
                        break
                    else:
                        free_ind = 0
                        prev_start = saved_ind + file_dict[ file_ind ][1]+1

                prev_start = block_end
                free_length = free_blocks[ free_ind ]        
                
            
                
print( file_dict )


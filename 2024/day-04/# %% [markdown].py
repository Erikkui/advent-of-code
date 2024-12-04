# %% [markdown]
# # Advent of Code 2024
# ## Day 04
# 
# 

# %% [markdown]
# ### Part 1

# %%
import numpy as np

filename = 'input.txt'
filename = '2024/day-04/test_input.txt'

with open( filename ) as file:
    lines = file.readlines()
    
lines = [ line.strip() for line in lines ]

number_of_lines = len( lines )
elems_per_line = len( lines[1] )
array = np.zeros( (number_of_lines, elems_per_line), dtype=int )

for ii, line in enumerate( lines ):
    for jj, _ in enumerate( line ):

        if lines[ii][jj] == "X":
            array[ii, jj] = 1
        elif lines[ii][jj] == "M":
            array[ii, jj] = 2
        elif lines[ii][jj] == "A":
            array[ii, jj] = 3
        elif lines[ii][jj] == "S":
            array[ii, jj] = 4
        else:
            array[ii, jj] = 0
            print( "Unknown character" )

# %%
X_inds = np.where( array == 1 )

xmas_count = 0
for ii, jj in zip( X_inds[0], X_inds[1] ):

    try:
        # Ifs for l-r xmas
        if array[ii, jj+1] == 2:
            if array[ii, jj+2] == 3:
                if array[ii, jj+3] == 4:
                    xmas_count += 1
                    # print( "l-r", ii, jj )
    except IndexError:
        pass                
    
    try:                
        # Ifs for r-l xmas
        if array[ii, jj-1] == 2 and jj-1 >= 0:
            if array[ii, jj-2] == 3 and jj-2 >= 0:
                if array[ii, jj-3] == 4 and jj-3 >= 0:
                    xmas_count += 1
                    # print( "r-l", ii, jj )
    except IndexError:
        pass
     
    try:
        # Ifs for u-d xmas
        if array[ii+1, jj] == 2:
            if array[ii+2, jj] == 3:
                if array[ii+3, jj] == 4:
                    xmas_count += 1
                    # print( "u-d", ii, jj )
    except IndexError:
        pass
                    
    try:                
        # Ifs for d-u xmas
        if array[ii-1, jj] == 2 and ii-1 >= 0:
            if array[ii-2, jj] == 3 and ii-2 >= 0:
                if array[ii-3, jj] == 4 and ii-3 >= 0:
                    xmas_count += 1
                    # print( "d-u", ii, jj )
    except IndexError:
        pass
    
    try:                
        # Ifs for u-r xmas
        if array[ii-1, jj+1] == 2 and ii-1 >= 0:
            if array[ii-2, jj+2] == 3 and ii-2 >= 0:
                if array[ii-3, jj+3] == 4 and ii-3 >= 0:
                    xmas_count += 1
                    # print( "NE", ii, jj )
    except IndexError:
        pass
    
    try:
        # Ifs for u-l xmas
        if array[ii-1, jj-1] == 2 and ii-1 >= 0 and jj-1 >= 0:
            if array[ii-2, jj-2] == 3 and ii-2 >= 0 and jj-2 >= 0:
                if array[ii-3, jj-3] == 4 and ii-3 >= 0 and jj-3 >= 0:
                    xmas_count += 1
                    # print( "NW", ii, jj )
    except IndexError:
        pass                
                    
    try:                
        # Ifs for d-r xmas
        if array[ii+1, jj+1] == 2:
            if array[ii+2, jj+2] == 3:
                if array[ii+3, jj+3] == 4:
                    xmas_count += 1
                    # print( "SE", ii, jj )
    except IndexError:
        pass                
                    
    try:                
        # Ifs for d-l xmas
        if array[ii+1, jj-1] == 2 and jj-1 >= 0:
            if array[ii+2, jj-2] == 3 and jj-2 >= 0:
                if array[ii+3, jj-3] == 4 and jj-3 >= 0:
                    xmas_count += 1
                    # print( "SW", ii, jj )
    except IndexError:
        pass                 
    
xmas_count  #2265 too low, 2450 too high; 2437 wrong; 2434
        

# %% [markdown]
# ### Part 2

# %%
A_inds = np.where( array == 3 )

x_mas_count = 0;
for ii, jj in zip( A_inds[0], A_inds[1] ):
    
    # Testing for M - M; - A -; S - S
    try:
        if array[ii-1][jj-1] == 2 and ii-1 >= 0 and jj-1 >= 0:
            if array[ii-1][jj+1] == 2 and ii-1 >= 0:
                if array[ii+1][jj-1] == 4 and jj-1 > 0:
                    if array[ii+1][jj+1] == 4:
                        x_mas_count += 1
    except IndexError:
        pass
    
    # Testing for S - S; - A -; M - M
    try:
        if array[ii-1][jj-1] == 4 and ii-1 >= 0 and jj-1 >= 0:
            if array[ii-1][jj+1] == 4 and ii-1 >= 0:
                if array[ii+1][jj-1] == 2 and jj-1 >= 0:
                    if array[ii+1][jj+1] == 2:
                        x_mas_count += 1
    except IndexError:
        pass
    
    # Testing for M - S; - A -; M - S
    try:
        if array[ii-1][jj-1] == 2 and ii-1 >= 0 and jj-1 >= 0:
            if array[ii-1][jj+1] == 4 and ii-1 >= 0:
                if array[ii+1][jj-1] == 2 and jj-1 > 0:
                    if array[ii+1][jj+1] == 4:
                        x_mas_count += 1
    except IndexError:
        pass
    
    # Testing for S - M; - A -; S - M
    try:
        if array[ii-1][jj-1] == 4 and ii-1 >= 0 and jj-1 >= 0:
            if array[ii-1][jj+1] == 2 and ii-1 >= 0:
                if array[ii+1][jj-1] == 4 and jj-1 > 0:
                    if array[ii+1][jj+1] == 2:
                        x_mas_count += 1
    except IndexError:
        pass
    
print( x_mas_count )
    

# %%




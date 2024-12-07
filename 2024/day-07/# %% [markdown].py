# %% [markdown]
# # Advent of Code 2024
# ## Day 07
# 

# %% [markdown]
# ### Part 1

# %%
import numpy as np

filename = 'input.txt'
filename = '2024/day-07/test_input.txt'

with open( filename ) as file:
    lines = file.readlines()
    
lines_temp = [ line.strip() for line in lines ]

eqns = []
results = []
for line in lines_temp:
    line = line.split(" ")
    line[0] = line[0][ :-1 ]
    results.append( int( line[0] ) )
    eqns_to_int = list( map(int, line[1:]) )
    eqns.append( eqns_to_int )

# %%
import copy

true_eqn_inds = []
for ii, eqn in enumerate( eqns ):
    set_size = len( eqn ) - 1
    total_combinations = 3 ** set_size
    k = 0
    
    # + = 0, * = 1
    while k < total_combinations:
        ternary = np.base_repr( k, base=3 )
        operator_placement = list( ternary )
        
        if len( operator_placement ) < set_size:
            diff = set_size - len( operator_placement )
            operator_placement = diff*["0"] + operator_placement
        
        eqn_calc = copy.deepcopy( eqn )
        for jj in range( set_size ):
            
            if operator_placement[jj] == "0":
                temp = eqn_calc[jj] + eqn_calc[ jj+1 ]
                eqn_calc[ jj+1 ] = temp
            elif operator_placement[jj] == "1":
                temp = eqn_calc[jj] * eqn_calc[ jj+1 ]
                eqn_calc[ jj+1 ] = temp
            else:
                temp = int( str( eqn_calc[jj] ) + str( eqn_calc[ jj+1 ] ) )
                eqn_calc[ jj+1 ] = temp 
            if temp > results[ii]:
                break
                 
        if temp == results[ii]:
            true_eqn_inds.append(ii)
            break
        
        k += 1
        
print( true_eqn_inds )

# %% [markdown]
# ### Part 2



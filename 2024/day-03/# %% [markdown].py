# %% [markdown]
# # Advent of Code 2024
# ## Day 03
# 

# %% [markdown]
# ### Part 1

# %%
filename = 'input.txt'
# filename = 'test_input.txt'
filename "C:\Users\erikk\OneDrive\Koodings\advent-of-code\2024\day-03\input.txt"

with open( filename ) as file:
    lines = file.readlines()

# %%
import re

regex_search = r"mul\(\d{1,3},\d{1,3}\)"

operations = []
for line in lines:
    operations.extend( re.findall( regex_search, line ) )

result = 0
for operation in operations:
    numbers = operation[4:-1].split( "," )
    result += int( numbers[0] ) * int( numbers[1] )
    
result

# %% [markdown]
# ### Part 2

# %%
search_calc = r"mul\(\d{1,3},\d{1,3}\)"
search_do = r"do\(\)"
search_dont = r"don't\(\)"

# Concatenating all data into one string
data = "" 
for line in lines:
    data += line 

# Finding all multiplicatins and instructions
all_instructions = []
for line in lines:
    all_instructions.extend( re.finditer( search_calc, line ) )
    all_instructions.extend( re.finditer( search_do, line ) )
    all_instructions.extend( re.finditer( search_dont, line ) )

all_instructions_sorted = sorted( all_instructions, key = lambda x: x.span()[0] )

result = 0
enable_multiplications = True
for instruction in all_instructions_sorted:
    
    if instruction.group() == "don't()":
        enable_multiplications = False
    elif instruction.group() == "do()":
        enable_multiplications = True
    elif enable_multiplications == False:
        continue
    else:
        
        operation = instruction.group()
        numbers = operation[4:-1].split( "," )
        result += int( numbers[0] ) * int( numbers[1] )
           
result  #107502320




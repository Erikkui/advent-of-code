
f = open( "2022/Day_01/input.txt", "r" )
data = f.read().splitlines()
f.close

caloriesList = []

calorieCount = 0
for calorie in data:

    if calorie != '':
        calorieCount += float( calorie )
    else: 
        caloriesList.append( calorieCount )
        calorieCount = 0

print( max( caloriesList ) )

topCalSum = 0.0
for ii in range(3):
    topCal = max( caloriesList )
    ind = caloriesList.index( topCal )
    topCalSum += topCal
    caloriesList.pop( ind )

print( topCalSum ) 


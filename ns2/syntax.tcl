# Set a variable
set a 12

# Print String
puts "Hello World"

# Print Variable
puts $a

# Print String and Variable
puts "Value is $a"

# Get user Input
set b [gets stdin]

# If Statement
if {$a>$b} {

}

# If Else
if {$a>$b} {

} else {

}

# For Loop (Increment)
for {set i 0} {$i<10} {incr i} {

}

for {set i 10} {$i>0} {set i [expr $i-1]} {

}


# Function / Procedure
proc nameOfFunction {} {

}

# Calling a Function
nameOfFunction

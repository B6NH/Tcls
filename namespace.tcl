#!/usr/bin/tclsh

# Namespaces

# Function in global scope
proc createUnique {} {

  # Execute function 1 level up
  uplevel 1 {

    # Create namespace 'cntr'
    namespace eval cntr {

      # Initialize namespace variable
      variable cntrVar 0

      namespace export nextNum

      # Create decrement function
      proc nextNum {} {
        variable cntrVar
        return [incr cntrVar -1]
      }

    }

    # Import function into namespace
    namespace import cntr::*

  }

}

# Variable used to create stack namespaces
set stackBody {

  variable stack

  proc push {value} {
    variable stack
    lappend stack $value
  }

  proc pop {} {
    variable stack
    set topValue [lindex $stack end]
    set stack [lrange $stack 0 end-1]
    return $topValue
  }

}

namespace eval nameSpace1 {

  # Create multiple namespace instances
  namespace eval stack1 $stackBody
  namespace eval stack2 $stackBody

  # Export functions that match pattern
  namespace export publicFunction* line getCounter

  # Initialize namespace variables
  variable nameSpaceVariable "Liquid Drum"
  variable counter 33

  proc fun1 {} {
    puts "Function 1"
  }

  proc fun2 {} {
    puts "Function 2"
  }

  proc fun3 {} {
    puts -nonewline "Function 2 from function 3: "
    fun2
  }

  proc fun4 {} {
    puts "Function 4"
  }

  proc line {} {
    puts ------------------------------------------------------
  }

  proc publicFunction1 {} {
    puts "Public function 1"
  }

  proc publicFunction2 {} {
    puts "Public function 2"
  }

  proc getCounter {} {

    # Use namespace variable
    variable counter
    return $counter

  }

  # Call function directly in namespace
  line

  # Create namespace 'cntr' inside nameSpace1
  createUnique

  # Show names of created namespaces (stack1, stack2, cntr)
  puts "Namespaces inside nameSpace1: [namespace children]"

  line

  # Function calls inside 'namespace eval'
  fun1
  fun3

  # Function 'nextNum' was imported by 'createUnique' procedure
  puts "Call nextNum inside namespace: [nextNum]"

}

# New function in an already existing namespace
proc nameSpace1::newFunction {} {
  puts "New function"
}

# Function with the same name exists in namespace
proc line {} {
  puts -*-*-*-*-*-*-*-*-*
}

# Import functions using pattern
# Use '-force' flag to overwrite old 'line' function
namespace import -force nameSpace1::publicFunction* nameSpace1::line nameSpace1::getCounter

# Call imported function
line

# Global namespace starts with ::
::nameSpace1::fun1

# Relative identifier
nameSpace1::fun4

# Absolute identifier
::nameSpace1::newFunction

# Functions imported with 'nameSpace1::publicFunction*' pattern
publicFunction1
publicFunction2

line

# Show visible namespaces
puts "Visible namespaces: [namespace children]"

# Access namespace variables directly or using imported function
puts "$nameSpace1::nameSpaceVariable [getCounter]"

# Access nested namespace variable using nameSpace1 identifier
puts "Call nextNum using identifier: [nameSpace1::nextNum]"

# Directly access variable from nested namespace
puts $nameSpace1::cntr::cntrVar

# Use multiple namespace instances
nameSpace1::stack1::push 5 ; nameSpace1::stack1::push 6 ; nameSpace1::stack1::push 7
nameSpace1::stack2::push 1 ; nameSpace1::stack2::push 2 ; nameSpace1::stack2::push 3

# Show stack values
puts "Stack 1: $nameSpace1::stack1::stack"
puts "Stack 2: $nameSpace1::stack2::stack"



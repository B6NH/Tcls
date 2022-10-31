#!/usr/bin/tclsh

# Guide

# Create new procedure
proc createProc {v} {
  proc newProc {} "\
    puts {New Procedure $v}
  "
}

# Modify procedure default value
proc unique {{val 0}} {
  incr val
  proc unique "{val $val}" [info body unique]
  return $val
}

# Modify argument
proc up {v} {
  upvar $v val
  incr val 2
}

proc gl {} {
  global glv
  incr glv 8
}

# Create and use new procedure
createProc 5
newProc

# Display procedure info
puts [info body createProc]
puts [info args createProc]

# Variable value
set a 1 ; set b a
puts "Value of $b is [set $b]"

# Evaluate string
set p {set d 15}
eval $p ; puts $d

# Match string
puts [string match "*test*" "This is a test"]

# Substring
puts [string range "Hello World" 6 8]

# Foreach
foreach {a b} { 1 11 2 22 3 33 } c { 111 222 333 } {
  puts "$a $b $c"
}

# Current directory
puts "Directory: [pwd]"

# Search list
puts [lsearch {5 6 7 8 9} 8]

# Default argument
puts "[unique] [unique] [unique]"

# Upvar
set a 6 ; up a ; puts $a

# Rename
rename up uup ; uup a ; puts $a

# Global
set glv 12 ; puts $glv ; gl ; puts $glv


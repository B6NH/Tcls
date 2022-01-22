#!/usr/bin/tclsh

# Add directory containing file 'pkgIndex.tcl'
lappend auto_path [pwd]

# Load package
package require myPackage 1.0

# Import functions
namespace import fileOne::one fileTwo::three

# Call imported functions
one ; three

# Call other functions directly
fileOne::two ; fileTwo::four

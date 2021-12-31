#!/usr/bin/wish

# Graphics

proc packExamples {} {

  # Default window is '.'

  # -------------------------------------------------------------

  # Create label named .hello
  label .hello -text "Hello World"

  # Create raised label
  label .la -relief raised -text "Raised Label"

  # -------------------------------------------------------------

  # Create text input widget with associated variable entryText
  set myEntry [entry .en1 -textvariable entryText]

  # Update text with button
  button .upText -text "Update input text"\
    -command { set entryText [string toupper $entryText] }

  # -------------------------------------------------------------

  # Label text is associated with labelVariable
  label .lav -textvariable labelVariable -relief sunken

  # Variable labelVariable is global
  global labelVariable

  # Set label text using variable
  set labelVariable "Text from labelVariable"

  # -------------------------------------------------------------

  # Create button with 'exit' command
  button .exit_button -text "QUIT" -command exit

  # Create button with command to change its text
  button .my_button -text "Click to change text"\
    -command { .my_button configure -text "New Text" }

  # -------------------------------------------------------------

  # Read widget properties with cget command
  puts "Label text: [.hello cget -text]"
  puts "Button text: [.exit_button cget -text]"
  puts "Button color: [.exit_button cget -background]"

  # Read widget property with configure command
  puts "Button text (configure): [.exit_button configure -text]"

  # -------------------------------------------------------------

  pack .hello .my_button .la .lav $myEntry .upText .exit_button

}

proc gridExamples {} {

  button .convert -text "En Francais" -command {
    translate { .convert .name .street } [.convert cget -text]
  }

  grid [label .name -text Name]
  grid [label .street -text Street]
  grid .convert

}

proc placeExamples {} {

  # Exit button
  set quitbutton [button .quitbutton -text "Quit" -command "exit"]

  # Main button
  set gobutton [button .gobutton -text "Calculate Sales Tax" \
    -command {set salesTax [expr $userInput * 0.15]}]

  # Input
  set priceLabel [label .priceLabel -text "Base Price:"]
  set input [entry .input -textvariable userInput]

  # Output
  set taxLabel [label .taxLabel -text "Tax :"]
  set result [label .result -textvariable salesTax -relief raised]

  # Set main window size
  . configure -width 250 -height 100

  # -------------------------------------------------------------

  # Place buttons

  # Place button at right bottom
  place $quitbutton -relx .75 -rely .7

  # Place button at left bottom
  place $gobutton -relx .01 -rely .7

  # -------------------------------------------------------------

  # Base price label and input
  place $priceLabel -x 0 -y 0
  place $input -x 75 -y 0

  # Result label and output
  place $taxLabel -x 0 -y 30
  place $result -x 40 -y 30

}

proc translate {widgets request} {

  # Upvar array from global level
  if {[string match "En Francais" $request]} {
    upvar #0 french table
  } else {
    upvar #0 english table
  }

  foreach w $widgets {
    $w configure -text $table([$w cget -text])
  }

}

# -------------------------------------------------------------

array set english {Nom Name Rue Street "In English" "En Francais" }
array set french {Name Nom Street Rue "En Francais" "In English" }

# -------------------------------------------------------------

#packExamples
#gridExamples
placeExamples

# -------------------------------------------------------------


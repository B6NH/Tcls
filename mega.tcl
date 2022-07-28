#!/usr/bin/wish

# Mega

proc birdExample {} {

  set bird {
    R0lGODlhIAAgAJEAANnZ2QAAAP///////yH5BAEAAAAALAAAAAAgACAAAAKWhI+p
    y+0Po5y02qtIHIJvFD8IPhrFDwAAxCPwjeID3N3dEfiYFB/zCD4mxcdMgo9H8TGT
    4ONRfARAgo9pFP8IPqYaxccj+JhI8Y1gx93dHcUPgo+pSPGD4GMqUnyCj6lJ8Qk+
    pibFJviYqhSb4GOqRlBC+Ji6EZQQPqZqBCWEj6kbQfAxdS0IPqYuBIXwMXW5/WGU
    kz5SADs=
  }

  image create photo bird -data $bird

  # Create and pack the text widget
  text .t -height 2 -width 60 -background white -font {times 16 bold}
  pack .t

  .t image create 1.0 -image bird
  .t insert 1.1 " Watch the birdie"

}

proc textExample {} {

  # Create the text widget and pack it.
  set txt [text .t -height 12 -width 80 -background white \
    -tabs {2.5i right 3i left 5.8i numeric}]
  pack $txt

  # Insert several lines at the end location. Each new line
  # becomes the new last line in the widget.
  $txt insert end "The next lines demonstrate tabbed text\n"
  $txt insert end "\n"
  $txt insert end "noTab \t Right Justified \t \
  Left Justified \t Numeric\n"
  $txt insert end "\n"
  $txt insert end "line1 \t column1 \t column2 \t 1.0\n"
  $txt insert end "line2 \t column1 text \t column2\
  text \t 22.00\n"
  $txt insert end "line3 \t text in column1 \t text\
  for column2 \t 333.00\n"

  # Insert a few lines at specific line locations.
  # To demonstrate some location examples
  $txt insert 1.0 "These lines are inserted last, but are\n"
  $txt insert 2.0 "inserted at the\n"
  $txt insert 2.end " beginning of the text widget\n"
  $txt insert {3.5 linestart} "so that they appear first.\n"
  $txt insert 4.0 "\n"

}

proc dialogWidgets {} {

  # Option menu
  tk_optionMenu .button varName Val1 Val2 Val3

  # Color selector
  tk_chooseColor
  
  # Window with message and buttons
  tk_messageBox -message "Continue Examples?" -type yesno

  tk_dialog .box "Example Dialog" \
    "Who’s on first? " \
    questhead 0 "Yes" "No" "Don’t Know"

  pack .button

}

proc grabExample {} {

  # Button doesn't respond to events
  pack [button .b -text "Show" -command {puts [grab current]}]
  pack [label .l -text "holding focus"]
  grab .l
  puts "Focus is held by: [grab current]"
  puts "Status for .l is: [grab status .l]"

}

proc waitExample {} {

  # Create and display two widgets
  pack [label .l -text "I’m the first .l"]
  pack [button .b -text "Click to destroy label" -command "destroy .l"]

  # The code pauses here until the window named .l is destroyed
  # This will happen when the button is clicked.
  tkwait window .l

  # After the button is clicked, and .l is destroyed,
  # a new .l is created and packed.
  pack [label .l -text "I’m a new .l"]

}

#birdExample
#textExample
#dialogWidgets
#grabExample
waitExample


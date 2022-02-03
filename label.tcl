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

proc radioButtonExample {} {

  # Run updateLabel when radiobutton is clicked
  proc updateLabel {myLabel item} {
    global price
    $myLabel configure -text "The cost for a potion of $item is $price gold pieces"
  }

  # Initial label
  set l [label .l -text "Select a Potion"]

  # Place label in grid
  grid $l -column 0 -row 0 -columnspan 3

  # Potions
  set itemList [list "Cure Light Wounds" 16 "Boldness" 20 "See Invisible" 60]

  # Current column
  set position 0

  # Create all radiobuttons
  foreach {item cost} $itemList {

    # Create radiobutton for potion
    radiobutton .b_$position -text $item -variable price \
      -value $cost -command [list updateLabel $l $item]

    # Place radiobutton in grid column
    grid .b_$position -column $position -row 1

    # Next column
    incr position

  }

}

proc checkButtonExample {} {

  proc updateLabel {myLabel item} {

    global price ; set total 0

    # Sum potion prices
    foreach potion [array names price] {
      incr total $price($potion)
    }

    # Display total price
    $myLabel configure -text "Total cost is $total Gold Pieces"

  }

  # Create and place label in grid
  set l [label .l -text "Select a Potion"]
  grid $l -column 0 -row 0 -columnspan 3

  # List of potions
  set itemList [list "Cure Light Wounds" 16 "Boldness" 20 \
    "See Invisible" 60 "Love Potion Number 9" 45]

  # Current checkbutton row
  set position 1

  # Create and display all checkbuttons
  foreach {item cost} $itemList {

    # Checkbutton value is potion cost
    checkbutton .b_$position -text $item \
      -variable price($item) -onvalue $cost -offvalue 0 \
      -command "[list updateLabel $l $item]"

    # Checbutton in row
    grid .b_$position -row $position -column 0 -sticky w
    incr position

  }

}

proc menuExamples {} {

  # Create menu button
  # Menu .mb.mnu is attached to menubutton .mb
  menubutton .mb -menu .mb.mnu -text "File"\
    -relief raised -background gray70

  # Create menu
  menu .mb.mnu

  # Add radiobuttons
  .mb.mnu add radiobutton -label "Small" \
    -variable menuText -value "small text"
  .mb.mnu add radiobutton -label "Medium" \
    -variable menuText -value "medium text"
  .mb.mnu add radiobutton -label "Large" \
    -variable menuText -value "large text"

  # Add separator
  .mb.mnu add separator

  # Add command
  .mb.mnu add command -label "Command"

  # Add top separator
  .mb.mnu insert 0 separator

  # Insert command at the top
  .mb.mnu insert 0 command -label "Top"

  # Add option that will be removed
  .mb.mnu add command -label "Removed"

  # Create submenu
  .mb.mnu add cascade -label Submenu -menu .mb.mnu.submenu
  menu .mb.mnu.submenu
  .mb.mnu.submenu add command -label subOption1
  .mb.mnu.submenu add command -label subOption2

  pack .mb

  # Delete option with label 'Removed'
  .mb.mnu delete Removed

  # Get option index
  if {[.mb.mnu index Large]!=5} {
    error "Invalid option index!"
  }

}

proc menuBarExamples {} {

  # Add menubar '.mbar' to root window
  . configure -menu .mbar

  # Create root window menu
  menu .mbar

  # Add 'Files' submenu
  .mbar add cascade -label Files -menu .mbar.files
  menu .mbar.files

  # Add 'Files' options
  .mbar.files add command -label Open -command "openFile"
  .mbar.files add command -label Close
  .mbar.files add command -label Edit

  .mbar add cascade -label System -menu .mbar.system
  menu .mbar.system
  .mbar.system add command -label "Arch"
  .mbar.system add command -label "Debian"
  .mbar.system add command -label "Ubuntu"
  .mbar.system add command -label "openSUSE"

  # Add option directly
  .mbar add command -label Run -command "go"

  # Add 'Help' submenu
  .mbar add cascade -label Help -menu .mbar.help
  menu .mbar.help

  # Add 'Help' option
  .mbar.help add command -label About -command "displayAbout"
  .mbar.help add command -label Contact

}

proc listBoxExamples {} {

  # Create empty listbox
  listbox .l ; pack .l

  # Add listbox items at the beginning
  .l insert 0 keyboard
  .l insert 0 mouse
  .l insert 0 otherDevice
  .l insert 0 printer

  # Delete second element (otherDevice)
  .l delete 1

  if {[.l curselection]!=""} {
    error "Invalid listbox selection!"
  }

  # Get last element text
  if {[.l get 2]!="keyboard"} {
    error "Invalid listbox text!"
  }

}

proc scrollbarExamples {version} {

  switch $version {

    1 {

      # Create scrollbar and set its command
      # After moving scrollbar, command will be expanded with 'moveto' function
      scrollbar .scroll -command ".box yview"

      # Create listbox controlled by scrollbar
      # Parameters will be added to the command
      # to inform how position of scrollbar changed
      listbox .box -height 4 -yscrollcommand ".scroll set"

      # Pack listbox and scrollbar
      pack .box -side left
      pack .scroll -side right -fill y

      # Insert listbox elements
      .box insert end 0 1 2 3 4 5 6 7 8 9 10

    }

    2 {

      # Listboxes
      listbox .leftbox -height 5 -exportselection 0
      listbox .rightbox -height 5 -exportselection 0

      # Insert listbox elements (left: 10, right: 20)
      for {set i 0} {$i < 10} {incr i} {

        # Left
        .leftbox insert end "Left Line $i"

        # Right
        .rightbox insert end "Right Line $i"
        .rightbox insert end "Next Right $i"

      }

      # Place listboxes in grid
      grid .leftbox -column 0 -row 0
      grid .rightbox -column 2 -row 0

      # Create scrollbar with moveLists command
      scrollbar .scroll -command "moveLists .scroll .leftbox .rightbox"

      # Set slider size and location
      .scroll set 0 [expr 5.0 / 20.0]

      # Place scrollbar in grid
      grid .scroll -column 1 -row 0 -sticky ns

      # Function to control 2 listboxes
      proc moveLists {scrollbar listbox1 listbox2 args} {

        # Get listbox height
        set height [$listbox2 cget -height]

        # Get number of list elements
        set size1 [$listbox1 size] ; set size2 [$listbox2 size]

        # Set size of larger list
        set size [expr {$size1 > $size2 ? $size1 : $size2}].0

        # Get scrollbar position
        set scrollPosition [$scrollbar get]
        set startFract [lindex $scrollPosition 0]

        # Get listbox top elements indices
        set top1 [expr int($size1 * $startFract)]
        set top2 [expr int($size2 * $startFract)]

        # Read added parameters (for example {scroll 1 units}
        set cmdlst [split $args]

        # Click on arrow or scrollbar - scroll
        # Drag slider - moveto
        switch [lindex $cmdlst 0] {

          "scroll" {

            # Get count and unit from cmdlst
            foreach {sc count unit} $cmdlst {}

            if {[string first units $unit] >= 0} {

              # Click on arrow (scroll 1/-1 units)
              set increment [expr 1 * $count];

            } else {

              # Click on scrollbar (scroll 1/-1 pages)
              set increment [expr $height * $count];

            }

            # Calculate new fractions
            set topFract1 [expr ($top1 + $increment) / $size]
            set topFract2 [expr ($top2 + $increment) / $size]
            if {$topFract1 < 0} {set topFract1 0}
            if {$topFract2 < 0} {set topFract2 0}

          }

          "moveto" {

            # The cmd list for example is 'moveto 0.61'
            # Get new topFract
            set topFract [lindex $cmdlst 1]
            if {$topFract < 0} {set topFract 0}

            # Scale values
            set topFract1 [expr $topFract * ($size1/$size)]
            set topFract2 [expr $topFract * ($size2/$size)]

          }

        }

        # Update listboxes
        $listbox1 yview moveto $topFract1
        $listbox2 yview moveto $topFract2

        set topFract [expr ($topFract1 > $topFract2) ? \
          $topFract1 : $topFract2 ]

        if {$topFract > (1.0 - ($height-1)/$size)} {
          set topFract [expr (1.0 - ($height-1)/$size)]
        }

        set bottomFract [expr $topFract + (($height-1)/$size)]

        # Update scrollbar
        $scrollbar set $topFract $bottomFract

      }

    }

    default {
      error "Invalid scrollbar example version!"
    }

  }

}

proc scaleExamples {} {
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
#placeExamples
#radioButtonExample
#checkButtonExample
#menuExamples
#menuBarExamples
#listBoxExamples
scrollbarExamples 2

# -------------------------------------------------------------


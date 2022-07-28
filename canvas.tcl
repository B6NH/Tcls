#!/usr/bin/wish

# Canvas

proc face {} {

  # Create canvas
  canvas .c -height 140 -width 140 -background blue
  pack .c

  # Create oval on canvas
  .c create oval 7 7 133 133 -outline black -fill red -width 2

  # Eyes
  .c create oval 39 49 53 63 -outline black -fill black
  .c create oval 102 63 88 49 -outline black -fill black

  # Nose
  .c create polygon 70 67 74 81 69 77 67 81 -fill black

  # Smile
  .c create arc 21 21 119 119 -start 225\
    -extent 95 -style arc -outline black -width 3

}

proc items {} {

  canvas .c -height 200 -width 200 -background white
  pack .c

  # Red Line
  .c create line 10 10 50 50 -width 2 -fill red

  # Blue Arc
  .c create arc 50 10 100 60 -width 2 -fill blue -start 45

  # Green Rectangle
  .c create rectangle 120 10 180 50 -fill green

  # Purple Oval
  .c create oval 10 60 60 90 -fill purple

  # Cyan Polygon
  .c create polygon 80 60 100 90 160 70 -fill cyan

  # Text Item
  .c create text 100 140 -fill red -text Canvas -font {consolas 35}

}

proc modif {} {

  # Create a canvas with a white background
  set canv [canvas .c -height 50 -width 290 -background white]

  # Create some text colored the default black.
  set top [ $canv create text 145 20 \
    -text "This text can be seen before clicking the button"]

  # Create some text colored white.
  # It won’t show against the background.
  set bottom [ $canv create text 145 30 -fill white \
    -text "This text can be seen after clicking the button"]

  # Create a button that will use itemconfigure to change the
  # colors of the two lines of text.
  set colorswap [button .b1 -text "Swap colors" \
    -command "$canv itemconfigure $top -fill white;\
    $canv itemconfigure $bottom -fill black;"]

  # Pack them
  pack $canv -side top
  pack $colorswap -side bottom

}

#face
#items
modif


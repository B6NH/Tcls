package provide myPackage 1.0

namespace eval fileTwo {

  namespace export three

  proc three {} {
    puts 3333
  }

  proc four {} {
    puts 4444
  }

}

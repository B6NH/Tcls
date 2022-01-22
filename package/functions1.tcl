package provide myPackage 1.0

namespace eval fileOne {

  namespace export one

  proc one {} {
    puts 1111
  }

  proc two {} {
    puts 2222
  }

}

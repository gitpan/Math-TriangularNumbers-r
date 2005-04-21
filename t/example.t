#######################################################################
# $Id: example.t,v 1.3 2005/03/06 19:41:01 dpchrist Exp $
#
# Test script for example code given in module pod documentation.
#
# Copyright 2005 by David Christensen <dpchrist@holgerdanske.com>
#######################################################################
# uses:
#----------------------------------------------------------------------

use Test::More tests => 1;

#######################################################################
# debugging:
#----------------------------------------------------------------------

# $Math::TriangularNumbers::debug = 1;

#######################################################################
# script:
#----------------------------------------------------------------------


  use Math::TriangularNumbers qw(T Ti is_T);
  
  ##### prints Triangular numbers "1, 3, 6, 10, 15, 21"
  print STDERR join(", ",T(1),T(2),T(3),T(4),T(5),T(6)), "\n";

  ##### prints right Triangular indices "1, 2, 2, 3, 3, 3":
  print STDERR join(", ", Ti(1),Ti(2),Ti(3),Ti(4),Ti(5),Ti(6)), "\n";
  
  ##### determines if the number 666 is triangular (it is):
  print STDERR is_T(666) ? "yes\n" : "no\n";

ok(1);

#######################################################################

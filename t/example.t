#######################################################################
# $Id: example.t,v 1.2 2005/02/27 02:16:41 dpchrist Exp $
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
  
  ##### prints the first four Triangular numbers "1, 3, 6, 10"
  print STDERR join(", ", T(1), T(2), T(3), T(4)), "\n";

  ##### prints their indices "1, 2, 3, 4":
  print STDERR join(", ", Ti(1), Ti(3), Ti(6), Ti(10)), "\n";
  
  ##### determines if the number 666 is triangular (it is):
  print STDERR is_T(666) ? "yes\n" : "no\n";

ok(1);

#######################################################################

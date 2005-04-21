#######################################################################
# $Id: TriangularNumbers.pm,v 1.7 2005/03/06 19:41:01 dpchrist Exp $

=head1 NAME

Math::TriangularNumbers - Perl extension for Triangular numbers.

Version 0.03


=head1 SYNOPSIS

  use Math::TriangularNumbers qw(T Ti is_T);
  
  ##### prints Triangular numbers "1, 3, 6, 10, 15, 21"
  print STDERR join(", ",T(1),T(2),T(3),T(4),T(5),T(6)), "\n";

  ##### prints right Triangular indices "1, 2, 2, 3, 3, 3":
  print STDERR join(", ",Ti(1),Ti(2),Ti(3),Ti(4),Ti(5),Ti(6)), "\n";
  
  ##### determines if the number 666 is triangular (it is):
  print STDERR is_T(666) ? "yes\n" : "no\n";


=head1 DESCRIPTION

I was using the following function for games:

    T(n) = 1 + 2 + ... + (n-1) + n

         = n * (n+1) / 2

For example:

    T(1) =  1
    T(2) =  3
    T(3) =  6
    T(4) = 10
    T(5) = 15
    T(6) = 21
    etc.

These are called Triangular numbers, after Pascal's Triangle:

				1
			    1       1
			1       2       1
		    1       3       3       1
		1       4       6       4       1
	    1       5      10      10       5       1
	1       6      15      20      15       6       1
    1       7      21      35      35      21       7       1

Observe the diagonal numbers starting at the third row:
1, 3, 6, 10, 15, 21.

This module implements the function T(n), given by the above equation,
and it's "right inverse", T'(N), given by:

	T'(N) = int( (1 + sqrt(1 + 8*(N-1))) / 2 )

E.g.  Given an integer N which is not necessarily a Triangular Number,
find n such that T(n-1) < N <= T(n). 

I have extended the definition of a Triangular number
to include zero and negative indices and integers.


=head2 EXPORT

None by default.

=cut

#######################################################################
# package:
#----------------------------------------------------------------------

package Math::TriangularNumbers;

#######################################################################
# uses/ requires:
#----------------------------------------------------------------------

use 5.006;
use strict;
use warnings;

use Carp;
use Data::Dumper;

require Exporter;

#######################################################################
# global variables:
#----------------------------------------------------------------------

our @ISA = qw(Exporter);

our %EXPORT_TAGS = ( 'all' => [ qw(
    T
    Ti
    is_T
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw();

our $VERSION = '0.03';

our $debug = 0;

#######################################################################
# preloaded methods:
#----------------------------------------------------------------------

=head2 FUNCTIONS

=head3 T($n)

Returns the $n-th Triangular number.
Croaks if passed a non-integer argument.
Note that T(0) = 0, and T(-$n) = -T($n).

=cut

sub T
{
    my $n = shift;
    print STDERR (caller(0))[3], ": ",
	Data::Dumper->Dump([$n], [qw(n)]), "\n"
	if $debug;

    croak "'$n' is not an integer"
	unless $n =~ /^-?\d+$/;
    
    my $T = 0 < $n
	?  $n * ( $n+1) / 2
	:  $n * (-$n+1) / 2;		##### let T(-n) = -T(n)
    
    print STDERR (caller(0))[3], ": ",
	Data::Dumper->Dump([$T], [qw(T)]), "\n"
	if $debug;
    return $T;
}

#----------------------------------------------------------------------

=head3 Ti($N)

Returns right Triangular index of $N.
Croaks if passed a non-integer argument.
Note that Ti(0) = 0, and Ti(-$T) = -Ti($T).

=cut

sub Ti
{
    my $N = shift;
    print STDERR (caller(0))[3], ": ",
	Data::Dumper->Dump([$N], [qw(N)]), "\n"
	if $debug;

    croak "'$N' is not an integer"
	unless $N =~ /^-?\d+$/;
    
    my $n = ($N == 0)
	    ? 0
	    : (0 < $N)
	      ?  int((1 + sqrt(1 + 8*($N-1))) / 2)
	      : -int((1 + sqrt(1 - 8*($N+1))) / 2); ### T'(-N) = -T'(N)

    print STDERR (caller(0))[3], ": ",
	Data::Dumper->Dump([$n], [qw(n)]), "\n"
	if $debug;
    return $n;
}

#----------------------------------------------------------------------

=head3 is_T($N)

Returns true if $N is a Triangular number,
if $N is zero,
or if -$N is a Triangular number,
otherwise returns false.
Croaks if passed a non-integer argument.

=cut

sub is_T
{
    my $N = shift;
    print STDERR (caller(0))[3], ": ",
	Data::Dumper->Dump([$N], [qw(x)]), "\n"
	if $debug;

    croak "'$N' is not an integer"
	unless $N =~ /^-?\d+$/;
    
    my $r = (T(Ti($N)) == $N);
    
    print STDERR (caller(0))[3], ": ",
	Data::Dumper->Dump([$r], [qw(r)]), "\n"
	if $debug;
    return $r;
}

#######################################################################
# end of code:
#----------------------------------------------------------------------

1;
__END__

#######################################################################
# remaining pod:
#----------------------------------------------------------------------

=pod

=head1 INSTALLATION

To install this module type the following:

   perl Makefile.PL
   make
   make test
   make install


=head1 DEPENDENCIES

None.


=head1 TO DO

Everything is currently implemented using standard Perl scalars,
so large arguments are likely to result in errors due to
floating-point limitations.


=head1 SEE ALSO

http://mathforum.org/dr.math/faq/faq.pascal.triangle.html

http://mathworld.wolfram.com/TriangularNumber.html

http://en.wikipedia.org/wiki/Triangular_numbers


=head1 AUTHOR

David Christensen, <dpchrist@holgerdanske.com>


=head1 CREDITS

Rob "Sisyphus", for helping me find the correct term "index" and
for suggesting a function to test if a number is triangular.


=head1 COPYRIGHT AND LICENSE

Copyright 2005 by David Christensen <dpchrist@holgerdanske.com>

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.6 or,
at your option, any later version of Perl 5 you may have available.


=cut

#######################################################################

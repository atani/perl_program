#!/usr/bin/perl

use strict;
use warnings;
use Data::Printer;

# subroutine
sub twice {
    my $num = shift;
    return $num * 2;
}


# subroutine's reference
my $twice_ref = \&twice;

print $twice_ref->(5);


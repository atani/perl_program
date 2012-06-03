#!/usr/bin/perl -w

use strict;
use WWW::Mechanize;
use Data::Printer;

my $mech  =  new WWW::Mechanize( autocheck  => 1 );

$mech->get("http://www.google.co.jp/");
my $ttt  = $mech->submit_form(
    fields  => {
        f  => 'test',
    },
);

p $ttt;

$mech->get();



#!/usr/bin/perl

use strict;
use warnings;
use XML::Simple;
use Data::Printer;

my $xml = XML::Simple->new;
my $conf = $xml->XMLin('conf.xml');

# 構造
p $conf;

# データアクセス方法
print "# Data get \n";
print $conf->{hosts}->{host1}->{ip};

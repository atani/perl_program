#!/usr/bin/perl

use strict;
use warnings;
use Geo::IP;

my $geo =  Geo::IP->open('./GeoLiteCity.dat',GEOIP_STANDARD);

my $search_str = $ARGV[0];
my ($loc, $from, $to);


if ($search_str  =~ /^(\d|[01]?\d\d|2[0-4]\d|25[0-5])\.(\d|[01]?\d\d|2[0-4]\d|25[0-5])\.(\d|[01]?\d\d|2[0-4]\d|25[0-5])\.(\d|[01]?\d\d|2[0-4]\d|25[0-5])$/ )
{
    $loc = $geo->record_by_addr("$search_str") or die;
    ($from, $to) = $geo->range_by_ip("$search_str");
    print "Range        : " . $from . " - " . $to . "\n";

} else {
    $loc =  $geo->record_by_name("$search_str") or die;
}
print "Country Code : " . $loc->country_name . "(" . $loc->country_code . ")\n";

exit;

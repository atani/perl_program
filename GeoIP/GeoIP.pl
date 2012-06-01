#!/usr/bin/perl
use strict;
use warnings;
use Geo::IP;
use LWP::Simple;

my $file = "./GeoIP.dat.gz";

# file check
if ((!-e $file ) or ( (-M $file ) > 30 )){
    &get_geoip;
}

if (@ARGV != 1) {
        print "Usage: geoip.pl <ipaddress|hostname>\n";
        exit(1);
}

chomp(my $ip_host = $ARGV[0]);
my $country;
my $gi = Geo::IP->open('./GeoIP.dat');

$country = $gi->country_code_by_addr($ip_host);

$country ||= '';

print $country . "\n";

sub get_geoip {
    my $geoip_file = get("http://geolite.maxmind.com/download/geoip/database/GeoLiteCountry/GeoIP.dat.gz");
    open(FILE ,">GeoIP.dat.gz") or die("Cant Create");
    eval{flock(FILE,2);};
    print FILE $geoip_file;
    close(FILE);
}

exit;

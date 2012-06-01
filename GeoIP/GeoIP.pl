#!/usr/bin/perl
use strict;
use warnings;
use autodie;
use Geo::IP;
use LWP::Simple;
use IO::Uncompress::Gunzip qw(gunzip $GunzipError);
use IO::File;
#use Data::Printer;

my $gzipfile = "GeoIP.dat.gz";
my $file = "GeoIP.dat";

# file check
if ((!-e $file ) or ( (-M $file ) > 30 )){
    &get_geoip;
    gunzip $gzipfile => $file;

}

if (@ARGV != 1) {
        print "Usage: geoip.pl ipaddress\n";
        exit(1);
}

chomp(my $ip_host = $ARGV[0]);
my $country;
my $gi = Geo::IP->open("$file");

$country = $gi->country_code_by_addr($ip_host);
$country ||= '';
print $country . "\n";

sub get_geoip {
    my $geoip_file = get("http://geolite.maxmind.com/download/geoip/database/GeoLiteCountry/GeoIP.dat.gz");
    my $fh = IO::File->new($gzipfile, 'w');
    $fh->print($geoip_file);
    $fh->close;
}

exit;

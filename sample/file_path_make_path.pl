#!/usr/bin/perl

use strict;
use warnings;
use File::Path qw/make_path/;

my $dir = "./test";

my $ret = make_path( $dir , {
    verbose => 0,
});


if ( $ret eq 0 ) {
    # 既に作成されていたディレクトリは何もしない。
    print "既に存在してます。 $dir \n";
} else {
    print "作成されました。 $dir \n";
}

exit;

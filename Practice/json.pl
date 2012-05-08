#!/usr/bin/perl

use strict;
use warnings;
use JSON 'decode_json';
use Data::Printer;

my $data = decode_json(get_content('conf.json'));

# 構造
p $data;

# データアクセス方法
print "# Data get \n";
print "$data->[0]->{age} \n";
print "$data->[0]->{name} \n";


# ファイルの内容を取得する関数
sub get_content {
    my $file = shift;

    open my $fh, '<', $file
        or die qq{Can't open file "$file": $!};
    
    return join '', <$fh>
}

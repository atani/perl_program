#!/usr/bin/perl

use strict;
use warnings;

my $info = {};

# ファイル名
my $file = shift;

# ファイルのオープン
open my $fh, '<', $file
    or die qq{Can't open file "$file": $!};

# 行の読み込み
while (my $line = <$fh>){
    # ヘッダを飛ばす
    next if $. == 1;

    # 改行の削除
    chomp $line;

    # 各列の取得
    my ($time, $url, $response_time, $size) = split /\s+/, $line;

    # 回数
    $info->{$time}{count}++;

    # 平均応答時間の合計
    $info->{$time}{response_time_total} += $response_time;

    # サイズの合計
    $info->{$time}{size_total} += $size;
}

# ファイルのクローズ
close $fh;

# ヘッダの出力
my @headers = qw/time count response_time_avarage size_total/;

print join(',', @headers) . "\n";

# 時刻順で出力
foreach my $time (sort keys %$info) {
    # 各情報
    my $count               = $info->{$time}{count};
    my $response_time_total = $info->{$time}{response_time_total};
    my $size_total          = $info->{$time}{size_total};

    # 平均応答時間を求める。
    my $response_time_average = $response_time_total / $count;
    $response_time_average = sprintf("%.1f", $response_time_average);

    # 出力レコード
    my @rec = ($time, $count, $response_time_average, $size_total);

    # 出力
    print join(',', @rec) . "\n";
}

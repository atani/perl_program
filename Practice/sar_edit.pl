#!/usr/bin/perl

use strict;
use warnings;

# ファイル名
my $file = shift;

# 引数がない場合($0はスクリプト名)
die "Usage: $0 FILE" unless $file;

# ファイルのオープン
open my $fh, '<', $file
    or die qq{Can't open file "$file": $!};

# 複数のCPUの情報を格納する配列リファレンス
my $cpu_infos = [];

# 1行ずつ読み込む
while (my $line = <$fh>) {
    # 1行目は飛ばす($.は現在の行番号)
    next if $. == 1;

    # 改行の削除
    chomp $line;

    # 行の情報を配列に変換
    my @rec = split /\s+/, $line;

    # CPUの情報を格納するハッシュ
    my $cpu_info = {};
    $cpu_info->{time} = $rec[0];
    $cpu_info->{user} = $rec[3];
    $cpu_info->{system} = $rec[5];

    # CPUの情報を追加
    push @$cpu_infos, $cpu_info;
}

# ファイルのクローズ
close $fh;


# ヘッダ(qw//は文字列リスト演算子)
my @headers = qw/time %user $system/;

# ヘッダの出力
print join(',', @headers) . "\n";

# CPUの情報を出力
foreach my $cpu_info (@$cpu_infos) {

    # レコードの情報を作成
    my @rec = (
        $cpu_info->{time},
        $cpu_info->{user},
        $cpu_info->{system}
    );
    # カンマで連結して出力
    print join(',', @rec) . "\n";
}


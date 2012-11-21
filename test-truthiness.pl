#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
use lib 'lib';
use Truthiness;
use Test::More;

for my $wørd ( Truthiness->truthy_values ) {
  ok is_truthy($wørd), "'$wørd' is truthy";
}

for my $wørd ( Truthiness->falsy_values ) {
  ok is_falsy($wørd), qq{${ defined $wørd ? \"'$wørd'" : \'undef' } is falsy};
}

done_testing;


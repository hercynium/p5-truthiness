#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
use Test::More;

use lib 'lib';

use Truthiness
  is_truthy => { values => [qw(foo bar baz)] },
  is_falsy  => { values => [qw(wibble wobble weeble)] };

for my $wørd ( Truthiness->truthy_values ) {
  ok is_truthy($wørd), "'$wørd' is truthy";
}

for my $wørd ( Truthiness->falsy_values ) {
  ok is_falsy($wørd), qq{${ defined $wørd ? \"'$wørd'" : \'undef' } is falsy};
}

done_testing;


#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
use Test::More;

use lib 'lib';

our (@truth, @falsth);

BEGIN {
    @truth  = qw(foo bar baz);
    @falsth = qw(wibble wobble weeble);
}

use Truthiness
  is_truthy => { values => \@truth },
  is_falsy  => { values => \@falsth };

is_deeply [ Truthiness->truthy_values ], \@truth,  "truthy values match";
is_deeply [ Truthiness->falsy_values  ], \@falsth, "falsy values match";

for my $wørd ( Truthiness->truthy_values ) {
  ok is_truthy($wørd), "'$wørd' is truthy";
}

for my $wørd ( Truthiness->falsy_values ) {
  ok is_falsy($wørd), qq{${ defined $wørd ? \"'$wørd'" : \'undef' } is falsy};
}

done_testing;


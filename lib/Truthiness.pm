use strict;
use warnings;
package Truthiness;
# ABSTRACT: sometimes true and false needs to be... flexible
use utf8;
use Carp;
use Data::Dumper;
use English qw(-no_match_vars);
use List::MoreUtils qw(any);

#use Sub::Exporter::Lexical qw();
use Sub::Exporter -setup => {
    #installer => Sub::Exporter::Lexical::lexical_installer,
    exports => {
        is_truthy => \&_create_truth,
        is_falsy  => \&_create_falsth,
    },
    groups  => {
        default => [ qw(is_truthy is_falsy) ],
    },

};

my @truthy_values = ( qw(true  yes on  enabled),  1 );
my @falsy_values  = ( qw(false no  off disabled), 0, undef );

# defaults can be overridden, or used in other ways.
sub truthy_values { shift; @truthy_values = @_ if @_; return @truthy_values }
sub falsy_values { shift; @falsy_values = @_ if @_; return @falsy_values }

sub _create_truth {
    my ($class, $name, $opt, $col) = @_;
    $class->truthy_values( @{ $opt->{values} } ) if defined $opt->{values};
    $class->_warp_reality( values => [ $class->truthy_values ] );
}

sub _create_falsth {
    my ($class, $name, $opt, $col) = @_;
    $class->falsy_values( @{ $opt->{values} } ) if defined $opt->{values};
    $class->_warp_reality( values => [ $class->falsy_values ] );
}

# given a list of values that should be considered "true" or "false",
# generate a sub that will match its input to any of those values.
sub _warp_reality {
    my ($class, %opt) = @_;
    my @values = @{ $opt{values} };
    return sub { return any { $_[0] ~~ $_ } @values };
}


1 && q{ this statement is false }; # or is it?
__END__

=head1 DESCRIPTION

Perl has pretty well-defined notions of "true" and "false". In a nutshell,
any expression that evaluates to undef, an empty string, or zero is false.
Everything else is true (there are some subtleties I'm glossing over here)

But, my friends, sometimes, that's just not good enough! Sometimes, TRUTH
has to fit YOUR NEEDS! TRUTH shouldn't be defined by your COMPILER! LARRY WALL
is not the ULTIMATE AUTHORITY on PURITY and GOODNESS! It's TIME, my brothers,
TO TAKE BACK OUR NATION! Don't let THEM tell you what TRUTH IS, when we ALL
KNOW that TRUTH COMES FROM THE HEART! IT COMES FROM THE GUT! SOMETIMES, IT
COMES FROM OTHER PLACES IN THE ABDOMEN, like the GALL BLADDER!

The important thing to REMEMBER, komrades, is that TRUTH is OUR RIGHT
AS AMERICANS!*

*offer void where prohibited, quantities limited while supply lasts, can not
be combined with other special promotions, may cause bloating, dizziness, and
an inflated sense of self-entitlement.

=head1 SYNOPSIS

  use Truthiness
    is_truthy => { values => [ qw( yes on enabled 1 ) ] },
    is_falsy  => { values => [ qw( no off disabled 0 ) ] };

  say "OK"  if is_truthy "enabled";   # prints "OK"

  my $foo = 'off';
  say "OK" if is_falsy  $foo;         # prints "OK"
  say "OK" if is_truthy $foo;         # nothing printed

=head1 SEE ALSO

https://en.wikipedia.org/wiki/Truthiness

use strict;
use warnings FATAL => 'all';
use 5.014;
package NetObj::IPv4Address;

# ABSTRACT: represent a IPv4 address

use Moo;
use Carp;
use List::MoreUtils qw( all );

sub _to_binary {
    my ($ipaddr) = @_;

    my @octets = split(qr{\.}, $ipaddr);
    return unless @octets == 4;
    return unless all {
        ($_ =~ m{\A \d+ \Z}xms) and ($_ >=0) and ($_ <= 255);
    } @octets;

    return pack('CCCC', @octets);
}

use namespace::clean;

sub is_valid {
    my ($ipaddr) = @_;
    croak 'NetObj::IPv4Adress::is_valid is a class method only'
    if ref($ipaddr) eq __PACKAGE__;

    return !! _to_binary($ipaddr);
}

has binary => (
    is => 'ro',
);

sub BUILDARGS {
    my ($class, $ip, @args) = @_;
    croak 'no IPv4 address given' unless defined($ip);
    croak 'too many arguments in constructor for ' . __PACKAGE__ if @args;

    $ip = _to_binary($ip) unless length($ip) == 4;
    croak 'invalid IPv4 address' unless $ip;

    return { binary => $ip };
}

1;

=head1 SYNOPSIS

  use NetObj::IPv4Address;

  # constructor
  my $ip = NetObj::IPv4Address->new('127.0.0.1');

  # test for validity
  NetObj::IPv4Address::is_valid('127.0.0.1'); # true
  NetObj::IPv4Address::is_valid('1.2.3.4.5'); # false

=head1 DESCRIPTION

NetObj::IPv4Address represents IPv4 addresses.

NetObj::IPv4Address is implemented as a Moose style object class (using Moo).

=method is_valid

The class method C<NetObj::IPv4Address::is_valid> tests for the validity of a
IPv4 address represented by a string.  It does not throw an exception but
returns false for an invalid and true for a valid IPv4 address.

If called on an object it does throw an exception.

=method new

The constructor expects exactly one argument representing an IPv4 address as a
string in the usual form of 4 decimal numbers between 0 and 255 separated by
dots.

It throws an exception for invalid IPv4 addresses.

=method binary

The C<binary> method returns the raw 4 bytes of the IPv4 address.

=for Pod::Coverage
BUILDARGS

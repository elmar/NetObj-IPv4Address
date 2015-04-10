use strict;
use warnings FATAL => 'all';
use 5.014;
package NetObj::IPv4Address;

# ABSTRACT: represent a IPv4 address

use Moo;

1;

=head1 SYNOPSIS

  use NetObj::IPv4Address;

  # constructor
  my $ip = NetObj::IPv4Address->new('127.0.0.1');

=head1 DESCRIPTION

NetObj::IPv4Address represents IPv4 addresses.

NetObj::IPv4Address is implemented as a Moose style object class (using Moo).

#!/usr/bin/env perl

# This is a simple script to automatically generate derivations for DAHDI
# firmware tarballs.
#
# The firmware files are normally fetched with a Makefile included with
# dahdi-linux. This script utilizes that same Makefile to generate a list of
# firmware tarballs, download those tarballs with nix-prefetch-url, and finally
# print out the derivations for those tarballs with url and sha256 sums
# included.
# 
# The purpose of this script is to make it easier to bump the version of the
# dahdi-linux derivation. Simply supply this script with the dahdi-linux
# version number, and it will generate derivations for all of the firmwares.
#
# Example usage:
#   $ ./updateFirmware.pl 2.10.1
#   $ ./updateFirmware.pl 2.10.1 > /tmp/dahdi-linux-firmware.nix
#
# Script requirements: perl, make, and Archive::Extract

use warnings;
use strict;

use Archive::Extract;
use Digest::SHA;
use File::Basename;
use File::Temp qw/ tempdir /;

my $mirror = "http://downloads.asterisk.org/pub/telephony/dahdi-linux";
my $firmware_mirror = "http://downloads.digium.com/pub/telephony/firmware/releases";

my $nix_store = "/nix/store";

sub show_help {
  print "Usage: ./updateFirmware.pl VERSION_NUMBER";
}

if(@ARGV != 1) {
  show_help();
  exit(1);
}

sub guess_derivation {
  my $filename = shift(@_);

  opendir(my $dh, $nix_store) || die "could not open nix store: $!";
  $filename = quotemeta($filename);
  my @matches = grep(/$filename$/, readdir($dh));
  closedir $dh;

  if(scalar @matches != 1) {
    return;
  }
  my $result = "$nix_store/$matches[0]";
  chomp($result);
  print STDERR "Guessed derivation: $result\n";
  return $result;
}

sub fetch_derivation {
  my $url = shift(@_);

  # download with nix-prefetch-url
  my $derivation = `PRINT_PATH=1 nix-prefetch-url ${url}`;

  # derivation path is on the second line
  chomp($derivation);
  $derivation = (split('\n', $derivation))[1];

  print STDERR "Fetched derivation: $derivation\n";

  return $derivation;
}

sub get_derivation {
  my $url = shift(@_);

  my $filename = $url;
  $filename =~ s/^.*\///;

  my $guess = guess_derivation($filename);

  my $derivation;
  if(defined $guess) {
    $derivation = $guess;
  } else {
    $derivation = fetch_derivation($url);
  }

  die "could not get derivation of: $url"
    unless defined $derivation;

  return $derivation;
}

sub get_derivation_sha256 {
  my $url = shift(@_);

  my $derivation = get_derivation($url);

  # use regex to get sha256 sum out of path
  my $nix_store_escaped = quotemeta($nix_store);
  $derivation =~ s/^$nix_store\///;
  $derivation =~ s/^(\w{32}).*/$1/;

  return $derivation;
};

my $version = $ARGV[0];

# get the dahdi-linux tarball derivation
my $dahdi_tarball = get_derivation("${mirror}/dahdi-linux-${version}.tar.gz");

# extract dahdi tarball into temproary directory
my $temp_dir = tempdir( CLEANUP => 1 );
print STDERR "Created temporary directory: $temp_dir\n";
my $ae = Archive::Extract->new( archive => $dahdi_tarball );
print STDERR "Extracting DAHDI tarball...";
$ae->extract( to => $temp_dir )
  or die "failed to extract tarball: $ae->error";
print STDERR " Done.\n";

# build string for print_firmware and print_fwloaders targets
my $print_targets = "\n\n";
$print_targets .= "print_firmware:\n" .
                  "\t@ echo \$(FIRMWARE)\n\n" .
                  "print_fwloaders:\n" .
                  "\t@ echo \$(FWLOADERS)\n\n" .
                  "print_all: print_firmware print_fwloaders\n";

# append print_firmware and print_fwloaders targets to firmware Makefile
my $makefile_path = "$temp_dir/dahdi-linux-${version}/drivers/dahdi/firmware/Makefile";
open(my $fh, ">>", $makefile_path)
  or die "could not open Makefile for appending: $!";
print $fh $print_targets;
close($fh);

# "make" the print targets
my $makefile_dir = dirname($makefile_path);
my $result = `make --quiet -C $makefile_dir print_all`;
$result =~ s/\n/ /g;
print STDERR "Found firmware tarballs: $result\n";

# split result into an array
my @firmwares = split(/\s/, $result);
@firmwares = map +{ name => (do {
                                  # remove version and file extension
                                  (my $new = $_) =~ s/(-(\d+\.)*\d+)?\.tar\.gz$//;
                                  # munge name for nix
                                  $new =~ s/\./_/g;
                                  $new}), 
                    filename => $_,
                    url => "$firmware_mirror/$_"
                  }, @firmwares;

# download each firmware and store each sha256 sum
my $sha = Digest::SHA->new(256);
foreach(@firmwares) {
  my $url = $_->{'url'};
  my $path = get_derivation($url);
  $sha->addfile($path);
  $_->{'sha256'} = $sha->hexdigest();
  $sha->reset(256);
}

# print the fetchurl derivations needed
print STDERR "\n\nOutput:\n\n\n";
foreach(@firmwares) {
  my $name = $_->{'name'};
  my $url = $_->{'url'};
  my $sha256 = $_->{'sha256'};

  print "$name = fetchurl {\n" .
        "  url = $url;\n" .
        "  sha256 = \"$sha256\";\n" .
        "};\n";
}

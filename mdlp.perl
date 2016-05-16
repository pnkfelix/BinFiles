#!/usr/bin/perl -w

use Getopt::Long;
use strict;

my $spec = q(
    --help          	Print this message and then quit
    -v              	Verbose mode
    --verbose [ditto]	
    --lang=LANG		Only print code blocks tagged as LANG
    --doc=slashes	Print doc too, with // before each line
);

my %Options;
GetOptions(\%Options,
           "help",
           "lang=s",
           "verbose",
           "doc=s") or die "Option parsing failure.\nUsage:\n$spec";
my $verbose = $Options{verbose};
my $doc = $Options{doc};
my $lang = $Options{lang};
my $slashes = 0;
if ($Options{help}) {
    print $spec;
    exit;
}
if ($doc) {
    if ($doc eq 'slashes') {
        $slashes = 1;
    } else {
        die "unrecognized doc variant: $doc"
    }
}

my $i = 0;
my $line = 0;
my $printed_doc_in_block = 0;
my $state = 'doc';
my $prev_line = undef;
my $prev_line_rendered = undef;
while (<>) {
    $line = $line + 1;
    if (/^```.*code/ or (($state eq 'code') and /^```/)) {
        if ($prev_line) {
            print "$prev_line_rendered"
        }
        $i = $i + 1;
        if ($state eq 'code') {
            print "\n"; # unless $line == 1;
        }
        next
    }
    if ( $i % 2 == 1) {
        $state = 'code';
        $prev_line = undef
        $prev_line_rendered = undef
        $printed_doc_in_block = undef;
    } else {
        $state = 'doc';
    }
    if ($state eq 'code') {
        my $leading_slashes = m|^//@|;
        if ($leading_slashes) {
            print STDERR "Warning: Leading slashes in code on line $line\n";
        }
        print;
    } elsif ($state eq 'doc' and $slashes) {
        my $trimmed = $_;
        $trimmed =~ s/^\s+|\s+$//g;
        if ($printed_doc_in_block || $trimmed) {
            $printed_doc_in_block = 1;
            if ($prev_line) {
                print "$prev_line_rendered";
            }
            if ($trimmed) {
                $prev_line = 1;
                $prev_line_rendered = "//@ $trimmed\n";
            } else {
                $prev_line = 1;
                $prev_line_rendered = "\n";
            }
        }
    }
}

if ($prev_line) { print $prev_line_rendered }

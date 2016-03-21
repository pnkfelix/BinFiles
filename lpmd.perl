#!/usr/bin/perl
my $lang = 'rust';

use Getopt::Long;
use strict;

my $spec = q(
    --help          	Print this message and then quit
    -v              	Verbose mode
    --verbose [ditto]
    --lang=language 	What language tag to use for code blocks
);
#    --comment=slashes	Comment marker form

my %Options;
GetOptions(\%Options,
           "help",
           "verbose",
           "lang=s") or die "Option parsing failure.\nUsage:\n$spec";

my $verbose = $Options{verbose};
my $lang = $Options{lang};
# my $comment = $Options{comment};
if ($Options{help}) {
    print $spec;
    exit;
}

my $in_code_block = 0;

my $prev_line;
my $prev_line_rendered;
my $line = 0;
while (<>) {
    if ($prev_line_rendered =~ m/^\s*```.*code/) {
        print STDERR "Warning: Leading ``` emitted from line $line\n";
    }

    $line = $line + 1;
    my $trimmed = $_;
    $trimmed =~ s/^\s+|\s+$//g;
    # print "looking at $_";

    # FIXME generalize to other comment marker forms. Maybe
    if (m|^\s*//@|) {
        # print "COMMENT\n";
        if ($in_code_block) {
            print "```\n";
            $in_code_block = 0;
        }
        # FIXME generalize to other comment marker forms. Maybe
        $_ =~ s|^\s*//@\s*||;

        print $prev_line_rendered;
        $prev_line = $_;
        $prev_line_rendered = $_;
    } elsif ($trimmed) {
        # print "CODE\n";
        print $prev_line_rendered;
        if (!$in_code_block) {
            print "```$lang,code\n";
            $in_code_block = 1;
        }
        $prev_line = $_;
        $prev_line_rendered = $_;
    } else {
        # print "BLANKLINE\n";
        print $prev_line_rendered;
        $prev_line = $trimmed;
        $prev_line_rendered = $_;
    }
}

print $prev_line_rendered;

if ($in_code_block) {
    print "```\n";
}

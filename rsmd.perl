#!/usr/bin/perl
$s = 'rust';

my $in_code_block = 0;

my $prev_line;
my $prev_line_rendered;
while (<>) {
    my $trimmed = $_;
    $trimmed =~ s/^\s+|\s+$//g;
    # print "looking at $_";
    if (m|^\s*//@|) {
        # print "COMMENT\n";
        if ($in_code_block) {
            print "```\n";
            $in_code_block = 0;
        }
        $_ =~ s|^\s*//@\s*||;
        print $prev_line_rendered;
        $prev_line = $_;
        $prev_line_rendered = $_;
    } elsif ($trimmed) {
        # print "CODE\n";
        print $prev_line_rendered;
        if (!$in_code_block) {
            print "```rust\n";
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

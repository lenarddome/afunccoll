#!/usr/bin/env perl

# Flatten marked PDF scripts for batch upload as a .zip
#
# REPLACEs a tree of PDF scripts containing comments with
# flattened versions. You should probably make a copy of the originals
# before running this.
#
# The benefit of this approach is that students often upload with the same
# filename, so you can't put all of the files into the same directory.
# However, if you keep the flattened PDFs in folders with the same names that
# Moodle/DLE uses, then the batch upload script is smart enough to match the
# files with the correct student.

use strict;
use warnings;

use Path::Tiny;
use File::Find::Rule;

my $dir = shift or die 'No directory given.';
my $dir_path = Path::Tiny->new($dir);

my @files = File::Find::Rule->file()->in( $dir_path );

# my @files = <*.pdf>;

my %file_info;

for my $file (@files) {
    my $file_name = path($file)->basename;
    my $fn_without_ext = $file_name;
    $fn_without_ext =~ s/\..{3}$//;
    $file_info{ path($file)->dirname }{ $fn_without_ext } = path($file)->basename; 
} 

for my $found_dir (keys(%file_info)) {
    my $file_name = (values %{$file_info{$found_dir}})[0];
    my $file_to_process = path($found_dir, $file_name);
    print "Processing this file: $file_to_process\n";
    # https://unix.stackexchange.com/questions/162922/is-there-a-way-to-flatten-a-pdf-image-from-the-command-line
    # this is slow, but it does the job without reducing the output quality
    my $cmd = "pdf2ps '$file_to_process' - | ps2pdf - /tmp/foo.pdf && mv /tmp/foo.pdf '$file_to_process'";
    #print "\$cmd = $cmd\n";
    `$cmd`;
}

exit;


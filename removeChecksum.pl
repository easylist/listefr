#!/usr/bin/perl

# Copyright 2011 Wladimir Palant
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

use strict;
use warnings;
use Digest::MD5 qw(md5_base64);

die "Usage: $^X $0 subscription.txt\n" unless @ARGV;

#my $file = $ARGV[0];
foreach my $file (@ARGV) {
  my $data = readFile($file);

  # Get existing checksum.
  $data =~ /^.*!\s*checksum[\s\-:]+([\w\+\/=]+).*\n/gmi;
  my $oldchecksum = $1;

  # Remove already existing checksum.
  $data =~ s/^.*!\s*checksum[\s\-:]+([\w\+\/=]+).*\n//gmi;

  writeFile($file, $data);
  $data = ();
}

sub readFile
{
  my $file = shift;

  open(local *FILE, "<", $file) || die "Could not read file '$file'";
  binmode(FILE);
  local $/;
  my $result = <FILE>;
  close(FILE);

  return $result;
}

sub writeFile
{
  my ($file, $contents) = @_;

  open(local *FILE, ">", $file) || die "Could not write file '$file'";
  binmode(FILE);
  print FILE $contents;
  close(FILE);
}

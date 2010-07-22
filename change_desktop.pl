#!/usr/bin/perl
#
use strict;
use WWW::Mechanize;
#
my $url  = "http://photography.nationalgeographic.com/photography/photo-of-the-day/";
#
my $mech  = WWW::Mechanize->new();
$mech->get( $url );
my @links = $mech->links();
my $download_link;

foreach my $link (@links){
   if  ($link->text() eq "Download Wallpaper (1600 x 1200 pixels)"){
       $download_link = $link->url();
       last;
   }
}

my $uri = $download_link;
my $date_time = localtime(time);
my @file_name = split(' ',$date_time);

#Picture will be stored in "/home/vivek/Pictures/" folder and file will be like this "Apr-1-2010.jpg"
##Change the path/folder...
# 
my $tempfile = "/home/dvf1976/Pictures/$file_name[1]-$file_name[2]-$file_name[4].jpg";
#
$mech->get( $uri, ':content_file' => $tempfile );
#
#
if ( -e $tempfile ){
    my $statement = "gconftool-2 --type string --set /desktop/gnome/background/picture_filename $tempfile";
    warn $statement;
    system($statement);
}


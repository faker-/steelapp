#!/usr/bin/perl -w  
#
# Script used to drain/undrain/disable/enable nodes on SteelApp Load Balancers
# 
# Requires: 
#  - perl-SOAP-Lite
#  - perl-Crypt-SSLeay
#  - perl-libwww-perl 
#
# Examples:
# ./steelapp.pl enable "Some Pool" "somenode.int.example.com:80"
# ./steelapp.pl disable "Some Pool" "somenode.int.example.com:80"
# ./steelapp.pl undrain "Some Pool" "somenode.int.example.com:80"
# ./steelapp.pl drain "Some Pool" "somenode.int.example.com:80"
#
# Based on:
# - https://splash.riverbed.com/thread/5986
#

use SOAP::Lite; 
$ENV{PERL_LWP_SSL_VERIFY_HOSTNAME}=0;

# Construct SteelApp URL
my $steel_user     = '<%= @username %>';
my $steel_password = '<%= @password %>';
my $steel_server   = '<%= @server %>';
my $steel_port     = '<%= @port %>';
my $url            = "https://$steel_user:$steel_password\@$steel_server:$steel_port/soap";

my $method = shift @ARGV;
my $poolName = shift @ARGV;
my @theNodes = @ARGV;
my $conn = SOAP::Lite
-> ns('http://soap.zeus.com/zxtm/1.0/Pool/')
-> proxy("$url")
-> on_fault( sub {
my( $conn, $res ) = @_;
die ref $res?$res->faultstring:$conn->transport->status; } );

if ($method eq 'drain') {
    my $res = $conn->addDrainingNodes( [ $poolName ], [[ @theNodes ]] ); 
} elsif ($method eq 'undrain') {
    my $res = $conn->removeDrainingNodes( [ $poolName ], [[ @theNodes ]] ); 
} elsif ($method eq 'disable') {
    my $res = $conn->disableNodes( [ $poolName ], [[ @theNodes ]] ); 
} elsif ($method eq 'enable') { 
    my $res = $conn->enableNodes( [ $poolName ], [[ @theNodes ]] ); 
} else {
    print "Unkown method!\n"
}

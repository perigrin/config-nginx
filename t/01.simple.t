#!/usr/bin/env perl
use lib qw(../lib);
use Test::More no_plan => 1;
use Config::Nginx;

my $conf = Config::Nginx->new();

ok $conf->input(
    {
        name       => "test.org",
        scriptname => "script/test_fcgi.pl",
        nproc      => 3,
        pidfile    => "/tmp/test.org.pid",
        socket     => "/tmp/test.org.socket",
    }
);

ok my $out = $conf->process;
like $out, qr/^\s+server_name test\.org \*\.test\.org;\s+$/smi;
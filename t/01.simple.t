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
like $out, qr/^\s+\Qserver_name test.org *.test.org;\E\s+$/smi;
TODO: {
    $TODO = "These don't work";
    like $out, qr|^\s+\Qfastcgi_pass /tmp/test.org.socket;\E\s+$|smi;
    like $out,
      qr|^\s+include\s+/var/www/sites/test.org/conf/fastcgi_params;\s+$|smi;
    like $out, qr|^\s+root\s+/var/www/sites/test.org/root\s+$|smi;
}

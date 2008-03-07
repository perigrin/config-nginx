use Test::More tests => 3;

BEGIN {
    use_ok('Config::Nginx');
    use_ok('Config::Nginx::UpstreamBlock');
    use_ok('Config::Nginx::ServerBlock');
}

diag("Testing Config::Nginx $Config::Nginx::VERSION");

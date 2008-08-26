use Test::More tests => 1;

BEGIN {
    use_ok('Config::Nginx');
}

diag("Testing Config::Nginx $Config::Nginx::VERSION");

use Test::More no_plan => 1;

{

    package MyConf;
    use Moose;
    with qw(
      Config::Nginx::ServerBlock
      Config::Nginx::TT2
      Config::Nginx::TT2::ServerBlock
    );

    no Moose;
    1;

}

$conf = MyConf->new();
ok( my $str = $conf->render, 'renders something' );
diag($str);
{

    package Config::Nginx::LocationBlock;
    use Moose::Role;

    has locations => (
        isa     => 'ArrayRef[Config::Nginx::Location]',
        is      => 'ro',
        default => sub { [ Config::Nginx::Location->new() ] },
    );

    no Moose::Role;
}

{

    package Config::Nginx::Location;
    use Moose;
    with qw(Config::Nginx::HttpServerLocationConfigs);
    has path => (
        isa     => 'Str',
        is      => 'ro',
        default => sub { '/' },
    );

    has alias => (
        isa     => 'Str',
        is      => 'ro',
        default => sub { '/other' },
        lazy    => 1,
        prefix  => 'alias_set',
    );

    has internal => (
        isa     => 'Boolean',
        is      => 'ro',
        default => 0,
        lazy    => 1,
        prefix  => 'internal_set',
    );

    has limit_except => (
        isa     => 'Config::Nginx::LimitExcept',
        is      => 'ro',
        default => sub { Config::Nginx::LimitExcept->new() },
        lazy    => 1,
        prefix  => 'limit_except_set',
    );

    # Auth
    # satisfy_any

    has proxy_pass => (
        isa     => 'Str',
        is      => 'ro',
        default => 'http://app',
        lazy    => 1,
        prefix  => 'proxy_pass_set',
    );

    no Moose;
    1;
}

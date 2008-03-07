{

    package Config::Nginx::UpstreamBlock;
    use Moose::Role;

    has blocks => (
        isa     => 'ArrayRef[Config::Nginx::Upstream]',
        is      => 'ro',
        default => sub { [ new Config::Nginx::Upstream ] },
    );

    no Moose::Role;
}

{

    package Config::Nginx::Upstream;
    use Moose;

    has name => (
        isa => 'Str',
        is  => 'ro',    
        default =>  sub { 'app' }, 
    );

    has ip_hash => (
        isa       => 'Boolean',
        is        => 'ro',
        lazy      => 1,
        default   => 0,
        predicate => 'fail_timeout_set',

    );

    has servers => (
        isa     => 'ArrayRef[Config::Nginx::Upstream::Server]',
        is      => 'ro',
        default => sub { [ new Config::Nginx::Upstream::Server ] },
    );

    no Moose;
}

{

    package Config::Nginx::Upstream::Server;
    use Moose;

    has name => (
        isa     => 'Str',
        is      => 'ro',
        default => '127.0.0.1:81',
    );

    # weight = NUMBER - set weight of the server, if not set weight is equal to
    # one.
    has weight => (
        isa       => 'Int',
        is        => 'ro',
        default   => sub { 1 },
        lazy      => 1,
        predicate => 'weight_set',
    );

    # max_fails = NUMBER - number of unsuccessful attempts at communicating with
    # the server within the time period (assigned by parameter fail_timeout)
    # after which it is considered inoperative. If not set, the number of
    # attempts is one. A value of 0 turns off this check. What is considered a
    # failure is defined by proxy_next_upstream or fastcgi_next_upstream (except
    # http_404 errors which do not count towards max_fails).
    has max_fails => (
        isa       => 'Int',
        is        => 'ro',
        default   => sub { 1 },
        lazy      => 1,
        predicate => 'max_failes_set',
    );

    # fail_timeout = TIME - the time during which must occur *max_fails* number
    # of unsuccessful attempts at communication with the server that would cause
    # the server to be considered inoperative, and also the time for which the
    # server will be considered inoperative (before another attempt is made). If
    # not set the time is 10 seconds.
    has fail_timeout => (
        isa       => 'Str',
        is        => 'ro',
        default   => '10s',
        lazy      => 1,
        predicate => 'fail_timeout_set',
    );

    # down - marks server as permanently offline, to be used with the directive
    # ip_hash.
    has down => (
        isa       => 'Bool',
        is        => 'ro',
        default   => 0,
        lazy      => 1,
        predicate => 'down_set',
    );

    # backup - (0.6.7 or later) only uses this server if the non-backup servers
    # are all down or busy
    has backup => (
        isa       => 'Bool',
        is        => 'ro',
        default   => 0,
        lazy      => 1,
        predicate => 'backup_set',
    );
    no Moose;
}

1;

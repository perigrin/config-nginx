{

    package Config::Nginx::ServerBlock;
    use Moose::Role;

    has servers => (
        isa     => 'ArrayRef[Config::Nginx::Server]',
        is      => 'ro',
        default => sub { [ new Config::Nginx::Server ] },
    );

    no Moose::Role;
}

{

    package Config::Nginx::Server;
    use Moose;
    with qw(
      Config::Nginx::HttpServerLocationConfigs
      Config::Nginx::LocationBlock
    );

    # server only
    has names => (
        isa     => 'ArrayRef[Str]',
        is      => 'ro',
        default => sub { [qw(example.com *.example.com)] },
    );

    has listen => (
        isa     => 'Config::Nginx::Server::ListenString',
        is      => 'ro',
        default => sub { Config::Nginx::Server::ListenString->new() },
    );
    
    no Moose;
    1;
}

{

    package Config::Nginx::Server::ListenString;
    use Moose;

    has address => (
        isa     => 'Str',
        is      => 'ro',
        default => sub { '127.0.0.1' },
    );

    has port => (
        isa       => 'Int',
        is        => 'ro',
        lazy      => 1,
        predicate => 'port_set',
        default   => '80',
    );

    # backlog=num -- is assigned parameter backlog in call listen(2). By default
    # backlog it is equal to -1.

    has backlog => (
        isa       => 'Int',
        is        => 'ro',
        default   => -1,
        lazy      => 1,
        predicate => 'backlog_set',
    );

    # rcvbuf = size-- is assigned parameter SO_RCVBUF for listening socket .
    has rcvbuf => (
        isa       => 'Maybe[Int]',
        is        => 'ro',
        default   => undef,
        lazy      => 1,
        predicate => 'rcvbuf_set'
    );

    # sndbuf = size-- is assigned parameter SO_SNDBUF for listening socket .
    has sndbuf => (
        isa       => 'Maybe[Int]',
        is        => 'ro',
        default   => undef,
        lazy      => 1,
        predicate => 'sndbuf_set',
    );

    # accept_filter = filter-- is assigned name accept -filter .
    # * It works only to FreeBSD, it is possible to use two filters-- dataready
    #   and httpready On the signal -HUP accept -filter it is possible to change
    #   only in the quite last versions FreeBSD : 6.0, 5.4 -STABLE and 4.11
    #   -STABLE

    has accept_filter => (
        isa       => 'Maybe[Str]',
        is        => 'ro',
        default   => undef,
        lazy      => 1,
        predicate => 'accept_filter_set',
    );

    # deferred-- indicates to use that postponed accept(2) on Linux with
    #     * the aid of option TCP_DEFER_ACCEPT .

    has deferred => (
        isa     => 'Boolean',
        is      => 'ro',
        default => 0,
        lazy    => 1,
    );

  # bind --indicates that it is necessary to make bind(2) separately
  #    * for this pair of address : port . The fact is that if are described
  #      several directives listen with the identical port, but by different
  #      addresses and one of the directives listen listens to on all addresses
  #      for this port( *: port ), then nginx will make bind(2) only to
  #      * : port. It is necessary to consider that in this case for determining
  #      the address, on which the connections arrive, is done the system call
  #      getsockname() . But if are used parameters backlog, rcvbuf, sndbuf,
  #      accept_filter or deferred, then it is always done separately for this
  #      pair of address : port bind(2)

    has bind => (
        isa     => 'Boolean',
        is      => 'ro',
        default => 0,
        lazy    => 1,
    );

    no Moose;
    1;
}

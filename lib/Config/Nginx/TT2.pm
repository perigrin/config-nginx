package Config::Nginx::TT2;
use Moose::Role;
use Template;

has tt2_config => (
    isa     => 'HashRef',
    is      => 'ro',
    default => sub { {} },
);

has tt2 => (
    isa     => 'Template',
    is      => 'ro',
    lazy    => 1,
    default => sub { Template->new( $_[0]->tt2_config ) },
    handles => [qw(process)],
);

no Moose::Role;
1;

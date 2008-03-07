package Config::Nginx::TT2::ServerBlock;
use Moose::Role;

has template => (
    isa     => 'Str',
    is      => 'ro',
    default => sub { local $/; <DATA> },
);

sub render {
    my ($self) = @_;
    $self->process( \$self->template, $self, \my $output );
    return $output;
}
no Moose::Role;
1;

__DATA__
foo: [% FOR server IN servers %] 
server {
    server_name [% FOR name IN server.names %] [% name %][% END %];
    [% IF server.listen %]listen [% server.listen.address %]:[% server.listen.port %];[% END %]
    [% IF server.root %]root [% server.root %];[% END %]
    [% FOR location IN server.locations  %]
    location [% location.path %] {
            [% IF location.index_set %]index [% location.index %];[% END %]
            [% IF location.root_set %]root [% location.root %];[% END %]
            [% IF location.proxy_pass_set %]proxy_pass [% location.proxy_pass %];[% END %]
    }
    [% END %]    
}
[% END %]

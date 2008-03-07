package Config::Nginx::TT2::UpstreamBlock;
use Moose::Role;

has template => (
    isa     => 'Str',
    is      => 'ro',
    default => sub { local $/; <DATA>},
);

sub render {
    my ( $self ) = @_;
    $self->process( \$self->template, $self, \my $output);
    return $output;
}
no Moose::Role;
1;

__DATA__
[% FOR upstream IN blocks %] 

upstream [% upstream.name %] {
    [% IF ip_hash %] ip_hash; [% END %]
    [% FOR server IN upstream.servers %]
        server [% server.name %] [% server.weight %] [% server.max_fails %] [% server.fail_timeout %] [% server.down %];
    [% END %]
}

[% END %]

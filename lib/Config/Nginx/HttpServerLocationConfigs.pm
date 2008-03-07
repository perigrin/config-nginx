package Config::Nginx::HttpServerLocationConfigs;
use Moose::Role;

has index                    => ( isa => 'Str', is => 'ro' );
has root                     => ( isa => 'Str', is => 'ro' );

## http, server, location
has client_body_in_file_only => ( isa => 'Str', is => 'ro' );
has client_body_buffer_size  => ( isa => 'Str', is => 'ro' );
has client_body_temp_path    => ( isa => 'Str', is => 'ro' );
has client_body_timeout      => ( isa => 'Str', is => 'ro' );
has client_max_body_size     => ( isa => 'Str', is => 'ro' );
has default_type             => ( isa => 'Str', is => 'ro' );
has error_page               => ( isa => 'Str', is => 'ro' );
has keepalive_timeout        => ( isa => 'Str', is => 'ro' );
has limit_rate               => ( isa => 'Str', is => 'ro' );
has msie_padding             => ( isa => 'Str', is => 'ro' );
has msie_refresh             => ( isa => 'Str', is => 'ro' );
has port_in_redirect         => ( isa => 'Str', is => 'ro' );
has recursive_error_pages    => ( isa => 'Str', is => 'ro' );
has send_timeout             => ( isa => 'Str', is => 'ro' );
has sendfile                 => ( isa => 'Str', is => 'ro' );
has tcp_nodelay              => ( isa => 'Str', is => 'ro' );
has tcp_nopush               => ( isa => 'Str', is => 'ro' );
has types                    => ( isa => 'Str', is => 'ro' );

no Moose::Role;
1;

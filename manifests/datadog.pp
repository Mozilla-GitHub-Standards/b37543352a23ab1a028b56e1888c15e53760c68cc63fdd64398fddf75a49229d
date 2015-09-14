class dns::datadog {
    package {
        ['perl-App-cpanminus', 'perl-LWP-Protocol-https', 'perl-File-Tail']:
            ensure => installed,
    } ->

    exec {
        'install-dogstatsd-perl':
            path => '/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin:/opt/aws/bin:/root/bin',
            command => 'cpanm https://github.com/binary-com/dogstatsd-perl/archive/0.04.tar.gz',
            unless => 'test -f /usr/local/share/perl5/DataDog/DogStatsd.pm',
    }

    class {
        'apache':
            default_vhost => false,
    }

    apache::vhost {
        'datadog_cgi_gateway':
            vhost_name  => '*',
            port        => '80',
            docroot     => '/var/www/cgi',
            scriptalias => '/usr/lib/cgi-bin',
    }
}

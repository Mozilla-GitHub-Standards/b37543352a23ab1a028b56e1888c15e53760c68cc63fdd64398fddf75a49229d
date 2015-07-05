class dns::files {
    file {
        '/var/named':
            ensure  => directory,
            mode    => '0711',
            owner   => "named",
            group   => 'named';
    
        '/var/named/.ssh':
            ensure  => directory,
            owner   => "named-update",
            group   => "named",
            mode    => '0700',
            require => User['named-update'];
    
        '/var/named/.subversion':
            ensure  => directory,
            owner   => "named-update",
            group   => "named",
            mode    => '0700',
            require => User['named-update'];
    
        '/var/named/.ssh/config':
            ensure  => present,
            owner   => "named-update",
            group   => "named",
            mode    => '0600',
            source  => "puppet:///modules/dns/ssh/config",
            require => User['named-update'];
    
        '/var/named/.ssh/known_hosts':
            ensure  => present,
            owner   => "named-update",
            group   => "named",
            mode    => '0644',
            source  => "puppet:///modules/dns/ssh/known_hosts",
            require => User['named-update'];
    
        '/var/named/chroot':
            ensure  => directory,
            mode    => '0711',
            owner   => "root",
            group   => "named",
            before  => Service['named'],
            require => Package['bind-chroot'];
    
        '/var/named/chroot/var':
            ensure  => directory,
            mode    => '0711',
            owner   => "root",
            group   => "named",
            before  => Service['named'];
    
        '/var/named/chroot/var/named':
            ensure  => directory,
            mode    => '0755',
            owner   => "named-update",
            group   => "named",
            before  => Service['named'];
    
        '/var/named/chroot/var/log':
            ensure  => directory,
            mode    => '0755',
            owner   => "named",
            group   => "named",
            require => User['named-update'],
            before  => Service['named'];
    
        '/var/named/chroot/var/log/named':
            ensure  => directory,
            mode    => '0755',
            owner   => "named",
            group   => "named",
            before  => Service['named'];
    
        '/var/named/chroot/var/run':
            ensure  => directory,
            owner   => "root",
            group   => "root",
            mode    => '0755',
            before  => Service['named'];
    
        '/var/named/chroot/var/run/named':
            ensure  => directory,
            owner   => "named",
            group   => "named",
            mode    => '0770',
            before  => Service['named'];
    
        '/var/named/chroot/var/run/namedctl':
            ensure  => directory,
            owner   => "named-update",
            group   => "named-update",
            mode    => '0755',
            before  => Service['named'];
    
        '/var/named/chroot/var/lock':
            ensure  => directory,
            owner   => "named-update",
            group   => "named",
            mode    => '0755';
    
        '/var/named/chroot/var/tmp':
            ensure  => directory,
            owner   => named,
            group   => named,
            mode    => '0770',
            before  => Service['named'];
    
        # /var/named/config/global-options:145: open: /etc/named-forwarding.conf: file not found
        '/var/named/chroot/etc/named-forwarding.conf':
            ensure  => present,
            before  => Service['named'];
    
        '/var/named/chroot/var/named/slaves':
            ensure  => directory,
            mode    => '0770',
            owner   => "named",
            group   => "named-update",
            before  => Service['named'],
            require => [
                Package['bind-chroot'],
                Exec["dns-svn-checkout"],
            ];
    
        '/var/named/chroot/var/named/dynamic':
            ensure => directory,
            owner  => "named",
            group  => "named-update",
            mode    => '0770',
            before  => Service['named'],
            require => [
                Package['bind-chroot'],
                Exec["dns-svn-checkout"],
            ];
    
        '/var/named/chroot/etc':
            ensure  => directory,
            owner   => "named",
            group   => "named",
            mode    => '0755',
            before  => Service['named'];
    
        '/var/named/chroot/etc/rndc.key':
            ensure  => file,
            mode    => '0640',
            owner   => "root",
            group   => "named",
            require => Exec["rndc-keygen"];
    
        '/var/named/chroot/etc/named.conf':
            ensure  => file,
            content => template('dns/named.conf.erb'),
            require => Package['bind'],
            notify  => Service['named'];
    
        '/etc/named.conf':
            ensure  => file,
            content => template('dns/named.conf.erb'),
            require => Package['bind'],
            notify  => Service['named'];
    
        '/etc/sysconfig/named':
            ensure  => file,
            mode    => '0644',
            source  => 'puppet:///modules/dns/sysconfig/named',
            before  => Service['named'],
            require => Package['bind'],
            notify  => Service['named'];
    
        '/etc/cron.d/named':
            ensure  => present,
            owner   => root,
            group   => root,
            mode    => '0644',
            source  => ['puppet:///modules/dns/cron.d/named'];
    
        '/usr/local/bin/namedctl':
            ensure  => present,
            owner   => root,
            group   => root,
            mode    => '0755',
            content => template('dns/namedctl.erb');

        '/usr/local/sbin/dns-svn-checkout':
            ensure  => present,
            owner   => root,
            group   => root,
            mode    => '0755',
            source  => 'puppet:///modules/dns/sbin/dns-svn-checkout';

        '/etc/rndc.key':
            ensure => link,
            target => '/var/named/chroot/etc/rndc.key';
    }
}

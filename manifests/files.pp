class dns::files {
    $view = 'view.akamai'

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
            require => Package['bind-chroot'];
    
        '/var/named/chroot/var':
            ensure  => directory,
            mode    => '0711',
            owner   => "root",
            group   => "named";
    
        '/var/named/chroot/var/named':
            ensure  => directory,
            mode    => '0755',
            owner   => "named-update",
            group   => "named";
    
        '/var/named/chroot/var/log':
            ensure  => directory,
            mode    => '0755',
            owner   => "named",
            group   => "named",
            require => User['named-update'];
    
        '/var/named/chroot/var/log/named':
            ensure  => directory,
            mode    => '0755',
            owner   => "named",
            group   => "named";
    
        '/var/named/chroot/var/run':
            ensure  => directory,
            owner   => "root",
            group   => "root",
            mode    => '0755';
    
        '/var/named/chroot/var/run/named':
            ensure  => directory,
            owner   => "named",
            group   => "named",
            mode    => '0770';
    
        '/var/named/chroot/var/run/namedctl':
            ensure  => directory,
            owner   => "named-update",
            group   => "named-update",
            mode    => '0755';
    
        '/var/named/chroot/var/lock':
            ensure  => directory,
            owner   => "named-update",
            group   => "named",
            mode    => '0755';
    
        '/var/named/chroot/var/tmp':
            ensure  => directory,
            owner   => named,
            group   => named,
            mode    => '0770';
    
        # /var/named/config/global-options:145: open: /etc/named-forwarding.conf: file not found
        '/var/named/chroot/etc/named-forwarding.conf':
            ensure  => present;
        
        '/var/named/chroot/etc':
            ensure  => directory,
            owner   => "named",
            group   => "named",
            mode    => '0755';
        
        '/var/named/chroot/etc/named.conf':
            ensure  => file,
            content => template('dns/named.conf.erb'),
            require => Package['bind'];
    
        '/var/named/chroot/etc/named-logging.conf':
            ensure  => file,
            mode    => '0644',
            source  => 'puppet:///modules/dns/etc/named-logging.conf',
            require => Package['bind'];

        '/etc/named.conf':
            ensure  => file,
            content => template('dns/named.conf.erb'),
            require => Package['bind'];
    
        '/etc/sysconfig/named':
            ensure  => file,
            owner   => 'root',
            group   => 'root',
            mode    => '0644',
            source  => 'puppet:///modules/dns/sysconfig/named',
            require => Package['bind'];
    
        '/etc/cron.d/named':
            ensure  => present,
            owner   => root,
            group   => root,
            mode    => '0644',
            source  => ['puppet:///modules/dns/cron.d/named'];

        '/etc/sudoers.d/named-update':
            ensure  => present,
            owner   => root,
            group   => root,
            mode    => '0644',
            source  => ['puppet:///modules/dns/sudoers.d/named-update'];

        '/usr/bin/namedctl':
            ensure  => present,
            owner   => root,
            group   => root,
            mode    => '0755',
            content => template('dns/namedctl.erb');

        '/etc/rndc.key':
            ensure => link,
            target => '/var/named/chroot/etc/rndc.key';

        '/etc/nubis.d/dns-server-boot':
            ensure => present,
            owner  => 'root',
            group  => 'root',
            mode   => 0755,
            source => 'puppet:///modules/dns/sbin/dns-server-boot';

        '/usr/sbin/dns-server-init':
            ensure => present,
            owner  => 'root',
            group  => 'root',
            mode   => 0755,
            source => 'puppet:///modules/dns/sbin/dns-server-init';

        '/usr/sbin/dns-server-associate-eip':
            ensure => present,
            owner  => 'root',
            group  => 'root',
            mode   => 0755,
            source => 'puppet:///modules/dns/sbin/dns-server-associate-eip';

        '/usr/libexec/named-find-file':
            ensure => present,
            owner  => 'root',
            group  => 'root',
            mode   => 0755,
            source => 'puppet:///modules/dns/libexec/named-find-file';
    }
}

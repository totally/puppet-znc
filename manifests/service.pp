class znc::service {

    file {'/etc/init.d/znc':
        ensure  => present,
        source  => 'puppet:///modules/znc/znc.init.d',
        owner   => 'root',
        group   => 'root',
        mode    => 755,
        require => [
            Class['znc::user'],
            Class['znc::config'],
            Class['znc::package'],
        ],
    } ->
    service {'znc':
        ensure  => running,
    }
}

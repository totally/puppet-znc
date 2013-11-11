class znc::package(
    $use_backport = znc::params::use_backport
) inherits znc::params {
    # znc uses sasl for authentication
    include sasl
    include apt

    if $use_backport {
        file { '/etc/apt/preferences.d/znc.pref':
            ensure  => $ensure,
            content => template('znc/etc/apt/preferences.d/znc.prefs.erb'),
            notify  => Exec['apt_update'],
        }
    }
    else {
        file { '/etc/apt/preferences.d/znc.pref':
            ensure  => $absent,
            require => Class['apt'],
            notify  => Exec['apt_update'],
        }
    }

    package {[
            "znc",
            "znc-dbg",
            "znc-dev",
            "znc-extra",
            "znc-perl",
            "znc-python",
            "znc-tcl",
        ]:
        ensure  => installed,
        require => File['/etc/apt/preferences.d/znc.pref'],
    }
}

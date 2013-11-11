class znc::user(
    $datadir    = hiera('znc_datadir', $znc::params::datadir),
) inherits znc::params {
    user {'znc':
        ensure  => present,
        uid     => 5546,
        gid     => 'sasl',
        home    => "${datadir}/",
    }
}

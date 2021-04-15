# @summary Install nginx.
#
# Install nginx.
#
# @example
#   include nginx::install
class nginx::install (
  # Using params.pp file.
  $package_name = $nginx::params::package_name
) inherits nginx::params {
  package { 'install_nginx':
    name => $package_name,              # Using params.pp file.
    ensure => $nginx::package_ensure,   # Using Hiera.
  }
}

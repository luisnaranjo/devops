# @summary Installs, configures and sets up a virtual host for nginx.
#
# Installs, configures and sets up a virtual host for nginx.
#
# @example
#   include nginx
class nginx (
  # Using params.pp file.
  $package_name  = $nginx::params::package_name,
  $config_path   = $nginx::params::config_path,
  $config_source = $nginx::params::config_source,
  $service_name  = $nginx::params::service_name,
  $vhosts_dir    = $nginx::params::vhosts_dir,

  # Using Hiera.
  String $config_ensure,
  String $package_ensure,
  String $service_ensure,
  Boolean $service_enable,
  Boolean $service_hasrestart,
  String $vhosts_port,
  String $vhosts_root,
  String $vhosts_ensure,
  String $vhosts_name,
  ) inherits nginx::params {
  contain nginx::install
  contain nginx::config
  contain nginx::service
  contain nginx::vhosts

  Class['nginx::install']
  -> Class['nginx::config']
  ~> Class['nginx::service']
  -> Class['nginx::vhosts']
}
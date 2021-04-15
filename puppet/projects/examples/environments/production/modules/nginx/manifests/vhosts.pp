# Generate a virtual hosts file for nginx. Requires node-specific Hiera data.
#
# @summary Generate a virtual hosts file for nginx.
#
# @example
#   include nginx::vhosts
class nginx::vhosts (
  $vhosts_dir = $nginx::params::vhosts_dir,
) inherits nginx::params {
  file { "${nginx::vhosts_name}.conf":  # Use double quotes when using variables, and enclose variable name with curly brackets.
    content => epp('nginx/vhosts.conf.epp'),    # Template file.
    ensure  => $nginx::vhosts_ensure,
    path    => "${vhosts_dir}/${nginx::vhosts_name}.conf",  # Use double quotes when using variables, and enclose variable name with curly brackets.
  }

  file { "$nginx::vhosts_root":
    ensure => 'directory',
  }
}

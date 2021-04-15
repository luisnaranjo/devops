node darjeto1c.mylabserver.com {
  include nginx
}
node darjeto2c.mylabserver.com {
  # include nginx       # Can also be specified this way.
  class { 'nginx': }
}

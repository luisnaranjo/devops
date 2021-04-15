node Default {
    include docker
    docker::image { 'forethought':
        docker_dir => '/tmp/app'
    }
}

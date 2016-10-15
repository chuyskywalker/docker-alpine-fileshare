job "afs" {
    type = "service"
    datacenters = [ "dc1" ]
    task "afs" {
        driver = "docker"
        config {
            image = "{image}"
        }
        resources {
            memory = 512
            cpu = 1000
        }
    }
}

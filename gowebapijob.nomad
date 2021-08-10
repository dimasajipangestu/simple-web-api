job "raw-exec-example" {
  datacenters = ["dc1"]
  type = "service"
  group "raw" {
    task "go-web-api" {
      driver = "exec"
      config {
        command = "/usr/bin/sh"
        args    = ["/home/dimasajipangestu/go/src/github.com/dimasajipangestu/simple-web-api/simple-web-api"]
      }
      resources {
        memory = 128
      }
    }
  }
}
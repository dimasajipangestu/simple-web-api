job "go-web-api" {
 
  # Run this job as a "service" type. Each job type has different properties
  type = "service"
 
  # A group defines a series of tasks that should be co-located on the same client (host)
  group "server" {
    count = 1
 
    # Create an individual task (unit of work)
    task "web-api" {
      driver = "exec"
 
      # Specifies what should be executed when starting the job
      config {
        command = "/bin/sh"
        args = [
          "/local/install_run.sh"]
      }
 
      # Defines the source of the artifact which should be downloaded
      artifact {
        source = "https://github.com/dimasajipangestu/simple-web-api"
      }
 
      # The service block tells Nomad how to register this service with Consul for service discovery and monitoring.
      service {
        name = "go-web-api"
        port = "http"
 
        check {
          type = "http"
          path = "/"
          interval = "10s"
          timeout = "2s"
        }
      }
 
      # Specify the maximum resources required to run the job, include CPU, memory, and bandwidth
      resources {
        cpu = 500
        memory = 256
 
        network {
          mbits = 5
 
          port "http" {
            static = 8080
          }
        }
      }
    }
  }
}

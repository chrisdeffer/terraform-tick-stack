variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}

variable "swarm-master-ip" {
  default = "10.0.1.56"
}
variable "influxdb-kapacitor-ip" {
  default = "10.0.1.57"
}
variable "chronograf-ip" {
  default = "10.0.1.58"
}
variable "swarm-worker-ip" {
  default = "10.0.1.59"
}
variable "swarm-worker-hostname" {
  default = "worker"
}
variable "influx-hostname" {
  default = "influx"
}
variable "chrono-hostname" {
  default = "chrono"
}
variable "master-hostname" {
  default = "swarm-master"
}
variable "worker-hostname" {
  default = "swarm-worker"
}
variable "AWS_REGION" {
  default = "us-east-1"
}
variable "AMIS" {
  type = "map"
  default = {
    us-east-1 = "ami-13be557e"
    us-west-2 = "ami-06b94666"
    eu-west-1 = "ami-844e0bf7"
  }
}

variable "SECURITY_GROUPS" {
  default = ["sg-00a632f510733c412","sg-0fa551d80897aeec5","sg-0f7cedf536ec89f34","sg-02496b49e8875bd53"]
}

variable "SUB1" {
  description = "subnet used for all components"
  default = "subnet-054bdd24cfd8cea90"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}
variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}
variable "INSTANCE_USERNAME" {
  default = "ubuntu"
}

terraform {
  required_providers {
    fly = {
      source  = "fly-apps/fly"
      version = "~> 0.0.21"
    }

    random = {
      version = ">= 2.1.2"
    }
  }

  required_version = "~> 1.4.6"
}

provider "fly" {
  fly_http_endpoint = "api.machines.dev"
}

provider "random" {}

resource "random_pet" "name" {}

#resource "fly_app" "exampleApp" {
#  name = "kandyba-flyiac"
#  org  = "personal"
#}

resource "fly_ip" "exampleIp" {
  app  = "kandyba-flyiac"
  type = "v4"
  #depends_on = [fly_app.exampleApp]
}

resource "fly_ip" "exampleIpv6" {
  app  = "kandyba-flyiac"
  type = "v6"
  #depends_on = [fly_app.exampleApp]
}

resource "fly_volume" "exampleVolume" {
  name   = "kandyba_volume"
  app    = "kandyba-flyiac"
  size   = 1
  region = var.fly_region
}

resource "fly_machine" "web" {
  app    = "kandyba-flyiac"
  region = var.fly_region
  name   = random_pet.name.id
  image  = "registry.fly.io/kandyba-flyiac"
  services = [
    {
      ports = [
        {
          port     = 443
          handlers = ["tls", "http"]
        },
        {
          port     = var.external_port
          handlers = ["http"]
        }
      ]
      "protocol" : "tcp",
      "internal_port" : 80
    }
  ]
  cpus       = 1
  memorymb   = 256
  depends_on = [null_resource.unmount_volume_in_background]
  mounts = [
    {
      path      = "/data"
      volume    = fly_volume.exampleVolume.id
      encrypted = var.encrypt_volume
    }
  ]
}

resource "null_resource" "unmount_volume_in_background" {
  depends_on = [fly_volume.exampleVolume]

  provisioner "local-exec" {
    when    = destroy
    command = "sleep 60"
  }
}

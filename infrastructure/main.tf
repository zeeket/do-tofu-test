locals {
  dotenv = templatefile("${path.module}/templates/.env.tftpl", {
    config = {
      DATABASE_URL            = "postgres://postgres:tekno@postgres:5432/postgres",
      POSTGRES_PASSWORD       = var.POSTGRES_PASSWORD,
      NEXTAUTH_SECRET         = var.NEXTAUTH_SECRET,
      NEXT_PUBLIC_TG_BOT_NAME = var.NEXT_PUBLIC_TG_BOT_NAME,
      TG_BOT_TOKEN            = var.TG_BOT_TOKEN,
      FORUM_ROOT_NAME         = var.FORUM_ROOT_NAME
    }
  })
  REPO_URL = "${var.GITHUB_SERVER_URL}/${var.GITHUB_REPOSITORY}.git"
}

data "cloudinit_config" "config" {
  gzip          = false
  base64_encode = false

  part {
    filename     = "user-data.sh"
    content_type = "text/x-shellscript"
    content = templatefile("${path.module}/templates/user-data.sh.tftpl",
      {
        REPO_URL = local.REPO_URL
    })
  }

  part {
    filename     = "cloud-config.yml"
    content_type = "text/cloud-config"
    content = templatefile("${path.module}/templates/cloud-config.yml.tftpl", { pub_key = var.pub_key, dotenv = local.dotenv }
    )
  }
}

resource "digitalocean_droplet" "www-1" {
  image     = "ubuntu-20-04-x64"
  name      = "www-1"
  region    = "fra1"
  size      = "s-1vcpu-1gb"
  user_data = data.cloudinit_config.config.rendered
}
resource "digitalocean_droplet" "react-app" {
    image = "ubuntu-14-04-x64"
    name = "react-app"
    region = "blr1"
    size = "512mb"
    ssh_keys = [
      "${var.ssh_fingerprint}"
    ]

    connection {
      user = "root"
      type = "ssh"
      private_key = "${file(var.pvt_key)}"
      timeout = "2m"
    }

    provisioner "remote-exec" {
        inline = [
            "export PATH=$PATH:/usr/bin",
            # install git
            "sudo apt-get update",
            "sudo apt-get -y install git",
            # install node
            "sudo apt-get -y install build-essential libssl-dev",
            "curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash -",
            "sudo apt-get install -y nodejs",
            "sudo apt-get install -y npm",
            # create the react app
            "npx create-react-app my-app",
            "cd my-app",
            "npm start" 
        ]
    }
}
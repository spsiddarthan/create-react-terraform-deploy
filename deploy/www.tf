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
            sudo apt-get -y install git,
            # install node
            sudo apt-get install build-essential libssl-dev,
            curl -sL https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh -o install_nvm.sh,
            bash install_nvm.sh,
            source ~/.profile,
            nvm install 8.9.4,
            nvm use 8.9.4,
            # create the react app
            npx create-react-app my-app
            cd my-app
            npm start 
        ]
    }
}
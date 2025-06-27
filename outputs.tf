output "instance_public_ip" {
    value = values(module.videogames_webserver)[*].instance.public_ip
}
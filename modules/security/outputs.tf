output "videogames_security_group_ids" {
    value = [aws_security_group.videogames_security_group.id]
}

output "videogames_instance_key_pair_name" {
    value = aws_key_pair.videogames_instance_key_pair.key_name 
}
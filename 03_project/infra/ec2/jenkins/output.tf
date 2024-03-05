output "private_ip" {
  description = "The Private IP of the Jenkins"
  value       = aws_instance.jenkins.private_ip
}
output "jenkins_id" {
  description = "The ID of the Jenkins"
  value       = aws_instance.jenkins.id
}
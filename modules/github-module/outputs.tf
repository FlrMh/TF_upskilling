output "instance_id" {
  description = "The name of the created GitHub repo."
  value       = github_repository.modulised-git-repo-tf.name
}

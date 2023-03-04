output "terraform_vm_ip" {
  value = module.load_balancer.lb_public_ip
}

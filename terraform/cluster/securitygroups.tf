resource "exoscale_security_group" "employee_app_security_group" {
  name = "employee_app_security_group"
}

resource "exoscale_security_group_rule" "kubelet" {
  security_group_id = exoscale_security_group.employee_app_security_group.id
  description       = "Kubelet"
  type              = "INGRESS"
  protocol          = "TCP"
  start_port        = 10250
  end_port          = 10250
  # (beetwen worker nodes only)
  user_security_group_id = exoscale_security_group.employee_app_security_group.id
}

resource "exoscale_security_group_rule" "calico_vxlan" {
  security_group_id = exoscale_security_group.employee_app_security_group.id
  description       = "VXLAN (Calico)"
  type              = "INGRESS"
  protocol          = "UDP"
  start_port        = 4789
  end_port          = 4789
  # (beetwen worker nodes only)
  user_security_group_id = exoscale_security_group.employee_app_security_group.id
}

resource "exoscale_security_group_rule" "nodeport_tcp" {
  security_group_id = exoscale_security_group.employee_app_security_group.id
  description       = "Nodeport TCP services"
  type              = "INGRESS"
  protocol          = "TCP"
  start_port        = 30000
  end_port          = 32767
  # (public)
  cidr = "0.0.0.0/0"
}

resource "exoscale_security_group_rule" "nodeport_udp" {
  security_group_id = exoscale_security_group.employee_app_security_group.id
  description       = "Nodeport UDP services"
  type              = "INGRESS"
  protocol          = "UDP"
  start_port        = 30000
  end_port          = 32767
  # (public)
  cidr = "0.0.0.0/0"
}
# Create new meshes
resource "aws_appmesh_mesh" "uc-blue" {
  name = "uc-blue"

  spec {
    egress_filter {
      type = "ALLOW_ALL"
    }
  }
}

resource "aws_appmesh_mesh" "uc-green" {
  name = "uc-green"

  spec {
    egress_filter {
      type = "ALLOW_ALL"
    }
  }
}
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
  shared_credentials_file = "~/.aws/credentials"
}

# Configure roles and policies
resource "aws_iam_role" "appMeshEcsTaskExecutionRole" {
  name = "appMeshEcsTaskExecutionRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_policy" "appMeshSecretsManagerReader" {
  name = "appMeshSecretsManagerReader"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "ssm:ListCommands",
                "ssm:ListDocumentVersions",
                "secretsmanager:DescribeSecret",
                "ssm:ListDocumentMetadataHistory",
                "ssm:DescribeMaintenanceWindowSchedule",
                "ssm:DescribeInstancePatches",
                "ssm:ListInstanceAssociations",
                "ssm:GetParameter",
                "ssm:GetMaintenanceWindowExecutionTaskInvocation",
                "ssm:DescribeAutomationExecutions",
                "ssm:GetMaintenanceWindowTask",
                "ssm:DescribeMaintenanceWindowExecutionTaskInvocations",
                "secretsmanager:GetRandomPassword",
                "ssm:DescribeAutomationStepExecutions",
                "ssm:ListOpsMetadata",
                "ssm:DescribeParameters",
                "ssm:ListResourceDataSync",
                "ssm:ListDocuments",
                "ssm:DescribeMaintenanceWindowsForTarget",
                "ssm:ListComplianceItems",
                "ssm:GetConnectionStatus",
                "ssm:GetMaintenanceWindowExecutionTask",
                "ssm:GetOpsItem",
                "ssm:GetMaintenanceWindowExecution",
                "ssm:ListResourceComplianceSummaries",
                "ssm:GetParameters",
                "ssm:GetOpsMetadata",
                "ssm:ListOpsItemRelatedItems",
                "ssm:DescribeOpsItems",
                "ssm:DescribeMaintenanceWindows",
                "ssm:DescribeEffectivePatchesForPatchBaseline",
                "ssm:GetServiceSetting",
                "ssm:DescribeAssociationExecutions",
                "ssm:DescribeDocumentPermission",
                "ssm:ListCommandInvocations",
                "secretsmanager:ListSecrets",
                "ssm:GetAutomationExecution",
                "ssm:DescribePatchGroups",
                "ssm:GetDefaultPatchBaseline",
                "ssm:DescribeDocument",
                "ssm:DescribeMaintenanceWindowTasks",
                "ssm:ListAssociationVersions",
                "ssm:GetPatchBaselineForPatchGroup",
                "ssm:PutConfigurePackageResult",
                "ssm:DescribePatchGroupState",
                "ssm:DescribeMaintenanceWindowExecutions",
                "secretsmanager:ListSecretVersionIds",
                "ssm:GetManifest",
                "ssm:DescribeMaintenanceWindowExecutionTasks",
                "secretsmanager:GetSecretValue",
                "ssm:DescribeInstancePatchStates",
                "ssm:DescribeInstancePatchStatesForPatchGroup",
                "ssm:GetDocument",
                "ssm:GetInventorySchema",
                "ssm:GetParametersByPath",
                "ssm:GetMaintenanceWindow",
                "ssm:DescribeInstanceAssociationsStatus",
                "ssm:DescribeAssociationExecutionTargets",
                "ssm:GetPatchBaseline",
                "ssm:DescribeInstanceProperties",
                "ssm:ListInventoryEntries",
                "ssm:DescribeAssociation",
                "ssm:ListOpsItemEvents",
                "ssm:GetDeployablePatchSnapshotForInstance",
                "ssm:DescribeSessions",
                "ssm:GetParameterHistory",
                "ssm:DescribeMaintenanceWindowTargets",
                "ssm:DescribePatchBaselines",
                "ssm:DescribeEffectiveInstanceAssociations",
                "ssm:DescribeInventoryDeletions",
                "ssm:DescribePatchProperties",
                "ssm:GetInventory",
                "ssm:GetOpsSummary",
                "ssm:DescribeActivations",
                "ssm:GetCommandInvocation",
                "ssm:ListComplianceSummaries",
                "secretsmanager:GetResourcePolicy",
                "ssm:DescribeInstanceInformation",
                "ssm:ListTagsForResource",
                "ssm:DescribeDocumentParameters",
                "ssm:ListAssociations",
                "ssm:GetCalendarState",
                "ssm:DescribeAvailablePatches"
            ],
            "Resource": "*"
        }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "appMeshSecretsManagerReader" {
  role       = aws_iam_role.appMeshEcsTaskExecutionRole.name
  policy_arn = aws_iam_policy.appMeshSecretsManagerReader.arn
}

resource "aws_iam_role_policy_attachment" "SecretsManagerReadWrite" {
  role       = aws_iam_role.appMeshEcsTaskExecutionRole.name
  policy_arn = "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
}

resource "aws_iam_role_policy_attachment" "CloudWatchFullAccess" {
  role       = aws_iam_role.appMeshEcsTaskExecutionRole.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchFullAccess"
}

resource "aws_iam_role_policy_attachment" "AWSCertificateManagerPrivateCAFullAccess" {
  role       = aws_iam_role.appMeshEcsTaskExecutionRole.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCertificateManagerPrivateCAFullAccess"
}

resource "aws_iam_role_policy_attachment" "AmazonECSTaskExecutionRolePolicy" {
  role       = aws_iam_role.appMeshEcsTaskExecutionRole.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy_attachment" "AWSXrayFullAccess" {
  role       = aws_iam_role.appMeshEcsTaskExecutionRole.name
  policy_arn = "arn:aws:iam::aws:policy/AWSXrayFullAccess"
}

resource "aws_iam_role_policy_attachment" "AWSCertificateManagerFullAccess" {
  role       = aws_iam_role.appMeshEcsTaskExecutionRole.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCertificateManagerFullAccess"
}

resource "aws_iam_role_policy_attachment" "AWSAppMeshFullAccess" {
  role       = aws_iam_role.appMeshEcsTaskExecutionRole.name
  policy_arn = "arn:aws:iam::aws:policy/AWSAppMeshFullAccess"
}

resource "aws_iam_role_policy_attachment" "AmazonPrometheusRemoteWriteAccess" {
  role       = aws_iam_role.appMeshEcsTaskExecutionRole.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonPrometheusRemoteWriteAccess"
}

resource "aws_iam_role_policy_attachment" "AWSAppMeshPreviewEnvoyAccess" {
  role       = aws_iam_role.appMeshEcsTaskExecutionRole.name
  policy_arn = "arn:aws:iam::aws:policy/AWSAppMeshPreviewEnvoyAccess"
}


#Prometheus Query User
resource "aws_iam_user" "prometheus-query-user" {
  name = "prometheus-query-user"
  path = "/"
}

resource "aws_iam_access_key" "prometheus-query-user" {
  user = aws_iam_user.prometheus-query-user.name
}

resource "aws_iam_user_policy_attachment" "AmazonPrometheusQueryAccess" {
  user = aws_iam_user.prometheus-query-user.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonPrometheusQueryAccess"
}

output "prometheus-query-user-access-key-id" {
  value = aws_iam_access_key.prometheus-query-user.id
}

output "prometheus-query-user-secret" {
  value = nonsensitive(aws_iam_access_key.prometheus-query-user.secret)
}

# Create VPC
resource "aws_vpc" "appmesh-vpc" {
  cidr_block           = "10.1.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "appmesh-vpc"
  }
}

resource "aws_subnet" "appmesh-subnet-1" {
  vpc_id     = aws_vpc.appmesh-vpc.id
  cidr_block = "10.1.0.0/24"
  tags = {
    Name = "AppMesh subnet 1"
  }
}

resource "aws_subnet" "appmesh-subnet-2" {
  vpc_id     = aws_vpc.appmesh-vpc.id
  cidr_block = "10.1.1.0/24"
  tags = {
    Name = "AppMesh subnet 2"
  }
}

resource "aws_internet_gateway" "appmesh-igw" {
  vpc_id = aws_vpc.appmesh-vpc.id

  tags = {
    Name = "AppMesh Internet Gateway"
  }
}

resource "aws_route_table" "appmesh-route-table" {
  vpc_id = aws_vpc.appmesh-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.appmesh-igw.id
  }

  tags = {
    Name = "AppMesh Route Table"
  }
}

resource "aws_route_table_association" "appmesh-subnet-1" {
  subnet_id      = aws_subnet.appmesh-subnet-1.id
  route_table_id = aws_route_table.appmesh-route-table.id
}

resource "aws_route_table_association" "appmesh-subnet-2" {
  subnet_id      = aws_subnet.appmesh-subnet-2.id
  route_table_id = aws_route_table.appmesh-route-table.id
}

resource "aws_security_group" "appmesh-allow-all" {
  name        = "Allow All"
  description = "Allow all inbound traffic"
  vpc_id      = aws_vpc.appmesh-vpc.id

  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "Allow all"
  }
}
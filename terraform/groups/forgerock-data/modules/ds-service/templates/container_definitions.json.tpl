[
  {
    "name": "directory-service",
    "image": "${aws_ecr_url}:${tag}",
    "environment": [
      {
        "name": "DS_PASSWORD",
        "value": "${ds_password}"
      }
    ],
    "portMappings": [
      {
        "protocol": "tcp",
        "containerPort": 389,
        "hostPort": 389
      },
      {
        "protocol": "tcp",
        "containerPort": 4444,
        "hostPort": 4444
      }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "${cloudwatch_log_group_name}",
        "awslogs-region": "${region}",
        "awslogs-stream-prefix": "${cloudwatch_log_prefix}"
      }
    }
  }
]
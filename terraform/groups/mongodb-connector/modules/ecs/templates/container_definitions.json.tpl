[
  {
    "name": "mongodb-connector",
    "image": "${aws_ecr_url}:${tag}",
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "${cloudwatch_log_group_name}",
        "awslogs-region": "${region}"
      }
    }
  }
]
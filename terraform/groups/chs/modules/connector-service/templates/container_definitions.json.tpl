[
  {
    "name": "remote-connector-server",
    "image": "${aws_ecr_url}:${tag}",
    "environment": [
      {
        "name": "FIDC_URL",
        "value": "${fidc_url}"
      },
      {
        "name": "CONNECTOR_NAME",
        "value": "${connector_name}"
      },
      {
        "name": "ENVIRONMENT",
        "value": "${environment}"
      },
      {
        "name": "RCS_JVM_ARGS",
        "value": "${rcs_jvm_args}"
      },
      {
        "name": "INACTIVE_FILE_URL",
        "value": "${inactive_file_url}"
      }
    ],
    "secrets": [
      { 
        "name": "RCS_CLIENT_SECRET",
        "valueFrom": "${rcs_client_secret}"
      },
      {
        "name": "SERVER_KEY",
        "valueFrom": "${server_key}"
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

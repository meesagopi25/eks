pipeline {
  agent any

  environment {
    TF_IN_AUTOMATION = "true"
    AWS_DEFAULT_REGION = "us-east-1"
  }

  options {
    timestamps()
    disableConcurrentBuilds()
  }

  stages {

    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Terraform Init') {
      environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-access-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
      }
      steps {
        sh '''
          terraform --version
          terraform init -reconfigure
        '''
      }
    }

    stage('Terraform Validate') {
      environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-access-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
      }
      steps {
        sh 'terraform validate'
      }
    }

    stage('Terraform Plan') {
      environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-access-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
      }
      steps {
        sh 'terraform plan -out=tfplan'
      }
    }

    stage('Manual Approval') {
      steps {
        input message: 'Approve Terraform Apply (EKS change)?',
              ok: 'Approve'
      }
    }

    stage('Terraform Apply') {
      environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-access-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
      }
      steps {
        sh 'terraform apply tfplan'
      }
    }
  }

  post {
    success {
      echo 'Terraform pipeline completed successfully.'
    }
    failure {
      echo 'Terraform pipeline failed. Please review logs.'
    }
    always {
      archiveArtifacts artifacts: 'tfplan', fingerprint: true
    }
  }
}

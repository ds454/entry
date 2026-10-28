pipeline {
  agent {
    kubernetes {
      yaml '''
        apiVersion: v1
        kind: Pod
        spec:
          containers:
          - name: buildkit
            image: moby/buildkit:v0.34.1
            securityContext:
              privileged: true
      '''
    }
  }
  stages {
    stage('build') {
      environment {
      }
      steps {
        container('buildkit') {
          script {
              sh """
                echo Hello, world!
              """
            }
          }
        }
      }
    }
  }

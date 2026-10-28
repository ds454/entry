pipeline {
  agent {
    kubernetes {
      yaml '''
        apiVersion: v1
        kind: Pod
        spec:
          containers:
          - name: buildkit
            image: moby/buildkit:v0.31.0
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
}
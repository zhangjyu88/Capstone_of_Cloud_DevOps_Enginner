pipeline {
    agent any
    stages {
      stage('Pylint *.py') {
        steps {
          sh 'pylint --disable=R,C *.py'
        }
      }
      stage('Build Docker image') {
        steps {
          sh './build_docker.sh'
        }
      }
      stage('Security Scan Docker image') {
        aquaMicroscanner imageName: "movie_web", notCompliesCmd: 'exit 4', onDisallowed: 'fail', outputFormat: 'html'
      }
      stage('Upload Docker to AWS ECR') {
        steps {
          withAWS(region:'us-east-2',credentials:'AWS') {
            sh '''
              docker tag movie_web:latest 918031923317.dkr.ecr.us-east-2.amazonaws.com/movie_web:latest
              docker push 918031923317.dkr.ecr.us-east-2.amazonaws.com/movie_web:latest
            '''
          }
        }
      }
    }
}

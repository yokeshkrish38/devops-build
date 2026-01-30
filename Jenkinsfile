pipeline {
    agent any

    environment {
        DEV_IMAGE  = "krish96/dev-react-app"
        PROD_IMAGE = "krish96/prod-react-app"
        TAG = "latest"
    }

    stages {

        stage('Clone Repo') {
            steps {
                checkout scm
            }
        }

        stage('Detect Branch') {
            steps {
                script {
                    BRANCH = env.BRANCH_NAME
                    echo "Branch detected: ${BRANCH}"
                }
            }
        }

        stage('Build Image') {
            steps {
                script {
                    if (BRANCH == 'dev') {
                        sh "docker build -t $DEV_IMAGE:$TAG ."
                    } else if (BRANCH == 'main') {
                        sh "docker build -t $PROD_IMAGE:$TAG ."
                    } else {
                        echo "Skipping unsupported branch: ${BRANCH}"
                    }
                }
            }
        }

        stage('Docker Login') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                }
            }
        }

        stage('Push Image') {
            steps {
                script {
                    if (BRANCH == 'dev') {
                        sh "docker push $DEV_IMAGE:$TAG"
                    } else if (BRANCH == 'main') {
                        sh "docker push $PROD_IMAGE:$TAG"
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                sh '''
                docker stop react-app || true
                docker rm react-app || true
                docker run -d -p 80:80 --name react-app \
                ${BRANCH == 'dev' ? DEV_IMAGE : PROD_IMAGE}:latest
                '''
            }
        }
    }
}


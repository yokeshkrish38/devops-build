pipeline {
    agent any

    environment {
        DEV_IMAGE  = "krish96/dev-react-app"
        PROD_IMAGE = "krish96/prod-react-app"
        TAG = "latest"
    }

    stages {

        stage('Detect Branch') {
            steps {
                script {
                    env.BRANCH = sh(
                        script: "git rev-parse --abbrev-ref HEAD",
                        returnStdout: true
                    ).trim()

                    if (env.BRANCH == 'dev') {
                        env.DEPLOY_IMAGE = "${DEV_IMAGE}:${TAG}"
                    } else if (env.BRANCH == 'main' || env.BRANCH == 'master') {
                        env.DEPLOY_IMAGE = "${PROD_IMAGE}:${TAG}"
                    } else {
                        error "Unsupported branch: ${env.BRANCH}"
                    }

                    echo "Branch: ${env.BRANCH}"
                    echo "Deploy Image: ${env.DEPLOY_IMAGE}"
                }
            }
        }

        stage('Build Image') {
            steps {
                sh "docker build -t ${DEPLOY_IMAGE} ."
            }
        }

        stage('Docker Login') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh '''
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                    '''
                }
            }
        }

        stage('Push Image') {
            steps {
                sh "docker push ${DEPLOY_IMAGE}"
            }
        }

        stage('Deploy') {
            steps {
                sh '''
                    docker stop react-app || true
                    docker rm react-app || true

                    docker run -d -p 80:80 \
                      --name react-app \
                      '"$DEPLOY_IMAGE"'
                '''
            }
        }
    }
}



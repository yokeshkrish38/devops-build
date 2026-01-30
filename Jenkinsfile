pipeline {
    agent any

    environment {
        DEV_IMAGE  = "krish96/dev-react-app"
        PROD_IMAGE = "krish96/prod-react-app"
        TAG = "latest"
    }

    stages {

        stage('Build Image') {
            steps {
                script {
                    echo "Branch detected: ${env.BRANCH_NAME}"

                    if (env.BRANCH_NAME == 'dev') {
                        sh "docker build -t ${DEV_IMAGE}:${TAG} ."
                    } else if (env.BRANCH_NAME == 'main') {
                        sh "docker build -t ${PROD_IMAGE}:${TAG} ."
                    } else {
                        error "Unsupported branch: ${env.BRANCH_NAME}"
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
                    sh '''
                      echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                    '''
                }
            }
        }

        stage('Push Image') {
            steps {
                script {
                    if (env.BRANCH_NAME == 'dev') {
                        sh "docker push ${DEV_IMAGE}:${TAG}"
                    } else {
                        sh "docker push ${PROD_IMAGE}:${TAG}"
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    def IMAGE = (env.BRANCH_NAME == 'dev') ? DEV_IMAGE : PROD_IMAGE

                    sh """
                      docker stop react-app || true
                      docker rm react-app || true
                      docker run -d -p 80:80 --name react-app ${IMAGE}:${TAG}
                    """
                }
            }
        }
    }
}



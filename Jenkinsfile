pipeline {
    environment {
        CredDocker = 'dockerhub'
    }
    agent none
    stages {
        stage("En contenedor") {
            agent {
                docker { image "python:3"
                args '-u root:root'
                }
            }
            stages {
                stage('Clone') {
                    steps {
                        git branch:'main',url:'https://github.com/angelsuarez1612/djangotutorialtest.git'
                    }
                }
                stage('Install') {
                    steps {
                        sh 'pip install -r requirements.txt'
                    }
                }
                stage('Test')
                {
                    steps {
                        sh 'python3 manage.py test'
                    }
                }

            }
        }
        stage("En maquina") {
            agent any
            stages {
                stage('Clonar') {
                    steps {
                        git branch:'main',url:'https://github.com/angelsuarez1612/djangotutorial_docker.git'
                    }
                }
                stage('Contruir imagen') {
                    steps {
                        script {
                            imagen = docker.build("angelsuarez1612/icdjango:latest")
                        }
                    }
                }
                stage('Subida de imagen') {
                    steps {
                        script {
                            docker.withRegistry( '', CredDocker ) {
                                imagen.push()
                            }
                        }
                    }
                }
                stage('Eliminar imagen') {
                    steps {
                        sh "docker rmi angelsuarez1612/icdjango:latest"
                    }
                }
                stage ('Conexión SSH') {
                    steps{
                        sshagent(credentials : ['SSH_VPS']) {
                            sh 'ssh -o StrictHostKeyChecking=no angelsuarez@zeus.suarezp.com wget https://raw.githubusercontent.com/angelsuarez1612/djangotutorial_docker/main/docker-compose.yaml -O docker-compose.yaml'
                            sh 'ssh -o StrictHostKeyChecking=no angelsuarez@zeus.suarezp.com docker-compose up -d --force-recreate'
                        }
                    }
                }
            }
        }           
    }
    post {
        always {
            mail to: 'angelsp1612@gmail.com',
            subject: "Status of pipeline: ${currentBuild.fullDisplayName}",
            body: "${env.BUILD_URL} has result ${currentBuild.result}"
        }
    }
}

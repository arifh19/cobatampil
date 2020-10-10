pipeline {
    agent any
    parameters {
        booleanParam(name: 'RunTest', defaultValue: true, description: 'Toggle this value for testing')
        choice(name: 'CI/CD', choices: ['CI', 'CICD'], description: 'Pick something')
    }
    stages {
        stage('Build project') {
            steps {
                nodejs('nodejs12') {
                    sh 'yarn install'
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    CommitHash = sh (script : "git log -n 1 --pretty=format:'%H'", retrunStdout: true)
                    buildDocker = docker.build("arifh19/cobatampil:${CommitHash}")
                }
            }
        }
        stage('Run Testing') {
            when {
                expression {
                    params.RunTest
                }
            }
            steps {
                script {
                    buildDocker.inside {
                        sh 'echo passed'
                    }
                }
            }
        }
        stage('Deploy') {
            when {
                expression {
                    params.CICD == params.CICD[1]
                }
            }
            steps {
                echo 'Deploy...'
            }
        }
    }
}

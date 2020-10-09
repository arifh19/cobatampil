/* groovylint-disable-next-line CompileStatic */
pipeline {
    agent any
    parameters {
        booleanParam(name: 'RunTest', defaultValue: true, description: 'Toggle this value for testing')
        choice(name: 'CICD', choices: ['CI', 'CICD'], description: 'Pick something')
    }
    stages {
        stage('Build project') {
            steps {
                echo 'build...'
            }
        }
        stage('Run Testing') {
            when {
                expression {
                    params.RunTest
                }
            }
            steps {
                echo 'Testing...'
            }
        }
        stage('Deploy') {
            when {
                expression {
                    params.CICD == 'CICD'
                }
            }
            steps {
                echo 'Deploy...'
            }
        }
    }
}

/* groovylint-disable-next-line CompileStatic */
pipeline {
    agent any
    parameters {
        booleanParam(name: 'RunTest', defaultValue: true, description: 'Toggle this value for testing')
        choice(name: 'CICD', choices: ['CI', 'CICD'], description: 'Pick something')
    }
    stages {
        stage('Build project') {
            step {
                echo 'build...'
            }
        }
        stage('Run Testing') {
            when {
                expression {
                    params.RunTest
                }
            }
            step {
                echo 'Testing...'
            }
        }
        stage('Deploy') {
            when {
                expression {
                    params.CICD == 'CICD'
                }
            }
            step {
                echo 'Deploy...'
            }
        }
    }
}

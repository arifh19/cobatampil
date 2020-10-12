def builderDocker
def CommitHash

pipeline {
    agent any
    parameters {
        booleanParam(name: 'RunTest', defaultValue: true, description: 'Toggle this value for testing')
        choice(name: 'CICD', choices: ['CI', 'CICD'], description: 'Pick something')
    }
    stages {
        stage('Build project') {
            steps {
                nodejs('nodejs12') {
                    sh 'yarn install'
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
                echo 'passed'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    // CommitHash = sh (script : "git log -n 1 --pretty=format:'%H'", returnStdout: true)
                    buildDocker = docker.build("arifh19/cobatampil:${GIT_BRANCH}")
                }
            }
        }
        stage('Push Image') {
            when {
                expression {
                    params.RunTest
                }
            }
            steps {
                script {
                    if (BRANCH_NAME == 'master') {
                        buildDocker.push("latest")
                    }else {
                        buildDocker.push("${GIT_BRANCH}")
                    }

                    
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    if (BRANCH_NAME == 'master') {
                        sshPublisher(
                            publishers: [
                                sshPublisherDesc(
                                    configName: 'production',
                                    verbose: false,
                                    transfers: [
                                        sshTransfer(
                                            execCommand: "docker pull arifh19/cobatampil:latest; docker kill cobatampil; docker run -d --rm --name cobatampil -p 80:80 arifh19/cobatampil:latest",
                                            execTimeout: 120000,
                                        )
                                    ]
                                )
                            ]
                        )
                    } else {
                        sshPublisher(
                            publishers: [
                                sshPublisherDesc(
                                    configName: 'development',
                                    verbose: false,
                                    transfers: [
                                        sshTransfer(
                                            execCommand: "docker rmi arifh19/cobatampil:${env.GIT_BRANCH}; docker pull arifh19/cobatampil:${env.GIT_BRANCH}; docker kill cobatampil; docker run -d --rm --name cobatampil -p 80:80 arifh19/cobatampil:${env.GIT_BRANCH}",
                                            execTimeout: 120000,
                                        )
                                    ]
                                )
                            ]
                        )
                    }
                    
                }
            }
        }
    }
}

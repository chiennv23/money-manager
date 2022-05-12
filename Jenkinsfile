
pipeline {
    agent none
    stages {
        stage ('Detect build os node') {
                steps {
                    script {
                        env.DEPLOY_ANDROID = ''
                        env.DEPLOY_IOS = ''

                        if (Jenkins.instance.getNode('mac-mini').toComputer().isOnline()) {
                        echo 'mac-mini node is online'
                        env.DEPLOY_IOS = 'true'
                        } else {
                        echo 'mac-mini node is offline'
                        }
                    }
                }
        }

        stage('Run on node') {
            parallel {
                stage('IOS build') {
                    when {
                        // environment name: 'DEPLOY_IOS', value: 'true'
                        expression { env.DEPLOY_IOS == 'true' }
                        beforeAgent true
                    }
                    agent {
                        label 'mac-mini'
                    }
                    stages {
                        stage('get git tag') {
                            steps {
                                script {
                                    latestTag = sh(returnStdout:  true, script: 'git tag --sort=-creatordate | head -n 1').trim()
                                    env.BUILD_VERSION = latestTag
                                }
                            }
                        }
                        stage ('Checkout Source') {
                            steps {
                                echo "Tag ${env.BUILD_VERSION}"
                               
                                checkout([$class: 'GitSCM', branches: [[name: "refs/tags/${env.BUILD_VERSION}"]],
                                    // userRemoteConfigs: [[url: 'https://gitlab.fis.vn/fis-mobile/e-invoice.git',
                                    //                     credentialsId: 'account_phuocnh']]
                                                        userRemoteConfigs: scm.userRemoteConfigs,
                                    ])
                            }
                        }

                        stage ('Download Dependencies') {
                            steps {
                                updateGitlabCommitStatus name: '[ANDROID] Download Dependencies', state: 'running'
                                sh 'flutter pub get'
                                echo 'env-BUILD_VERSION 12 master '
                                echo "${env.BUILD_VERSION}"
                                //sh 'flutter build apk'
                            }
                            post {
                                success {
                                    updateGitlabCommitStatus name: '[ANDROID] Download Dependencies', state: 'success'
                                }
                                failure {
                                    updateGitlabCommitStatus name: '[ANDROID] Download Dependencies', state: 'failed'
                                }
                                aborted {
                                    updateGitlabCommitStatus name: '[ANDROID] Download Dependencies', state: 'canceled'
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

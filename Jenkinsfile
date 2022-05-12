@Library('shared-library-mobile') _
import com.dev.BuildToolsIOS2

def buildTools = new BuildToolsIOS2()

pipeline {
    parameters {
        string(name: 'NEXUS_DIR_URL_PUBLIC', description: 'nexus directory url public', defaultValue: 'https://nexus-dev.telkomdigitalsolution.co/repository/ewz-public/my-tens-gobeyond-ios')
        string(name: 'NEXUS_DIR_URL_PRIVATE', description: 'nexus directory url private', defaultValue: 'https://nexus-dev.telkomdigitalsolution.co/repository/ewz/my-tens-gobeyond-ios')
        string(name: 'CHAT_ID', description: 'chat id of telegram group', defaultValue: '-180171105') //-180171105
        string(name: 'TELEGRAM_CHAT_TITLE', description: 'chat title in telegram', defaultValue: 'MyTens GoBeyond IOS')
        string(name: 'CERT_TYPE', description: 'certificate type: ENTERPRISE or DEFAULT', defaultValue: 'DEFAULT')
    }
    
    agent { label 'agent-ios' }

    triggers { pollSCM '* * * * *' }

    environment {
        LANG="en_US.UTF-8"
        LANGUAGE="en_US.UTF-8"
        LC_ALL="en_US.UTF-8"
        VAULT_ADDR = "https://vault.playcourt.id"
    }

    options {
        skipDefaultCheckout()
    }

    stages {
        stage('Kill Old Build') {
            steps {
                script {
                    buildTools.setPipeline(this)
                    buildTools.setupTools(env.BRANCH_NAME)
                    KillOldBuild()
                }
            }
        }
        stage('Checkout SCM') {
            steps {
                cleanWs()
                checkout scm
                script {
                    echo 'get COMMIT_ID'
                    sh 'echo -n $(git rev-parse --short HEAD) > ./commit-id'
                    commitId = readFile('./commit-id')
                }
                stash(name: 'ws', includes:'**,./commit-id')
            }
        }
        stage('Setup Env') {
            steps {
                script{
                    UnlockKeychain()
                    createFolder('Configuration')
                    downloadFromNexus.DownloadIosConfiguration(NEXUS_DIR_URL_PRIVATE)
                    downloadFromNexus.DownloadIosProfiles(NEXUS_DIR_URL_PRIVATE, buildTools.configuration)
                    buildTools.runMintBootstrap()
                    buildTools.runMintGenerateXCodeGen()
                    buildTools.setupToolsAfterDownloadConfig()
                }
            }
        }
        stage('Install') {
            steps {
                script{
                    buildTools.install()
                }
            }
        }
        stage('Unit Test dan Sonarqube') {
            parallel {
                stage('Unit Test') {
                    steps {
                        script{
                            buildTools.runUnitTest()
                        }
                    }
                }
                stage('Sonarqube') {
                    steps {
                        script{
                            buildTools.scanSonarqube()
                        }
                    }
                }
            }
        }
        stage('Generate Plist File & Ipa') {
            parallel {
                stage('Generate ExportOptions') {
                    steps {
                        script{
                            def signingInfo = buildTools.signingInfo
                            def method = buildTools.getMethodToExportOptions(CERT_TYPE)
                            generateFiles.GenerateExportOptions(
                                bundleIdentifier: signingInfo.bundleIdentifier,
                                provisioningProfileSpecifier: signingInfo.provisioningProfileSpecifier,
                                codeSignIdentity: signingInfo.codeSignIdentity,
                                developmentTeam: signingInfo.developmentTeam,
                                method: method
                            )
                        }
                    }
                }
                stage('Generate manifest') {
                    steps {
                        script{
                            def version = buildTools.getVersion()
                            def ipaUrl = generateFiles.GetIpaUrl(NEXUS_DIR_URL_PRIVATE, buildTools.nameNexus, version)
                            generateFiles.GenerateManifestPlist(
                                bundleIdentifier: buildTools.signingInfo.bundleIdentifier,
                                title: buildTools.appName,
                                version: version,
                                ipaUrl: ipaUrl
                            )
                            def manifestUrl = generateFiles.GetManifestUrl(NEXUS_DIR_URL_PUBLIC, buildTools.nameNexus, version)
                            generateFiles.GenerateLandingPageHtml(
                                title: buildTools.appName,
                                manifestUrl: manifestUrl
                            )
                        }
                    }
                }
                stage('Generate Ipa') {
                    steps {
                        script{ 
                            buildTools.build()
                            buildTools.archive()
                            buildTools.export()
                        }
                    }
                }

            }
        }
        stage('Publish Ipa') {
            steps {
                script{
                    def version = buildTools.getVersion()
                    publishToNexus.PublishIpaToNexus(NEXUS_DIR_URL_PRIVATE, buildTools.environment, version)
                    publishToNexus.PublishManifestToNexus(NEXUS_DIR_URL_PUBLIC, buildTools.environment, version)
                    publishToNexus.PublishLandingPageToNexus(NEXUS_DIR_URL_PUBLIC, buildTools.environment, version)
                }
            }
        }
    }
    post {
        success {
            script {
                withCredentials([string(credentialsId: 'telegram-bot', variable: 'TELEGRAM')]) {  
                    def version = buildTools.getVersion()
                    def url = publishToNexus.GetLandingPageUrl(NEXUS_DIR_URL_PUBLIC, buildTools.nameNexus, version)
                    def textMessage = "Jenkins ${TELEGRAM_CHAT_TITLE} Job Success --- build from ${env.BRANCH_NAME} ${version} ${url}"
                    sendTelegram(TELEGRAM, CHAT_ID, textMessage)
                }
            }
        }
        failure {
            script {
                withCredentials([string(credentialsId: 'telegram-bot', variable: 'TELEGRAM')]) {  
                    def textMessage = "Jenkins ${TELEGRAM_CHAT_TITLE} Job Failed --- build from ${env.BRANCH_NAME}"
                    sendTelegram(TELEGRAM, CHAT_ID, textMessage)
                }
            }
        }
    }
}

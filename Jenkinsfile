pipeline {

    agent any

    stages {
        stage('prepare') {
            steps {
                sh "haxelib newrepo"
                sh "haxelib git arp_ci https://github.com/ArpEngine/Arp-ci master --always"
                sh "haxelib run arp_ci sync"
            }
        }

        stage('flash') {
            steps {
                sh "ARPCI_PROJECT=ArpSupport ARPCI_TARGET=swf haxelib run arp_ci test"
            }
        }

        stage('js') {
            steps {
                sh "ARPCI_PROJECT=ArpSupport ARPCI_TARGET=js haxelib run arp_ci test"
            }
        }

        stage('neko') {
            steps {
                sh "ARPCI_PROJECT=ArpSupport ARPCI_TARGET=neko haxelib run arp_ci test"
            }
        }

        stage('cpp') {
            steps {
                sh "ARPCI_PROJECT=ArpSupport ARPCI_TARGET=cpp haxelib run arp_ci test"
            }
        }
    }

    post {
        always {
            junit(
                    allowEmptyResults: true,
                    keepLongStdio: true,
                    healthScaleFactor: 2.0,
                    testResults: 'bin/report/*.xml'
            )
        }
    }
}

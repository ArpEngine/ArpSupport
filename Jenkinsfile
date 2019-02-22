pipeline {

    agent any

    stages {
        stage('prepare') {
            steps {
                githubNotify(context: 'flash', description: '', status: 'PENDING');
                githubNotify(context: 'js', description: '', status: 'PENDING');
                sh "haxelib newrepo"
                sh "haxelib git arp_ci https://github.com/ArpEngine/Arp-ci master --always"
                sh "haxelib run arp_ci sync"
            }
        }

        stage('flash') {
            steps {
                sh "ARPCI_PROJECT=ArpSupport ARPCI_TARGET=swf haxelib run arp_ci test"
            }
            post {
                success { githubNotify(context: 'flash', description: '', status: 'SUCCESS'); }
                unsuccessful { githubNotify(context: 'flash', description: '', status: 'FAILURE'); }
            }
        }

        stage('js') {
            steps {
                sh "ARPCI_PROJECT=ArpSupport ARPCI_TARGET=js haxelib run arp_ci test"
            }
            post {
                success { githubNotify(context: 'js', description: '', status: 'SUCCESS'); }
                unsuccessful { githubNotify(context: 'js', description: '', status: 'FAILURE'); }
            }
        }
    }

    post {
        always { junit(testResults: 'bin/report/*.xml', keepLongStdio: true); }
    }
}

node {

                tool 'LocalMaven'

               

                stage('Checkout') { 

                                //git url: 'https://github.com/mviknesh/JAXWS-Maven-WS.git', credentialsId: 'GIT'
                              git url: 'https://github.com/mviknesh/JAXWS-Maven-WS.git', credentialsId: 'GIT', branch: "${Branch}"

                }

                dir("${WORKSPACE}") {

                                stage('Build') {

                                  //bat label: 'Maven Build status', script: 'mvn clean install sonar:sonar -DskipTests'

                                  bat label: 'Maven Build status', script: 'mvn clean install -DskipTests'

                                }

                                stage('Docker Image') {

                                                bat label: 'Docker Image',script: 'docker build -t jaxws-maven-ws:latest --rm=true .'

                                }

                                stage('Stop And Remove Container Exists') {

            /*To stop and remove if container exists or running.

                                                 Returning true to avoid failure if not exists or running */

            bat label: 'Stop/Remove if exists', returnStatus: true, script: 'docker rm -f jaxws-maven-ws'

        }

        stage('Docker Run') {

            bat label: 'Docker Run status', script: 'docker run --name=jaxws-maven-ws -d -p 8083:8080 jaxws-maven-ws:latest'

        }

    }

}

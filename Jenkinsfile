pipeline {
	agent any
	tools {
        maven 'maven3.6' 
    }
	stages {

		stage('Cleanup') {
			steps {
				cleanWs()
			}
		}

		stage('SCM Checkout') {
			steps {
				script {
					echo 'Stage 1'
					git branch: 'main',
					credentialsId: 'git_secrets',
					url: 'https://github.com/sanjibbehera/timepass_repo.git'
				}
			}
		}

		stage('Zip Repo') {
			steps {
				bat "mvn clean package"
			}
		}

		/*stage('Publish to Artifact') {
			steps {
				echo 'Upload starts'
				bat "mvn --settings ${WORKSPACE}/settings.xml clean install"
				echo 'Upload finished'
			}
		}*/
		
		stage('publish to artifactory') {
          steps {
				bat "mvn --settings ${WORKSPACE}/settings.xml clean install"
            rtUpload (
                  serverId: 'artifactory',
                  spec: '''{
                        "files": [
                          {
                            "pattern": "target\assemblyPluginTutorial*.zip",
                            "target": "libs-snapshot-local"
                          }
                       ]
                  }'''
              )
              rtPublishBuildInfo (
                    serverId: "artifactory"
                )
          }
        }
	}
}
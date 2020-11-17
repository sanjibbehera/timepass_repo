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

		stage('Publish to Artifact') {
			steps {
				echo 'Upload starts'
				bat "mvn --settings ${WORKSPACE}/settings.xml clean install"
				echo 'Upload finished'
			}
		}
		
		stage('Upload'){
			steps{
				echo 'Uploading'
				script{
					def server = Artifactory.newServer url: 'http://localhost:8081/artifactory', credentialsId: 'artifactory'
					server.bypassProxy=true
					def uploadSpec = """{
						"files": [
							{
								"pattern": "assemblyPluginTutorial*",
								"target": "libs-release-local/com/sanjib/assemblyPluginTutorial/" 
							}
						] 
					}"""
					server.upload(uploadSpec)
				}
			}
		}
		
		/*stage('publish to artifactory') {
          steps {
            rtUpload (
                  serverId: 'artifactory',
                  spec: '''{
                        "files": [
                          {
                            "pattern": "assemblyPluginTutorial*.zip",
                            "target": "libs-release-local/com/sanjib/assemblyPluginTutorial/"
                          }
                       ]
                  }''',

                  buildName: 'demo-app',
                  buildNumber: env.GIT_HASH_VERSION
              )
              rtPublishBuildInfo (
                    serverId: "artifactory",
                    buildName: 'demo-app',
                    buildNumber: env.GIT_HASH_VERSION
                )
          }
        }*/
	}
}
    pipeline{
        agent{
            node{
                label 'workstation'
            }
    }
        options{
            ansiColor('xterm')
        }
        parameters {
            choice(name: 'ACTION', choices: ['apply', 'destroy'], description: 'CHOOSE TF action')
        }
        stages{
          stage('parameter store update'){
            steps {
              dir('PS'){
                git branch: 'main', url: 'https://github.com/shreebadiger/aws-parameter-store.git'      
                sh 'terraform init'
                sh 'terraform apply -auto-approve '                
              }
            }
          }
            stage('TF ACTION'){
            parallel{
              stage('DEV ENV'){
                steps{
                    dir('DEV') {
                git branch: 'main', url: 'https://github.com/shreebadiger/roboshop-terraform.git'      
                sh 'terraform init -backend-config=env-dev/state.tfvars'
                sh 'terraform ${ACTION} -auto-approve -var-file=env-dev/main.tfvars'

                   }
               }
            } 
          //             stage('PROD ENV'){
          //              steps{
          //               dir('PROD') {
          //             git branch: 'main', url: 'https://github.com/shreebadiger/roboshop-terraform.git'                         
          //           sh 'terraform init -backend-config=env-prod/state.tfvars'
          //         sh 'terraform ${ACTION} -auto-approve -var-file=env-prod/main.tfvars'
          //      } 
          //    }

          // }
          }  
        }
      }
      post {
        always {
          cleanWs()
        }
      }
    }
    

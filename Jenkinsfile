pipeline {
  agent {
    kubernetes {
      yaml """
apiVersion: v1
kind: Pod
metadata:
  labels:
    some-label: some-label-value
spec:
  containers:
  - name: elf
    image: bryandollery/terraform-packer-aws-alpine 
    command: 
    - bash
    tty: true
"""
    }
  } 
  stages {
      stage("connect") {
          steps {
              container('elf') {
                  sh '. elf.sh'
              }
          }
      }
  }

}


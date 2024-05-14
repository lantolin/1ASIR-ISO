#!/bin/bash

if [[ -z $1 ]]; then 
  JAVABIN=/usr/lib/jvm/java-17-openjdk-amd64/bin/java
else
  JAVABIN=/home/lantolin/opt/jdk1.8.0_271/bin/java
fi

$JAVABIN -version


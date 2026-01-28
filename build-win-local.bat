@rem Utility script to build the windows agent locally

@setlocal
@set REGISTRY=794835664978.dkr.ecr.eu-west-1.amazonaws.com
@set REGISTRY_ORG=jenkins
@set REGISTRY_REPO_INBOUND_AGENT=inbound-agent
@set ON_TAG=true
@set WINDOWS_VERSION_OVERRIDE=ltsc2022
@set WINDOWS_AGENT_TYPE_OVERRIDE=inbound-agent
@set BUILD_NUMBER=0

@rem docker buildx bake does not yet fully work on Windows. Revert to using docker build directly.
@rem docker buildx bake --file docker-bake.hcl --file docker-bake.override.hcl --pull windowsservercore

@rem arg and tag values are pulled from this command output:
@rem docker buildx bake --file docker-bake.hcl -file docker-bake.override.hcl --print windowsservercore)
docker build -f windows/windowsservercore/Dockerfile ^
  --build-arg JAVA_HOME="C:/openjdk-25" ^
  --build-arg JAVA_VERSION="25.0.1+8" ^
  --build-arg TOOLS_WINDOWS_VERSION="ltsc2022" ^
  --build-arg VERSION="3355.v388858a_47b_33" ^
  --build-arg WINDOWS_VERSION_TAG="ltsc2022" ^
  -t "794835664978.dkr.ecr.eu-west-1.amazonaws.com/jenkins/inbound-agent:3355.v388858a_47b_33-0-jdk25-windowsservercore-ltsc2022" ^
  -t "794835664978.dkr.ecr.eu-west-1.amazonaws.com/jenkins/inbound-agent:jdk25-windowsservercore-ltsc2022" ^
  --pull ^
  .



# Script To Install Jenkins and its dependencies.

For ubuntu only.

Re-login is required for Docker to work without sudo

Jenkins runs on port 8080

Initial Jenkins password:

sudo cat /var/lib/jenkins/secrets/initialAdminPassword


Streamlit installs in user space, not system Python (this avoids breaking Ubuntu)
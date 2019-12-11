wget -O splunk-7.1.0-2e75b3406c5b-linux-2.6-amd64.deb 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=7.1.0&product=splunk&filename=splunk-7.1.0-2e75b3406c5b-linux-2.6-amd64.deb&wget=true'
sudo dpkg -i splunk-7.1.0-2e75b3406c5b-linux-2.6-amd64.deb
sudo /opt/splunk/bin/splunk start

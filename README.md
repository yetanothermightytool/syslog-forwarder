# rsyslog (syslog-forwarder) Docker Container

## Version Information
~~~~
Version: 1.0 (Nov 13 2024)
Author: Stephan "Steve" Herzig
~~~~

This guide walks you through the steps to download, build, and run a persistent Docker container configured with rsyslog to forward Syslog messages selectively. The container listens on TCP port 1514, applies filters based on message severity, and forwards critical and higher-priority messages to a specified remote Syslog server over TCP. 

## Steps to Setup

### 1. Download the Files from GitHub

Clone the repository to your local machine:

```bash
git clone https://github.com/yetanothermightytool/syslog-forwarder.git
```

### 2. Change into the Directory

Navigate into the project directory:

```bash
cd syslog-forwarder
```

### 3. Adjust the rsyslog.conf file

In the `rsyslog.conf` file, locate the line containing destination-ip-address:514 and update it with the correct IP address of your remote syslog server. This example shows how to filter messages based on severity, forwarding only messages with warning (4) or higher:

```plaintext
# Load TCP input module and listen on TCP port 1514
module(load="imtcp")
input(type="imtcp" port="1514")

# Filter: Only forward messages with severity warning (4) or higher
if $syslogseverity <= '4' then @@destination-ip-address:514

```

- @@: This symbol tells rsyslog to use TCP for forwarding.
- @: If you want to use UDP instead, change @@ to a single @, which will use UDP for forwarding messages.
Using TCP ensures reliable delivery by confirming receipt, whereas UDP can be helpful in scenarios where lower latency is prioritized over guaranteed delivery. 


### 4. Build the Docker Image

Build the Docker image with the tag `logstash-veeam-syslog`:

```bash
sudo docker build -t syslog-forwarder .
```

### 6. Run the Docker Container

Run the Docker container:

```bash
sudo docker run -d --name syslog-forwarder -p 1514:1514/tcp syslog-forwarder
```

## Notes

This setup has been tested with:

- Ubuntu 22.04 LTS
- Docker version 27.3.1
- Alpine 3.20.3
- rsyslogd  8.2404.0 (aka 2024.04)

## Version History
- 1.0
  - Initial version


**Please note this config is unofficial and is not created nor supported by Veeam Software.**
**The project is still a work in progress. The files stored in my GitHub can be used for an initial configuration.**

# Confluence-OracleJDK
Atlassian Confluence on OracleJDK
Referenced To Gaurav Dubey update on https://bitbucket.org/atlassian/docker-atlassian-confluence-server/overview

Confluence Server is where you create, organise and discuss work with your team. Capture the knowledge that's too often lost in email inboxes and shared network drives in Confluence – where it's easy to find, use, and update. Give every team, project, or department its own space to create the things they need, whether it's meeting notes, product requirements, file lists, or project plans, you can get more done in Confluence.

Learn more about Confluence Server: https://www.atlassian.com/software/confluence

This Docker container makes it easy to get an instance of Confluence up and running.
Quick Start

For the directory in the environmental variable CONFLUENCE_HOME that is used to store Confluence data (amongst other things) we recommend mounting a host directory as a data volume:

Start Atlassian Confluence Server:

$> docker run -v /data/your-confluence-home:/var/atlassian/application-data/confluence --name="confluence" -d -p 8090:8090 -p 8091:8091 mabdulmoghni/confluence-oraclejdk

Success. Confluence is now available on http://localhost:8090*

Please ensure your container has the necessary resources allocated to it. We recommend 2GiB of memory allocated to accommodate the application server. See Supported Platforms for further information.

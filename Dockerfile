FROM ubuntu:20.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    apt-transport-https

# Add Microsoft repository
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/ubuntu/20.04/prod.list > /etc/apt/sources.list.d/mssql-release.list

# Install SQL Server
RUN apt-get update && ACCEPT_EULA=Y apt-get install -y msodbcsql17 mssql-tools unixodbc-dev
RUN ACCEPT_EULA=Y apt-get install -y mssql-server

# Set environment variables
ENV MSSQL_PID=Express
ENV ACCEPT_EULA=Y
ENV SA_PASSWORD=YourStrong!Passw0rd

# Expose SQL Server port
EXPOSE 1433

# Start SQL Server
CMD ["/opt/mssql/bin/sqlservr"]

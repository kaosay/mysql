# mysql
Install use and optimize mysql

## How to install mariadb
```
# 1. Install prerequisites
sudo apt update
sudo apt install gnupg2 curl software-properties-common -y

# 2. Import the MariaDB GPG key
curl -LsS https://downloads.mariadb.com/MariaDB/mariadb_repo_setup | sudo bash -s -- --mariadb-server-version=11.8.5

# The above command automatically:
#   - Adds the official MariaDB repository for 11.8.5
#   - Configures it for your Ubuntu version
#   - Imports the signing key

# 3. Update package list
sudo apt update

# 4. Install MariaDB 11.8.5 (server + client)
sudo apt install mariadb-server mariadb-client -y

# If you want to be 100% sure you get exactly 11.8.5 (in case newer 11.8.x exists):
# sudo apt install mariadb-server=1:11.8.5+maria~${UBUNTU_CODENAME} mariadb-client=1:11.8.5+maria~${UBUNTU_CODENAME} -y
```

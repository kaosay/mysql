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

## Backup mysql
```
mysqldump --all-databases --ignore-database=mysql > bak.sql
```
```
docker exec mysql mysqldump -uroot -p123 --databases testdb > testdb.sql
```

## Config slow sql
```
-- 检查慢查询日志是否开启
SHOW GLOBAL VARIABLES LIKE 'slow_query_log%';

-- 检查当前的慢查询时间阈值
SHOW GLOBAL VARIABLES LIKE 'long_query_time';

-- 1. 开启慢查询日志
SET GLOBAL slow_query_log = 'ON';

-- 2. 设置“慢”的阈值，例如1秒
SET GLOBAL long_query_time = 1;

-- （可选）记录所有未使用索引的查询，这对优化很有帮助
SET GLOBAL log_queries_not_using_indexes = 'ON';
```

#### 删除某个文件之前的所有binlog日志：
```
PURGE BINARY LOGS TO 'mysql-bin.010';
```
#### 删除某个时间点之前的所有日志：
````
PURGE BINARY LOGS BEFORE '2026-06-25 10:50:00';
````


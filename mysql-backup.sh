#!/bin/bash
# This script is for backup mysql database in docker
# mysql-backup.sh

#-- create msyql bakcup user，access localhost
# CREATE USER 'backup_user'@'localhost' IDENTIFIED BY 'dafds12312fdsfds21';
# GRANT PROCESS, SELECT, SHOW VIEW, TRIGGER, LOCK TABLES ON *.* TO 'backup_user'@'localhost';

# 58 23 * * * /yourBackupDirectory/autobak-sql/mysql-backup.sh >> /yourBackupDirectory/autobak-sql/backup.log 2>&1

# ========== 配置区域 ==========
##DUMP_CMD="mariadb-dump"
DUMP_CMD="mysqldump"
DB_NAME="kaosay"
CONTAINER_NAME="mysql-1"
MYSQL_USER="backup_user"
MYSQL_PASS="dafds12312fdsfds21"
BACKUP_DIR="/root/autobak-sql"
DATE=$(date +%Y%m%d_%H%M%S)
RETENTION_DAYS=7
# ==============================

# 创建备份目录（如果不存在）
mkdir -p "$BACKUP_DIR"

# 执行备份
echo "[$(date '+%Y-%m-%d %H:%M:%S')] Starting backup..."

docker exec "$CONTAINER_NAME" \
  $DUMP_CMD \
    -u"$MYSQL_USER" \
    -p"$MYSQL_PASS" \
    --single-transaction \
    --routines \
    --triggers \
    --add-drop-table \
    --max_allowed_packet=512M \
    ${DB_NAME} \
  2>> "$BACKUP_DIR/backup.log" \
  | gzip > "$BACKUP_DIR/${DB_NAME}${DATE}.sql.gz"

# 检查备份是否成功
if [ ${PIPESTATUS[0]} -eq 0 ]; then
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Backup completed successfully: backup_${DATE}.sql.gz"
    echo "Size: $(du -h "$BACKUP_DIR/${DB_NAME}${DATE}.sql.gz" | cut -f1)"
else
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] ERROR: Backup failed!"
    cat "$BACKUP_DIR/backup.log"
    exit 1
fi

# 清理旧备份
find "$BACKUP_DIR" -type f -name "*.sql.gz" -mtime +$RETENTION_DAYS -delete
echo "[$(date '+%Y-%m-%d %H:%M:%S')] Cleaned up backups older than $RETENTION_DAYS days"

# 可选：记录备份大小
du -sh "$BACKUP_DIR" | awk '{print "Total backup directory size: " $1}'

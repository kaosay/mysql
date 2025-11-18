#!/bin/bash

mysqldump  --single-transaction  --quick  --lock-tables=false db_name  >  db_20251118.sql

mysqldump -uroot -p  --single-transaction  --quick  --lock-tables=false db_name  >  db_`date +%Y%m%d%H`.sql

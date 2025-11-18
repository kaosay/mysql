#!/bin/bash

mysqldump  --single-transaction  --quick  --lock-tables=false db_name  >  db_20251118.sql

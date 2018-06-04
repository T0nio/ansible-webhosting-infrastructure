#!/bin/bash

# TODO Description of the file 

export BORG_PASSPHRASE={{borg_passphrase}}

# Export Mysql databases dans /var/www/databases

BACKUP_DIR=/var/www/dbs
# MYSQL Parameters
MYSQL_UNAME=root
MYSQL_PWORD={{ mysql_root_pwd }}

# Don't backup databases with these names 
# Example: starts with mysql (^mysql) or ends with _schema (_schema$)
IGNORE_DB="(^mysql|_schema$)"
#==============================================================================
# METHODS
#==============================================================================

# YYYY-MM-DD
TIMESTAMP=$(date +%F)
function mysql_login() {
  local mysql_login="-u $MYSQL_UNAME" 
  if [ -n "$MYSQL_PWORD" ]; then
    local mysql_login+=" -p$MYSQL_PWORD" 
  fi
  echo $mysql_login
}

function database_list() {
  local show_databases_sql="SHOW DATABASES WHERE \`Database\` NOT REGEXP '$IGNORE_DB'"
  echo $(mysql $(mysql_login) -e "$show_databases_sql"|awk -F " " '{if (NR!=1) print $1}')
}

function backup_database(){
    backup_file="$BACKUP_DIR/$TIMESTAMP.$database.sql.gz" 
    output+="$database => $backup_file\n"
    $(mysqldump $(mysql_login) $database | gzip -9 > $backup_file)
}

function backup_databases(){
  local databases=$(database_list)
  local total=$(echo $databases | wc -w | xargs)
  local output=""
  local count=1
  for database in $databases; do
    backup_database
    local count=$((count+1))
  done
  echo -ne $output | column -t
}
backup_databases

sshpass -p {{backup_password}} borg create --compression lz4 ssh://{{backup_username}}@{{backup_host}}:{{backup_port}}/~/{{server_name}}/main::backup-{now} /var/www 

sshpass -p {{backup_password}} borg prune --list --keep-daily=7 --keep-weekly=4 --keep-monthly=2 --keep-yearly=2 --save-space ssh://{{backup_username}}@{{backup_host}}:{{backup_port}}/~/{{server_name}}/main 

rm /var/www/dbs/* -f
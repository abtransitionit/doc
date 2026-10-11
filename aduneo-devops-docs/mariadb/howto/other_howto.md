# [Maria DB][Topic_Whatis] > [Howto][Howto_List] > Other


[//]: #(Reference)
[Topic_Whatis]: ../README.md
[Howto_List]:  ../list/howto_list.md
[Install_Howto]:   ../howto/install_howto.md
[Datacenter_List]: ../list/datacenter_list.md
[Vm_Howto]:        ../howto/vm_howto.md


# shell to instance@local

```bash
##  as user not root
sudo mysql -u root -h localhost -p

##  as user:root
sudo mysql
sudo mysql -u root
sudo mysql -u root -h localhost
sudo mysql -u root -h localhost -p
sudo mysql -u keystone -h 92.222.22.21 -D keystone -P 3306 -p"ops"
ops
```

# Switch Db
```bash
use mysql;
```


# Display Info via shell

```sql
-- List Db
SHOW DATABASES;

-- List var
SHOW VARIABLES;
SHOW VARIABLES like 'version';

-- display version
select @@version;
select version();

-- display info
STATUS;
```

## List Db:table
```sql
use mysql
SHOW TABLES;
```
## List Db:Table:column
```sql
desc mysql.servers;
```
## List Db:User
```sql
-- list user:all
select user from mysql.user

-- display user@current
select user();
Select current_user();  

-- display user@logged
SELECT user, host, db, command FROM information_schema.processlist;
```

## List Db:User:Grant
```sql
-- for user:all
SHOW GRANTS;

-- for user:ubuntu on localhost
SHOW GRANTS FOR 'ubuntu'@'localhost';

-- same as 'ubuntu'@'%'
SHOW GRANTS FOR 'ubuntu';

-- other
SHOW GRANTS FOR 'admin'@'192.168.0.1';

-- other
select * from information_schema.user_privileges;
```



# Play sql on Db
## Method
```bash
KEYSTONE_DB_NAME="keystone"
sudo mysql -u root  -e "CREATE DATABASE IF NOT EXISTS ${KEYSTONE_DB_NAME}
```
## Method
```bash
KEYSTONE_DB_NAME="keystone"
SQL_FILE_PATH="/tmp/test.sql"
mysql -u root ${KEYSTONE_DB_NAME} < ${SQL_FILE_PATH}
```

## Method
```bash
#!/bin/bash
KEYSTONE_DBUSER_NAME="keystone"
KEYSTONE_DBUSER_PWD="malafait"
KEYSTONE_DB_NAME="keystone"
sudo mysql -u root -h localhost << EOF
GRANT ALL PRIVILEGES ON ${KEYSTONE_DB_NAME}.* TO 'keystone'@'localhost' IDENTIFIED BY '${KEYSTONE_DBUSER_PWD}';
GRANT ALL PRIVILEGES ON ${KEYSTONE_DB_NAME}.* TO 'keystone'@'%'         IDENTIFIED BY '${KEYSTONE_DBUSER_PWD}';
EOF
```
## Method
```bash
#!/bin/bash
MX_DB_USER_NAME="ubuntu"
MX_DB_USER_PWD="titi"
sudo mysql -u root -h localhost << EOF
ALTER USER '${MX_DB_USER_NAME}'@'localhost' IDENTIFIED BY "${MX_DB_USER_PWD}";
EOF
```

# Manage USer
## Create user with grant
```sql
-- Generic
GRANT type_of_permission ON database_name.table_name TO 'username'@'localhost';

-- create user:keystone with grant on db:keystone
GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'localhost' IDENTIFIED BY 'maxlafait';
FLUSH PRIVILEGES;
```


## Create user
```sql
CREATE USER 'ubuntu'@'localhost' IDENTIFIED BY 'maxlafait';
GRANT ALL PRIVILEGES ON *.* TO 'ubuntu'@'localhost';
--FLUSH PRIVILEGES;
```
## Delete user
```sql
DROP USER 'username'@'localhost';
```

# Delete Grant
```bash
REVOKE type_of_permission ON database_name.table_name FROM 'username'@'localhost';
```



## Update pwd
### Method
```bash
ALTER USER 'root'@'localhost' IDENTIFIED BY 'maxlafait';
ALTER USER 'user'@'hostname'  IDENTIFIED BY 'NewPwd';
FLUSH PRIVILEGES;
```
### Method
```sql
UPDATE mysql.user SET Password=PASSWORD('MxPwd') WHERE USER='MxUserName';
UPDATE mysql.user SET Password=PASSWORD('MxPwd') WHERE USER='MxUserName' AND Host='locahost';
```




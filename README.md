# Magento 2 with Docker
Basic Magento 2 Project works on LAMP and LEMP stacks with Docker

### Installation Steps
**1. Create Services with Docker Containers**

- copy docker-compose-{server-type}-{env}.yml to docker-compose.yml
- if you first time create container then run `docker-compose up -d --build`
- otherwise run `docker-compose up -d`

**2. Create a Magento Open Source Project with Composer**

- After creating containers connect magento2-php container 
- run this command to connect `docker exec -it magento2-php bash` 
- cd html directory
- run this command to create project `composer create-project --repository=https://repo.magento.com/ magento/project-community-edition magento2`
- When Authentication required screen appears enter your keys to username and password areas
- After project is created cd magento2 folder

**3. Install Magento 2**

- If you want to deploy sample data then run this command `php bin/magento sampledata:deploy`
- You must set read-write permissions for the web server group before you install the Magento software. Run the following commands
`find var generated vendor pub/static pub/media app/etc -type f -exec chmod g+w {} +`
`find var generated vendor pub/static pub/media app/etc -type d -exec chmod g+ws {} +`
`chown -R :www-data . # Ubuntu`
`chmod u+x bin/magento`
- To install Magento 2 run the following command 
`bin/magento setup:install \
--base-url=http://localhost \
--db-host=magento2-mysql \
--db-name=magento2 \
--db-user=admin \
--db-password=Magento2Docker \
--admin-firstname=admin \
--admin-lastname=admin \
--admin-email=admin@admin.com \
--admin-user=admin \
--admin-password=admin123 \
--language=en_US \
--currency=USD \
--timezone=America/Chicago \
--use-rewrites=1 \
--use-sample-data`
- You can change these information with yours except db-host. It should be name of the mysql container magento2-mysql. 
- However, if you want to use an external host for database you must change the db-host with host address of the database.
- After installation process you can open your store on http://localhost 
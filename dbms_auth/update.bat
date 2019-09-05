cd %~dp0
call liquibase\liquibase --defaultsFile=liquibase.meta.properties --changeLogFile=db.changelog.meta.xml update >> main.log
call liquibase\liquibase --defaultsFile=liquibase.auth.properties --changeLogFile=db.changelog.auth.xml update >> main.log
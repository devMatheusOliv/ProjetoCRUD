# Usa diretamente o WAR pré-compilado pelo NetBeans
# Antes do deploy, recompile no NetBeans: Clean and Build → gera dist/prj_funcionando.war
FROM tomcat:9.0-jdk21-temurin

# Remove apps padrão do Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*

# Copia o WAR como ROOT para a app responder em / (sem prefixo de contexto)
COPY dist/prj_funcionando.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]

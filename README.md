# Configuração de CGI no Ubuntu com Apache
Este guia simplificado mostra como configurar o CGI no Ubuntu usando Apache, para permitir a execução de scripts no servidor e gerar conteúdo dinâmico.

## Passo a Passo
Instale o Apache
Atualize os pacotes e instale o Apache, caso ainda não esteja instalado:

```
sudo apt update
sudo apt install apache2
```

## Habilite o Módulo CGI
Ative o módulo CGI no Apache e reinicie o serviço para aplicar:

```
sudo a2enmod cgi
sudo systemctl restart apache2
```

## Configure o Diretório de Scripts CGI
Abra o arquivo de configuração do Apache e adicione o alias para o diretório de scripts:

```
sudo nano /etc/apache2/sites-available/000-default.conf
```
Dentro do bloco <VirtualHost>, insira:

```
ScriptAlias /cgi-bin/ /usr/lib/cgi-bin/
```

## Permita Execução de CGI no Diretório
No mesmo arquivo, configure as permissões para execução de scripts:

```
<Directory "/usr/lib/cgi-bin">
    Options +ExecCGI
    AddHandler cgi-script .cgi .pl .sh
    Require all granted
</Directory>
```

## Crie um Script de Teste
Crie um script simples no diretório de scripts para verificar a configuração:

```
sudo nano /usr/lib/cgi-bin/test.sh
```

Insira o seguinte conteúdo:

```
#!/bin/bash
echo "Content-type: text/html"
echo ""
echo "<html><body><h1>CGI Test</h1></body></html>"
```

## Dê Permissão de Execução ao Script
Torne o script executável:

```
sudo chmod +x /usr/lib/cgi-bin/test.sh
```

## Reinicie o Apache
Aplique as configurações reiniciando o Apache:

```
sudo systemctl restart apache2
```

## Teste o Script CGI
Acesse no navegador:

```
http://localhost/cgi-bin/test.sh
```

Deverá aparecer uma página com o título "CGI Test".

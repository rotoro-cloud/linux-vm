<h2>Задание 0</h2>

<h4>Подготовь систему bp 2-х VMs как в 7 разделе (котоорый про сеть), а после этого запусти `sudo bash 9-prj/task9-prj.sh`</h4>

<h2>Задание 1</h2>

<details> 
  <summary>Скопировать  архив из /home/max/pollme-code.tar.gz на машине `ws01` на сервер `app01` </summary>
   <pre>scp /home/max/pollme-code.tar.gz app01:/home/max/pollme-code.tar.gz</pre>
</details>

<h2>Задание 2</h2>

<details> 
  <summary>На `app01` сервере раcпакуй скопированный файл в директорию `/opt/` </summary>
   <pre>ssh app01</pre>
   <pre>sudo tar -zxf pollme-code.tar.gz -C /opt</pre>
</details>
<details> 
  <summary>Используй команду `rm` для tar-файла `pollme-code.tar.gz` </summary>
  <pre>rm /home/max/pollme-code.tar.gz</pre>
</details>
<details> 
  <summary>Убедись, что каталог извлечен таким образом, что путь `/opt/pollme-code/pollme/` существует на `app01` </summary>
  <pre>ls -al /opt/pollme-code/pollme/</pre>
</details>

<h2>Задание 3</h2>
<h4>Для развертывания Макс установил базу данных `mysql` на своей рабочей станции.</h4> 
<details> 
  <summary>Вернись на сервер `ws01` и проверь статус `mysql.service`</summary>
   <pre>exit</pre>
   <pre>systemctl status mysql</pre>
</details>
<h4>База работает только на локальные подключения. Нужно, чтобы она принимала внешние подключения.</h4>
<details> 
  <summary>Добавь запись `bind-address = 0.0.0.0` и `mysqlx-bind-address = 0.0.0.0` в секцию `[mysqld]` файла `/etc/mysql/mysql.conf.d/mysqld.cnf </summary>
  <pre>sudo sed -i 's/bind-address\s*=\s*127\.0\.0\.1$/bind-address = 0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf</pre>
</details>
<h4>Теперь база готова слушать внешний мир, но ее надо перезапустить</h4>
<details> 
  <summary>Перезапусти БД `mysql` на сервере </summary>
  <pre>sudo systemctl restart mysql</pre>
</details>
<details> 
  <summary>На каком порту запущена `mysql`? Проверь с помощью команды `netstat` </summary>
  <pre>sudo netstat -tulpn | grep mysql | grep LISTEN</pre>
</details>
<h4>Запомни этот порт, он скоро понадобится</h4>

<h2>Задание 4</h2>
<h4>Теперь займемся кодом приложения.</h4> 
<details> 
  <summary>Возвращайся на `app01`. Попробуй запустить приложение так:</summary>
   <pre>ssh app01</pre>
   <pre>Перейди в директорию `/opt/pollme-code/pollme/`</pre>
   <pre>Запусти команду `python3 manage.py runserver 0.0.0.0:8000`</pre>
</details>
<h4>Команда успешна? Приложение запустилось? Нажми `Control + C`, если ты не можешь вернуться в приглашение оболочки</h4>
<details> 
  <summary>Установи необходимые для приложения пакеты-зависимости. Имена пакетов `python3-pip default-libmysqlclient-dev pkg-config mysql-client  python3.10-dev  build-essential  libmysqlclient-dev` </summary>
  <pre>sudo apt install python3-pip default-libmysqlclient-dev pkg-config mysql-client  python3.10-dev  build-essential  libmysqlclient-dev</pre>
</details>
<details> 
  <summary>Найди в каталоге `/opt/pollme-code/` файл python-зависимостей `requirements.txt` и установи их с помощью менеджера пакетов `PIP` </summary>
  <pre>pip install -r requirements.txt</pre>
</details>
<details> 
  <summary>Также отдельно нужно глобально поставить пакет `mysqlclient` через PIP</summary>
  <pre>sudo pip install mysqlclient</pre>
</details>
<h4>Снова запусти команду `python3 manage.py runserver 0.0.0.0:8000`</h4>
<details> 
  <summary>Проверь ошибки в логах последней команды </summary>
  <pre>Can't connect to local MySQL server through socket</pre>
</details>

<h2>Задание 5</h2>
<h4>Похоже, что Макс использует `неправильный` порт для `mysql`.</h4> 
<details> 
  <summary>Найди файл в каталоге `/opt/pollme-code/`, строка которого соответствует `DATABASES = {`</summary>
   <pre>grep -ir "DATABASES = {" /opt/pollme-code</pre>
</details>
<details> 
  <summary>Замени значение `localhost` на `ws01`</summary>
   <pre>sudo vi <найденый файл></pre>
</details>
<details> 
  <summary>В том же файле исправь порт `mysql`, чтобы он совпадал с портом, используемым на `ws01`</summary>
   <pre>sudo vi <найденый файл></pre>
</details>
  
<h4>Проверь подключение командой `mysql -udjangouser -p'PASSWORD' -h ws01 -P 3306 -D lets_quiz`</h4>
  
<h2>Задание 6</h2>
<h4>Для разрешения подключения удаленного пользователя к БД нужно изменить запись в таблице базы.</h4> 
<details> 
  <summary>Вернись на `ws01`. Там запусти команду `mysql -u root -p`, введи пароль `rootpassmysql`</summary>
   <pre>exit</pre>
   <pre>mysql -u root -prootpassmysql</pre>
</details>
<details> 
  <summary>После  входа сделай запись в таблицу `mysql`, чтобы разрешить пользователю `djangouser` работать с хоста `app01`</summary>
   <pre>CREATE USER 'djangouser'@'app01' IDENTIFIED WITH mysql_native_password BY 'PASSWORD';GRANT ALL PRIVILEGES ON lets_quiz.* TO 'djangouser'@'app01';</pre>
  <pre>FLUSH PRIVILEGES;</pre>
</details>
<details> 
  <summary>Выйди из mysql-клиента командой `exit;` и вернись на `app01`</summary>
   <pre>exit</pre>
  <pre>ssh app01</pre>
</details>
  
<h2>Задание 7</h2>
<details> 
  <summary>Измени владельца `ВСЕХ` файлов и каталогов в `/opt/pollme-code/` на пользователя `pollme` на сервере `app01`</summary>
   <pre>sudo chown -R pollme /opt/pollme-code/</pre>
</details>
<details> 
  <summary>Снова запусти приложение Макса на `app01`, выполнив следующее:</summary>
   <pre>Перейди в каталог `/opt/pollme-code/pollme`</pre>
  <pre>python3 manage.py runserver 0.0.0.0:8000 --insecure</pre>
</details>

<h4>Теперь проложение должно запуститься. Ты можешь получить доступ к нему введя в браузере `http://localhost:30080`.</h4> 
  
<h2>Задание 8</h2>
  
<h4>Создай новую службу c названием `pollme.service` со следующими характеристиками:</h4> 
<h5>Путь к unit-файлу `/etc/systemd/system`</h5> 
<h5>Имя службы: `pollme.service`</h5> 
<h5>Включение на этапе `multi-user.target`</h5> 
<h5>Описание службы: `PollMe Web App`</h5> 
<h5>Команда для запуска: `python3 manage.py runserver 0.0.0.0:8000 --insecure`</h5> 
<h5>Рабочая директория: `/opt/pollme-code/pollme`</h5> 
<h5>Запуск от имени пользователя `pollme`</h5> 
<h5>Необходим перезапуск `при сбое`</h5> 
<h5>Запусти `pollme.service` и сделай ее доступной после перезагрузки</h5> 
  
<details> 
<summary>Здесь текст файла службы</summary>
   <pre>[Unit]
Description=PollMe Web App

[Service]
ExecStart=/usr/bin/python3 manage.py runserver 0.0.0.0:8000 --insecure
Restart=on-failure
WorkingDirectory=/opt/pollme-code/pollme
User=pollme

[Install]
WantedBy=multi-user.target</pre>
</details>
<details> 
  <summary>Здесь команды</summary>
   <pre>sudo systemctl enable pollme --now</pre>
</details>


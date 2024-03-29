### ***Linux shell***

___

***1. Проверить сколько shell есть в системе и какие доступны.***

```diff
+ Интерпретатор командной строки, или shell (shell -- оболочка) -- эта та программа, которая принимает команды от пользователя и исполняет их.

- Использую команды:

# cat /etc/shells
# grep '^[^#]' /etc/shells
```

```shell
/bin/sh
/bin/bash
/usr/bin/bash
/bin/rbash
/usr/bin/rbash
/bin/dash
/usr/bin/dash
```

***2. Проверить какой текущий shell я использую.***

*Команда выбирает процессы, идентификационные номера которых отображаются в pid. Аргумент $ возвращает PID*


```shell

$ ps -p $$

    PID TTY          TIME CMD
  13456 pts/3    00:00:00 bash
```

*Можно сохранить имя оболочки в переменной*

```shell
$ echo $0 

-bash
```
*Используя команду grep, я нашел в этом файле строку, которая начинается с имени пользователя, вошедшего в систему в данный момент и его оболочку:*

```shell
$ grep "^$USER" /etc/passwd

root:x:0:0:root:/root:/bin/bash
```

***3. Проверить какой текущий shell через переменную.***

```shell

$ echo "$SHELL"

/bin/bash

$ printf "My current shell - %s\n" "$SHELL"

My current shell - /bin/bash
```

***4. Проверить какой текущий shell командой readlink***

*Нужно сделать символическую ссылку, содержащую фактический путь к выполняемой команде с идентификатором процесса pid.*

```shell
$ readlink /proc/$$/exe

/usr/bin/bash
```

***5. Проверяю версию оболочки, в моем случае - bash***

![](./media/photo1.png)

![](./media/photo2.png)


 *У меня оболочка bash по дефолту поставлена в системе, можно оптимизировать и выставлять, есть три способа:*
 
```diff
- # vi /etc/passwd - вручную отредактировать в файле требуемую оболочку для определенного пользователя.

- # chsh --shell /bin/sh anton - утилитой командной строки для изменения оболочки входа в систему.

- # usermod --shell /bin/bash anton - утилитой для изменения данных учетной записи пользователя, хранящихся в файле /etc/passwd.
```

***6. Сравнение переменных окружения***

Это удаленный bash через ssh

![](./media/photo3.png)

Локальный bash

![](./media/photo4.png)


При взаимодействии с вашим сервером через сеанс оболочки существует множество фрагментов информации, которые ваша оболочка компилирует для определения своего поведения и доступа к ресурсам. Некоторые из этих параметров содержатся в параметрах конфигурации, а другие определяются пользователем.

Один из способов, с помощью которого оболочка отслеживает все эти настройки и детали, — это поддерживаемая ею область, называемая средой. Среда — это область, которую оболочка создает каждый раз при запуске сеанса, содержащего переменные, определяющие системные свойства

Переменные среды `LOGNAME` у меня отличаются, потому что нахожусь под разными пользователями. `XDG_SESSION_TYPE` для удаленного bash задана как **tty** - виртуальная консоль. `MOTD_SHOWN` приветствие обеспечивает **pam**. `LS_COLORS` - цветовые коды, которые используются для дополнительного добавления цветного вывода в команду ls. Это используется для различения различных типов файлов и предоставления пользователю дополнительной информации с первого взгляда. Переменные `XDG_*` задает `pam_systemd` регистрируя сеансы пользователей. `PATH` - разные. Список каталогов, которые система будет проверять при поиске команд. Когда пользователь вводит команду, система проверяет каталоги в этом порядке на наличие исполняемого файла. `SSH_TTY=/dev/pts1/`, это означает что по эту пути хранится псевдотерминал, с помощью приложения ввидят вывод и ввод через терминальное устройство. И `DBUS_SESSION_BUS_ADDRESS` вызывает какой то демон при старте сеанса.



***7. Проверяю все переменные среды доступные в текушей сессии***

`$ env` - будет отображать только список переменных среды, которые были экспортированы, и не будет отображать все переменные bash. У меня вывод схожий с выводом 
`printenv`

![](./media/photo5.png)


___

***<mark style="background-color: #00BFFF">Полезные ссылки для меня:</mark>***

1. https://www.digitalocean.com/community/tutorials/how-to-read-and-set-environmental-and-shell-variables-on-linux

2. https://www.cyberciti.biz/faq/linux-list-all-environment-variables-env-command/

3. https://habr.com/ru/post/47163/

4. https://www.cyberciti.biz/tips/how-do-i-find-out-what-shell-im-using.html


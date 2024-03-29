Был создан скрипт `infinite1.sh` по пути `/tmp/script/infinite1.sh`

![](./media/image10.png)

Запустил скрипт `#bash infinite1.sh` и проверил утилитой **htop** в другом
терминале.

![](./media/image11.png)

Попытался убить процесс `Kill- F9`. Как результат процесс перешел в состояние `terminated`.

![](./media/image4.png)

Лучший подход - перенаправить команду на `/dev/null`, это файл виртуального устройства, который при записи в него всё отправляет в пустоту.

```bash
bash infinite1.sh & \> /dev/null & - запустить процесс
kill -9 (PID процесса) - убить процесс
```

Второй вариант - команда **nohup**, сокращение от no hang up, это команда, которая поддерживает выполнение процесса даже после выхода из оболочки.

Он делает это, блокируя получение процессами сигнала SIGHUP (Signal Hang
UP), который является сигналом, который обычно отправляется процессу,
когда он выходит из терминала.

```bash
$ nohup infinite1.sh &\>/dev/null &
```
Сделал 3 скрипта одинаковых:

![](./media/image12.png)

Запустил их в background

![](./media/image8.png)

Вот что показывает **htop** - все три скрипта запущены, но в состоянии sleep. На значениях CPU - периодически появляются значения 0.5-0.7

![](./media/image5.png)

![](./media/image1.png)

Ок. Поменял скрипты, чтобы соответствовали максимальному потреблению CPU. Пробую еще раз запустить.

![](./media/image9.png)

Теперь все три в состоянии - **running**

![](./media/image3.png)

Запущен еще один скрипт с установленным более низким приоритетом.

```java
# nice -n 10 nohup bash infinite4.sh & \> /dev/null
```

![](./media/image6.png)

Меняем приоритет уже запущенного процесса

```java
#renice -n 5 -p 9169
```

![](./media/image7.png)

Также, команда renice позволяет суперпользователю изменять значение nice процессов любого пользователя, в моем случае я могу изменить для root

```java
#renice -n 15 -u root
```
![](./media/image2.png)

```java
#kill -9 9173 9171 9169 9188
```

Некоторые процессы могут рассматриваться как критически важные, в то время как другие могут быть выполнены за счет остатка ресурсов. Задачи с высоким приоритетом имеют низшее значение **nice**, так как они поглощают ресурсы. С другой стороны, задачи с низким приоритетом имеют высокое значение **nice**, так как они используют минимальное количество ресурсов.

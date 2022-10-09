## ***Load Balancer in AWS cloud. Working with web-servers and copy html.***

___


+ *Устанавливаю интерфейс командной строки в `AWS` на своей локальной машине*


```shell
$ curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

$ unzip awscliv2.zip

$ sudo ./aws/install

$ aws --version
```

```shell
aws-cli/2.8.0 Python/3.9.11 Linux/5.15.0-46-generic exe/x86_64.ubuntu.20 prompt/off
```

+ *Потом необходимо создать учетные данные интерфейса командной строки AWS из консоли управления AWS. Переходим в `IAM - Dashboard - Users ` Там будут перечислены все доступные учетные записи пользователей в учетной записи AWS, у меня пусто - создаю и также группу `testusers` и добавляю туда нового юзера. Можно авторизироватся по этой ссылке https://148658770076.signin.aws.amazon.com/console*


![](./media/photo1.png)

![](./media/photo2.png)

![](./media/photo3.png)

![](./media/photo4.png)

+ *Применяем наш созданный `AWS Access Key ID` и `AWS Secret Access Key` через командную строку на `Ubuntu` и ложим в один из файликов `json, yaml, table, text` и проверяем*


```shell
$ aws configure
$ aws configure list
$ aws configure list-profiles
```



+ *Создать `Role` для `EC2` и `AWS Managment CLI` чтобы они могли вызывать другие сервисы в AWS. Это сделал в `IAM` То есть, по сути этим мы предоставляем права достпупа пользователям или сервисам, при создании виртуалки EC2 нужно выбрать, если мы хотим чтобы сервис работал ограниченно, но можно поставить и `None`*

![](./media/photo6.png)

![](./media/photo7.png)

![](./media/photo8.png)


+ *Также я поковырялся в `security group` там можно ограничить передачу трафика по определенным протоколам, я создал такое правило для `SSH` `HTTP` `HTTPs` доступ по ним к нашим виртуалкам с любого адреса, но это тоже можно ограничить. Потом можно назначить это правило для все 3х `EC2`*

![](./media/photo9.png)

+ *Создать 3 `ЕС2` (Amazon Elastic Compute Cloud) в `Console Home - EC2 - Launch Instance`  позволяющий пользователю арендовать виртуальный сервер в разных `avlability zone` (`us-east-2c, us-east-2b, us-east-2a`) и не запускать*

![](./media/photo10.png)

+ *Создать `S3` и положить туда 3 разных html страницы Amazon Simple Storage Service (S3) — это сервис хранения данных, предлагаемый Amazon. Вы можете думать о S3 как о веб-платформе, предоставляемой Amazon, где вы можете хранить файлы и любые другие типы данных в облаке. По умолчанию при создании снять галочки с блокировки публичного доступа к нашему бакету*

![](./media/photo5.png)

![](./media/photo11.png)

```html
<html>
<p>Hello World!</p>
<p>Welcome to my website-1&nbsp;this is my first <strong>s3</strong> static hosted site-1.</p>
<p>&nbsp;</p>
</html>

<html>
<p>Hello World!</p>
<p>Welcome to my website-2&nbsp;this is my first <strong>s3</strong> static hosted site-2.</p>
<p>&nbsp;</p>
</html>

<html>
<p>Hello World!</p>
<p>Welcome to my website-3&nbsp;this is my first <strong>s3</strong> static hosted site-3.</p>
<p>&nbsp;</p>
</html>
```

+ *Написать скрипты `userdata` для каждой `EC2` которые будут вытягивать в `S3` нужный нам html файл и ложить его в директорию с которой работает сервер `Apache`, который нужно установить и запустить.*

```shell
#!/bin/bash
sudo su
yum update -y
yum install httpd -y
aws s3 cp s3://antoha.storage/index1.html /var/www/html/index.html
systemctl enable httpd
systemctl start httpd

#!/bin/bash
sudo su
yum update -y
yum install httpd -y
aws s3 cp s3://antoha.storage/index2.html /var/www/html/index.html
systemctl enable httpd
systemctl start httpd

#!/bin/bash
sudo su
yum update -y
yum install httpd -y
aws s3 cp s3://antoha.storage/index3.html /var/www/html/index.html
systemctl enable httpd
systemctl start httpd
```

*Так же, есть вариант с синхронизацией двух директорий на `S3` и `EC2`*


```shell
#!/bin/bash
sudo su
yum update -y
yum install httpd -y
chkconfig httpd on
cd /var/www/html
aws s3 sync s3://antoha.storage/какая-то папка /var/www/html
service httpd start
```

+ *Создать и отконфигурировать `Application Load Balancer` во вкладке `EC2 - Load Balancing` и перед этим поднять виртуалки с прописанной `userdata`. Load Balancer должен быть `Internet-facing` с доступом в интернет*

![](./media/photo12.png)

![](./media/photo13.png)



+ *Создать до определения портов на которые мы будем обращатся к `Load Balancer` - `target group`, то есть, на какой порт он будет форвардидб пакеты для `WebServers`, добавить их в группу.При настройке `LoadBalancer` как `listener` на порту 443 потребует создание сертификатов.*

![](./media/photo14.png)

![](./media/photo15.png)

+ *Указать в какие подсети каких `avilability zone` будет пересылаться трафик*

![](./media/photo16.png)


+ *Так же, нужно не забыть сделать `S3 Bucket` публичным добавить `Policy` в формате `JSON` и так же разрешаем запросы HTTP к корзине из браузера, добавляем `CORS`. ПО `Object URL` можно проверить как наша страничка отображается в браузере.*

![](./media/photo17.png)

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::antoha.storage/*"
        }
    ]
}
```
```json
[
    {
        "AllowedHeaders": [
            "Authorization",
            "Content-Length"
        ],
        "AllowedMethods": [
            "GET"
        ],
        "AllowedOrigins": [
            "*"
        ],
        "ExposeHeaders": [],
        "MaxAgeSeconds": 3000
    }
]
```

+ *После того как я понял что у меня без авторизации каждой машины с помощью креденшелов не запуститься команда `aws copy` пришла идея попробовать другой скрипт без авторизации, либо сделать `shapshot` c установленым `yum install -y awscli` и авторизированым под рут юзера `aws configure`*

``` bash
#!/bin/bash
sudo su
yum update -y
yum install httpd -y
systemctl enable httpd
systemctl start httpd
curl https://s3.us-east-2.amazonaws.com/antoha.storage/index1.html --output /var/www/html/index.html
```

*Обратить внимание, что snaphot делается с готового инстанса и сохраняется в образы `AMI`, а потом с `AMI from catalog` делаются мои виртуалки куда я прописываю `userdata`*

![](./media/photo18.png)

![](./media/photo19.png)

![](./media/photo20.png)


*Запуск с `userdata`*

![](./media/photo21.png)


+ ***Финальная проверка работоспособности `LoadBalancer`. `HealthCheck` в `target groups` пройден. При обращении на `LoadBalancer` выдает разные страницы.***


![](./media/photo22.png)


![](./media/photo23.png)

____

#### ***Полезные ссылки для меня:***

*1. https://docs.aws.amazon.com/cli/v1/userguide/install-linux-al2017.html*

*2. https://aws.amazon.com/ru/premiumsupport/knowledge-center/s3-locate-credentials-error/*

*3. https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-lamp-amazon-linux-2.html*

*4. https://bobbyhadz.com/blog/aws-s3-allow-public-read-access*

*5. https://www.youtube.com/watch?v=P_ae2pW-DpY*

*6. https://www.youtube.com/watch?v=dhRwKPrum44*

*7. https://docs.aws.amazon.com/AmazonS3/latest/userguide/HostingWebsiteOnS3Setup.html*

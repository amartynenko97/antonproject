# antonproject

![](https://img.shields.io/badge/GitHub%20Pages-222222?style=for-the-badge&logo=GitHub%20Pages&logoColor=white) ![](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white) ![](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white) ![](https://img.shields.io/badge/GIT-E44C30?style=for-the-badge&logo=git&logoColor=white) ![](https://img.shields.io/badge/VirtualBox-21416b?style=for-the-badge&logo=VirtualBox&logoColor=white) ![](https://img.shields.io/badge/Jenkins-D24939?style=for-the-badge&logo=Jenkins&logoColor=white) ![](https://img.shields.io/badge/Python-FFD43B?style=for-the-badge&logo=python&logoColor=blue}) ![](https://img.shields.io/badge/Visual_Studio_Code-0078D4?style=for-the-badge&logo=visual%20studio%20code&logoColor=white) ![](https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white) ![](https://img.shields.io/badge/Azure_DevOps-0078D7?style=for-the-badge&logo=azure-devops&logoColor=white) ![](https://img.shields.io/badge/Ansible-000000?style=for-the-badge&logo=ansible&logoColor=white) ![](https://img.shields.io/badge/Microsoft%20SQL%20Server-CC2927?style=for-the-badge&logo=microsoft%20sql%20server&logoColor=white) ![](https://img.shields.io/badge/Docker-2CA5E0?style=for-the-badge&logo=docker&logoColor=white) ![](https://img.shields.io/badge/Kibana-005571?style=for-the-badge&logo=Kibana&logoColor=white) ![](https://img.shields.io/badge/Elastic_Search-005571?style=for-the-badge&logo=elasticsearch&logoColor=white) ![](https://img.shields.io/badge/Debian-A81D33?style=for-the-badge&logo=debian&logoColor=white) ![](https://img.shields.io/badge/GNU%20Bash-4EAA25?style=for-the-badge&logo=GNU%20Bash&logoColor=white) ![](https://img.shields.io/badge/Amazon_AWS-FF9900?style=for-the-badge&logo=amazonaws&logoColor=white) ![](https://img.shields.io/badge/kubernetes-326ce5.svg?&style=for-the-badge&logo=kubernetes&logoColor=white)
___
## Git-flow
___
В ветке main хранится основная версия кода.
Для разработки новой функциональности создайте ветку с именем задачи.
Для внесения срочных изменений создайте ветку hotfix-{{current-version}}.

1. Создать пул реквест в ветку main с изменениями.
2. После подтверждения смерджить изменения в масте.
3. Билд и деплой запустится автоматически.


#### Команды:
+ Без использования расширений git-flow:

```shell
$ git checkout main
$ git checkout -b branch-name
```

+ При использовании расширений git-flow:

```shell
$ git flow hotfix start branch-name
```

+ По завершении работы с веткой ее сливают в main.

```shell
$ git checkout main
$ git merge branch-name
```
___

#### OR Use GitFlow - WorkFlow

1. First, for convenience, you can install the Git-flow extension $ git flow init
2. GitFlow is a set of Git commands that allows you to perform many operations on a repository with just one command.
3. Everything in the master branch is available for deployment and is stable.
4. To work on something new, create a fork from the master and give it a descriptive name (new_feature).
5. Also, you can create branches from an existing feature branch.
6. Make a local commit to this branch and regularly push your work to the branch of the same name on the server.
7. When you need feedback or help, or you think a branch is ready to be merged, open a pull request.
8. After someone else has reviewed and validated the feature, you can combine it with the master.
9. After merging and submitting to the master, your function is ready to be deployed.
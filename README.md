# antonproject

## Git-flow
В ветке main хранится основная версия кода.
Для разработки новой функциональности создайте ветку с именем задачи.
Для внесения срочных изменений создайте ветку hotfix-{{current-version}}.

1. Создать пул реквест в ветку main с изменениями.
2. После подтверждения смерджить изменения в масте.
3. Билд и деплой запустится автоматически.

## Команды:
###Без использования расширений git-flow:

git checkout main
git checkout -b branch-name

###При использовании расширений git-flow:

$ git flow hotfix start branch-name

По завершении работы с веткой ее сливают в main.

git checkout main
git merge branch-name

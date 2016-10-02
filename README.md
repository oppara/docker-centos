
```
vmの作成、起動と確認
% docker-machine ls
% docker-machine create -d virtualbox dev
% docker-machine ls 

環境変数設定と確認
% eval $(docker-machine env dev)
% env | grep DOCKER

コンテナの作成と起動と確認
% docker-compose up -d

コンテナの確認
% docker-compose ps

コンテナ確認
% docker ps -a

イメージ確認
% docker images

sshで接続
% ssh -l foo -p 2222 -i ./ssh/foo `docker-machine ip dev`
or 
% ssh -l foo -p 2222 -i ./ssh/foo -o 'StrictHostKeyChecking no' `docker-machine ip dev`

sshを使わず接続
% docker exec -it コンテナ名 bash
```

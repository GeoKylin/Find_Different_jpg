#!/usr/bin/env bash 
git init

git add .

git commit -m "2020/7/4"
git remote add origin git@github.com:GeoKylin/Find_Different_jpg.git

git pull --rebase origin master
git push -u origin master

@echo off
set repo=%1

git init 

git commit -m "first commit" 
git remote add origin %repo%
git pull --rebase origin master
git push -u origin master
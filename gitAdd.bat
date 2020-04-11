@echo off
set repo=%1

git init 

git commit -m "first commit" 
git remote add origin %repo%
git push -u origin master
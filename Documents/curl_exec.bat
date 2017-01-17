@echo off
cls

set requestType=%1
set params=%~2
set url=%3
set redirect=%4

set params=%params:""="%
set url=%url:#egal#==%

curl -X "%requestType%" %params% %url% > %redirect%
REM pause
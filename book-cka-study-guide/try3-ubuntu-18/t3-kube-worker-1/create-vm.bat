@echo off
setlocal enabledelayedexpansion
for %%f in (%CD%) do (set VM_NAME=%%~nf&echo set VM_NAME=%%~nf)
echo vagrant up... creating %VM_NAME%
vagrant up
echo vagrant ssh... ssh to %VM_NAME%
vagrant ssh
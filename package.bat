@echo off

set /p boxid=Enter VirtualBox name: 
pushd "%~dp0"
del package.box
vagrant package --base %boxid% --vagrantfile Vagrantfile_box
vagrant box add --name iiif-to-go-api package.box
popd
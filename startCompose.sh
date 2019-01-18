#!/usr/bin/env bash

. `pwd`/docker-config/config.sh
. common

copyDumpLocally() {
    docker-compose down

    #Download dump and run mysql container
    echo "Show available dump"
    ssh "$SSH_USERNAME"@"$REMOTE_HOST" sudo ls -l "$ASSETS_FOLDER/$1/$2"

    if [ ! $? -eq 0 ]; then
        echo "Failed attempt ssh connection for $SSH_USERNAME to $REMOTE_HOST"
        exit
    fi
    read -p "Choice sql file to init database: " sqlDump

    checkFileExist=true
    while $checkFileExist; do
        ssh "$SSH_USERNAME"@"$REMOTE_HOST" sudo cp "$ASSETS_FOLDER/$1/$2/$sqlDump /home/$SSH_USERNAME"

        if [ $? -eq 0 ]
        then
            if [ -e init-db ]
            then
                rm -rf init-db/*
            else
                mkdir init-db
            fi
            scp -r "$SSH_USERNAME"@"$REMOTE_HOST":"/home/$SSH_USERNAME/$sqlDump" init-db
            checkFileExist=false
        else
            read -p "Choice a valid sql file: " sqlDump
        fi
    done
}

echo -n "Please select docker folder in your projects to use Docker Compose. Now you are here: `pwd` "
read dockerFolder

cd dockerFolder

branchNameDashed="${2////_}"

read -p "Do you want start from a new database? " yn

checkNewDatabase=true
while $checkNewDatabase; do
    case $yn in
        [Yy] ) copyDumpLocally $1 $2 "$branchNameDashed"
               checkNewDatabase=false
               ;;
        [Nn] ) checkNewDatabase=false
               ;;
        * ) read -p "Please answer Yy or Nn " yn
            ;;
    esac
done

echo ""

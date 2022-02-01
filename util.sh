. "$(dirname $0)/colors.sh"

COMPOSE_ENV_PATH_FULL=""
COMPOSE_FILE_LIST=""
NUM_COMPOSE_ENVS=0
INDEX_COUNT=0

getComposeFilePath() {
    local _outval=$1
    local envName=$2
    local filePath=$COMPOSE_ENV_PATH_FULL/docker-compose.$envName.yml

    eval "$_outval=\$filePath"
}

checkComposeFile() {
    if [ ! -f $composeFile ]; then
        echo "Error: Compose file does not exist - $1"
        exit 50
    fi
}

composeOperation() {
    local envName=$1
    local operation=$2
    local composeFile

    if [ "up" = "$operation" ]; then
        operation="up -d"
    fi

    if [ "logs" = "$operation" ]; then
        operation="logs -f"
    fi

    getComposeFilePath composeFile $envName
    checkComposeFile $composeFile

    docker-compose -f $composeFile $operation
}

moveToComposeFilePath() {
    COMPOSE_ENV_PATH=${COMPOSE_ENV_PATH:-$(pwd)}
    COMPOSE_ENV_PATH_FULL="$(dirname $COMPOSE_ENV_PATH)/$(basename $COMPOSE_ENV_PATH)"
    COMPOSE_ENV_PATH_FULL=$(realpath $COMPOSE_ENV_PATH_FULL)
    cd $COMPOSE_ENV_PATH_FULL

    echo "${txtYellow}Searching: $COMPOSE_ENV_PATH_FULL${colorReset}\n"
}

getComposeFiles() {
    COMPOSE_FILE_LIST=`find $COMPOSE_ENV_PATH_FULL -maxdepth 1 -name "docker-compose*.yml" | sort`
    COMPOSE_FILE_LIST=`echo $COMPOSE_FILE_LIST | sed -e "s#$COMPOSE_ENV_PATH_FULL/docker-compose\.##g" | sed -e "s#\.yml##g" | sed -e "s# #\n#g"`
    NUM_COMPOSE_ENVS=`echo "$COMPOSE_FILE_LIST" | wc -l`

    if [ -z "$COMPOSE_FILE_LIST" ]; then
        errorAndExit "No Compose Environments Found!\nEnsure run this command where all your docker-compose.*.yml files reside, or set the COMPOSE_ENV_PATH Environment Variable to the path where they reside." 98
    fi
}

iterateEnvsForSingleOp() {
    operation=$1
    actionLabel=$2

    storeIFS

    for envName in $COMPOSE_FILE_LIST; do
        INDEX_COUNT=$((INDEX_COUNT+1))
        echo $INDEX_COUNT - $actionLabel $envName...

        restoreIFS
        composeOperation $envName $operation
        storeIFS

        if [ ! "$INDEX_COUNT" -eq "$NUM_COMPOSE_ENVS" ]; then
            echo =======================================================
        fi
    done

    restoreIFS
}

storeIFS() {
    # Store IFS for restoring later
    OLDIFS=$IFS
IFS='
'
}

restoreIFS() {
    # Restore IFS
    IFS=$OLDIFS
}

errorAndExit() {
    errMsg=$1
    exitCode=$2

    echo "${txtRed}$errMsg${colorReset}"
    exit $exitCode
}

# Force scripts to operate in COMPOSE_ENV_PATH_FULL
moveToComposeFilePath
# Gather Compose Filenames
getComposeFiles

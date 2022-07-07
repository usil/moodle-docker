workspaces_path=$(pwd)

function delete_image_if_exist {
  image=$(docker images "$1" -a -q)
  if [ ! "$image" == "" ]; then
    echo "deleting image: $image"
    docker rmi -f "$image"
  fi
}

for ARGUMENT in "$@"
do
   KEY=$(echo $ARGUMENT | cut -f1 -d=)
   KEY_LENGTH=${#KEY}
   VALUE="${ARGUMENT:$KEY_LENGTH+1}"
   export "$KEY"="$VALUE"
done

echo "#################"
echo "Updating source code"
echo "#################"

cd $workspaces_path
git fetch
latest_branch=$(git for-each-ref --sort=-committerdate | head -n 1 | awk -F '/' '{ print $NF }')
git checkout $latest_branch
git pull origin $latest_branch


echo "#################"
echo "Launching"
echo "#################"
cd $workspaces_path

if [ ! -f .env ]; then
  echo "" > .env
fi

if [ -s .env ]; then
  echo ".env is empty"
else
  export $(cat .env | xargs)
fi


# https://stackoverflow.com/a/50850881

if [ "$build" == "true" ]; then
  docker-compose down
  delete_image_if_exist "moodle-moodle"
  docker-compose up -d --build
else
  docker-compose down && docker-compose up -d
fi

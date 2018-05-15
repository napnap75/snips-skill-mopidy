#/usr/bin/env bash -e

VENV=venv

if [ ! -d "$VENV" ]
then

    PYTHON=`which python2`

    if [ ! -f $PYTHON ]
    then
        echo "could not find python"
    fi
    virtualenv -p $PYTHON $VENV

fi

. $VENV/bin/activate

pip install -r requirements.txt

# Installing mopidy and dependencies
wget -q -O - https://apt.mopidy.com/mopidy.gpg | sudo apt-key add -
sudo wget -q -O /etc/apt/sources.list.d/mopidy.list https://apt.mopidy.com/jessie.list
sudo apt-get update
sudo apt-get install mopidy -y
sudo apt-get install mopidy-spotify -y

# Writing configuration files for mopidy
sudo cp /etc/mopidy/mopidy.conf /etc/mopidy/mopidy.conf.backup
sudo python mopidy_configuration.py >> /etc/mopidy/mopidy.conf

# Enable mopidy as a service
sudo systemctl enable mopidy

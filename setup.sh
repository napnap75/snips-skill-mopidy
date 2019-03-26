#/usr/bin/env bash -e

if [ ! -e "./config.ini" ]
then
    cp config.ini.default config.ini
fi

VENV=venv

if [ ! -d "$VENV" ]
then

    PYTHON=`which python2`

    if [ ! -f $PYTHON ]
    then
        echo "could not find python"
    fi
    echo "Installing virtualenv ..."
    virtualenv -p $PYTHON $VENV > /dev/null

fi

. $VENV/bin/activate

echo "Installing python dependencies ..."
pip install -r requirements.txt > /dev/null

echo "Done installing python dependencies."

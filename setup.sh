#!/bin/sh

if ! which virtualenv > /dev/null ; then
    echo "Couldn't find virtualenv"
    exit 1
fi

if [ ! -f config.py ] ; then
    echo "Please copy config.py.dist to config.py and edit the settings accordingly (if appropriate)"
    exit 1
fi

echo "Configuring environment..."

[ ! -f env/bin/activate ] && virtualenv env
. env/bin/activate

pip install -qr requirements.txt

echo "Updating data..."
mkdir -p data tmp
env/bin/python -c "from dc_common import model; model.create_tables()" || exit 1

touch tmp/restart.txt

echo "Setup complete."


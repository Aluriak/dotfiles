# create and load the venv
virtualenv venv -p /usr/bin/python3
source venv/bin/activate

# populate it
if [ -f requirements.txt ]
then
    pip install -r requirements.txt
elif [ -f setup.cfg ]
then
    python -c "import configparser; c = configparser.ConfigParser(); c.read('setup.cfg'); print(c['options']['install_requires'])" | xargs pip install -U
fi

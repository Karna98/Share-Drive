#bin/bash
echo "Try Running in virtual enviroment"
read -p "Do you still want to continue ? [y|N] " -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi
echo "<------------>"
echo "Installing Requirements"
pip install -r requirements.txt
echo "Requirements Installation Completed"
echo "<------------>"
echo "Setting Up Database"
./setupDB.sh
echo "Database Setup Completed"
echo "<------------>"
echo "Exporting 'app' to FLASK_APP"
export FLASK_APP='app'
echo "<------------>"
echo "Setting FLASK_DEBUG"
export FLASK_DEBUG=1
echo "<------------>"
echo "Running FLASK .."
flask run
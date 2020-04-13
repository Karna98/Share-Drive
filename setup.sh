#bin/bash

echo "<------------>"
echo "Setup Virtual Environment and then continue setup (Recommended)"
echo "<------------>"
echo
echo "<------------>"
echo "Select method to run Share Drive :"
echo "1) Normal run (without Docker)"
echo "2) Docker Run (with Docker)"
read -p " Option [Press 1 or 2 and Enter ]:  " option
echo "<------------>"
echo

if [ $option == '1' ]
then 
    echo "<------------>"
    echo "Checking and Installing Requirements"
    echo "<------------>"
    echo
    pip install -r requirements.txt
    echo
    echo "<------------>"
    echo "Requirements Checking and Installation Completed"
    echo "<------------>"
    echo
    echo "<------------>"
    echo "Starting Share Drive (without Docker) ..."
    echo "<------------>"
    echo
    python3 app.py
else 
    if [[ "$(docker images -q share-drive 2> /dev/null)" == "" ]]; 
    then
        echo "<------------>"
        echo "Creating Docker container 'share-drive' ..."
        echo "<------------>"
        echo
        sudo docker build -t share-drive:latest .
        echo
        echo "<------------>"
        echo "Created Docker container 'share-drive' sucessfully"
        echo "<------------>"
        echo
    fi
    echo "<------------>"
    echo "Starting Share Drive (with Docker)..."
    echo "<------------>"
    sudo docker run -d -p 8080:8080 share-drive
    echo
    
    echo "<------------>"
    echo "Share Drive Running ..."
    echo
    echo 'Visit http://127.0.0.1:5001'
    echo "<------------>"
    echo 

    echo "<------------>"
    echo "Press '1' to stop docker (share-drive)"
    read -p " Stop Share Drive ? [Press 1 and Enter] " choice
    echo "<------------>"
    
    if [ $choice == '1' ]
    then
        echo
        echo "<------------>"
        echo "Stopping Share Drive ."
        echo "<------------>"
        sudo docker stop $(docker ps -q --filter ancestor=share-drive )
    fi
fi

echo
echo
echo "<------------>"
echo "Successfully Stopped Share Drive . BYE !!"
echo "<------------>"
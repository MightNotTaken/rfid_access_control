#! /bin/sh
#! /usr/bin/python3
sudo chmod 777 *;
sudo rm -r /accesscontrol;
echo "removed previous installations";


sudo mkdir /accesscontrol;
echo "/accesscontrol directory created";
sudo cp -r ./backend /accesscontrol/backend;
echo "backend copied to /accesscontrol/backend";
sudo cp -r ./frontend /accesscontrol/frontend;
echo "frontend copied to /accesscontrol/frontend"


sudo cp -r ./backend.sh /usr/local/bin/backend.sh;
echo "copied backend.sh file in /usr/local/bin";
sudo cp -r ./backend.service /etc/systemd/system/backend.service;
echo "created backend.service";
sudo chmod +x /usr/local/bin/backend.sh;

sudo cp -r ./rfidentrance.sh /usr/local/bin/rfidentrance.sh;
echo "copied rfidentrance.sh file in /usr/local/bin";
sudo cp -r ./rfidentrance.service /etc/systemd/system/rfidentrance.service;
echo "created rfidentrance.service";
sudo chmod +x /usr/local/bin/rfidentrance.sh;

sudo cp -r ./rfidexit.sh /usr/local/bin/rfidexit.sh;
echo "copied rfidexit.sh file in /usr/local/bin";
sudo cp -r ./rfidexit.service /etc/systemd/system/rfidexit.service;
echo "created rfidexit.service";
sudo chmod +x /usr/local/bin/rfidexit.sh;

sudo cp -r ./rfidauth.sh /usr/local/bin/rfidauth.sh;
echo "copied rfidauth.sh file in /usr/local/bin";
sudo cp -r ./rfidauth.service /etc/systemd/system/rfidauth.service;
echo "created rfidauth.service";
sudo chmod +x /usr/local/bin/rfidauth.sh;

sudo cp -r ./frontend.sh /usr/local/bin/frontend.sh;
echo "copied frontend.sh file in /usr/local/bin";
sudo cp -r ./frontend.service /etc/systemd/system/frontend.service;
echo "created frontend.service";
sudo chmod +x /usr/local/bin/frontend.sh;

sudo systemctl daemon-reload;
echo "systemctl daemon reloaded";

sudo systemctl enable backend.service;
echo "backend service enabled";
sudo systemctl stop backend.service;
sudo systemctl start backend.service;
echo "backend service started";

sudo systemctl enable rfidentrance.service;
echo "rfidentrance service enabled";
sudo systemctl stop rfidentrance.service;
sudo systemctl start rfidentrance.service;
echo "rfidentrance service started";

sudo systemctl enable rfidexit.service;
echo "rfidexit service enabled";
sudo systemctl stop rfidexit.service;
sudo systemctl start rfidexit.service;
echo "rfidexit service started";


sudo systemctl enable frontend.service;
echo "frontend service enabled";
sudo systemctl stop frontend.service;
sudo systemctl start frontend.service;
echo "frontend service started";

sudo systemctl enable rfidauth.service;
echo "rfidauth service enabled";
sudo systemctl stop rfidauth.service;


echo "installation completed";

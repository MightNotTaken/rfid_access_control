#! /bin/sh
sudo chmod 777 *;
sudo rm -r /accesscontrol;
echo "removed previous installations";
sudo mkdir /accesscontrol;
echo "/accesscontrol directory created";
sudo cp -r ./backend /accesscontrol/backend;
echo "backend copied to /accesscontrol/backend";
sudo cp -r ./frontend /accesscontrol/frontend;
echo "frontend copied to /accesscontrol/frontend"

sudo gcc /accesscontrol/backend/dummy.c -o rfid_reader.o

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
sudo systemctl daemon-reload;
echo "systemctl daemon reloaded";
sudo systemctl enable backend.service;
echo "backend service enabled";
sudo systemctl start backend.service;
echo "backend service started";
sudo systemctl enable rfidentrance.service;
echo "rfidentrance service enabled";
sudo systemctl start rfidentrance.service;
echo "rfidentrance service started";
sudo systemctl enable rfidexit.service;
echo "rfidexit service enabled";
sudo systemctl start rfidexit.service;
echo "rfidexit service started";
echo "installation completed";

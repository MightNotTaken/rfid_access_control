#! /bin/sh
sudo chmod 777 *;
sleep 1;
sudo rm -r /accesscontrol;
echo "removed previous installations";
sudo mkdir /accesscontrol;
echo "/accesscontrol directory created";
sleep 1;
sudo cp -r ./backend /accesscontrol/backend;
echo "backend copied to /accesscontrol/backend";
sleep 1;
sudo cp -r ./frontend /accesscontrol/frontend;
echo "frontend copied to /accesscontrol/frontend"
sleep 1;

sudo cp -r ./backend.sh /usr/local/bin/backend.sh;
echo "copied backend.sh file in /usr/local/bin";
sudo cp -r ./backend.service /etc/systemd/system/backend.service;
echo "created backend.service";
sudo chmod +x /usr/local/bin/backend.sh;
sleep 1;
sudo cp -r ./rfidentrance.sh /usr/local/bin/rfidentrance.sh;
echo "copied rfidentrance.sh file in /usr/local/bin";
sudo cp -r ./rfidentrance.service /etc/systemd/system/rfidentrance.service;
echo "created rfidentrance.service";
sudo chmod +x /usr/local/bin/rfidentrance.sh;
sleep 1;
sudo cp -r ./rfidexit.sh /usr/local/bin/rfidexit.sh;
echo "copied rfidexit.sh file in /usr/local/bin";
sudo cp -r ./rfidexit.service /etc/systemd/system/rfidexit.service;
echo "created rfidexit.service";
sudo chmod +x /usr/local/bin/rfidexit.sh;
sleep 1;
sudo systemctl daemon-reload;
echo "systemctl daemon reloaded";
sleep 1;
sudo systemctl enable backend.service;
sleep 1;
sudo systemctl start rfidentrance.service;
sleep 1;
sudo systemctl start rfidexit.service;
sleep 1;
echo "services initialized"

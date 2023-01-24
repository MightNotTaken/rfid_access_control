#! /bin/sh

sudo mkdir /accesscontrol
sudo cp ./backend /accesscontrol/backend
sudo cp ./frontend /accesscontrol/frontend
sudo cp ./backend.service /usr/local/bin/backend.sh
sudo systemctl daemon-reload
sudo systemctl enable backend.service
sudo systemctl start backend.service

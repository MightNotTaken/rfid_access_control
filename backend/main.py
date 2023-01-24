from flask import Flask
import threading
from util import make_directories, check_for_rfid_changes, path, countof
import subprocess
import os

app = Flask(__name__)

@app.route("/count", methods=["GET"])
def get_count():
    
    return {"count": countof('inside')}, 200


def run_server():
    app.run(port=3030)

def listen_to_entrance_gate():
    subprocess.run([path('d.exe'), '15', '16', 'entrance'])

def listen_to_exit_gate():
    subprocess.run([path('d.exe'), '0', '1', 'exitgate'])

if __name__ == '__main__':
    make_directories(['entrance', 'exitgate', 'authorized', 'inside'])

    # entrance_thread = threading.Thread(target=listen_to_entrance_gate)
    # entrance_thread.start()

    # exit_thread = threading.Thread(target=listen_to_exit_gate)
    # exit_thread.start()

    server_thread = threading.Thread(target=run_server)
    server_thread.start()

    counter_thread = threading.Thread(target=check_for_rfid_changes)
    counter_thread.start()



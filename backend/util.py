import os
from time import sleep

def path(x):
    return os.path.join(os.path.dirname(__file__), x)

def get_authorized_users():
    authorized = path('authorized')
    if not os.path.exists(authorized):
        os.mkdir(authorized)
    return os.listdir(authorized)

def welcom(person):
    with open(os.path.join(path('inside'), person), 'w') as person_file:
        person_file.close()
    print('welcom', person)


def check_for_rfid_changes():
    while True:
        entrance_gate = path('entrance')
        exit_gate = path('exitgate')
        inside = path('inside')
        person_at_entrance = os.listdir(entrance_gate)
        if person_at_entrance:
            authorized_users = get_authorized_users()         
            for person in person_at_entrance:
                if authorized_users and authorized_users.count(person):
                    welcom(person)
                os.unlink(os.path.join(entrance_gate, person))

        person_at_exit = os.listdir(exit_gate)
        if person_at_exit:
            for person in person_at_exit:
                os.unlink(os.path.join(inside, person))
                os.unlink(os.path.join(exit_gate, person))
                

def countof(type):
    return len(os.listdir(path(type)))

        
def make_directories(dirlist):
    for dir in dirlist:
        try:
            os.mkdir(path(dir))
        except Exception as e:
            pass

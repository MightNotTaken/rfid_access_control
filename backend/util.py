import os
from time import sleep
from hardware import indicator_01, indicator_02, indicator_03, switch_01, switch_02

INDICATION_TIMING = 2000


def path(x):
    return os.path.join('/accesscontrol/backend', x)

def get_authorized_users():
    authorized = path('authorized')
    if not os.path.exists(authorized):
        os.mkdir(authorized)
    return os.listdir(authorized)

def welcom(person):
    with open(os.path.join(path('inside'), person), 'w') as person_file:
        person_file.close()
    indicator_01.glow(INDICATION_TIMING)

def update_indicators():
    indicator_01.update()
    indicator_02.update()
    indicator_03.update()


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
                try:
                    os.unlink(os.path.join(entrance_gate, person))
                except:
                    pass
        
        person_at_exit = os.listdir(exit_gate)
        if person_at_exit:
            for person in person_at_exit:
                indicator_02.glow(INDICATION_TIMING)
                try:
                    os.unlink(os.path.join(inside, person))
                except:
                    pass

                try:
                    os.unlink(os.path.join(exit_gate, person))
                except:
                    pass
        
        person_inside = os.listdir(inside)
        if person_inside:
            indicator_03.glow()
        else:
            indicator_03.turn_off()
        
        update_indicators()
        if switch_01.pressed():
            indicator_01.glow(INDICATION_TIMING)
        if switch_02.pressed():
            indicator_02.glow(INDICATION_TIMING)
        

def countof(type):
    return len(os.listdir(path(type)))

        
def make_directories(dirlist):
    for dir in dirlist:
        try:
            os.mkdir(path(dir))
        except Exception as e:
            pass

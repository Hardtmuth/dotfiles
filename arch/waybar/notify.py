import subprocess

def notify(title, message):
    try:
        subprocess.run(["notify-send", title, message])
    except:
        pass


notify('123', 'sdfsd')
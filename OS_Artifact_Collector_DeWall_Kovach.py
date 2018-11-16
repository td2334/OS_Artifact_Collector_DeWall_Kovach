from tkinter import *
from tkinter import messagebox
from tkinter import scrolledtext
from paramiko import *
from pypsrp.client import Client
from io import StringIO
from os import system
from os import remove
import subprocess
import sys


def text_window(text):
    width, height = 100, 50
    scroll_window = scrolledtext.ScrolledText(width=width, height=height, wrap='word')
    scroll_window.insert(1.0, text)
    scroll_window.pack(side=LEFT)
    mainloop()


def multiprompt(flag):
    file = open('temp', 'r+')
    if flag == 1:  # linux
        temp = ''
        list = []
        for line in file:
            if ">>>" in line:
                list.append(temp)
                temp = ''
            else:
                temp += line
        date_time = list[0]
        os = list[1]
        hardware = list[2]
        user_info = list[3]
        services = list[4]
        scheduled_tasks = list[5]
        network = list[6]
        # installed_software = list[7]
        processes = list[7]
        drivers = list[8]
        downloads_documents = list[9]
        more_os = list[10]

    else:  # windows
        num_new = 0
        temp = ''
        list = []
        for line in file:
            line.replace('=', '')
            if line == '\n':
                num_new += 1
                if num_new == 8:
                    list.append(temp)
                    num_new = 0
                    temp = ''
            else:
                num_new = 0
                if "=" not in line:
                    temp += line
        file.close()
        remove('temp')
        date_time = list[0]
        os = list[1]
        cpu_info = list[2]
        ram = list[3]
        hdd = list[4]
        hostname_domain = list[5]
        user_info = list[6]
        boot1 = list[7]
        boot2 = list[8]
        mac_table = list[9]
        mac_interfaces = list[10]
        routing_table = list[11]
        ip_addresses = list[12]
        dhcp_server = list[13]
        dns_servers = list[14]
        gateway = list[15]
        listening_services = list[16]
        connections = list[17]
        dns_cache = list[18]
        smb_share = list[19]
        smb_printers = list[20]
        wireless_profiles = list[21]
        # software = list[22]
        processes = list[22]
        drivers = list[23]



def runssh(fields):
    ssh = SSHClient()
    ssh.set_missing_host_key_policy(AutoAddPolicy())
    ssh.connect(fields[0].get(), username=fields[1].get(), password=fields[2].get())
    f = open('forensics_bash_script_one', 'r')
    f2 = open('temp', 'a+')
    for line in f:
        if line[0] != '#':
            (stdin, stdout, stderr) = ssh.exec_command('$echo ' + fields[2].get() + ' | sudo -S ' + line)
            for line2 in stdout.readlines():
                f2.write(line2)
    ssh.close()
    f.close()
    f2.close()
    multiprompt(1)


def linux():
    remote_result = messagebox.askquestion("Remote", "Are you connecting remotely?")
    if remote_result == 'yes':
            remote_input = Tk()
            Label(remote_input, text="IP/FQDN").grid(row=0)
            Label(remote_input, text="Username").grid(row=1)
            Label(remote_input, text="Password").grid(row=2)

            e1 = Entry(remote_input)
            e2 = Entry(remote_input)
            e3 = Entry(remote_input)

            e1.grid(row=0, column=1)
            e2.grid(row=1, column=1)
            e3.grid(row=2, column=1)

            fields = [e1, e2, e3]

            b1 = Button(remote_input, text="Continue", command=lambda: runssh(fields))
            b1.grid(row=3)
            mainloop()

            return
    else:
        p = subprocess.Popen(["sudo", "./forensics_bash_script_one"], stdout=subprocess.PIPE)
        f = open('temp', 'a+')
        for line in p.stdout:
            line = line.decode()
            f.write(line)
        f.close()
        multiprompt(1)
        return


def runpypsrp(fields):
    client = Client(fields[0].get(), username=fields[1].get(), password=fields[2].get())
    temp = ''
    temp, streams, had_errors = client.execute_ps("GetWindowsArtifacts.ps1")
    f = open('temp', 'a+')
    f.write(temp)
    f.close()
    multiprompt(0)


def windows():
    remote_result = messagebox.askquestion("Remote", "Are you connecting remotely?")
    if remote_result == 'yes':
        remote_input = Tk()
        Label(remote_input, text="IP/FQDN").grid(row=0)
        Label(remote_input, text="Username").grid(row=1)
        Label(remote_input, text="Password").grid(row=2)

        e1 = Entry(remote_input)
        e2 = Entry(remote_input)
        e3 = Entry(remote_input)

        e1.grid(row=0, column=1)
        e2.grid(row=1, column=1)
        e3.grid(row=2, column=1)

        fields = [e1, e2, e3]

        b1 = Button(remote_input, text="Continue", command=lambda: runpypsrp(fields))
        b1.grid(row=3)
        mainloop()
        return
    else:
        output = open('temp', 'a+')
        p = subprocess.Popen(["powershell.exe", "-File", "GetWindowsArtifacts.ps1"], stdout=subprocess.PIPE)
        for line in p.stdout:
            line = line.decode().replace("b'", '')
            line = line.replace("\r\n'", '')
            output.write(line)
        output.close()
        multiprompt(0)
        return


master = Tk()

osPrompt = Text(master, height=1, width=20)
osPrompt.insert(END, "What is the host OS?")
osPrompt.grid(row=0, columnspan=2, padx=10, pady=10)

linuxButton = Button(master, text="Linux", command=linux)
linuxButton.grid(row=1, column=0, padx=5, pady=5)

windowsButton = Button(master, text="Windows", command=windows)
windowsButton.grid(row=1, column=1, padx=5, pady=5)

master.mainloop()

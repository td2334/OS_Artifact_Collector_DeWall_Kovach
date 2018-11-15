from tkinter import *
from tkinter import messagebox
from paramiko import *
from pypsrp.client import Client
from os import system
import subprocess
import sys


def runssh(fields):
    ssh = SSHClient()
    ssh.set_missing_host_key_policy(AutoAddPolicy())
    ssh.connect(fields[0].get(), username=fields[1].get(), password=fields[2].get())
    f = open('forensics_bash_script_one', 'r')
    output = []
    for line in f:
        if line[0] != '#':
            (stdin, stdout, stderr) = ssh.exec_command('$echo ' + fields[2].get() + ' | sudo -S ' + line)
            for line2 in stdout.readlines():
                output.append(line2)
    ssh.close()
    f.close()
    for x in output:
        print(x)


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
        bash_command = "sudo ./forensics_bash_script_one"
        output = system(bash_command)
        return


def runpypsrp(fields):
    client = Client(fields[0].get(), username=fields[1].get(), password=fields[2].get())
    temp = ''
    temp, streams, had_errors = client.execute_ps("GetWindowsArtifacts.ps1")
    print(temp)


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
        p = subprocess.Popen(["powershell.exe", "-File", "GetWindowsArtifacts.ps1"], stdout=sys.stdout)
        output = p.communicate()
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

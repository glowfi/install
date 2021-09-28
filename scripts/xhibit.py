#!/usr/bin/python

# Module Imports
from tcolorpy import tcolor
import subprocess
import platform
import os
import re

# INFO
info = ["" for _ in range(8)]

# OSNAME
os_name = subprocess.check_output(["cat", "/etc/os-release"]).decode("utf-8")
os_name = os_name.split("\n")[0]
matches = re.findall(r"\"(.+?)\"", os_name)
os_name = "".join(matches)
info[0] = os_name

# KERNEL
kernel = platform.release()
info[1] = kernel

# TOTAL PACKAGES
packages = subprocess.Popen(
    "pacman -Q | wc -l",
    shell=True,
    stdin=subprocess.PIPE,
    stdout=subprocess.PIPE,
    stderr=subprocess.PIPE,
)
packages = int(packages.stdout.readlines(-1)[0])
info[2] = str(packages)

# DEFAULT USER SHELL
shell = os.environ.get("SHELL").split("/")[2]
info[3] = shell

# DESKTOP ENVIRONMENT
de_wm = os.environ.get("XDG_CURRENT_DESKTOP")
info[4] = de_wm

# UPTIME
uptime = float(
    subprocess.check_output(["cat", "/proc/uptime"]).decode("utf-8").split()[0]
)


def time_format(seconds: int):
    if seconds is not None:
        seconds = int(seconds)
        d = seconds // (3600 * 24)
        h = seconds // 3600 % 24
        m = seconds % 3600 // 60
        s = seconds % 3600 % 60
        if d > 0:
            return "{:02d}D {:02d}h {:02d}m {:02d}s".format(d, h, m, s)
        elif h > 0:
            return "{:02d}h {:02d}m {:02d}s".format(h, m, s)
        elif m > 0:
            return "{:02d}m {:02d}s".format(m, s)
        elif s > 0:
            return "{:02d}s".format(s)
    return "-"


uptime = time_format(uptime)
info[5] = uptime

# CPU GPU
cpu_gpu = (
    subprocess.check_output(["cat", "/proc/cpuinfo"])
    .decode("utf-8")
    .split("\n")[4]
    .split(":")[1]
    .lstrip()
    .split(" ")
)
cpu = " ".join(cpu_gpu[0:2])
gpu = " ".join(cpu_gpu[6:])
info[6] = cpu
info[7] = gpu

# Field colors
field_colors = [
    "#fb4934",
    "#b8bb26",
    "#fabd2f",
    "#83a598",
    "#d3869b",
    "#8ec07c",
    "#fe8019",
    "#d79921",
]

print("")
print(tcolor(f"           /           /                     ",color=field_colors[0],styles=["bold"]))
print(tcolor(f"          /' .,,,,  ./                       ",color=field_colors[1],styles=["bold"]))
print(tcolor(f"         /';'     ,/         | {info[0]}     ",color=field_colors[0],styles=["bold"]))
print(tcolor(f"        / /   ,,//,`'`       | {info[1]}     ",color=field_colors[1],styles=["bold"]))
print(tcolor(f"       ( ,, '_,  ,,,' ``     | {info[2]}     ",color=field_colors[2],styles=["bold"]))
print(tcolor(f"       |    /@  ,,, ;'' `    | {info[3]}     ",color=field_colors[3],styles=["bold"]))
print(tcolor(f"      /    .   ,''/' `,``    | {info[4]}     ",color=field_colors[4],styles=["bold"]))
print(tcolor(f"     /   .     ./, `,, ` ;   | {info[5]}     ",color=field_colors[5],styles=["bold"]))
print(tcolor(f"  ,./  .   ,-,',` ,,/''\,'   | {info[6]}     ",color=field_colors[6],styles=["bold"]))
print(tcolor(f" |   /; ./,,'`,,'' |   |     | {info[7]}     ",color=field_colors[7],styles=["bold"]))
print(tcolor(f" |     /   ','    /    |                     ",color=field_colors[7],styles=["bold"]))
print(tcolor(f"  \___/'   '     |     |                     ",color=field_colors[6],styles=["bold"]))
print(tcolor(f"    `,,'  |      /     `\                    ",color=field_colors[0],styles=["bold"]))
print(tcolor(f"         /      |        \                   ",color=field_colors[1],styles=["bold"]))
print("")

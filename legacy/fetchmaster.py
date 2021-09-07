#!/usr/bin/python

# Module Imports
from tcolorpy import tcolor
import random
import subprocess
import platform
import os
import re

# INFO
info = [None for _ in range(8)]

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

# Elements to fill
elems = ("─") * 32
elems1 = [" "] * 33

s = ""
for i in elems:
    s += i

# Spacing and start value
spc = 5
start = 2

# Getting value of max lenght string
max = max(info, key=len)
max_ind = info.index(max)
name_ = ["OS", "KERNEL", "PACKAGES", "SHELL", "DE/WM", "UPTIME", "CPU", "GPU"]
set_index = start + len(name_[max_ind]) + spc


# Function to print the information in colors
def get(name, value, name_color):
    k = ""
    value_color = "#d5c4a1"
    for ind, val in enumerate(elems1):
        if ind < start:
            k += val
        if ind == start:
            k += tcolor(name, color=name_color, styles=["bold"])
        if ind > start + len(name) and ind < set_index:
            k += val
        if ind == set_index:
            k += tcolor(value, color=value_color, styles=["bold"])
        if ind >= set_index + len(value):
            k += val
    return k


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

# Character and border colors
use_color = random.choice(field_colors)

# Right border color
exp = tcolor(f"│", color=use_color, styles=["bold"])

# Info and border list
ls = [
    tcolor(f"╭{s}╮", color=use_color, styles=["bold"]),
    tcolor(
        f"{exp}{get(name_[0],info[0],field_colors[0])}{exp}",
        color="#ee1177",
        styles=["bold"],
    ),
    tcolor(
        f"{exp}{get(name_[1],info[1],field_colors[1])}{exp}",
        color="#ee1177",
        styles=["bold"],
    ),
    tcolor(
        f"{exp}{get(name_[2],info[2],field_colors[2])}{exp}",
        color="#ee1177",
        styles=["bold"],
    ),
    tcolor(
        f"{exp}{get(name_[3],info[3],field_colors[3])}{exp}",
        color="#ee1177",
        styles=["bold"],
    ),
    tcolor(
        f"{exp}{get(name_[4],info[4],field_colors[4])}{exp}",
        color="#ee1177",
        styles=["bold"],
    ),
    tcolor(
        f"{exp}{get(name_[5],info[5],field_colors[5])}{exp}",
        color="#ee1177",
        styles=["bold"],
    ),
    tcolor(
        f"{exp}{get(name_[6],info[6],field_colors[6])}{exp}",
        color="#ee1177",
        styles=["bold"],
    ),
    tcolor(
        f"{exp}{get(name_[7],info[7],field_colors[7])}{exp}",
        color="#ee1177",
        styles=["bold"],
    ),
    tcolor(f"╰{s}╯", color=use_color, styles=["bold"]),
]


# Character function


def wally(use_color=use_color):
    print(tcolor(f"                  {ls[0]}", color=use_color, styles=["bold"]))
    print(tcolor(f"     .-'''-.      {ls[1]}", color=use_color, styles=["bold"]))
    print(tcolor(f"    |       |     {ls[2]}", color=use_color, styles=["bold"]))
    print(tcolor(f"   ⪜|---_---|⪛   ╭{ls[3]}", color=use_color, styles=["bold"]))
    print(tcolor(f"   Ͼ|__(_)__|Ͽ   │{ls[4]}", color=use_color, styles=["bold"]))
    print(tcolor(f"    |   _   |    │{ls[5]}", color=use_color, styles=["bold"]))
    print(tcolor(f"    |       |    ╯{ls[6]}", color=use_color, styles=["bold"]))
    print(tcolor(f"   ˏ====○====ˎ    {ls[7]}", color=use_color, styles=["bold"]))
    print(tcolor(f"       / \        {ls[8]}", color=use_color, styles=["bold"]))
    print(tcolor(f"                  {ls[9]}", color=use_color, styles=["bold"]))


def dogbert(use_color=use_color):
    print(tcolor(f"                 {ls[0]}", color=use_color, styles=["bold"]))
    print(tcolor(f"                 {ls[1]}", color=use_color, styles=["bold"]))
    print(tcolor(f"    .-----.      {ls[2]}", color=use_color, styles=["bold"]))
    print(tcolor(f"  .`       `.   ╭{ls[3]}", color=use_color, styles=["bold"]))
    print(tcolor(f" / /-() ()-\ \  │{ls[4]}", color=use_color, styles=["bold"]))
    print(tcolor(f" \_|   ○   |_/  │{ls[5]}", color=use_color, styles=["bold"]))
    print(tcolor(f"  '.       .'   ╯{ls[6]}", color=use_color, styles=["bold"]))
    print(tcolor(f"    `-._.-'      {ls[7]}", color=use_color, styles=["bold"]))
    print(tcolor(f"                 {ls[8]}", color=use_color, styles=["bold"]))
    print(tcolor(f"                 {ls[9]}", color=use_color, styles=["bold"]))


def alice(use_color=use_color):
    print(tcolor(f"           ..-..             {ls[0]}", color=use_color, styles=["bold"]))
    print(tcolor(f"         (~     ~)           {ls[1]}", color=use_color, styles=["bold"]))
    print(tcolor(f"       (           )         {ls[2]}", color=use_color, styles=["bold"]))
    print(tcolor(f"     (    ~~~~~~~    )      ╭{ls[3]}", color=use_color, styles=["bold"]))
    print(tcolor(f"   (     |  . .  |     )    │{ls[4]}", color=use_color, styles=["bold"]))
    print(tcolor(f"  (      |  (_)  |      )   │{ls[5]}", color=use_color, styles=["bold"]))
    print(tcolor(f" (       |       |       )  ╯{ls[6]}", color=use_color, styles=["bold"]))
    print(tcolor(f"   (.,.,.|  ===  |.,.,.)     {ls[7]}", color=use_color, styles=["bold"]))
    print(tcolor(f"          '.___.'            {ls[8]}", color=use_color, styles=["bold"]))
    print(tcolor(f"           /   \             {ls[9]}", color=use_color, styles=["bold"]))



def pointy_haired_boss(use_color=use_color):
    print(tcolor(f"    @         @      {ls[0]}", color=use_color, styles=["bold"]))
    print(tcolor(f"   @@  ..-..  @@     {ls[1]}", color=use_color, styles=["bold"]))
    print(tcolor(f"   @@@' _ _ '@@@     {ls[2]}", color=use_color, styles=["bold"]))
    print(tcolor(f"    @(  . .  )@     ╭{ls[3]}", color=use_color, styles=["bold"]))
    print(tcolor(f"     |  (_)  |      │{ls[4]}", color=use_color, styles=["bold"]))
    print(tcolor(f"     |   _   |      │{ls[5]}", color=use_color, styles=["bold"]))
    print(tcolor(f"     |_     _|      ╯{ls[6]}", color=use_color, styles=["bold"]))
    print(tcolor(f"    /|_'---'_|\      {ls[7]}", color=use_color, styles=["bold"]))
    print(tcolor(f"   / | '\_/' | \     {ls[8]}", color=use_color, styles=["bold"]))
    print(tcolor(f"  /  |  | |  |  \    {ls[9]}", color=use_color, styles=["bold"]))


def asok(use_color=use_color):
    print(tcolor(f"                 {ls[0]}", color=use_color, styles=["bold"]))
    print(tcolor(f"    @@@@@@@@@    {ls[1]}", color=use_color, styles=["bold"]))
    print(tcolor(f"    |       |    {ls[2]}", color=use_color, styles=["bold"]))
    print(tcolor(f"    | _   _ |   ╭{ls[3]}", color=use_color, styles=["bold"]))
    print(tcolor(f"   Ͼ| ○   ○ |Ͽ  │{ls[4]}", color=use_color, styles=["bold"]))
    print(tcolor(f"    |   u   |   │{ls[5]}", color=use_color, styles=["bold"]))
    print(tcolor(f"    |  ---  |   ╯{ls[6]}", color=use_color, styles=["bold"]))
    print(tcolor(f"   / `-._.-´ \   {ls[7]}", color=use_color, styles=["bold"]))
    print(tcolor(f"        |        {ls[8]}", color=use_color, styles=["bold"]))
    print(tcolor(f"                 {ls[9]}", color=use_color, styles=["bold"]))


def curt(use_color=use_color):
    print(tcolor(f"               {ls[0]}", color=use_color, styles=["bold"]))
    print(tcolor(f"    დოოოოოდ    {ls[1]}", color=use_color, styles=["bold"]))
    print(tcolor(f"    |     |    {ls[2]}", color=use_color, styles=["bold"]))
    print(tcolor(f"    |     |   ╭{ls[3]}", color=use_color, styles=["bold"]))
    print(tcolor(f"    |-Ο Ο-|   │{ls[4]}", color=use_color, styles=["bold"]))
    print(tcolor(f"   Ͼ   ∪   Ͽ  │{ls[5]}", color=use_color, styles=["bold"]))
    print(tcolor(f"    |     |   ╯{ls[6]}", color=use_color, styles=["bold"]))
    print(tcolor(f"   ˏ`-.ŏ.-´ˎ   {ls[7]}", color=use_color, styles=["bold"]))
    print(tcolor(f"       @       {ls[8]}", color=use_color, styles=["bold"]))
    print(tcolor(f"        @      {ls[9]}", color=use_color, styles=["bold"]))


characters_names = ["wally", "dogbert", "alice", "pointy_haired_boss", "asok", "curt"]
charac = random.choice(characters_names)

eval(charac + "()")

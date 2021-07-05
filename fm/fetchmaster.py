# Module Imports
from tcolorpy import tcolor
import subprocess
import os
import random

# Getting Info from bash script

# Location of bash script
path = "~/.local/bin/fm/fetchmaster.sh"
path = os.path.expanduser(path)

# Getting info
info = str(subprocess.run([path], capture_output=True, shell=True).stdout)[2:]
info = info.split("\\n")
info = info[:len(info) - 1]

os_name = info[0]
os_name = os_name[6:len(os_name) - 1]
info[0] = os_name

def_sh = info[3]
def_sh = def_sh[5:]
info[3] = def_sh

up_time = info[5]
up_time = tuple(up_time.split(" "))
info[5] = up_time

# Processing info
for ind, val in enumerate(info):
    if ind == len(info) - 3:
        sec = int(val[0])
        min = int(val[1])
        if min >= 1:
            info[5] = f"{min} minutes"
        if min >= 60:
            time_h = min // 60
            time_min = round((min / 60 - time_h), 2)
            info[5] = f"{time_h}h, {int(time_min*100)}m"
        if min<=1:
            info[5] = f"{sec} seconds"


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
field_colors = ["#fb4934", "#b8bb26", "#fabd2f",
                "#83a598", "#d3869b", "#8ec07c", "#fe8019", "#d79921"]

# Character and border colors
use_color = random.choice(field_colors) 

# Right border color
exp = tcolor(f"│", color=use_color, styles=["bold"])

# Info and border list
ls = [
    tcolor(f"╭{s}╮", color=use_color, styles=["bold"]),
    tcolor(f"{exp}{get(name_[0],info[0],field_colors[0])}{exp}",
           color="#ee1177", styles=["bold"]),
    tcolor(f"{exp}{get(name_[1],info[1],field_colors[1])}{exp}",
           color="#ee1177", styles=["bold"]),
    tcolor(f"{exp}{get(name_[2],info[2],field_colors[2])}{exp}",
           color="#ee1177", styles=["bold"]),
    tcolor(f"{exp}{get(name_[3],info[3],field_colors[3])}{exp}",
           color="#ee1177", styles=["bold"]),
    tcolor(f"{exp}{get(name_[4],info[4],field_colors[4])}{exp}",
           color="#ee1177", styles=["bold"]),
    tcolor(f"{exp}{get(name_[5],info[5],field_colors[5])}{exp}",
           color="#ee1177", styles=["bold"]),
    tcolor(f"{exp}{get(name_[6],info[6],field_colors[6])}{exp}",
           color="#ee1177", styles=["bold"]),
    tcolor(f"{exp}{get(name_[7],info[7],field_colors[7])}{exp}",
           color="#ee1177", styles=["bold"]),
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
    print(tcolor(f"                 {ls[0]}",color=use_color,styles=["bold"]))
    print(tcolor(f"                 {ls[1]}",color=use_color,styles=["bold"]))
    print(tcolor(f"    .-----.      {ls[2]}",color=use_color,styles=["bold"]))
    print(tcolor(f"  .`       `.   ╭{ls[3]}",color=use_color,styles=["bold"]))
    print(tcolor(f" / /-() ()-\ \  │{ls[4]}",color=use_color,styles=["bold"]))
    print(tcolor(f" \_|   ○   |_/  │{ls[5]}",color=use_color,styles=["bold"]))
    print(tcolor(f"  '.       .'   ╯{ls[6]}",color=use_color,styles=["bold"]))
    print(tcolor(f"    `-._.-'      {ls[7]}",color=use_color,styles=["bold"]))
    print(tcolor(f"                 {ls[8]}",color=use_color,styles=["bold"]))
    print(tcolor(f"                 {ls[9]}",color=use_color,styles=["bold"]))

def alice(use_color=use_color):
        print(tcolor(f"           ..-..             {ls[0]}",color=use_color,styles=["bold"]))
        print(tcolor(f"         (~     ~)           {ls[1]}",color=use_color,styles=["bold"]))
        print(tcolor(f"       (           )         {ls[2]}",color=use_color,styles=["bold"]))
        print(tcolor(f"     (    ~~~~~~~    )      ╭{ls[3]}",color=use_color,styles=["bold"]))
        print(tcolor(f"   (     |  . .  |     )    │{ls[4]}",color=use_color,styles=["bold"]))
        print(tcolor(f"  (      |  (_)  |      )   │{ls[5]}",color=use_color,styles=["bold"]))
        print(tcolor(f" (       |       |       )  ╯{ls[6]}",color=use_color,styles=["bold"]))
        print(tcolor(f"   (.,.,.|  ===  |.,.,.)     {ls[7]}",color=use_color,styles=["bold"]))
        print(tcolor(f"          '.___.'            {ls[8]}",color=use_color,styles=["bold"]))
        print(tcolor(f"           /   \             {ls[9]}",color=use_color,styles=["bold"]))

def pointy_haired_boss(use_color=use_color):
        print(tcolor(f"    @         @      {ls[0]}", color=use_color,styles=["bold"]))
        print(tcolor(f"   @@  ..-..  @@     {ls[1]}", color=use_color,styles=["bold"]))
        print(tcolor(f"   @@@' _ _ '@@@     {ls[2]}", color=use_color,styles=["bold"]))
        print(tcolor(f"    @(  . .  )@     ╭{ls[3]}", color=use_color,styles=["bold"]))
        print(tcolor(f"     |  (_)  |      │{ls[4]}", color=use_color,styles=["bold"]))
        print(tcolor(f"     |   _   |      │{ls[5]}", color=use_color,styles=["bold"]))
        print(tcolor(f"     |_     _|      ╯{ls[6]}", color=use_color,styles=["bold"]))
        print(tcolor(f"    /|_'---'_|\      {ls[7]}", color=use_color,styles=["bold"]))
        print(tcolor(f"   / | '\_/' | \     {ls[8]}", color=use_color,styles=["bold"]))
        print(tcolor(f"  /  |  | |  |  \    {ls[9]}", color=use_color,styles=["bold"]))

def asok(use_color=use_color):
        print(tcolor(f"                 {ls[0]}", color=use_color,styles=["bold"]))
        print(tcolor(f"    @@@@@@@@@    {ls[1]}", color=use_color,styles=["bold"]))
        print(tcolor(f"    |       |    {ls[2]}", color=use_color,styles=["bold"]))
        print(tcolor(f"    | _   _ |   ╭{ls[3]}", color=use_color,styles=["bold"]))
        print(tcolor(f"   Ͼ| ○   ○ |Ͽ  │{ls[4]}", color=use_color,styles=["bold"]))
        print(tcolor(f"    |   u   |   │{ls[5]}", color=use_color,styles=["bold"]))
        print(tcolor(f"    |  ---  |   ╯{ls[6]}", color=use_color,styles=["bold"]))
        print(tcolor(f"   / `-._.-´ \   {ls[7]}", color=use_color,styles=["bold"]))
        print(tcolor(f"        |        {ls[8]}", color=use_color,styles=["bold"]))
        print(tcolor(f"                 {ls[9]}", color=use_color,styles=["bold"]))

def curt(use_color=use_color):
        print(tcolor(f"               {ls[0]}",color=use_color,styles=["bold"]))   
        print(tcolor(f"    დოოოოოდ    {ls[1]}",color=use_color,styles=["bold"]))                 
        print(tcolor(f"    |     |    {ls[2]}",color=use_color,styles=["bold"]))   
        print(tcolor(f"    |     |   ╭{ls[3]}",color=use_color,styles=["bold"]))     
        print(tcolor(f"    |-Ο Ο-|   │{ls[4]}",color=use_color,styles=["bold"]))       
        print(tcolor(f"   Ͼ   ∪   Ͽ  │{ls[5]}",color=use_color,styles=["bold"]))         
        print(tcolor(f"    |     |   ╯{ls[6]}",color=use_color,styles=["bold"]))     
        print(tcolor(f"   ˏ`-.ŏ.-´ˎ   {ls[7]}",color=use_color,styles=["bold"]))       
        print(tcolor(f"       @       {ls[8]}",color=use_color,styles=["bold"]))   
        print(tcolor(f"        @      {ls[9]}",color=use_color,styles=["bold"]))   

characters_names=['wally','dogbert','alice','pointy_haired_boss','asok','curt']
charac=random.choice(characters_names)

eval(charac + "()")

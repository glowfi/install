# ===================================================================
#                      Python Functions
# ===================================================================

"""
Utility Function
"""
import os
stream = os.popen('whereis node')
output = stream.read()
output=str(output).split('/')[3]

from ranger.api.commands import Command

class fzf_searchFileIndexed(Command):
    """
    Find a file using fzf.
    """

    def execute(self):
        import subprocess
        import os.path
        fzf = self.fm.execute_command(
            "du -a --exclude %s --exclude './.*' --exclude './**/.git' --exclude 'node_modules' ~/.config/* ~/cdx/* ~/main/* | awk '{print $2}' |fzf --preview 'bat --theme 'gruvbox-dark' --style numbers,changes --color=always {}'" %output, universal_newlines=True, stdout=subprocess.PIPE)
        stdout, stderr = fzf.communicate()
        if fzf.returncode == 0:
            fzf_file = os.path.abspath(stdout.rstrip('\n'))
            if os.path.isdir(fzf_file):
                self.fm.cd(fzf_file)
            else:
                self.fm.select_file(fzf_file)


class fzf_searchContent(Command):
    """
    Find a contents inside of file using fzf.
    """

    def execute(self):
        import subprocess
        import os.path
        fzf = self.fm.execute_command(
            "rg --line-number -g !%s -g '!./.*' -g '!node_modules'  .  | awk -F':' '{ print $0 }' | fzf | awk -F ':' '{print $1}'" %output, universal_newlines=True, stdout=subprocess.PIPE)
        stdout, stderr = fzf.communicate()
        if fzf.returncode == 0:
            fzf_file = os.path.abspath(stdout.rstrip('\n'))
            if os.path.isdir(fzf_file):
                self.fm.cd(fzf_file)
            else:
                self.fm.select_file(fzf_file)

class fzf_searchCurrent(Command):
    """
    Find files inside current working directory using fzf.
    """

    def execute(self):
        import subprocess
        import os.path
        fzf = self.fm.execute_command(
            "du -a --exclude %s --exclude './.*' --exclude './**/.git' --exclude 'node_modules' . | awk '{print $2}' |fzf --preview 'bat --theme 'gruvbox-dark' --style numbers,changes --color=always {}'" %output, universal_newlines=True, stdout=subprocess.PIPE)
        stdout, stderr = fzf.communicate()
        if fzf.returncode == 0:
            fzf_file = os.path.abspath(stdout.rstrip('\n'))
            if os.path.isdir(fzf_file):
                self.fm.cd(fzf_file)
            else:
                self.fm.select_file(fzf_file)

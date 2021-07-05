from ranger.api.commands import Command


class fzf_searchFile(Command):
    """
    Find a file using fzf.
    """
    def execute(self):
        import subprocess
        import os.path
        fzf = self.fm.execute_command("du -a ~/.config/* ~/install/* ~/cdx/* ~/main/* | awk '{print $2}' |fzf --preview 'bat --style numbers,changes --color=always {}'", universal_newlines=True, stdout=subprocess.PIPE)
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
        fzf = self.fm.execute_command("rg . | fzf | awk -F':' '{ print $1 }'", universal_newlines=True, stdout=subprocess.PIPE)
        stdout, stderr = fzf.communicate()
        if fzf.returncode == 0:
            fzf_file = os.path.abspath(stdout.rstrip('\n'))
            if os.path.isdir(fzf_file):
                self.fm.cd(fzf_file)
            else:
                self.fm.select_file(fzf_file)

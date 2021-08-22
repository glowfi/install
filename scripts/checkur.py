#!/usr/bin/python

import requests
import json
import tempfile, os
from subprocess import call


class checkur:
    def __init__(self, method, url):
        self.method = method
        self.url = url

    def create_file(self):
        EDITOR = os.environ.get("EDITOR", "vim")
        with tempfile.NamedTemporaryFile(suffix=".json") as tf:
            call([EDITOR, tf.name])
            f = open(
                tf.name,
            )
            json_file = json.load(f)
        return json_file

    def display(self, res_code, data):
        print("")
        print("===================================================================")
        print("                          Response                                 ")
        print("===================================================================")

        print("")
        print("#### STATUS CODE ####")
        print(res_code)
        print("")
        print("#### RESPONSE DATA ####")
        print(json.dumps(data, indent=4))

    def get_(self, url):
        r = requests.get(url)
        try:
            self.display(r.status_code, r.json())
        except:
            self.display(r.status_code, r.text)

    def post_(self, url, params):
        r = requests.post(url, json=params)
        try:
            self.display(r.status_code, r.json())
        except:
            self.display(r.status_code, r.text)

    def put_(self, url, params):
        r = requests.put(url, json=params)
        try:
            self.display(r.status_code, r.json())
        except:
            self.display(r.status_code, r.text)

    def delete_(self, url):
        r = requests.delete(url)
        try:
            self.display(r.status_code, r.json())
        except:
            self.display(r.status_code, r.text)

    def patch_(self, url, params):
        r = requests.patch(url, json=params)
        try:
            self.display(r.status_code, r.json())
        except:
            self.display(r.status_code, r.text)

    def handler(self):

        if self.method.lower() == "get":
            self.get_(self.url)

        elif self.method.lower() == "post":
            f = self.create_file()
            self.post_(self.url, f)

        elif self.method.lower() == "put":
            f = self.create_file()
            self.put_(self.url, f)

        elif self.method.lower() == "delete":
            self.delete_(self.url)

        elif self.method.lower() == "patch":
            f = self.create_file()
            self.patch_(self.url, f)

        else:
            print("Please provide a vaild method!")


method = input("Which Method to use? ")
url = input("Which URL to hit ? ")
obj = checkur(method, url)
obj.handler()

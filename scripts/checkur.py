#!/usr/bin/python

import requests
import json
import tempfile, os
from subprocess import call
from rich.console import Console
from rich.syntax import Syntax


class checkur:
    def __init__(self, method, url, cookies, headers):
        self.method = method
        self.url = url
        self.cookies = cookies
        self.headers = headers

    def get_codes(self, code):
        codes = {
            100: "Informational: Continue",
            101: "Informational: Switching Protocols",
            102: "Informational: Processing",
            200: "Successful: OK",
            201: "Successful: Created",
            202: "Successful: Accepted",
            203: "Successful: Non-Authoritative Information",
            204: "Successful: No Content",
            205: "Successful: Reset Content",
            206: "Successful: Partial Content",
            207: "Successful: Multi-Status",
            208: "Successful: Already Reported",
            226: "Successful: IM Used",
            300: "Redirection: Multiple Choices",
            301: "Redirection: Moved Permanently",
            302: "Redirection: Found",
            303: "Redirection: See Other",
            304: "Redirection: Not Modified",
            305: "Redirection: Use Proxy",
            306: "Redirection: Switch Proxy",
            307: "Redirection: Temporary Redirect",
            308: "Redirection: Permanent Redirect",
            400: "Client Error: Bad Request",
            401: "Client Error: Unauthorized",
            402: "Client Error: Payment Required",
            403: "Client Error: Forbidden",
            404: "Client Error: Not Found",
            405: "Client Error: Method Not Allowed",
            406: "Client Error: Not Acceptable",
            407: "Client Error: Proxy Authentication Required",
            408: "Client Error: Request Timeout",
            409: "Client Error: Conflict",
            410: "Client Error: Gone",
            411: "Client Error: Length Required",
            412: "Client Error: Precondition Failed",
            413: "Client Error: Request Entity Too Large",
            414: "Client Error: Request-URI Too Long",
            415: "Client Error: Unsupported Media Type",
            416: "Client Error: Requested Range Not Satisfiable",
            417: "Client Error: Expectation Failed",
            418: "Client Error: I'm a teapot",
            419: "Client Error: Authentication Timeout",
            420: "Client Error: Enhance Your Calm",
            420: "Client Error: Method Failure",
            422: "Client Error: Unprocessable Entity",
            423: "Client Error: Locked",
            424: "Client Error: Failed Dependency",
            424: "Client Error: Method Failure",
            425: "Client Error: Unordered Collection",
            426: "Client Error: Upgrade Required",
            428: "Client Error: Precondition Required",
            429: "Client Error: Too Many Requests",
            431: "Client Error: Request Header Fields Too Large",
            444: "Client Error: No Response",
            449: "Client Error: Retry With",
            450: "Client Error: Blocked by Windows Parental Controls",
            451: "Client Error: Redirect",
            451: "Client Error: Unavailable For Legal Reasons",
            494: "Client Error: Request Header Too Large",
            495: "Client Error: Cert Error",
            496: "Client Error: No Cert",
            497: "Client Error: HTTP to HTTPS",
            499: "Client Error: Client Closed Request",
            500: "Server Error: Internal Server Error",
            501: "Server Error: Not Implemented",
            502: "Server Error: Bad Gateway",
            503: "Server Error: Service Unavailable",
            504: "Server Error: Gateway Timeout",
            505: "Server Error: HTTP Version Not Supported",
            506: "Server Error: Variant Also Negotiates",
            507: "Server Error: Insufficient Storage",
            508: "Server Error: Loop Detected",
            509: "Server Error: Bandwidth Limit Exceeded",
            510: "Server Error: Not Extended",
            511: "Server Error: Network Authentication Required",
            598: "Server Error: Network read timeout error",
            599: "Server Error: Network connect timeout error",
        }
        return codes[code]

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
        console = Console()
        print("")
        print("")
        print("#### STATUS CODE ####")
        print("")
        console.print(f"Response Code: {res_code}", style="bold magenta")
        console.print(
            f"Response Status: {self.get_codes(res_code)}", style="bold green"
        )
        print("")
        print("#### RESPONSE DATA ####")
        print("")
        syntax_response = Syntax(
            json.dumps(data, indent=4),
            "json",
            theme="monokai",
            line_numbers=False,
            word_wrap=True,
            code_width=69,
            tab_size=4,
        )
        console.print(syntax_response)

    def get_(self, url):
        r = requests.get(url, headers=self.headers, cookies=self.cookies)
        try:
            self.display(r.status_code, r.json())
        except Exception as e:
            self.display(r.status_code, r.text)

    def post_(self, url, params):
        r = requests.post(url, json=params, headers=self.headers, cookies=self.cookies)
        try:
            self.display(r.status_code, r.json())
        except Exception as e:
            self.display(r.status_code, r.text)

    def put_(self, url, params):
        r = requests.put(url, json=params, headers=self.headers, cookies=self.cookies)
        try:
            self.display(r.status_code, r.json())
        except Exception as e:
            self.display(r.status_code, r.text)

    def delete_(self, url):
        r = requests.delete(url)
        try:
            self.display(
                r.status_code, r.json(), headers=self.headers, cookies=self.cookies
            )
        except Exception as e:
            self.display(r.status_code, r.text)

    def patch_(self, url, params):
        r = requests.patch(url, json=params, headers=self.headers, cookies=self.cookies)
        try:
            self.display(r.status_code, r.json())
        except Exception as e:
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
ask_cookies = input("Want to send any cookies? ")
ask_headers = input("Want to send any headers? ")

if ask_cookies == "y":
    cookies_key = input("Enter the cookie keys seperated by comma: ").split(",")
    cookies_value = input(
        "Enter the corresponding cookie values seperated by comma: "
    ).split(",")
    cookies = {}
    try:
        for ind, val in enumerate(cookies_key):
            cookies[val] = cookies_value[ind]

    except Exception as e:
        raise e
    else:
        pass

if ask_headers == "y":
    headers_key = input("Enter the headers keys seperated by comma: ").split(",")
    headers_value = input(
        "Enter the corresponding headers values seperated by comma: "
    ).split(",")
    headers = {}
    try:
        for ind, val in enumerate(headers_key):
            headers[val] = headers_value[ind]

    except Exception as e:
        raise e
    else:
        pass

if ask_cookies == "n":
    cookies = None

if ask_headers == "n":
    headers = None

obj = checkur(method, url, cookies, headers)
obj.handler()

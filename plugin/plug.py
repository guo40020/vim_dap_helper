import json
from vim import * 

def load_launch():
    cwd = vim.eval('getcwd()')
    f = open(f'{cwd}/.vscode/launch.json', "r")
    launchjson = json.load(f)
    configurations = launchjson["configurations"]
    for conf in configurations:
        vim.command(f"""lua 
            local tbl = require 'dap'.configurations.{conf["type"]}
            table.insert(tbl, {{
                type = '{conf["type"]}';
                name = '{conf["name"]}';
                request = '{conf["request"]}';
                {"dlvToolPath = vim.fn.exepath('dlv');" if conf["type"] == "go" else ""}
                program = '{conf["program"].replace("workspaceRoot", "workspaceFolder")}';
            }})
        """)


from robot.api.deco import keyword
import json

@keyword(name="Pretty Json")

def pretty_json(dictionary):
    return json.dumps(dictionary, indent=4)
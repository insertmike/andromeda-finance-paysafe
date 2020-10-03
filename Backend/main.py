import json
from flask import make_response, jsonify
from flask import Flask, request

from flask_httpauth import HTTPBasicAuth
from werkzeug.security import generate_password_hash, check_password_hash

app = Flask(__name__)

"""
   Register kid (POST) parent id - 
                1.Email
                2.Password
                3.Name
                
             response - 201
            
"""

@app.route('/parent/<int:id>/kid', methods=['POST'])
def register_kid():
    try:
        json_temp = "{}"
        temp_response = json.loads(json_temp)
        response = make_response(temp_response, 201)
        return response
    except:
        response = make_response(jsonify({"error": "Not found"}), 404)
        return response


"""
   Register parent (POST)  - 
                1.Email
                2.Password
                3.Name

             response - 201

"""


@app.route('/parent', methods=['POST'])
def register_parent():
    try:
        json_temp = "{}"
        temp_response = json.loads(json_temp)
        response = make_response(temp_response, 201)
        return response
    except:
        response = make_response(jsonify({"error": "Not found"}), 404)
        return response


"""
   Register task (POST) 1.Email 2.Password  3.Kid_id- 
                2.Summary
                3.Reward
                
              response - 201
"""

@app.route('/parent/<int:parent_id>/kid/<int:kid_id>/task', methods=['POST'])
def register_task():
    try:
        json_temp = "{}"
        temp_response = json.loads(json_temp)
        response = make_response(temp_response, 201)
        return response
    except:
        response = make_response(jsonify({"error": "Not found"}), 404)
        return response


"""
   Login kids (POST)  - 
                1.Email
                2.Password
                
            response - 200 is_kid, name
"""

@app.route('/login', methods=['POST'])
def login_kid():
    try:
        json_temp = "{}"
        temp_response = json.loads(json_temp)
        response = make_response(temp_response, 200)
        return response
    except:
        response = make_response(jsonify({"error": "Not found"}), 404)
        return response


"""
   parent/$ID?kids (GET) - 
                        1.Email
                        2.Password
          response - 
                    1.Kid_name
                    2.Kid_balance
                    3.Kid_task summary
                    4.kid_task state
"""

@app.route('/parent/<int:id>/kid', methods=['GET'])
def parent_ID_kids(id):
    try:
        json_temp = "{}"
        temp_response = json.loads(json_temp)
        response = make_response(temp_response, 200)
        return response
    except:
        response = make_response(jsonify({"error": "Not found"}), 404)
        return response


"""
   Kid tasks (GET) - 
                1.Email
                2.Password
    response -
                1.Summary
                2.ID
                3.Reward
                4.State
                5.Kid_balance
"""

@app.route('/parent/<int:parent_id>/kid/<int:kid_id>/task', methods=['GET'])
def kid_tasks():
    try:
        json_temp = "{}"
        temp_response = json.loads(json_temp)
        response = make_response(temp_response, 200)
        return response
    except:
        response = make_response(jsonify({"error": "Not found"}), 404)
        return response


"""
   Kid tasks (PUT) - 
                1.Email
                2.Password
                3.Image
                4.Comment
"""

@app.route('/parent/<int:parent_id>/kid/<int:kid_id>/task', methods=['PUT'])
def kid_tasks_put():
    try:
        json_temp = "{}"
        temp_response = json.loads(json_temp)
        response = make_response(temp_response, 201)
        return response
    except:
        response = make_response(jsonify({"error": "Not found"}), 404)
        return response



"""
   Full tasks (GET) - 
                1.Email
                2.Password
                3.Kid_id
    response -
            1.ID
            2.Summary
            3.Image
            4.Comment
            5.State
"""

@app.route('/full_kid_tasks', methods=['GET'])
def kid_tasks_all():
    try:
        json_temp = "{}"
        temp_response = json.loads(json_temp)
        response = make_response(temp_response, 200)
        return response
    except:
        response = make_response(jsonify({"error": "Not found"}), 404)
        return response


"""
   Full tasks (POST) - 
                1.Email
                2.Password
                3.Kid ID
                4.Task ID
    response -
            200
"""

@app.route('/full_kid_tasks', methods=['POST'])
def kid_tasks_all_put():
    try:
        json_temp = "{}"
        temp_response = json.loads(json_temp)
        response = make_response(temp_response, 200)
        return response
    except:
        response = make_response(jsonify({"error": "Not found"}), 404)
        return response
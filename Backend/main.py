import json
from flask import make_response, jsonify
from flask import Flask, request

app = Flask(__name__)

"""
   Register kid (PUT) - 
                1.Email
                2.Password
                3.Name
                4.Parent_id
                
             response - 201
            
"""

@app.route('/register_kid', methods=['PUT'])
def register_kid():
    try:
        json_temp = "{}"
        temp_response = json.loads(json_temp)
        response = make_response(temp_response, 201)
        return response
    except:
        response =  make_response(jsonify({"error": "Not found"}), 404)
        return response


"""
   Register task (PUT) - 
                1.Email
                2.Password
                3.Kid_id
                4.Summary
                3.Reward
                
              response - 201
"""

@app.route('/register_task', methods=['PUT'])
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
                
            response - 200
"""

@app.route('/login_kid', methods=['POST'])
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
   Login parent (POST)  - 
                1.Email
                2.Password
                
            response - 200
"""

@app.route('/login_parent', methods=['POST'])
def login_parent():
    try:
        json_temp = "{}"
        temp_response = json.loads(json_temp)
        response = make_response(temp_response, 201)
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
                3.Kid_id
    response -
                1.Summary
                2.ID
                3.Reward
                4.State
"""

@app.route('/kid_tasks', methods=['GET'])
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

@app.route('/kid_tasks', methods=['PUT'])
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
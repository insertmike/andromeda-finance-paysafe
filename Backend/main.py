import json

import flask
from flask import make_response, jsonify
from flask import Flask, request
from flask_httpauth import HTTPBasicAuth
from werkzeug.security import generate_password_hash, check_password_hash
import sqlite3

app = Flask(__name__)
auth = HTTPBasicAuth()

conn = sqlite3.connect('/Users/dpavlovski/Desktop/paysafe-hackathon-vmv/Backend/Kidromeda.db')
c = conn.cursor()

users = {
    "john": generate_password_hash("hello"),
    "susan": generate_password_hash("bye")
}


@auth.verify_password
def verify_password(username, password):

        conn = sqlite3.connect('/Users/dpavlovski/Desktop/paysafe-hackathon-vmv/Backend/Kidromeda.db')
        c = conn.cursor()
        query = "SELECT PASSWORD FROM Kid WHERE EMAIL = '" + username + "'"
        c.execute(query)
        password_db = c.fetchone()[0]
        if check_password_hash(password_db, password):
            return username


"""
   Register kid (POST) parent id - 
                1.Email
                2.Password
                3.Name
                
             response - 201
            
"""


@app.route('/parent/<int:id>/kid', methods=['POST'])
@auth.login_required
def register_kid(id):
    try:
        conn = sqlite3.connect('/Users/dpavlovski/Desktop/paysafe-hackathon-vmv/Backend/Kidromeda.db')
        c = conn.cursor()

        name = request.json.get('name')
        email = request.json.get('email')
        password = request.json.get('password')

        balance = 0
        parent_id = id

        c.execute("INSERT INTO Kid(NAME,Email,PASSWORD,BALANCE,Parent_id) VALUES (?, ?, ?, ?, ?)",
                  (name, email, generate_password_hash(password),balance,parent_id))
        conn.commit()

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
@auth.login_required
def register_parent():
    try:
        conn = sqlite3.connect('/Users/dpavlovski/Desktop/paysafe-hackathon-vmv/Backend/Kidromeda.db')
        c = conn.cursor()

        name = request.json.get('name')
        email = request.json.get('email')
        password = request.json.get('password')

        c.execute("INSERT INTO Parent(NAME,Email,PASSWORD) VALUES (?, ?, ?)",
                  (name, email, generate_password_hash(password)))
        conn.commit()

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
@auth.login_required
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
@auth.login_required
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
@auth.login_required
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
@auth.login_required
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
@auth.login_required
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
@auth.login_required
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
@auth.login_required
def kid_tasks_all_put():
    try:
        json_temp = "{}"
        temp_response = json.loads(json_temp)
        response = make_response(temp_response, 200)
        return response
    except:
        response = make_response(jsonify({"error": "Not found"}), 404)
        return response

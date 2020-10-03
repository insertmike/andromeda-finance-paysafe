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
        keep = c.fetchone()
        if keep is not None:
            password_db = keep[0]
            if check_password_hash(password_db, password):
                return username

        query = "SELECT PASSWORD FROM Parent WHERE EMAIL = '" + username + "'"
        c.execute(query)
        keep = c.fetchone()
        if keep is not None:
            password_db = keep[0]
            if check_password_hash(password_db, password):
                return username



"""
   AUTHORIZATION HEADER - EMAIL & PASSWORD
   Register kid (POST) parent id - 
        request-
        
        {
            "email": "VALUE",
            "password": "VALUE",
            "name": "VALUE"
        }
   
             response - 201
            
"""
@app.route('/parent/<int:id>/kid', methods=['POST'])
def register_kid(id):
    try:
        conn = sqlite3.connect('/Users/dpavlovski/Desktop/paysafe-hackathon-vmv/Backend/Kidromeda.db')
        c = conn.cursor()

        name = request.json.get('name')
        email = request.json.get('email')
        password = request.json.get('password')

        balance = 0
        parent_id = id

        c.execute("INSERT INTO KID(NAME,Email,PASSWORD,BALANCE,Parent_id) VALUES (?, ?, ?, ?, ?)",
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
   AUTHORIZATION HEADER - EMAIL & PASSWORD
   Register parent (POST)  - 
               request -
        {
            "email": "VALUE",
            "password": "VALUE",
            "name": "VALUE"
        }

             response - 201
"""
@app.route('/parent', methods=['POST'])
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
   AUTHORIZATION HEADER - EMAIL & PASSWORD
   Register task (POST)      
        request -
                {
                    "summary": "VALUE",
                    "reward": "VALUE"
                }
                
              response - 201
"""
@app.route('/parent/<int:parent_id>/kid/<int:kid_id>/task', methods=['POST'])
@auth.login_required
def register_task(kid_id):
    try:
        conn = sqlite3.connect('/Users/dpavlovski/Desktop/paysafe-hackathon-vmv/Backend/Kidromeda.db')
        c = conn.cursor()

        #add checking for parent permision to change the kid( is this the parent of the kid)

        summary = request.json.get('summary')
        reward = request.json.get('reward')
        completed = 0
        comment = ""
        url = ""

        c.execute("INSERT INTO TASK(SUMMARY,REWARD,COMPLETED,COMMENT,URL,Kid_id) VALUES (?, ?, ?, ?, ?, ?)",
                  (summary, reward,completed,comment,url,kid_id))
        conn.commit()

        json_temp = "{}"
        temp_response = json.loads(json_temp)
        response = make_response(temp_response, 201)
        return response
    except:
        response = make_response(jsonify({"error": "Not found"}), 404)
        return response


"""
   AUTHORIZATION HEADER - EMAIL & PASSWORD
   Login  (GET)  -
            

            response - 200
            {
                "is_parent": "VALUE",
                "name": "VALUE"
                "email":"VALUE",
                "current_id":"VALUE"
                
            }
"""
@app.route('/login', methods=['GET'])
@auth.login_required
def login():
    email = auth.username()

    conn = sqlite3.connect('/Users/dpavlovski/Desktop/paysafe-hackathon-vmv/Backend/Kidromeda.db')
    c = conn.cursor()

    query = "SELECT NAME, ID FROM Kid WHERE EMAIL = '" + email + "'"
    c.execute(query)
    keep = c.fetchone()
    if keep is not None:
        name = keep[0]
        id = keep[1]

        response = {'name': name, 'is_parent': False, 'email': email, 'current_id':id}

        return make_response(jsonify(response), 200)

    query = "SELECT NAME, ID FROM Parent WHERE EMAIL = '" + email + "'"
    c.execute(query)
    keep = c.fetchone()
    if keep is not None:
        name = keep[0]
        id = keep[1]
        response = {'name': name, 'is_parent': True,'email': email, 'current_id':id}

        return make_response(jsonify(response), 200)

    response = make_response(jsonify({"error": "Not found"}), 404)
    return response



"""
   AUTHORIZATION HEADER - EMAIL & PASSWORD
   parent/$ID?kids (GET) - 

          response - 
                    
{children: { name, balance, tasks: [{ summary, status, reward, image: string|null, comment: string }] }
"""
@app.route('/parent/<int:parent_id>/kid', methods=['GET'])
@auth.login_required
def parent_id_kids(parent_id):
    try:
        conn = sqlite3.connect('/Users/dpavlovski/Desktop/paysafe-hackathon-vmv/Backend/Kidromeda.db')
        c = conn.cursor()
        query = "SELECT ID FROM KID WHERE Parent_id = '" + str(parent_id) + "'"
        c.execute(query)
        keep = c.fetchone()
        print(keep)

        if keep is not None:
            for entry in keep:
                query = "SELECT * FROM TASK WHERE Kid_id = '" + str(entry) + "'"
                c.execute(query)
                keep1 = c.fetchone()
                print(keep1)

        json_temp = "{}"
        temp_response = json.loads(json_temp)
        response = make_response(temp_response, 200)
        return response
    except:
        response = make_response(jsonify({"error": "Not found"}), 404)
        return response



"""
   AUTHORIZATION HEADER - EMAIL & PASSWORD
   Kid tasks (PUT) (kid ready method) - 
            {
                "image": "VALUE",
                "comment": "VALUE"
            }
    response - 201
"""


@app.route('/parent/<int:parent_id>/kid/<int:kid_id>/task/<int:task_id>', methods=['PUT'])
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
   AUTHORIZATION HEADER - EMAIL & PASSWORD
   Kid tasks (POST) (verify if the task is done) - 
            request-
            {
                "verify": "VALUE",
            }
            
            
      response - 200

"""


@app.route('/parent/<int:parent_id>/kid/<int:kid_id>/task/<int:task_id>/verify', methods=['POST'])
@auth.login_required
def parants_tasks_put():
    try:
        json_temp = "{}"
        temp_response = json.loads(json_temp)
        response = make_response(temp_response, 200)
        return response
    except:
        response = make_response(jsonify({"error": "Not found"}), 404)
        return response


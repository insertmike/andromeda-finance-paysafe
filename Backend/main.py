import json
import os

import flask
from flask import make_response, jsonify
from flask import Flask, request
from flask_httpauth import HTTPBasicAuth
from werkzeug.security import generate_password_hash, check_password_hash
import sqlite3
from flask import g

app = Flask(__name__)
auth = HTTPBasicAuth()

conn = sqlite3.connect(os.getcwd() + '/Kidromeda.db')
c = conn.cursor()

DATABASE = '/Kidromeda.db'


def get_db():
    db = getattr(g, '_database', None)
    if db is None:
        db = g._database = sqlite3.connect(os.getcwd() + DATABASE)
    return db




def query_db(query, args=(), one=False):
    cur = get_db().execute(query, args)
    rv = cur.fetchall()
    get_db().commit()
    cur.close()
    return (rv[0] if rv else None) if one else rv


@app.teardown_appcontext
def close_connection(exception):
    db = getattr(g, '_database', None)
    if db is not None:
        db.close()


@auth.verify_password
def verify_password(username, password):

    keep = query_db("SELECT PASSWORD FROM Kid WHERE EMAIL = '" + username + "'", one=True)

    if keep is not None:
        password_db = keep[0]
        if check_password_hash(password_db, password):
            return username

    keep = query_db("SELECT PASSWORD FROM Parent WHERE EMAIL = '" + username + "'", one=True)

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
        name = request.json.get('name')
        email = request.json.get('email')
        password = request.json.get('password')
        balance = 0
        parent_id = id
        query_db('INSERT INTO KID(NAME,Email,PASSWORD,BALANCE,Parent_id) VALUES (?, ?, ?, ?, ?)',
                       [name, email, generate_password_hash(password), balance, parent_id])

        # Get Last Entry
        res = query_db('SELECT * FROM kid ORDER BY id DESC', one=True)
        id = res[0]
        name = res[1]
        email = res[2]
        balance = res[4]
        parent_id = res[5]

        response = {'id': id, 'name': name, 'is_parent': True, 'email': email, 'balance': balance,
                    'parent_id': parent_id}


        return make_response(jsonify(response), 201)
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
        name = request.json.get('name')
        email = request.json.get('email')
        password = request.json.get('password')
        query_db('INSERT INTO Parent(NAME,Email,PASSWORD) VALUES (?, ?, ?)',
                       [name, email, generate_password_hash(password)])

        # Get Last Entry
        res = query_db('SELECT id,name,email FROM parent ORDER BY id DESC', one=True)

        parent_id = res[0]

        name = res[1]

        email = res[2]

        response = {'id': parent_id, 'name': name, 'is_parent': True, 'email': email}
        return make_response(jsonify(response), 201)


    except:
        response = make_response(jsonify({"error": "Not found"}), 404)
        return response


"""
   AUTHORIZATION HEADER - EMAIL & PASSWORD
   Get parent (GET)  -
             response - 201
"""


@app.route('/parent', methods=['GET'])
@auth.login_required
def get_parent():
    try:
        parent = query_db('SELECT id, name,  email FROM parent WHERE parent.email = ?', [auth.username()], one=True)
        id = parent[0]
        name = parent[1]
        email = parent[2]
        response = {'id': id, 'name': name, 'is_parent': True, 'email': email}
        return make_response(jsonify(response), 200)
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
def register_task(parent_id, kid_id):
    try:

        #add checking for parent permision to change the kid( is this the parent of the kid)

        summary = request.json.get('summary')
        reward = request.json.get('reward')

        reward = float(reward)

        completed = 0
        comment = ""
        url = ""

        query_db('INSERT INTO TASK(SUMMARY,REWARD,COMPLETED,COMMENT,URL,Kid_id) VALUES (?, ?, ?, ?, ?, ?)',
                 [summary, reward, completed, comment, url, kid_id])

        res = query_db('SELECT ID,SUMMARY,REWARD,COMPLETED,COMMENT,KID_ID FROM task ORDER BY id DESC', one=True)
        response = {'task_id': res[0],'summary': res[1],'reward': res[2], "status": res[3], 'comment': res[4], "kid_id": res[5]}
        return make_response(jsonify(response), 200)
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

    keep = query_db("SELECT NAME, ID FROM Kid WHERE EMAIL = '" + email + "'", one=True)
    if keep is not None:
        name = keep[0]
        id = keep[1]

        response = {'name': name, 'is_parent': False, 'email': email, 'current_id': id}

        return make_response(jsonify(response), 200)

    keep = query_db("SELECT NAME, ID FROM Parent WHERE EMAIL = '" + email + "'", one=True)
    if keep is not None:
        name = keep[0]
        id = keep[1]
        response = {'name': name, 'is_parent': True, 'email': email, 'current_id': id}

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
        response = {"children" :[]}
        children = query_db("SELECT id, parent_id, name, balance FROM kid WHERE parent_id ='" + str(parent_id) + "'",[])
        # print(children)
        for child in children:
            curr_kid = {}
            curr_kid['id']=child[0]
            curr_kid['parent_id']=child[1]
            curr_kid['name']=child[2]
            curr_kid['balance']=child[3]
            curr_kid['tasks']= []
            tasks = query_db("SELECT id, summary, completed, reward, comment, kid_id FROM task WHERE kid_id ='" + str(child[0]) + "'")
            print(tasks)
            if not tasks:
                curr_kid['tasks'].append([])
                response['children'].append(curr_kid)
                continue
            for task in tasks:
                curr_task = {}
                curr_task['id'] = task[0]
                curr_task['summary'] = task[1]
                curr_task['status'] = task[2]
                curr_task['reward'] = task[3]
                curr_task['comment'] = task[4]
                curr_task['kid_id'] = task[5]
                curr_kid['tasks'].append(curr_task)
            response['children'].append(curr_kid)
        response = make_response(jsonify(response), 200)
        return response
    except:
        response = make_response(jsonify({"error": "Not found1"}), 404)
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
def kid_tasks_put(parent_id, kid_id, task_id):
    image = request.json.get('image')
    comment = request.json.get('comment')

    query_db("UPDATE task SET url ='" + image + "', comment='" + comment + "', completed='1' WHERE id ='" + str(task_id) + "'")

    curr = query_db("SELECT * FROM Task WHERE id = '" + str(task_id) + "'", one=True)

    if curr is not None:
        response = {'task_id': curr[0], 'summary': curr[1], 'reward': curr[2], 'status': curr[3],'comment':curr[4]}

        return make_response(jsonify(response), 200)


"""
   AUTHORIZATION HEADER - EMAIL & PASSWORD
   Kid tasks (POST) (verify if the task is done) -
            request-
            {
                "verify": "VALUE",
            }


      response - 200

"""


@app.route('/parent/<int:parent_id>/kid/<int:kid_id>/task/<int:task_id>/verify', methods=['PUT'])
@auth.login_required
def parants_tasks_put(parent_id, kid_id, task_id):
    verify = request.json.get('verify')
    if verify == 'True':
        query_db("UPDATE task SET completed='2' WHERE id ='" + str(task_id) + "'")

        curr = query_db("SELECT * FROM Task WHERE id = '" + str(task_id) + "'", one=True)

        if curr is not None:
            response = {'task_id': curr[0], 'summary': curr[1], 'reward': curr[2], 'status': curr[3], 'comment': curr[4]}

            return make_response(jsonify(response), 200)

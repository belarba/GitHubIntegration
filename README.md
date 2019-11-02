Fork this repository then run

```bundle install```

start the rails server with

```rails s```

use some API app as Postman or Insomnia

1 - Create an user

```
Add a POST call using this path: http://localhost:3000/users
```
Pass, as Params, **name**, **username**, **email**, **password** and **confirm_password**

Send it.

You should recieve and information saying the user is created

2 - Log in

```
Add a POST call using this path http://localhost:3000/auth/login
```

Pass, as Params, **email** and **password**

You should recieve a **token** and some other informations

3 - Let's consult on GitHub

```
Add a POST call using this path localhost:3000/api/v1/find
```

Add the **token** as *header* param *Authorize*

Add one of the follows filters on Params:
**free_text** = will search by whatever you type
**username** = will find this specify user
**language** = will specify the language of the repos of result

You can sort by (just add the key and 1 to value):
**sort_by_star**, **sort_by_fork** or **sort_by_date**

And you can define if result is **order_by** = asc or **order_by**=desc

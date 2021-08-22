# Restful Api TEST - HUNG NGUYEN TON

## Installation
* If you don't have Ruby, install it (e.g., by using rvm and when you finish, just run this:
```sh
gem install bundler
bundle install
```

* Then configure database (it uses sqlite3 by default) in config/databse.yml and run migrations and seeds:
```sh
rails db:migrate
rails db:seed
```

* Seeds adds 2 users (fixed):
```sh
Admin: admin@example.com / 123456
Member: member@example.com / 123456
```

## API

**1. Get token (to login send):**
```sh
POST /api/v1/tokens

{
  "email": "admin@example.com", # or member@example.com
  "password": "123456"
}
```

**2. User - List:**
```sh
GET /api/v1/users

{
  "keyword": "",
  "page": "1",
  "per_page": "10"
}
```

**3. User - Details (Show):**
```sh
GET /api/v1/users/1
```

**4. User - Create:**
```sh
POST /api/v1/users

{
  "user": {
    "email": "user@example.com",
    "password":"secret@",
    "name": "Hung Nguyen",
    "role": "admin" # user
  }
}
```

**5. User - Update/Edit:**
```sh
PATCH /api/v1/users/1

{
  "user": {
    "email": "user@example.com",
    "password":"secret@",
    "role": "admin"
  }
}
```

**6. User - Delete:**
```sh
DELETE /api/v1/users/1
```

**7. User - Block:**
```sh
PUT /api/v1/users/1/block
```

**8. User - Unlock:**
```sh
PUT /api/v1/users/1/unblock
```

**9. Blog - List:**
```sh
GET /api/v1/blogs

{
  "keyword": "",
  "page": "1",
  "per_page": "5"
}
```

**10. Blog - Details (Show):**
```sh
GET /api/v1/blogs/1
```

**11. Blog - Create:**
```sh
POST /api/v1/tokens

{
  "blog": {
    "title": "Aenean ut erat lorem", 
    "content": "Pellentesque lobortis nulla nisl, vitae viverra leo consequat sit amet."
  }
}
```

**12. Blog - Update/Edit:**
```sh
PATCH /api/v1/blogs/1

{
  "blog": {
    "title": "Aenean ut erat lorem", 
    "content": "Pellentesque lobortis nulla nisl, vitae viverra leo consequat sit amet."
  }
}
```

**13. Blog - Publish:**
```sh
PUT /api/v1/blogs/1/publish
```

**14. Blog - Un-publish:**
```sh
PUT /api/v1/blogs/1/unpublish
```

**15. Blog - Like:**
```sh
PUT /api/v1/blogs/1/like
```

**16. Blog - Unlike:**
```sh
PUT /api/v1/blogs/1/unlike
```

**17. Blog - Featured List (Most likes)**
```sh
GET /api/v1/blogs/featured_list

{
  "top": "2",
  "page": "1",
  "per_page": "5"
}
```

**Note:** Run rails routes to see the full list of routes. articles and users follows the general REST CRUD scheme.

## Run Server
```sh
rails s
```
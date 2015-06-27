###Map-Route API Docs

base_url: 

`https://nameless-forest-6621.herokuapp.com/`

Authorization occurs by passing the key `Access-Token` with the value of the token in the header of the POST request.  All requests must be validated with a token.

Quick find:

####Users
* [User Registration](#user-registration)
`POST '/users/register'`
* [Log In](#log-in)
`POST /users/login`

####Trips
* [Create a Trip](#create-a-post)
`POST /trips`
* [Get the Current User's Trips](#get-a-current-users-trips)
`GET /trips/:trip_id`

####Locations
* [Create a Location](#create-a-location)
`POST /trips/:trip_id/locations`
* [Get Locations on a Trip](#get-locations-on-a-trip)
`GET /posts/:id/guesses`

###Users
***
####User Registration
`POST '/users/register'`

* **Required Params:**
  * `username: string`
  * `email: string`
  * `password: string`
  * `address: string`
  * `city:string`
  * `state:string`
  * `zipcode:string`

* Optional Params (not yet implemented):
	* first name
	* last name

* Response: 
  * Status Code: 201 success, 422 unsuccessful

* Example success:

```json

{
  "username": "taylor_d1",
  "email": "taylor@test1.com",
  "access_token": "0511839909f6b21a5370af54c0ad84bf",
  "id": 2
}

```

***

####Log In

`POST '/users/login'`

* **Required Params:**
  * `username: string`
  * `password: string`

* Response: 
  * Status Code: 201 success, 422 unsuccessful

* Example success:

```json

{
  "username": "taylor_d1",
  "email": "taylor@test1.com",
  "access_token": "0511839909f6b21a5370af54c0ad84bf",
  "id": 2
}
```

***
###Trips
***
####Create a Trip

`POST '/trips'`

* **Required Params:**
  * `title: string`

* Response: 
  * Status Code: 201 success, 422 unsuccessful

* Example success:

```json
```

***
####Get the Current User's Trips

`GET '/trips'`

* **Required Params:**
  * `title: string`

* Response: 
  * Status Code: 202 success, 404 unsuccessful

* Example success:

```json
[
  {
    "id": 2,
    "title": "groceries",
    "user_id": 3,
    "created_at": "2015-06-27T15:08:41.561Z",
    "updated_at": "2015-06-27T15:08:41.561Z"
  },
  {
    "id": 3,
    "title": "errand",
    "user_id": 3,
    "created_at": "2015-06-27T15:22:47.695Z",
    "updated_at": "2015-06-27T15:22:47.695Z"
  },
  {
    "id": 4,
    "title": "houses",
    "user_id": 3,
    "created_at": "2015-06-27T15:25:01.933Z",
    "updated_at": "2015-06-27T15:25:01.933Z"
  },
  {
    "id": 5,
    "title": "vacation",
    "user_id": 3,
    "created_at": "2015-06-27T15:28:12.837Z",
    "updated_at": "2015-06-27T15:28:12.837Z"
  },
  {
    "id": 6,
    "title": "Rome",
    "user_id": 3,
    "created_at": "2015-06-27T15:29:19.520Z",
    "updated_at": "2015-06-27T15:29:19.520Z"
  },
  {
    "id": 7,
    "title": "underworld",
    "user_id": 3,
    "created_at": "2015-06-27T15:30:03.343Z",
    "updated_at": "2015-06-27T15:30:03.343Z"
  },
  {
    "id": 8,
    "title": "7th Circle of Hell",
    "user_id": 3,
    "created_at": "2015-06-27T15:30:35.186Z",
    "updated_at": "2015-06-27T15:30:35.186Z"
  }
]
```


***
###Locations
***
####Create a Location

`POST '/trips/:trip_id/locations'`

* **Required Params:**
  * `name: string`
  * `street:string`
  * `city:string`
  * `state:string`
  * `zipcode:string`

* Response: 
  * Status Code: 201 success, 422 unsuccessful

* Example success:

```json
{
  "id": 7,
  "name": "kroger",
  "lat": 33.7523226,
  "lng": -84.3926305,
  "trip_id": 2,
  "created_at": "2015-06-27T15:17:24.099Z",
  "updated_at": "2015-06-27T15:17:24.099Z",
  "street": "150 MLK Jr Dr NW",
  "city": "Atlanta",
  "state": "GA",
  "zipcode": "30303",
  "user_id": null,
  "origin_id": null,
  "dest_id": null
}

```


***
####Get Locations on a Trip

`GET '/trips/:trip_id/locations'`

* **Required Params:**
  * `title: string`

* Response: 
  * Status Code: 202 success, 404 unsuccessful

* Example success:

```json
[
  {
    "id": 7,
    "name": "Iron Yard",
    "lat": 33.7523226,
    "lng": -84.3926305,
    "trip_id": 2,
    "created_at": "2015-06-27T15:17:24.099Z",
    "updated_at": "2015-06-27T15:33:55.017Z",
    "street": "150 MLK Jr Dr NW",
    "city": "Atlanta",
    "state": "GA",
    "zipcode": "30303",
    "user_id": null,
    "origin_id": null,
    "dest_id": 9
  },
  {
    "id": 8,
    "name": "Iron Yard",
    "lat": 33.7523226,
    "lng": -84.3926305,
    "trip_id": 2,
    "created_at": "2015-06-27T16:15:27.014Z",
    "updated_at": "2015-06-27T16:15:27.014Z",
    "street": "150 MLK Jr Dr NW",
    "city": "Atlanta",
    "state": "GA",
    "zipcode": "30303",
    "user_id": null,
    "origin_id": null,
    "dest_id": null
  },
  {
    "id": 9,
    "name": "Iron Yard",
    "lat": 33.7523226,
    "lng": -84.3926305,
    "trip_id": 2,
    "created_at": "2015-06-27T16:15:28.118Z",
    "updated_at": "2015-06-27T16:15:28.118Z",
    "street": "150 MLK Jr Dr NW",
    "city": "Atlanta",
    "state": "GA",
    "zipcode": "30303",
    "user_id": null,
    "origin_id": null,
    "dest_id": null
  }
]


```



# API

Base URL is a top secret stuff. If you are the one who refers to that API, chances are that I've already provided base URL to ya. 

## Endpoints

1. /people - GET.
    Returns list of people.
    
    Respnse example:
    ```
    [
        {
            "id": 1,
            "name": "SomeName1"
        },
        {
            "id": 2,
            "name": "SomeName2",
            "relation": "Relation",
            "avatar": "$BASE_URL/path/to/image/got/from/posting/image"
        }
    ]
    ```
    
2. /people - POST.
    Creates and returns new person.
    
    Body parameters:
    - name: String
    - relation: String (optional)
    - avatar: String (optional)
    
    Response example:
    ```
    {
        "id": 1,
        "name": "SomeName2",
        "relation": "Relation",
        "avatar": "$BASE_URL/path/to/image/got/from/posting/image"
    }
    ```

3. /people/:personId/debts - GET.
    Returns a list of debts for selected person
    
    Path parameters:
    - personId: Int. Person identifier
    
    Response example:
    ```
    [
        {
            "id": 1,
            "value": 400,
            "personId": 1,
            "description": "For coffee in Starbucks",
            "date": "2019-07-03T12:20:40Z"
        },
        {
            "id": 2,
            "value": 300,
            "personId": 1,
            "date": "2019-07-03T12:20:40Z"
        }
    ]
    ```

4. /people/:personId/debts - POST.
    Creates a new debt for selected person.
    
    Path parameters:
    - personId: Int. Person identifier
    
    Body parameters:
    - value: Int
    - date: Double (timestamp for selected date. Please refer to 'timeIntervalSinceReferenceDate' property of Date object)
    - description: String (optional)
    
    Response example:
    ```
    {
        "personId": 1,
        "id": 2,
        "value": 400,
        "date": "2019-07-03T12:20:40Z",
        "description": "For coffee in Starbucks "
    }
    ```
    
5. /people/:personId - DELETE.
    Deletes individual person
    
    Path parameters:
    - personId: Int. Person identifier
    
    Response:
    Status code 200
    
6. /debts/:debtId - DELETE
    Deletes individual debt
    
    Path parameters:
    - debtId: Int. Debt identifier
    
    Response:
    Status code 200
    
7. /image - POST
    Uploads an image to server. Body type should be binary
    
    Response:
    
    ```
    "url": String // (Uploaded image accessible from this url)
    ```


### Notice:
For all endpoints please following headers: 
"Content-Type": "application/x-www-form-urlencoded"

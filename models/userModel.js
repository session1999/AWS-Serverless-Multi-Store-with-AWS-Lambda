///Import the required aws sdk module to interact with dynamoDB

const {DynamoDBClient, PutItemCommand} = require("@aws-sdk/client-dynamodb");

const {v4: uuidv4} = require("uuid");

//Ini

const dynamoDBClient = new DynamoDBClient({region: "eu-north-1"});

const TABLE_NAME = "Users";

//User model class to represent a user and handle database operation

class UserModel{
    constructor(email, fullName){
        this.email = email; 
        this.fullName=fullName;
        this.userId = uuidv4();
        this.createdAt = new Date().toISOString();
    }

    //Save user data to dynamoDB
    async save(){
        const params = {
            TableName: TABLE_NAME,
            Item: {
                userId: {S: this.userId},
                email: {S: this.email},
                fullName: {S: this.fullName},
                createdAt: {S: this.createdAt}
            }
        };

        try {
            await dynamoDBClient.send(new PutItemCommand(params));

            
        } catch (error) {
            throw error;
            
        }
    }
}

module.exports = UserModel;
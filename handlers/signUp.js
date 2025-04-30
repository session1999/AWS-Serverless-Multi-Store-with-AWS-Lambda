// Import the required AWS SDK modules to interact with Amazon Cognito
const { CognitoIdentityProviderClient, SignUpCommand } = require("@aws-sdk/client-cognito-identity-provider");

// Initialize Cognito client with our AWS Region
const client = new CognitoIdentityProviderClient({ region: "eu-north-1" });

const UserModel = require("../models/userModel");

// Define Cognito App client ID for user pool authentication
const CLIENT_ID = process.env.CLIENT_ID;

// Create signup function to sign up users
exports.SignUp = async (event) => {
    // Parse the incoming request body to extract user data
    const { email, fullName, password } = JSON.parse(event.body);

    // Configure parameters for Cognito sign-up command
    const params = {
        ClientId: CLIENT_ID,
        Username: email, 
        Password: password,
        UserAttributes: [
            { Name: "email", Value: email },
            { Name: "name", Value: fullName },
        ],
    };

    try {
        // Create user in Cognito user pool
        // the Signupcommand is calling the signupcommand up at the very top
        //the params is telling the signupcommand that these are the parameters we want
        const command = new SignUpCommand(params);

        // Execute the sign-up request 
        await client.send(command);
        //Calling the user model
        const newUser =  new UserModel(email,password);
        
        await newUser.save();

        
        return {
            statusCode: 200,
            body: JSON.stringify({ msg: "Account created, please verify your email!" }),
        };

    } catch (error) {
        console.error("Signup error:", error);
        return {
            statusCode: 500,
            body: JSON.stringify({ msg: error.message || "Internal Server Error" }),
        };
    }
    
};



const {CognitoIdentityProviderClient, InitiateAuthCommand} = require("@aws-sdk/client-cognito-identity-provider");

// Initialize Cognito client with our AWS Region
const client = new CognitoIdentityProviderClient({region: "eu-north-1"});

// Define Cognito App client ID for user pool authentication
const CLIENT_ID = process.env.CLIENT_ID;

// Create function to confirm signed up users
exports.SigninUsers = async(event) =>{
    const {email, password} = JSON.parse(event.body);

    //variable to confirm user
    const params = {
        ClientId: CLIENT_ID,// tells AWS the cognito the user is interacting with
        AuthFlow: "USER_PASSWORD_AUTH", //Auth flow for username/password
        AuthParameters:{
        USERNAME: email,
        PASSWORD:password,

        } 
        

    };

    try{
       const  command =new InitiateAuthCommand(params);
       const response = await client.send(command); // this will execute the auth parameters request

       return {
        statusCode:200,
        body: JSON.stringify({msg: "Logged in", 
        tokens: response.AuthenticationResult, //This will contain the accessToken, RefreshToken and idToken
    
    },),
       }
    }
    catch(error){

        return {
            statusCode:500,
            body: JSON.stringify({error: error.message}),
           }

    }
}
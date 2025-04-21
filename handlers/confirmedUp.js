const {CognitoIdentityProviderClient, ConfirmSignUpCommand} = require("@aws-sdk/client-cognito-identity-provider");

// Initialize Cognito client with our AWS Region
const client = new CognitoIdentityProviderClient({region: "eu-north-1"});

// Define Cognito App client ID for user pool authentication
const CLIENT_ID = process.env.CLIENT_ID;


// Create function to confirm signed up users
exports.ConfirmedSignUp = async(event) =>{
    const {email, confirmationCode} = JSON.parse(event.body);

    //variable to confirm user
    const params = {
        ClientId: CLIENT_ID,
        Username: email,
        ConfirmationCode: confirmationCode,

    };

    try{
       const  command =new ConfirmSignUpCommand(params);
       await client.send(command);

       return {
        statusCode:200,
        body: JSON.stringify({msg: "Use successfully confirmed"})
       }
    }
    catch(error){

        return {
            statusCode:200,
            body: JSON.stringify({error: error.message}),
           }

    }
}
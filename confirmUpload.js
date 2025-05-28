const {DynamoDBClient,PutItemCommand} = require("@aws-sdk/client-dynamodb");

//Initialize Dynamo Cleint with the aws region

const dynamodbClient = new DynamoDBClient({region: "eu-north-1"});


//Lambda function to confirm file upload and store metadata in DynamoDB
exports.confirmUpload = async(event) => {

    try {
        
        const tableName = "Banners";
        const bucketName = "banner-images-aptechclass-1999";

        //Extract the file name from S3 event - extracting what was uploaded
        const record = event.Records[0];

        //extracting the file name from s3 event
        const fileName = record.s3.object.key;

        //How the image will be accessed - construct the public url for the uploaded file
        const imageUrl = `https://${bucketName}.s3.amazonaws.com/${fileName}`;

        //prepare the file metadata to upload in dynamoDB
        const putItemCommand = new PutItemCommand({
            TableName: tableName,
            Item:{
                fileName:{S: fileName},
                imageUrl: {S: imageUrl},
                uploadedAt: {S: new Date().toISOString},
            }
        })

        //save file metadata to DynamoDB
        await dynamodbClient.send(putItemCommand);

        return{
            statusCode:200,
            body: JSON.stringify({msg:"file uploaded & confirmed"}),
        }


    } catch (error) {
        
        return{
            statusCode:500,
            body: JSON.stringify({msg:error.message}),
        }
    }
}






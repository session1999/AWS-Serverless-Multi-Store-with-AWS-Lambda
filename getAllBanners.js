//Import the required aws sdk to interact with dynamoDB

const {DynamoDBClient, ScanCommand} = require("@aws-sdk/client-dynamodb");

//initalize the dynamodb client with our aws region
const dynamoDbClient = new DynamoDBClient({region: "eu-north-1"})

//lambda function to retrieve all banners from dynamodb table
exports.getAllBanners = async() =>{

    try {
        const tableName = process.env.DYNAMODB_TABLE;

        //create a scanCommand to fetch all items(banners) from the table
        const scanCommand = new ScanCommand({
            TableName: tableName,
        });

        //excute the scan command to fetch banner items
       const{Items} = await dynamoDbClient.send(scanCommand);

        //if no items are found, rturn an empty list with a message
        if(!Items || Items.length==0){

            return {
                statusCode: 400,
                body: JSON.stringify({msg:"No Banners found"}),
            }
        }
        //format the retrieved banners items into readable Json response
        const banners = Items.map(item=> ({
            imageUrl : item.imageUrl.S,
            fileName: item.fileName.S,
        }))
        return{
            statudCode: 200,
            body: JSON.stringify(banners)
        }
        
    } catch (error) {
        return{
            statudCode: 500,
            body: JSON.stringify({error:error.message}),
        }
        
    }
}
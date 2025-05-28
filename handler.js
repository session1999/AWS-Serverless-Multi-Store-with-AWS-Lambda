//import the required AWS SDK modules needed to interact with S3

const {S3Client, PutObjectCommand} = require("@aws-sdk/client-s3");
const { getSignedUrl } = require("@aws-sdk/s3-request-presigner");


const s3client = new S3Client({
  region: "eu-north-1"
})

//create a lambda function to generate the presigned url which will be used to upload to file to s3
exports.getSignedUrl = async(event)=>{



  try {
      const bucketName = "banner-images-aptechclass-1999";

      const {fileName, fileType} = JSON.parse(event.body);

      //Validate that both filename and fileType are provided
      if(!fileName || !fileType){
        return{
          statusCode:400,
          body:JSON.stringify({error: "Filename and Type are require"})
        }
      }

      //create an s3 putObjectCommand with bucket key
      const command = new PutObjectCommand({
        Bucket:bucketName,
        Key: fileName,
        ContentType: fileName,
      });

      //Generate a presigned url that expires in 3600
      const signedUrl= await getSignedUrl(s3client, command, {expiresIn:3600});

      return{
        statusCode:200,
        body:JSON.stringify({uploadUrl: signedUrl}),
      }



  } catch (error) {
    return{
      statusCode: 500,
      body:JSON.stringify({error: error.message})
    }
    
  }
}
# user-uploader
A basic Ruby applet to take data from a CSV file and add it to an application via an API

## Configuration File
The applet is configured by a config.json file and requires the following values to function...
- csvFilepath - the relative path to the csv file containing your data.  
*For example "example-data.csv".*
- allowableHeaders - An array of strings representing the csv header values that the applet should expect to find in the csv file.   
*For example ["firstname", "lastname", "address_number", "address_firstline", "postcode"]*
- map - A hash map of key-value pairs, where the keys are headers from the allowableHeaders list and the values, the desired property from the requestTemplate. For nested data values use dot notation.  
*For example - In the example set up, the address object is nested within the user profile object. To update the addresses postcode property we'd specify "address.postcode"*
- requestTemplate - The template (or schema) for the body of the api request to be made.

## Example-Data.csv
For my own personal use i have created an example-data.csv which uses data based on user profiles. Feel free to use this to play around with the app or create your own.

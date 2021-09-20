class CsvToApiMapConfig

    # Constructor
    def initialize(configFile)
        read_config(configFile)
        if load_data() == 0
            #handle error
        end
    end

    def read_config(filepath)
        
        puts "Reading Configuration File"

        require 'json'
        data = JSON.parse(File.read(filepath))

        @allowableHeaders = data["allowableHeaders"]
        @map = data["map"]
        @requestTemplate = data["requestTemplate"]
        @sourceFilename = data["csvFilepath"]
    end

    def load_data()
        puts "Loading Data"

        # load CSV handler and read in csv file
        require("csv")
        csvArr = CSV.read(@sourceFilename)

        # create an array for the csv headers
        headers = csvArr[0]

        # verify the headers match the allowable headers list from the map config file (order must match aswell)
        if(headers != @allowableHeaders)
            puts "File headers do not match the allowable headers list: #{headers}"
            return 0
        end

        #prcoess the data passing through the rest of the data set.
        if processData(csvArr[1..]) == 0
            #handle error
            return 0
        end
    end

    def processData(data)

        puts "Processing Data"

        requestBody = @requestTemplate

        #maybe validate that the data object passed through is a 3d array
        data.each { |row| 
            row.each_with_index { | item, index | 
                #get the apiPropName by first getting the csvPropName from allowable headers and then looking it up in the map
                apiPropName = @map[@allowableHeaders[index]]
                
                # store the value within the relvant part of the request body
                if apiPropName.split(".").length() > 1
                    evalString = "requestBody#{SplitDotNotationToEvalString(apiPropName)} = item"
                    eval(evalString)
                else
                    requestBody[apiPropName] = item
                end
            }
            
            puts "\t\tRequest body generated: #{requestBody}"
        }
    end

    def SplitDotNotationToEvalString(dotString)
        
        evalString = ""

        #create eval string 
        dotString.split(".").each { |prop| evalString += "['#{prop}']" }

        return evalString
    end
end


config = CsvToApiMapConfig.new("./config.json")

puts "Press RETURN when you're done."
gets




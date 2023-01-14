require 'openai'
require 'ruby/openai'
require 'date'
require 'open-uri'
require 'httparty'
require 'net/http'
require 'rmagick'

#created by Christopher Bradford. Please connect through Github with questions or contributions.

# Setup the OpenAI client

api_key = ENV['OPEN_API_KEY']
client = OpenAI::Client.new(access_token: api_key)
# Get the current timestamp
timestamp = DateTime.now.strftime("%Y-%m-%d %H:%M:%S")

# Ask the user for the name of the folder to save the results in
print "Enter the name of the folder to save the results in: "
folder_name = gets.chomp

# Create the "chatGPT_results" folder if it doesn't exist
Dir.mkdir("chatGPT_results") unless Dir.exist?("chatGPT_results")

# Create the user-specified folder if it doesn't exist
Dir.mkdir("chatGPT_results/#{folder_name}") unless Dir.exist?("chatGPT_results/#{folder_name}")

# Initialize a variable to keep track of the number of files saved
file_count = 1

# Continuously prompt the user for a question or action
while true do
    print "What would you like to do? (ask/image/exit): "
    input = gets.chomp
    break if input.downcase == 'exit'
    if input.downcase == 'ask'
        while true do
            # Ask the user for a question
            print "Please ask a question: "
            question = gets.chomp
            # Send the question to the OpenAI API
            response = client.completions(
                parameters:{
                model: "text-davinci-002",
                prompt: question,
                temperature: 0.5,
                max_tokens: 1024}
            )
            # Extract the generated text
            generated_text = response['choices'][0]['text']
            # Print the generated text to the console
            puts generated_text
            # Save the generated text to a file
            filename = "chatGPT_results/#{folder_name}/result_#{file_count}.txt"
            File.write(filename, generated_text)
            file_count += 1
            # Prompt the user to ask another question or exit
            print "What would you like to do next? (ask/exit): "
            next_action = gets.chomp
            break if next_action.downcase == 'exit'
        end
    elsif input.downcase == 'image'
        while true do
            print "Please provide a description of the image you want to see: "
            imageDesc = gets.chomp
            #Send the request to the Dall-E API
            
             response = client.images.generate(parameters: { prompt: imageDesc, size: "512x512" })

             if response.body.nil? || response.body.empty?
              puts "Error: API returned no response"
             elsif response.code != 200
             puts "Error: #{response.code} - #{response.message}"
             break
             elsif response.parsed_response['errors']
             puts "Error: #{response.parsed_response['errors'].first['message']}"
             break
             else
            # Extract the URL of the generated image
            image_url = response.dig("data", 0, "url")
            
            image = Magick::ImageList.new(image_url)
 
            # Display the image
            image.display
            
            # Ask the user if they want to save the image
            print "Would you like to save the image? (Y/N): "
            save_response = gets.chomp
            if save_response.downcase == 'y'
                # Save the image to a file
                filename = "chatGPT_results/#{folder_name}/image_#{file_count}.jpg"
                image.write(filename)
                file_count += 1
            end
            # Prompt the user to ask another question or exit
            print "What would you like to do next? (image/exit): "
            next_action = gets.chomp
            break if next_action.downcase == 'exit'
        end
      end
    else
        puts "Invalid input, please enter 'ask', 'image', or 'exit'."
    end
end



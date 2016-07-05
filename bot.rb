require 'facebook/messenger'

# 1
Facebook::Messenger.configure do |config|
  config.access_token = ENV['ACCESS_TOKEN']
  config.verify_token = ENV['VERIFY_TOKEN']
end

include Facebook::Messenger

# 2
Bot.on :message do |message|
  puts "Received #{message.text} from #{message.sender}"

  Bot.deliver(
    recipient: message.sender,
    message: {
      text: "Oh Hello, would you like to see Hello world in which language?"
    }
  )

  Bot.deliver(
    recipient: message.sender,
    message: {
      attachment: {
        type: 'template',
        payload: {
          template_type: 'button',
          text: 'What service would you like to log in with?',
          buttons: [
            { type: 'postback', title: 'French', payload: 'FRENCH' },
            { type: 'postback', title: 'Italian', payload: 'ITALIAN' }
          ]
        }
      }
    }
  )
end

# 3
Bot.on :postback  do |postback|

  case postback.payload
  when 'FRENCH'
    text = "Bonjour le monde 🇫🇷"
  when 'INTALIAN'
    text = "Ciao mondo 🇮🇹"
  end

  Bot.deliver(
    recipient: postback.sender,
    message: {
      text: text
    }
  )
end
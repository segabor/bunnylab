require 'starling'
require 'json/pure'
require 'xmpp4r'
require 'xmpp4r/roster'
require 'cgi'
class Fleebie
  include Jabber
  attr_accessor :jid, :password
  attr_reader :client, :roster

  def initialize
    self.jid = ARGV[0]
    self.password = ARGV[1]
    @client = Client.new(self.jid)
    Jabber::debug = true
    connect
  end

  def connect
    @client.connect
    @client.auth(@password)
    @client.send(Presence.new.set_type(:available))

    #the "roster" is our bot contact list
    @roster = Roster::Helper.new(@client)

    #...to accept new subscriptions
    start_subscription_callback

    #...to do something with the messages we receive
    start_message_callback

    #When the backend application has done its job, it tells the listener
    #via the "listener" message queue.
    process_queue
  end

  private

  #Whatever we receive, we send it to our "backend" message queue. It's
  #not our job to parse and decode the actual message
  def start_message_callback
    @client.add_message_callback do |m|

      @starling.set('backend',{
        :from => m.from,
        :body => m.body
      }.to_json
      ) unless m.composing? || m.body.to_s.strip == ""

    end
  end


  #whenever someone adds the bot to his contact list, it gets here
  def start_subscription_callback
    @roster.add_subscription_request_callback do |item,pres|
      #we accept everyone
      @roster.accept_subscription(pres.from)

      #Now it's our turn to send a subscription request
      x = Presence.new.set_type(:subscribe).set_to(pres.from)
      @client.send(x)

      #let's greet our new user
      m=Message::new
      m.to = pres.from
      m.body = "Welcome! Type a location to get the weather forecast"
      @client.send(m)
    end
  end

  #The backend application talks to this XMPP interface via starling.
  #in process_queue we process our job list.
  def process_queue
    @starling = Starling.new('127.0.0.1:11211')
    th = Thread.new do
      Thread.current.abort_on_exception = true
      loop do
        item = @starling.get('listener')
        unless item.nil?
          jitem = JSON.parse(item) rescue nil
          msg = Message::new(jitem["from"])
          msg.type=:chat
          if jitem["success"] == true
            msg.body = "\n"
            msg.body += jitem["message"] + "\n"
            msg.body += "Current temp: #{jitem["details"]["current_temperature"]}\n"
            msg.body += "Winds: #{jitem["details"]["winds"]}\n\n"
            msg.body += "<b>TODAY</b>\n"
            msg.body += jitem["details"]["today"]["condition"] + "\n"
            msg.body += "Min/Max : #{jitem["details"]["today"]["low_f"]} / "
            msg.body += jitem["details"]["today"]["high_f"] + " ("
            msg.body += jitem["details"]["today"]["low_c"] + " / "
            msg.body += jitem["details"]["today"]["high_c"] + ") \n\n"

            msg.body += "<b>TOMORROW</b>\n"
            msg.body += jitem["details"]["tomorrow"]["condition"] + "\n"
            msg.body += "Min/Max : #{jitem["details"]["tomorrow"]["low_f"]} /"
            msg.body += jitem["details"]["tomorrow"]["high_f"] + " ("
            msg.body += jitem["details"]["tomorrow"]["low_c"] + " / "
            msg.body += jitem["details"]["tomorrow"]["high_c"] + ") \n"

            msg.add_element(prepare_html(msg.body))
            msg.body = msg.body.gsub(/<.*?>/, '')
          else
            msg.body = jitem["message"]
          end
          @client.send(msg)

        end
      end
    end
  end

  def prepare_html(text)
    h = REXML::Element::new("html")
    h.add_namespace('http://jabber.org/protocol/xhtml-im')

    # The body part with the correct namespace
    b = REXML::Element::new("body")
    b.add_namespace('http://www.w3.org/1999/xhtml')

    # The html itself
    t = REXML::Text.new(text.gsub("\n","<br />"), false, nil, true, nil, %r/.^/ )

    # Add the html text to the body, and the body to the html element
    b.add(t)
    h.add(b)
    h
  end


end

Fleebie.new
Thread.stop

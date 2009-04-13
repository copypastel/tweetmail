require 'rubygems'
require 'twitter'
require '../lib/twitter_ext'

include TwitterExt

describe Twitter.extend(TwitterExt) do

  describe Reply do

    before :all do
      @reply = Reply.new( 'ecin', 'daicoden', 'bar')
    end

    it "should hold a :from attribute" do
      @reply.from.should eql('ecin')
    end

    it "should hold a :message and :msg attribute" do
      @reply.message.should eql('bar')
      @reply.msg.should eql('bar')
    end
    
    it "should hold a :to attribute" do
      @reply.to.should eql('daicoden')
    end

  end

  describe Twitter::Replies() do

    before :all do
      @username = 'ecin'
      @replies = Twitter::Replies(@username)
    end

    it "should return a list of replies" do
      @replies.each do |r|
        r.class.should be(Reply)
      end
    end

    it "should return replies that contain /@username/" do
      filter = Regexp.new( '@' + @username)
      @replies.each do |r|
        (r.msg =~ filter).class.should be(Fixnum)
      end
    end

    it "should return replies from valid users" do
      @replies.each do |r|
        r.from.should_not be(nil)
      end
    end

    it "should return replies with message bodies" do
      @replies.each do |r|
        r.message.should_not be(nil)
      end
    end

  end

end
module Tweetmail
  module TwitterExt
  
    class Reply < Struct.new(:id, :from, :to, :message, :when)
      alias :msg :message
      alias :when? :when
    end
  
    def Replies(username = nil, since = nil)
      return [] if username.nil?
      replies = []
      Twitter::Search.new.to(username).since(since).each do |t| 
        replies << Reply.new( t.id, t.from_user, t.to_user, t.text, Time.parse(t.created_at) )
      end
      replies
    end
  end
end
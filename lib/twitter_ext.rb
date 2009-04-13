module TwitterExt
  
  class Reply < Struct.new(:from, :to, :message)
    alias :msg :message
  end
  
  def Replies(username = nil)
    return [] if username.nil?
    replies = []
    Twitter::Search.new.to(username).each {|t| replies << Reply.new(t.from_user, t.to_user, t.text)}
    replies
  end
  
end
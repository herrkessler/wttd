class WhatToDoToday < Sinatra::Base

  # Dashboard
  # -----------------------------------------------------------

   get '/dashboard' do
    # env['warden'].authenticate!
    authorize!
    slim :"dashboard/index"
    # if env['warden'].user.admin?
      # @users = User.all
      # @pois = Poi.all
      # @chats = Conversation.all
      # @messages = Message.all
      # @conversations = Conversation.all
      # @friends = Friendship.all
      # @poi_user = PoiUser.all


      # # Redis
      # # -----------------------------------------------------------

      # # @online_redis_users = $redis.scard('online_users')

      # # User Stats
      # # -----------------------------------------------------------

      # @online_users = @users.all(:status => :online).length
      # @offline_users = @users.all(:status => :offline).length
      # @idle_users = @users.all(:status => :idle).length

      # # Find User with most friendships
      # # -----------------------------------------------------------

      # friend_user = Hash.new 0
      # user_friend = Hash.new 0
      # @friends.each do |friend|
      #   friend_user[friend.user_id] += 1
      # end
      # @friends.each do |friend|
      #   user_friend[friend.friend_id] += 1
      # end
      # result_1 = friend_user.max_by{|k,v| v}
      # result_2 = user_friend.max_by{|k,v| v}
      # final_result = []
      # final_result << user_friend
      # final_result << friend_user
      # sorted_final_results = final_result.inject{|memo, el| memo.merge( el ){|k, old_v, new_v| old_v + new_v}}
      # user_with_most_friends = sorted_final_results.max_by{ |k,v| v }[0]
      # @most_friends = User.get(user_with_most_friends)

      # # Find User with most messages
      # # -----------------------------------------------------------

      # messages_user = Hash.new 0
      # @messages.each do |message|
      #   messages_user[message.sender] += 1
      # end
      # user_with_most_messages = messages_user.max_by{ |k,v| v }[0]
      # @messages_amount = messages_user.max_by{ |k,v| v }[1]
      # @most_messages = User.get(user_with_most_messages)

      # # poi Stats
      # # -----------------------------------------------------------

      # most_active_poi_hash = @poi_user.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
      # most_active_poi_id = most_active_poi_hash.values.max                   
      # @most_active_poi = poi.get(most_active_poi_id)

      # # Email Stats
      # # -----------------------------------------------------------

      # # @email_stats ||=env['warden'].user.conversations.messages.reject { |h| [env['warden'].user.id].include? h['sender'] }.map(&:status) || halt(404)

      # # Render View
      # # -----------------------------------------------------------

     # else 
     #   flash[:error] = "You're not the admin"
     #   redirect to('/')
     # end
    
   end

end
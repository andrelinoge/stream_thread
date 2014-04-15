class Chat

  constructor: (channel_id, user_name) ->
    @event_source    = new EventSource("/channels/#{channel_id}/chats/chat");
    @chat_messages   = $("#chat-messages");
    @message         = $("#message");
    @response        = ''
    @user_name       = user_name

    @initialize_message_sending(user_name)


  initialize_message_sending: (current_user_name) ->
    @event_source.addEventListener 'push-message', (e) =>
      data = JSON.parse(e.data)
      @push_message(data)

    @event_source.addEventListener 'enter-exit-chatroom', (e) =>
      response = JSON.parse(e.data)
      $members = $("<ul cass='nav nav-list'></ul>")

      response.members.forEach (member) ->
        $("<li><a href='#'>#{member}</a></li>").appendTo $members

      $("#channel-members").html $members
      response.username = ""
      @push_message(response)


  push_message: (data) =>
    if data.username == @user_name
      messanger_name  = "You"
      alignment_class = "pull-right"
    else 
      messanger_name  = data.username
      alignment_class = "pull-left"


    $("<div class='span7 clear #{alignment_class}'> \
      <p class='#{data.bg_color}'> \
        <span class='time'> [#{data.time}] </span> \
        <span class='chat-username'>#{messanger_name} : </span> \
        #{data.message} \
      </p> \
    </div>")
      .hide()
      .appendTo(@chat_messages)
      .fadeIn(1000)

    @chat_messages.animate({ scrollTop : @chat_messages.prop("scrollHeight") - @chat_messages.height() }, 500)
    @message.val("")

window.Chat = Chat
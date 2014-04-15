['test_channel_1', 'test_channel_2', 'test_channel_3'].each do |channel_name|
	Channel.create(name: channel_name)
end
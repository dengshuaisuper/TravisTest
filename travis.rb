require 'rubygems'
#require 'nokogiri'
#require 'open-uri'
require 'json'
require 'net/http'
#require 'travis'

#repo =Travis::Repository.current
#puts repo
#ower_repo = system('echo $TRAVIS_REPO_SLUG')
ower_repo = ENV['TRAVIS_REPO_SLUG']
puts ower_repo
#branch = system('echo $TRAVIS_BRANCH')
branch = ENV['TRAVIS_BRANCH']
puts branch
#event_type = system('echo $TRAVIS_EVENT_TYPE')
event_type = ENV['TRAVIS_EVENT_TYPE']
puts event_type

pull_number = "null"
if(event_type == "pull_request")
  pull_number = system('echo $TRAVIS_PULL_REQUEST')
  uri = "https://api.github.com/repos/#{ower_repo}/pulls/pull_number"
  resp = Net::HTTP.get_response(URI.parse(uri))
  jresp = JSON.parse(resp.body)
  puts jresp
end


puts "-------------------------------------------------------------"
#uri = "https://api.github.com/repos/DengShuaiSimon/xcat-core/pulls"
uri = "https://api.github.com/repos/DengShuaiSimon/TravisTest/events"
resp = Net::HTTP.get_response(URI.parse(uri))

jresp = JSON.parse(resp.body)
json = jresp[0]

#puts jresp['title']
puts "event type : #{json['type']}"
puts "repo name : #{json['repo']['name']}"
puts "repo url : #{json['repo']['url']}"
puts "repo branch : #{json['payload']['ref']}"
puts "repo path/name : #{Dir.pwd}"


if(json['type']=="PushEvent")
  puts "payload/commits : #{json['payload']['commits']}"
elsif(json['type']=="PullRequestEvent")
  puts "pull_request title : #{json['payload']['pull_request']['title']}"
  puts "pull_request description : #{json['payload']['pull_request']['body']}"
elsif(json['type']=="IssueCommentEvent")
  puts "issue title : #{json['payload']['issue']['title']}"
  puts "comment body : #{json['payload']['comment']['body']}"
end

#puts "repo url : #{jresp[0]['repo']['url']}"

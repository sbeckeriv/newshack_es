require "rubygems"
require "tire"
require "time"
require "crack"
random_hashes=[{"type"=>"article","title"=>"title","body"=>"body one","address"=>"address","created_at"=>(Time.now).strftime("%FT%TZ"),"city"=>"seattle","zipcode"=>"98103","tags"=>[{"name"=>"one"},{"name"=>"tag2"}],"owner"=>"owner","source"=>"source","id"=>"1"}]

articles=[]

Tire.index 'news' do
  random_hashes.each{|hash|
    if(articles.size>200)
      import articles
      articles=[]
    end
    articles.push(hash)
  }
  puts articles
  import articles 
end
Tire.index 'news' do
  refresh
end
=begin
params={
"start_date"=>(Time.now-604800).strftime("%FT%TZ"),"tags"=>"one"}
if(params["tags"])
match = { "text" => { "body" => { "query" => params["tags"], "operator" => "or" } } }
elsif(params["search"])
match = { "text_phrase" => { "body" => { "query" => params["search"], "operator" => "or" } } }
else
match = {"match_all"=>{}}
end
 geo_box = nil
if(params["sw_long"])
  geo_box= {"geo_bounding_box"=>
    {"location"=>{"top_left"=>[params["sw_long"].to_f,params["ne_lat"].to_f ], "bottom_right"=>[params["ne_long"].to_f,params["sw_lat"].to_f]}}}
end
date_range=nil
if(params["start_date"] || params["end_date"])
  date_range={
    "range"=> {
    "created_at"=> {
    "from"=> params["start_date"],
    "to"=> (params["end_date"]||Time.now.strftime("%FT%TZ"))
  }
  }
  }
end 
owner=nil
if(params["owner"] )
  owner={
    "terms"=> {
    "owner"=> params["owner"]
  }
  }
end 
sources=nil
if(params["source"] )
  sources={
    "terms"=> {
    "source"=> params["source"].split(",")
  }
  }
end
querys = [geo_box,date_range,owner,sources].compact
if(querys.size==1)
  querys = querys.first
else
  querys= {"and"=>querys}
end
size = (params[:size]||10).to_i
from = params["page"].to_i * size
qu = {"size"=>size,
  "from"=>from,
  "query"=>
{"filtered"=>
  {"filter"=>querys,
    "query"=>match}}}
        @results = Tire.search("news",qu )

=end

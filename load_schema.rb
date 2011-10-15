require "rubygems"
require "tire"
require "net/http"
require "pp"
require "uri"
require "date"
require "time"

Tire.index 'news' do
  create :mappings=>{
    "article" => {
        "date_formats" => ["yyyy-MM-dd", "dd-MM-yyyy","basic_date_time_no_millis"],
        "_all" => {"enabled" => true},
        "properties" => {
            "_id" => {"index"=> "not_analyzed", "store" => "yes",:type=>'string'},
            "title" =>  {"type" => "string", "store" => "yes"},
            "body" =>  {"type" => "string", "store" => "yes"},
            "location" => {
                "type" => "geo_point"
            },
            "created_at"=>{"type" => "date"},
            "address"=>{"type"=>"string"},
            "city"=>{"type"=>"string"},
            "zipcode"=>{"type"=>"string"},
            "owner" => {"type" => "string"},
            "source"=>{"type"=>"string"},
            "tags" => {
                "properties" => {
                    "_id" => {"index"=> "not_analyzed", "store" => "yes",:type=>'integer'},
                    "name" => {"type" => "string"}, 
                }
            }
        }
    }
  }
end


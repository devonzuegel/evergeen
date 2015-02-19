class StaticPagesController < ApplicationController

  def home
    at_home = true
    if logged_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end
  
  def help
  end

  def about
    response = HTTParty.get("http://rubygems.org/api/v1/versions/httparty.json")
    test = response[0]['number']
    puts 'test: ' + test
  end

  def mission
    response = HTTParty.get("http://rubygems.org/api/v1/versions/httparty.json")
    test = response[0]['number']
    puts 'test: ' + test
  end

  def contact
  end

end

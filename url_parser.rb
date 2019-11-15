class UrlParser
  attr_reader :new_url, :scheme, :domain, :fragment_id
  def initialize(new_url)
    @new_url = new_url
    @scheme = new_url.split(":").first
    @fragment_id = new_url.split("#").last
  end

  def domain
    @port = new_url.split(":").last.split("/").first
    if @port == "" 
    @domain = @new_url.split("//").last.split("/").first
    else  
    @domain = @new_url.split("//").last.split(":").first   
    end  
  end  

  def port
    @port = new_url.split(":").last.split("/").first
    if @scheme == "https" && @port == ""
      @port = "443"
    elsif @scheme == "http" && @port == ""
      @port = "80"
    else
      @port
    end
  end

  def path
    @path = new_url.split(":").last.split("/").last.split('?').first
    if @path == ""
    nil 
    else
      return @path
    end
  end

  def query_string
    query = new_url.split(":").last.split("/").last.split('?').last
    first_key = query.split('=').first
    first_value = query.split('&').first.split('=').last
    second_key = query.split('&').last.split('=').first
    second_value = query.split('&').last.split('#').first.split('=').last
    @query_string = {first_key => first_value, second_key => second_value}
  end    


end

google = UrlParser.new "http://www.google.com:60/search?q=cat&name=Tim#img=FunnyCat"

p google.scheme
p google.domain
p google.port
p google.path
p google.query_string
p google.fragment_id

github_url = UrlParser.new "https://github.com/search?q=ruby#stuff"

p github_url.scheme
p github_url.domain
p github_url.port
p github_url.path
p github_url.query_string
p github_url.fragment_id


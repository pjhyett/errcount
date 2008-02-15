class Counter < Mongrel::HttpHandler
  Style = ".ctr { background-image:url(http://errcount.com/images/counter.png); float:left; width:15px; height:20px; }"
  
  def process(request, response)
    response.start(200) do |head, out|
      # grab row from db
      id = request.params["PATH_INFO"][/\d+/].to_i
      row = ActiveRecord::Base.connection.select_one("select url, hits from sites where id = #{id}")
      
      # check for correct referrer
      if Regexp.new(row["url"]) =~ request.params["HTTP_REFERER"]
        ActiveRecord::Base.connection.update("update sites set hits = hits + 1 where id = #{id}")
      end
      
      # build counter javascript
      counter = %{var counter='<style>#{Style}</style><div style="cursor:pointer" onclick="window.location=\\'http://errcount.com\\'">}
      row["hits"].to_s.split(//).each do |num|
        counter += %{<div class="ctr" style="background-position:#{150 - (15 * num.to_i)}px 0;"></div>}
      end
      counter += "</div>';document.write(counter);"
      
      # serve it up
      head["Content-Type"] = "text/javascript"
      out.write counter
    end
  end
end

uri "/ctr", :handler => Counter.new, :in_front => true

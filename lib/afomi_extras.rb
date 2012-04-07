# Afomi Extras
#
# Custom helper methods I like to use across projects.
#


class Array
  def to_html_list
    html = "<ul>"
    self.each do |item|
      html += "<li>#{item}</li>"
    end
    html += "</ul>"
  end
end

class Hash
  def to_html_list
    html = "<ul>"
    self.each_pair do |k, v|
      html += "<li>#{k} (#{v})</li>"
    end
    html += "</ul>"
  end
end

class ActionController::Base
  # call before_filter :log_session
  def log_session
    puts "Session:"
    puts session.inspect
  end
end



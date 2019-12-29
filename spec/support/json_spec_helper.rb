module JsonSpecHelper
  def json
    JSON.parse(response.body)
  end
end

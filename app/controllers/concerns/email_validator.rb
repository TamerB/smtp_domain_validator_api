module EmailValidator
  require 'net/http'
  require 'json'

  def validate_email
    uri = URI("http://apilayer.net/api/check?" + "access_key=" + Rails.application.credentials['API_ACCESS_KEY'] + "&email=" + params[:email] + "&smtp=1&fomat=1")
    req = Net::HTTP::Get.new(uri)

    response = Net::HTTP.start(uri.hostname, uri.port) {|http|
      http.request(req)
    }

    data = JSON.parse(response.body)
    logger.info(data)

    if data.key?('smtp_check')
      {:message => {message: (data['smtp_check'] ? "Valid" : "Invalid") + " SMTP domain!"}, :code => :ok}
    else
      puts data
      {:message => {message: "Something went wrong... Please try again later"}, :code => :service_unavailable}
    end
  end
end

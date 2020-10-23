class HomeController < ApplicationController
  def index
  end

  # checks
  # checks/id
  # checks/id/details
  def user_information
    uri = URI.parse("#{ENV['URL_TRUORA']}/checks")
    request = Net::HTTP::Get.new(uri)
    request["Truora-Api-Key"] = ENV['TOKEN_TRUORA']

    req_options = {
      use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end

    render json: response.body
  end
end

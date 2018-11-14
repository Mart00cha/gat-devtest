module RequestSpecHelper
  def json
    JSON.parse(response.body)
  end

  def login_user(email, password)
    post '/auth/login', params: { email: email, password: password }
    json['access_token']
  end
end

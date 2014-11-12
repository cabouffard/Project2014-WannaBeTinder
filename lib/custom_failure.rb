class CustomFailure < Devise::FailureApp
  def redirect_url
    root_path
  end

  def respond
    if http_auth?
      http_auth
    else
      if request.format.json?
        self.status = :unauthorized
        self.response_body = { :sucess => false, :data => { :message => "login failed" }}.to_json
        self.content_type = "json"
      else
        redirect
      end
    end
  end
end

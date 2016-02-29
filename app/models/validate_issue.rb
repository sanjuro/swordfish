class ValidateIssue 
  attr_accessor :params

  def initialize(params)
    @params = params
  end

  def validate!
    validates_name
    validates_body
  end

  def validates_name
    raise HTTPStatus::UnprocessableEntity, "Can't have transactional account with the same bank and account number" if params[:name].nil?
  end

  def validates_body
    raise HTTPStatus::UnprocessableEntity, "Can't have deposit account with the same bank and account number" if params[:body].nil?
  end
end
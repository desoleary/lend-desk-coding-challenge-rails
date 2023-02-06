class LoginSessionCreateOrganizer < ApplicationOrganizer
  def self.steps
    [ValidatorAction, LoginSessionCreateAction]
  end

  class ValidatorAction < ApplicationValidatorAction
    self.contract_class = LoginSessionCreateContract
  end
end

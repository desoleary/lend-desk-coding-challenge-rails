class UserCreateOrganizer < ApplicationOrganizer
  def self.steps
    [ValidatorAction, UserCreateAction]
  end

  class ValidatorAction < ApplicationValidatorAction
    self.contract_class = UserCreateContract
  end
end
